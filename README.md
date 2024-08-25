# Sysbox Development Workstation

## Overview
The Sysbox Development Workstation is a fully isolated and ephemeral development environment using the Sysbox container runtime. It provides a secure and consistent workspace where developers can install and use various tools without affecting their host environment. This project supports tools like 0install, Nix, and Code Server, allowing developers to work directly in their browser with portable development tools.

## Features
- **Isolated Development Environment:** Leverages the Sysbox runtime to create a secure, isolated container that simulates a full VM.
- **Ephemeral Workstation:** Perfect for testing or temporary setups, where the workstation can be easily spun up and destroyed.
- **Browser-Based IDE:** Includes Code Server, enabling developers to code from their browser.
- **Portable Package Management:** Supports 0install and Nix for managing development tools, ensuring reproducibility and flexibility.
- **Customizable:** Provides scripts for installing various developer tools like Go, Node.js (NVM), Python (Pyenv, Pipx, Poetry), Podman, and more.

## Requirements
- Sysbox Runtime
- Docker

## Default Credentials
```
Username: developer
Password: developer
```

## Run a Workstation Container
Create a Container with default settings:
```bash
docker run --runtime=sysbox-runc -it -d \
    -p=127.0.0.1:2222:22 \
    -p=127.0.0.1:8081:80 \
    -p=127.0.0.1:8080:8080 \
    --hostname=sysbox-jammy-host \
    --name=sysbox-jammy-container \
    cedricanover94/sysbox-jammy:latest
```

---

## SSH to the Workstation Container
```shell
ssh developer@127.0.0.1 -p 2222
```

---

## Build
```shell
$ ./build.sh <username> <password>
# ---- Or
$ DOCKER_HUB_USERNAME='<dockerhub_username>' DOCKER_HUB_PUSH='<yes|no>' ./build.sh <username> <password>
```

If you prefer to build with custom parameters, use the following commands:
```shell
# ---- Build
IMG_NAME='<image_name>'
NEW_USERNAME='<username>'
export PASSWORD='<password>'
export DOCKER_BUILDKIT=1
docker build -t $IMG_NAME \
    --secret id=newpass,env=PASSWORD \
    --build-arg NEW_USER=$NEW_USERNAME \
    --no-cache --progress='plain' .

# ---- Run
docker run --runtime=sysbox-runc -it -d --rm \
    -p=127.0.0.1:2222:22 \
    -p=127.0.0.1:8081:80 \
    -p=127.0.0.1:8080:8080 \
    --hostname=sysbox-jammy-host \
    --name=sysbox-jammy-container \
    $IMG_NAME

# ---- SSH
ssh $NEW_USERNAME@127.0.0.1 -p 2222
```

## Installing Tools
Once inside the Sysbox container, run the commands to install the following tools.

### 0install
```shell
$ ~/supply_scripts/install_0install.sh
```

### Nix
```shell
$ ~/supply_scripts/install_nix.sh
```

### Code Server
```shell
$ ~/supply_scripts/install_code_server.sh <code-server-password>

# The default project root directory is "/home/<username>/project-root"
# URL (on your host): http://127.0.0.1:8080/  <-- If you followed the run command previously
# Code Server Password: <code-server-password>

# ---- Or

# Custom Project Path (must be in the user home)
$ PROJ_PATH=$HOME/path/to/project-dir ~/supply_scripts/install_code_server.sh <code-server-password>
```
