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
COPY	./srcs/wp-config.php /tmp
COPY	./srcs/config.inc.php /tmp
COPY	./srcs/nginx.conf /etc/nginx/sites-available

CMD	bash /tmp/start.sh

EXPOSE	80 443
