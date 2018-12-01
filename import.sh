#!/usr/bin/env bash

STORAGE_DIR=$1
DATABASE_DUMP=$2

if [ -e .env ]; then
    source .env
else
    echo "Please set up your .env file before starting your enviornment."
    exit 1
fi

DB_SERVER=${CONTAINER_NAME}-db

docker exec ${DB_SERVER} /usr/bin/mysqldump -u root --password="${MYSQL_ROOT_PASSWORD}" < ${DATABASE_DUMP}

rm -rf ${KOKEN_DATA_DIR}/storage/*
cp -r STORAGE_DIR/* ${KOKEN_DATA_DIR}/storage/

cp ./koken_patches/database.php ${KOKEN_DATA_DIR}/storage/configuration/
