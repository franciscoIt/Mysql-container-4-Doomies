#!/bin/bash

PASSWORD=secret
CONTAINER_NAME=mysql_container
DB_NAME=mydb

# Run the MySQL container in the background
docker run -d --rm \
    --name=$CONTAINER_NAME \
    -e MYSQL_ROOT_PASSWORD=$PASSWORD \
    -e MYSQL_DATABASE=$DB_NAME \
    -p 3307:3306 \
    mysql:latest

# Introduce a delay to allow MySQL to initialize
sleep 20

# Get the IP address of the running container
DOCKER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_NAME)

# Optionally, you can check the MySQL logs for errors
# docker logs $CONTAINER_NAME

echo "Container started. Connecting to MySQL..."

# Connect to MySQL using the Docker IP and mapped port
mysql -u root -h $DOCKER_IP -P 3306 -p

# Stop the container
docker stop $CONTAINER_NAME

