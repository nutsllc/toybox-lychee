#!/bin/sh
set -e

user="www-data"
group="www-data"

if [ -n "${TOYBOX_GID+x}" ] && ! cat /etc/group | grep ":${TOYBOX_GID}:" > /dev/null 2>&1; then
    groupmod -g ${TOYBOX_GID} ${group}
    echo "GID of ${group} has been changed."
fi

if [ -n "${TOYBOX_UID+x}" ] && ! cat /etc/passwd | grep ":${TOYBOX_UID}:" > /dev/null 2>&1; then
    usermod -u ${TOYBOX_UID} ${user}
    echo "UID of ${user} has been changed."
fi


docroot="/var/www/html"
config="${docroot}/data/config.php"

if [ -f ${config} ]; then
    rm -rf ${config}
fi

echo "<?php" >> ${config}
echo "" >> ${config}
echo "// Database configuration" >> ${config}
echo '$dbHost = '"'${MARIADB_PORT_3306_TCP_ADDR}'; // Host of the database" >> ${config}
echo '$dbUser = '"'${MARIADB_ENV_MYSQL_USER}'; // Username of the database" >> ${config}
echo '$dbPassword = '"'${MARIADB_ENV_MYSQL_PASSWORD}'; // Password of the database" >> ${config}
echo '$dbName = '"'${MARIADB_ENV_MYSQL_DATABASE}'; // Database name" >> ${config}
echo '$dbTablePrefix = '"''; // Table prefix" >> ${config}
echo "" >> ${config}
echo "?>" >> ${config}

chown -R ${user}:${group} ${docroot}

exec "$@"
