#!/bin/bash

self=$(cd $(dirname $0);pwd)
dist=${self}/..

dirs=(
    "${dist}/3.1.5/apache-php5.6"
    "${dist}/3.1.5/apache-php7.0"
)
for d in ${dirs[@]}; do
    src=${self}/../seed
    [ -d ${d} ] && rm -r ${d}
    php_ver=$(echo ${d} | awk -F "/" '{print $(NF)}' | sed "s%^apache-php\([0-9.]\)%\1%") 
    printf "Generate: Dockerfile for Lychee - apache2-PHP${php_ver} on ${baseOS}..."
    mkdir -p ${d}
    cp ${src}/apache-php/Dockerfile-seed ${d}/Dockerfile
    cp ${src}/apache-php/docker-entrypoint.sh-seed ${d}/docker-entrypoint.sh
    cp ${src}/apache-php/Makefile-seed ${d}/Makefile
    chmod 755 ${d}/docker-entrypoint.sh
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Dockerfile
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Makefile
    echo "done."
done

echo "complete!"

exit 0
