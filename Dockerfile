FROM	debian:buster

RUN	apt-get update && \
	apt-get install -y \
	wget \
	php \
	php-fpm \
	php-curl \
	php-mbstring \
	php-mysql \
	php-xml \
	php-zip \
	nginx \
	mariadb-server && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY	./srcs/start.sh /tmp
COPY	./srcs/wordpress.conf /etc/nginx/sites-available

#nginx
RUN	rm /etc/nginx/sites-available/default && \
	rm /etc/nginx/sites-enabled/default && \
	ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/

#ssl
RUN	mkdir /etc/nginx/ssl && \
	openssl genrsa -out /etc/nginx/ssl/server.key 2048 && \
	openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP" && \
	openssl x509 \
	-req \
	-in /etc/nginx/ssl/server.csr \
	-days 36500 \
	-signkey /etc/nginx/ssl/server.key > /etc/nginx/ssl/server.crt

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

EXPOSE	80 443