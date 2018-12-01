#!/usr/bin/env bash
if [ -e .env ]; then
    source .env
else 
    echo "Please set up your .env file before starting your environment."
    exit 1
fi
docker-compose up -d 
