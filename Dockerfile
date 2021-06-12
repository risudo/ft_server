FROM	debian:buster

RUN	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y vim wget apt-utils

COPY	./srcs/init_sql.sh /tmp

#nginx
RUN	apt-get install -y nginx 

#mariadb
RUN	apt-get install -y mariadb-server
	#bash /tmp/init_sql.sh

#php
RUN	apt-get install -y php-fpm php-mysql

#wordpress
RUN	cd /var/www/html/ && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz && \
	chown -R www-data:www-data /var/www/html/wordpress
COPY	./srcs/wp-config.php /var/www/html/wordpress/
# ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/
RUN	service nginx start && \
	service php7.3-fpm start

