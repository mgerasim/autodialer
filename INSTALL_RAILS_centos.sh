sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel wget libcurl-devel.x86_64
sudo yum install -y crontabs cronie cronie-anacron

echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
echo 'nameserver 8.8.4.4' >> /etc/resolv.conf

#Add the EPEL yum repository. 
yum -y install epel-release

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
gem install bundler
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
