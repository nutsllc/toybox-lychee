#!/bin/sh
set -e

user="www-data"
group="www-data"

if [ -n "${TOYBOX_GID}" ] && ! cat /etc/group | awk 'BEGIN{ FS= ":" }{ print $3 }' | grep ${TOYBOX_GID} > /dev/null 2>&1; then
    groupmod -g ${TOYBOX_GID} ${group}
    echo "GID of ${group} has been changed."
fi

if [ -n "${TOYBOX_UID}" ] && ! cat /etc/passwd | awk 'BEGIN{ FS= ":" }{ print $3 }' | grep ${TOYBOX_UID} > /dev/null 2>&1; then
    usermod -u ${TOYBOX_UID} ${user}
    echo "UID of ${user} has been changed."
fi

docroot="/usr/share/nginx/html"
config="${docroot}/data/config.php"

{
    echo "<?php"
    echo "// Database configuration"
    echo '$dbHost = '"'${DB_HOST:=mysql}';"
    echo '$dbUser = '"'${DB_USER:=lychee}';"
    echo '$dbPassword = '"'${DB_PASSWORD:=lychee}';"
    echo '$dbName = '"'${DB_NAME:=lychee}';"
    echo '$dbTablePrefix = '"'${DB_TABLE_PREFIX}';"
    echo ""
    echo "?>"
} > ${config}

chown -R ${user}:${group} ${docroot}

exec "$@"
