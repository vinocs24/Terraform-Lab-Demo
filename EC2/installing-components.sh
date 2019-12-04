#!/bin/bash
sudo su
yum update -y
yum install httpd php php-mysql -y
cd /var/www/html
echo "healthy" > healthy.html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
mv wordpress/wp-config-sample.php wordpress/wp-config.php
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
chkconfig httpd on
service httpd start
