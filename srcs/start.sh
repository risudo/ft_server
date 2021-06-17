if test "$AUTOINDEX" = "off"
then
	sed -i -e 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/wordpress.conf
fi
service php7.3-fpm start
service mysql start
service nginx start
bash
