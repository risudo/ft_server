#mariadb
service mysql start
echo "create database wordpress;" | mysql -u root --skip-password
echo "create user 'rsudo'@'localhost' identified by '1111';" | mysql -u root --skip-password
echo "grant all privileges on wordpress.* to 'rsudo'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#nginx
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/

#ssl
mkdir /etc/nginx/ssl
openssl genrsa -out /etc/nginx/ssl/server.key 2048
openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP"
openssl x509 \
-req \
-in /etc/nginx/ssl/server.csr \
-days 36500 \
-signkey /etc/nginx/ssl/server.key > /etc/nginx/ssl/server.crt

#wordpress
cd /var/www/html/
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
chown -R www-data:www-data /var/www/html/wordpress
mv /tmp/wp-config.php /var/www/html/wordpress

#phpmyadmin
cd /var/www/html/
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
tar xvf phpMyAdmin-5.0.4-all-languages.tar.gz
mv phpMyAdmin-5.0.4-all-languages phpmyadmin
chown -R www-data:www-data /var/www/html/phpmyadmin
mv /tmp/config.inc.php /var/www/html/phpmyadmin

#autoindex
if test "$AUTOINDEX" = "off"
then
	sed -i -e 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/wordpress.conf
fi

#service start
service php7.3-fpm start
service nginx start
tail -f /dev/null