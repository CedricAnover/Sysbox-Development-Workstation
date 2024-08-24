#!/bin/bash

set -e

# Install Pipx
echo "Installing Pipx..."
sudo apt update
sudo apt install -y pipx
echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc
. $HOME/.bashrc
exec "$SHELL"
