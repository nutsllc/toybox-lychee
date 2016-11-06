#!/bin/bash

self=$(cd $(dirname $0);pwd)
dist=${self}/..

# ----------------------------------------------------------
# apache-php
# ----------------------------------------------------------
dirs=(
    "${dist}/3.1.3/apache-php5.6"
    "${dist}/3.1.3/apache-php7.0"
    "${dist}/3.1.4/apache-php5.6"
    "${dist}/3.1.4/apache-php7.0"
    "${dist}/3.1.5/apache-php5.6"
    "${dist}/3.1.5/apache-php7.0"
)
for d in ${dirs[@]}; do
    src=${self}/../seed
    [ -d ${d} ] && rm -r ${d}
    php_ver=$(echo ${d} | awk -F "/" '{print $(NF)}' | sed "s%^apache-php\([0-9.]*\)$%\1%") 
    lychee_ver=$(echo ${d} | awk -F "/" '{print $(NF - 1)}') 
    printf "Generate: Dockerfile for Lychee v${lychee_ver} - apache2-PHP${php_ver} ..."
    mkdir -p ${d}
    cp ${src}/apache-php/Dockerfile-seed ${d}/Dockerfile
    cp ${src}/apache-php/docker-entrypoint.sh-seed ${d}/docker-entrypoint.sh
    cp ${src}/apache-php/Makefile-seed ${d}/Makefile
    chmod 755 ${d}/docker-entrypoint.sh
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Dockerfile
    sed -i -e "s/{{LYCHEE_VERSION}}/${lychee_ver}/" ${d}/Dockerfile
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Makefile
    sed -i -e "s/{{LYCHEE_VERSION}}/${lychee_ver}/" ${d}/Makefile
    echo "done."
done

# ----------------------------------------------------------
# php-fpm
# ----------------------------------------------------------
dirs=(
    "${dist}/3.1.3/php-fpm5.6"
    "${dist}/3.1.3/php-fpm7.0"
    "${dist}/3.1.4/php-fpm5.6"
    "${dist}/3.1.4/php-fpm7.0"
    "${dist}/3.1.5/php-fpm5.6"
    "${dist}/3.1.5/php-fpm7.0"
)
for d in ${dirs[@]}; do
    src=${self}/../seed
    [ -d ${d} ] && rm -r ${d}
    php_ver=$(echo ${d} | awk -F "/" '{print $(NF)}' | sed "s%^php-fpm\([0-9.]*\)$%\1%") 
    lychee_ver=$(echo ${d} | awk -F "/" '{print $(NF - 1)}') 
    printf "Generate: Dockerfile for Lychee v${lychee_ver} - PHP-FPM${php_ver} ..."
    mkdir -p ${d}
    cp ${src}/php-fpm/Dockerfile-seed ${d}/Dockerfile
    cp ${src}/php-fpm/docker-entrypoint.sh-seed ${d}/docker-entrypoint.sh
    cp ${src}/php-fpm/Makefile-seed ${d}/Makefile
    chmod 755 ${d}/docker-entrypoint.sh
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Dockerfile
    sed -i -e "s/{{LYCHEE_VERSION}}/${lychee_ver}/" ${d}/Dockerfile
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Makefile
    sed -i -e "s/{{LYCHEE_VERSION}}/${lychee_ver}/" ${d}/Makefile
    echo "done."
done

echo "complete!"

exit 0
