#!/bin/bash
sudo yum -y install http://ftp.riken.jp/Linux/remi/enterprise/remi-release-7.rpm
sudo yum -y install mariadb-server httpd php72-php php72-php-common php72-php-gd php72-php-mbstring php72-php-mysqlnd php72-php-pear

sudo cp -f ./config/my.cnf /etc
sudo systemctl enable httpd mariadb
sudo systemctl start httpd mariadb

echo ""
echo "***********************************************"
echo "initial setup complete."
echo "You have to exec mysql_secure_installation"
echo "***********************************************"

