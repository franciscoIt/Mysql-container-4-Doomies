#!/bin/bash

PASSWORD=secret
CONTAINER_NAME=mysql_container
DB_NAME=mydb
DOCKER_PORT=3306
HOST_PORT=53306
VOLUME_NAME=mysql-volume

show_menu() {
    echo """
    Select an option:
    1) Start MySQL container
    2) Stop MySQL container
    3) Check MySQL container status
    4) Enter MySQL shell
    5) Import db
    6) Export db
    0) Exit
    """
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

status() {
    docker ps

    echo """
    Connection Details of $CONTAINER_NAME (Workbench, Tableplus...):
    Host: 127.0.0.1
    Password: Default, check documentation or in case of customization, the script
    Port: $HOST_PORT
    """
}

add_volume() {
    docker volume create $VOLUME_NAME

}

import_db() {
    read -p "Enter the complete file path:" path
    if [ -e path ]; then
        mysql -u root -h 127.0.0.1 -P $HOST_PORT -p <path
    else
        echo "* * * File does not exist. * * *"
    fi
}

export_db() {
    mkdir -p ./output_db
    echo "Write the current password -->" $PASSWORD
    mysql -u root -h 127.0.0.1 -P $HOST_PORT -p -e "show databases;"

    read -p "Write the database to export:" db_name
    mysqldump -u root -h 127.0.0.1 -P $HOST_PORT -p $db_name >./output_db/$db_name.sql
}

main() {
    while true; do
        show_menu
        read -p "Enter your choice: " choice
        case $choice in
        1) start ;;
        2) stop ;;
        3) status ;;
        4) connect ;;
        5) import_db ;;
        6) export_db ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *) echo "Invalid option, please try again." ;;
        esac
    done
}

main
