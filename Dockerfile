FROM	debian:buster

RUN	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y vim wget apt-utils php php-fpm php-curl php-mbstring php-mysql php-xml php-zip

COPY	./srcs/start.sh /tmp

#nginx
RUN	apt-get install -y nginx && \
	rm /etc/nginx/sites-enabled/default
COPY	./srcs/default_nginx /etc/nginx/sites-enabled

#mariadb
COPY	./srcs/init_sql.sh /tmp
RUN	apt-get install -y mariadb-server && \
	bash /tmp/init_sql.sh

#wordpress
RUN	cd /var/www/html/ && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	chown -R www-data:www-data /var/www/html/wordpress
COPY	./srcs/wp-config.php /var/www/html/wordpress/

#phpmyadmin
RUN	cd /var/www/html/ && \
	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
	tar xvf phpMyAdmin-5.0.4-all-languages.tar.gz && \
	mv phpMyAdmin-5.0.4-all-languages phpmyadmin && \
	chown -R www-data:www-data /var/www/html/phpmyadmin
COPY	./srcs/config.inc.php /var/www/html/phpmyadmin

CMD	bash /tmp/start.sh

