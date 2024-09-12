# Mysql_Docker_workflow --> # MySQL Docker Initialization Script

## Overview

This script automates the process of running a MySQL Docker container, connecting to it, and then stopping the container. It’s designed to be a simple and effective way to set up and interact with a MySQL database in a Docker environment without knowledge of Docker.

## Features

- **Start MySQL Container**: Runs a MySQL instance in a Docker container.
- **Wait for Initialization**: Ensures MySQL is ready to accept connections.
- **Connect to MySQL**: Opens a MySQL client connection to the running container.
- **Clean Up**: Stops and removes the container after use.

## Requirements
### Docker installed and running on your machine.
Source: https://docs.docker.com/engine/install/ubuntu/#installation-methods 
1. Set up Docker's apt repository.
```bash 
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
2. Install the Docker packages.
```
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
- MySQL client installed for database connections.
```
sudo apt install mysql-client
```
## Script Configuration

Before running the script, configure the following variables according to your requirements:

- `PASSWORD`: The root password for the MySQL instance.
- `CONTAINER_NAME`: The name to assign to the Docker container.
- `DB_NAME`: The name of the MySQL database to create.


## Usage

1. **Save the Script**:
   - Save the provided script to a file, e.g., `mysql-docker-script.sh`.

2. **Make the Script Executable**:
   ```bash
   chmod +x script.sh
