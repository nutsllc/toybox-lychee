FROM php:5.6-apache
MAINTAINER NutsProject, LLC <dev@nutsproject.co.jp>

ENV LYCHEE_VERSION=3.1.5

RUN apt-get update && apt-get install -y \
        unzip \
        wget \
        libmcrypt-dev \
        mcrypt \
        libpng12-dev \
        libjpeg-dev \
        libgd-tools \
        libmagickwand-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && yes | pecl install imagick \
    && docker-php-ext-enable imagick \
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
    && wget -O /var/www/${LYCHEE_VERSION}.tar.gz https://github.com/electerious/Lychee/archive/v${LYCHEE_VERSION}.tar.gz \
    && tar xzf /var/www/${LYCHEE_VERSION}.tar.gz -C /var/www \
    && rm -rf /var/www/html \
    && rm -rf /var/www/html/${LYCHEE_VERSION}.tar.gz \
    && mv /var/www/Lychee-${LYCHEE_VERSION} /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 777 /var/www/html/data /var/www/html/uploads \
    && ln -s /var/www/html/uploads /uploads \
    && ln -s /var/www/html/data /data

VOLUME /uploads
VOLUME /data

WORKDIR /var/www/html
EXPOSE 8080

COPY docker-entrypoint.sh /entrypoint-ex.sh

ENTRYPOINT ["/entrypoint-ex.sh"]
CMD ["apache2-foreground"]
