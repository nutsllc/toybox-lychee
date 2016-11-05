FROM php:5.6-apache
MAINTAINER NutsProject, LLC <dev@nutsproject.co.jp>

RUN apt-get update && apt-get install -y \
        git \
        unzip \
        wget \
        libmcrypt-dev \
        mcrypt \
        libpng12-dev \
        libjpeg-dev \
        libgd-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install exif gd json mbstring mysqli zip mcrypt opcache \
    && { \
        echo 'max_execution_time = 200'; \
        echo 'post_max_size = 100M'; \
        echo 'upload_max_size = 100M'; \
        echo 'upload_max_filesize = 20M'; \
        echo 'memory_limit = 256M'; \
	} > /usr/local/etc/php/php.ini \
    && { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && cd /var/www \
    && git clone https://github.com/electerious/Lychee.git html \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 777 html/data/ html/uploads/ \
    && ln -s /var/www/html/uploads uploads \
    && ln -s /var/www/html/data data

VOLUME /uploads
VOLUME /data

WORKDIR /var/www/html
EXPOSE 8080

COPY docker-entrypoint.sh /entrypoint-ex.sh

ENTRYPOINT ["/entrypoint-ex.sh"]
CMD ["apache2-foreground"]
