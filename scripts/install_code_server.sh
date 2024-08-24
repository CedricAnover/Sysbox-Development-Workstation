#!/usr/bin/bash

# Usage:
# ~/supply_scripts/install_code_server.sh <password>
# PROJ_PATH="$HOME/path/to/project-root" ~/supply_scripts/install_code_server.sh <password>

set -e

CODE_SERVER_PASSWORD="$1"
: ${THE_USER:=$(whoami)}
: ${CODE_SERVER_PORT:=8080}
: ${PROJ_PATH:="/home/$THE_USER/project-root"}
IP_ADDRESS="$(ip -br addr | grep 'eth0' | awk '{print $3}' | cut -d'/' -f1)"
SERVICE_PATH="$HOME/.config/systemd/user/code-server.service"

if [ "$#" -ne 1 ]; then
    echo "Invalid Argument."
    exit 1
fi

echo "Installing Code Server..."
curl -fsSL https://code-server.dev/install.sh | sh
#curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=X.X.X
# System-wide Installation
#curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=X.X.X --prefix=/usr/local
# Standalone Installation
#curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=X.X.X --method=standalone


echo "Configuring Code Server..."
mkdir -p "$PROJ_PATH"
mkdir -p "$(dirname "$SERVICE_PATH")"

cat <<EOF > $SERVICE_PATH
[Unit]
Description=code-server

[Service]
Type=simple
Environment=PASSWORD=$CODE_SERVER_PASSWORD
ExecStart=/usr/bin/code-server --bind-addr $IP_ADDRESS:$CODE_SERVER_PORT --auth password $PROJ_PATH
Restart=always

[Install]
WantedBy=default.target
EOF

echo "Starting Code Server..."
systemctl --user daemon-reload
systemctl --user enable code-server.service
systemctl --user start code-server.service
