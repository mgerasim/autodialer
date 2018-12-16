sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel wget libcurl-devel.x86_64
sudo yum install -y crontabs cronie cronie-anacron

#Add the EPEL yum repository. 
yum -y install epel-release

# Nginx
sudo yum install -y nginx 
systemctl start nginx
sudo systemctl enable nginx

#Then install the Node.js package:
yum install -y nodejs

# Install a Database MariaDB \ MySQL
sudo yum install -y mariadb-server mariadb-devel
sudo systemctl enable mariadb
systemctl start mariadb

useradd rails
echo 'kxJFqz' | passwd rails --stdin
usermod -aG wheel rails 

su - rails



