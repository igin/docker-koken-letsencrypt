#!/usr/bin/env bash

set -o xtrace

HTML_TAR=$1
DATABASE_DUMP=$2

if [ -e .env ]; then
    source .env
else
    echo "Please set up your .env file before starting your environment."
    exit 1
fi

mkdir -p /tmp/koken_restore
tar -C /tmp/koken_restore -zxvf ${HTML_TAR}

STORAGE_DIR=/tmp/koken_restore/storage

DB_SERVER=${CONTAINER_NAME}-db

echo "DROP DATABASE ${MYSQL_DATABASE};" | docker exec -i ${DB_SERVER} /usr/bin/mysql ${MYSQL_DATABASE} -u root --password="${MYSQL_ROOT_PASSWORD}"
echo "CREATE DATABASE ${MYSQL_DATABASE};" | docker exec -i ${DB_SERVER} /usr/bin/mysql ${MYSQL_DATABASE} -u root --password="${MYSQL_ROOT_PASSWORD}"
docker exec -i ${DB_SERVER} /usr/bin/mysql ${MYSQL_DATABASE} -u root --password="${MYSQL_ROOT_PASSWORD}" < ${DATABASE_DUMP}

rm -rf ${KOKEN_DATA_DIR}/storage/*
cp -r ${STORAGE_DIR}/* ${KOKEN_DATA_DIR}/storage/

docker exec -i ${CONTAINER_NAME}-web /bin/chown -R www-data:www-data /var/www/html/storage
docker exec -i ${CONTAINER_NAME}-web /bin/chmod -R 755 /var/www/html/storage

rm -rf /tmp/koken_restore

cp ./koken_patches/database.php ${KOKEN_DATA_DIR}/storage/configuration/
