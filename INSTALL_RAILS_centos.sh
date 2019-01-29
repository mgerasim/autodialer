########
# Swap #
########

# Проверка текущего свапа
swapon -s
# Проверть свободное дисковое пространство
df -h
# Создать файл подкачки
sudo fallocate -l 2G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile
# Создать пространство подкачки (инициализация)
sudo mkswap /swapfile
sudo swapon /swapfile
swapon -s
# Настроить автоматическое монтирование swap`а
sudo cp /etc/fstab  /etc/fstab.backup && sudo echo "/swapfile   swap    swap    sw  0   0" >> /etc/fstab
sudo sysctl vm.swappiness=10
cp /etc/sysctl.conf  /etc/sysctl.conf.backup && sudo echo "vm.swappiness = 10" >> /etc/sysctl.conf
sysctl vm.vfs_cache_pressure=50
cp /etc/sysctl.conf  /etc/sysctl.conf.backup && sudo echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf


###
sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel wget libcurl-devel.x86_64
sudo yum install -y crontabs cronie cronie-anacron

echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
echo 'nameserver 8.8.4.4' >> /etc/resolv.conf

#Add the EPEL yum repository. 
yum -y install epel-release

# Безопасность
sudo yum install -y firewalld firewall-config -y  
sudo systemctl start firewalld 

# Fail2ban
sudo yum -y install fail2ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban


# Nginx
sudo yum install -y nginx 
cd /etc/nginx
mv nginx.conf nginx.conf.bak
wget https://raw.githubusercontent.com/mgerasim/autodialer/master/nginx/nginx.conf
# https://unix.stackexchange.com/questions/218747/nginx-says-open-etc-nginx-conf-d-foo-conf-failed-13-permission-denied
getenforce
setenforce 0
systemctl restart nginx
sudo systemctl enable nginx
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --permanent --zone=public --service=http --add-port=3000/tcp
sudo firewall-cmd --reload


#Then install the Node.js package:
yum install -y nodejs

# Install a Database MariaDB \ MySQL
sudo yum install -y mariadb-server mariadb-devel
sudo systemctl enable mariadb
systemctl start mariadb

# Zabbix
rpm -Uvh https://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
yum install -y zabbix-agent
echo '178.21.11.109   zbx01' >> /etc/hosts
#vi /etc/zabbix/zabbix_agentd.conf
systemctl enable zabbix-agent
systemctl start zabbix-agent
systemctl status zabbix-agent
# Создаем новый сервис в брандмауэре:
firewall-cmd --permanent --new-service=zabbix
# Добавим в сервис нужные порты:
firewall-cmd --permanent --service=zabbix --add-port=10050/tcp
firewall-cmd --permanent --service=zabbix --add-port=10051/tcp
# Теперь добавляем созданный сервис как разрешенный:
firewall-cmd --permanent --add-service=zabbix
# и перезапускаем фаервол:
firewall-cmd --reload

# /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf
UserParameter=mysql.outgoing,mysql --user=avtodialer --password=avtodialer  -e 'SELECT count(*) FROM outgoings WHERE status="INSERTED"' avtodialerdb --batch --skip-column-name
UserParameter=mysql.answer,mysql --user=avtodialer --password=avtodialer  -e 'SELECT count(*) FROM answers' avtodialerdb --batch --skip-column-name
UserParameter=mysql.activetrunk, mysql --user=avtodialer --password=avtodialer  -e 'SELECT sum(callcount) FROM tranks where enabled=true ' avtodialerdb --batch --skip-column-name
UserParameter=asterisk.outgoing, ls /var/spool/asterisk/outgoing/ | wc -l
systemctl restart zabbix-agent

useradd rails
echo 'kxJFqz' | passwd rails --stdin
usermod -aG wheel rails 

su - rails

cd ~/
git clone git://github.com/sstephenson/rbenv.git .rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
# re-init bash
source ~/.bash_profile
# install latest ruby
#rbenv install -v 2.5.1 
RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install 2.5.1
# sets the default ruby version that the shell will use 
rbenv global 2.5.1
# to disable generating of documents as that would take so much time 
echo "gem: --no-document" > ~/.gemrc
gem install bundler -v 1.16.1
# must be executed everytime a gem has been installed in order for the ruby executable to run
rbenv rehash
gem install rails
gem install whenever
gem install mysql2
rbenv rehash 

#Git
git config --global user.name "Mikhail Gerasimov"
git config --global user.email "mgerasim@inbox.ru"

#Generating a new SSH key
ssh-keygen -t rsa -b 4096 -C "mgerasim@inbox.ru"
cat ~/.ssh/id_rsa.pub
# upload to github


# Autodialer
cd ~/
mkdir projects && cd projects
git clone git@github.com:mgerasim/autodialer.git
cd autodialer && bundle install
#  Установить Capistrano
bundle install
rbenv rehash
cap install

/bin/mysql -e "CREATE DATABASE avtodialerdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
/bin/mysql -e "CREATE DATABASE avtodialerdevel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"

/bin/mysql -e "CREATE USER 'avtodialer'@'localhost' IDENTIFIED BY 'avtodialer'"
/bin/mysql -e "GRANT ALL PRIVILEGES ON avtodialerdb.* TO 'avtodialer'@'localhost' identified by 'avtodialer'"    
/bin/mysql -e "GRANT ALL PRIVILEGES ON avtodialerdevel.* TO 'avtodialer'@'localhost' identified by 'avtodialer'"
/bin/mysql -e "FLUSH PRIVILEGES"

rake db:migrate
RAILS_ENV=production rake db:migrate

/bin/mysql --user=avtodialer --password=avtodialer avtodialerdb -e "ALTER TABLE outgoings MODIFY COLUMN created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"
/bin/mysql --user=avtodialer --password=avtodialer avtodialerdevel -e "ALTER TABLE outgoings MODIFY COLUMN created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"

cd ~/
mkdir repos
cd repos/
git init --bare autodialer.git
cd ~/projects/autodialer
git remote add local file:///home/rails/repos/autodialer.git/
git push local master

echo 'export SECRET_KEY_BASE=d0498ebab49bd3da5faa27c7e93a73662f443d1de577a0ad97e1991a72d46ae0eee5353dcae19fc4560bd9ef76e06474fb6387395ba4536d24e8c582bba96e80' >> ~/.bashrc
source ~/.bashrc

mkdir -p /home/rails/apps/
mkdir -p /home/rails/apps/autodialer/
mkdir -p /home/rails/apps/autodialer/shared/
mkdir -p /home/rails/apps/autodialer/shared/config
cd ~/projects/autodialer
cp config/* /home/rails/apps/autodialer/shared/config
cap production deploy
cd ~/apps/autodialer/current/
gem install whenever
whenver --update-crontab

####
## Asterisk
## https://asterisk-pbx.ru/wiki/asterisk_install/asterisk-15_centos-7_realtime
## https://www.dmosk.ru/miniinstruktions.php?mini=asterisk-centos
## https://serveradmin.ru/ustanovka-asterisk-i-freepbx-na-centos-7/
##
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y kernel-devel kernel-headers

yum install -y e2fsprogs-devel  keyutils-libs-devel krb5-devel libogg \
libselinux-devel libsepol-devel libxml2-devel libtiff-devel gmp php-pear \
php php-gd php-mysql php-pdo php-mbstring ncurses-devel \
mysql-connector-odbc unixODBC unixODBC-devel \
audiofile-devel libogg-devel openssl-devel zlib-devel  \
perl-DateManip sox git wget net-tools psmisc

yum install -y gcc gcc-c++ make gnutls-devel \
libxml2-devel ncurses-devel subversion doxygen \
texinfo curl-devel net-snmp-devel neon-devel  \
uuid-devel libuuid-devel sqlite-devel sqlite \
speex-devel gsm-devel libtool libtool-ltdl libtool-ltdl-devel \
libsrtp libsrtp-devel xmlstarlet

yum install -y lynx mariadb-server mariadb php php-mysql php-mbstring tftp-server httpd ncurses-devel sendmail sendmail-cf sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git php-process crontabs cronie cronie-anacron wget vim php-xml uuid-devel sqlite-devel net-tools gnutls-devel php-pear

yum update -y

# reboot


## Настройка безопасности:
# Создаем новый сервис в брандмауэре:
firewall-cmd --permanent --new-service=asterisk
# Добавим в сервис нужные порты:
firewall-cmd --permanent --service=asterisk --add-port=5060/tcp
firewall-cmd --permanent --service=asterisk --add-port=5060/udp
firewall-cmd --permanent --service=asterisk --add-port=5061/tcp
firewall-cmd --permanent --service=asterisk --add-port=5061/udp
firewall-cmd --permanent --service=asterisk --add-port=4569/udp
firewall-cmd --permanent --service=asterisk --add-port=5038/tcp
firewall-cmd --permanent --service=asterisk --add-port=10000-20000/udp
# где 5060 — SIP, 5061 — SIP over TLS, 4569 — IAX, 5038 — AMI (Asterisk Manager Interface), 10000-20000 — диапазон для динамических портов.
# Теперь добавляем созданный сервис как разрешенный:
firewall-cmd --permanent --add-service=asterisk
# и перезапускаем фаервол:
firewall-cmd --reload


cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15-current.tar.gz
tar zxvf asterisk-15-current.tar.gz
cd asterisk*
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
contrib/scripts/install_prereq install-unpackaged
make distclean
./configure --with-pjproject-bundled --with-crypto --with-ssl=ssl --with-srtp --with-iconv --with-libcurl --with-speex --with-mysqlclient
make menuselect
make && make install && make config && ldconfig
make samples
sed -i 's/ASTARGS=""/ASTARGS="-U asterisk"/g'  /usr/sbin/safe_asterisk
useradd -m asterisk &&
chown asterisk.asterisk /var/run/asterisk &&
chown -R asterisk.asterisk /etc/asterisk &&
chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk &&
chown -R asterisk.asterisk /usr/lib/asterisk

systemctl enable asterisk
systemctl start asterisk

###########
chmod 777 /var/spool/asterisk/outgoing/
chmod 777 /var/spool/asterisk/
chmod 777 /var/spool/
chmod 777 /var/

chmod 777 /var/lib/nginx/tmp/client_body/
chmod 777 /var/lib/nginx/tmp/
chmod 777 /var/lib/nginx
chmod 777 /var/lib/
chmod 777 /var/



####################
### ODBC 
####################
sudo yum install -y mysql-connector-odbc
sudo yum install -y unixODBC unixODBC-devel libtool-ltdl libtool-ltdl-devel
echo "[asterisk-connector]" >> /etc/odbc.ini
echo "Description = MySQL connection to 'avtodialer' database" >> /etc/odbc.ini
echo "Driver = MySQL" >> /etc/odbc.ini
echo "Database = avtodialerdb" >> /etc/odbc.ini
echo "Server = localhost" >> /etc/odbc.ini
echo "Port = 3306" >> /etc/odbc.ini
echo "Socket = /var/lib/mysql/mysql.sock" >> /etc/odbc.ini

isql -v asterisk-connector avtodialer avtodialer

echo "[asteriskcdrdb]" >> /etc/asterisk/res_odbc.conf
echo "enabled=yes" >> /etc/asterisk/res_odbc.conf
echo "dsn=asterisk-connector" >> /etc/asterisk/res_odbc.conf
echo "pooling=no" >> /etc/asterisk/res_odbc.conf
echo "limit=1" >> /etc/asterisk/res_odbc.conf
echo "pre-connect=yes" >> /etc/asterisk/res_odbc.conf
echo "username=avtodialer" >> /etc/asterisk/res_odbc.conf
echo "password=avtodialer" >> /etc/asterisk/res_odbc.conf
asterisk -x "core reload"
asterisk -x "odbc show"

echo "[global]" >> /etc/asterisk/cdr_odbc.conf 
echo "dsn=asteriskcdrdb" >> /etc/asterisk/cdr_odbc.conf 
echo "loguniqueid=yes" >> /etc/asterisk/cdr_odbc.conf 
echo "dispositionstring=yes" >> /etc/asterisk/cdr_odbc.conf 
echo "table=cdr" >> /etc/asterisk/cdr_odbc.conf 
echo "usegmtime=no" >> /etc/asterisk/cdr_odbc.conf 
echo "hrtime=yes" >> /etc/asterisk/cdr_odbc.conf 
echo "newcdrcolumns=yes" >> /etc/asterisk/cdr_odbc.conf 

####################
### .NET Core
####################
yum install -y centos-release-dotnet
yum install -y rh-dotnet20
scl enable rh-dotnet20 bash
dotnet --info

vi ~/.bashrc
source scl_source enable rh-dotnet20

# new user
useradd dotnet
echo 'kxJFqz' | passwd dotnet --stdin
usermod -aG wheel dotnet 
