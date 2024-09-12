#!/bin/bash

PASSWORD=secret
CONTAINER_NAME=mysql_container
DB_NAME=mydb
DOCKER_PORT=3306
HOST_PORT=53306

# Run the MySQL container in the background
docker run -d --rm \
    --name=$CONTAINER_NAME \
    -e MYSQL_ROOT_PASSWORD=$PASSWORD \
    -e MYSQL_DATABASE=$DB_NAME \
    -p $HOST_PORT:$DOCKER_PORT \
    mysql:latest

# Introduce a delay to allow MySQL to initialize
echo "Charging..."
sleep 5 

# Optionally, you can check the MySQL logs for errors
# docker logs $CONTAINER_NAME

echo "Container started. Connecting to MySQL..."

# Connect to MySQL using localhost and the mapped port
mysql -u root -h 127.0.0.1 -P $HOST_PORT -p$PASSWORD

# Stop the container
docker stop $CONTAINER_NAME

