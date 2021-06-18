#mariadb
service mysql start
echo "create database wordpress;" | mysql -u root --skip-password
echo "create user 'rsudo'@'localhost' identified by '1111';" | mysql -u root --skip-password
echo "grant all privileges on wordpress.* to 'rsudo'@'localhost';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

#autoindex
if test "$AUTOINDEX" = "off"
then
	sed -i -e 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/wordpress.conf
fi

#service start
service php7.3-fpm start
service nginx start
bash