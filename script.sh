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
    7) Reset db data
    0) Exit
    """
}

start() {
    echo "Starting MySQL container..."
    if  docker run -d --rm \
        --name="$CONTAINER_NAME" \
        -e MYSQL_ROOT_PASSWORD="$PASSWORD" \
        -e MYSQL_DATABASE="$DB_NAME" \
        -v "$VOLUME_NAME:/var/lib/mysql" \
        -p "$HOST_PORT:$DOCKER_PORT" \
        mysql:latest; then
        clear
    else 
        echo "Failed to start the container. Check the previous error"
        return 1
    fi
}

connect() {
    echo "Current MySQL root password is: $PASSWORD"
    if mysql -u root -h 127.0.0.1 -P "$HOST_PORT" -p; then clear
    fi
}

stop() {
    if  docker stop $CONTAINER_NAME; then 
        clear
    fi 
}

status() {
    echo """
    * * * * STATUS * * * * 
    Connection Details of $CONTAINER_NAME (Workbench, Tableplus...):
    Host: 127.0.0.1
    Password: $PASSWORD
    Port: $HOST_PORT
    """
}

add_volume() {
    docker volume create $VOLUME_NAME
}

import_db() {
    read -p "Enter the complete file path:" path
    if [ -f path ]; then
        mysql -u root -h 127.0.0.1 -P $HOST_PORT -p < "$path"
    else
        echo "* * * File does not exist. * * *"
    fi
}

export_db() {
    mkdir -p ./output_db
    echo "Current MySQL root password is: $PASSWORD"
    mysql -u root -h 127.0.0.1 -P  "$HOST_PORT" -p -e "SHOW DATABASES;"

    read -p "Enter the database name to export:" db_name
    
    if  mysqldump -u root -h 127.0.0.1 -P "$HOST_PORT" -p "$db_name" > "./output_db/$db_name.sql"; 
    then clear
        echo "Database exported to ./output_db/$db_name.sql"
    else 
        echo "Failed to export the database."
    fi
    
}

reset () {
    stop
    if docker volume ls -q | grep -q "$VOLUME_NAME"; then
    docker volume rm "$VOLUME_NAME"
    else
        echo "Volume $VOLUME_NAME does not exist."
    fi
    start
}

show_activity () {
    if docker ps | grep -q "$CONTAINER_NAME"; then
        echo " Status --> Container up"
    else
        echo "Status --> Container down"
    fi
}

main() {
    while true; do
        show_activity
        show_menu
        read -p "Enter your choice: " choice
        case $choice in
        1) start ;;
        2) stop ;;
        3) status ;;
        4) connect ;;
        5) import_db ;;
        6) export_db ;;
        7) reset ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *) echo "Invalid option, please try again."; clear;;
        esac
    done
}

main
