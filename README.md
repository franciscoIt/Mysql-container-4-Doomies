# Mysql-container-4-Doomies

## Overview

This little CLI tool automates the process of running a MySQL throught a Docker container, managing the main cases of use like: 
- Run a Mysql instance without interfere with the Mysql common ports .
- Import and export databases.
- Status option that retreive data for MysqlWorkbench or Tableplus.
- Connect automatically to the Mysql CLI.
- Clean all the data.
It’s designed to be a FAST AND SIMPLE way to set up and interact with a MySQL database in a Docker environment without knowledge of Docker nor being familiar with the syntax.

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
```bash
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
- MySQL client installed for database connections.
```bash
sudo apt install mysql-client
```
## Script Configuration

Before running the script, you can configure the following variables according to your requirements:

- `PASSWORD=secret`
- `CONTAINER_NAME=mysql_container`
- `DB_NAME=mydb`
- `DOCKER_PORT=3306`
- `HOST_PORT=53306`


## Usage

1. **Save the Script**:
   - Save the provided script to a file, e.g., `script.sh`.

2. **Make the Script Executable**:
   ```bash
   chmod +x script.sh
3. **Run the script**
   ```
   sudo ./script.sh
   ```
