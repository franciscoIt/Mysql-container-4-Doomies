#!/bin/bash

PASSWORD=secret
CONTAINER_NAME=mysql_container
DB_NAME=mydb
DOCKER_PORT=3306
HOST_PORT=53306

show_menu() {
    echo "Select an option:"
    echo "1) Start MySQL container"
    echo "2) Stop MySQL container"
    echo "3) Check MySQL container status"
    echo "4) Enter MySQL shell"
    echo "5) Exit"
}

start() {
    docker run -d --rm \
        --name=$CONTAINER_NAME \
        -e MYSQL_ROOT_PASSWORD=$PASSWORD \
        -e MYSQL_DATABASE=$DB_NAME \
        -p $HOST_PORT:$DOCKER_PORT \
        mysql:latest
    echo "Charging..."
    sleep 5
    echo "Container started. Connecting to MySQL..."
}

connect() {
    echo "Write the current password -->" $PASSWORD
    mysql -u root -h 127.0.0.1 -P $HOST_PORT -p
}

stop() {
    docker stop $CONTAINER_NAME
}

check_container_status() {
    docker ps
}

main() {
    while true; do
        show_menu
        read -p "Enter your choice: " choice
        case $choice in
        1) start ;;
        2) stop ;;
        3) check_container_status ;;
        4) connect ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *) echo "Invalid option, please try again." ;;
        esac
    done
}

main
