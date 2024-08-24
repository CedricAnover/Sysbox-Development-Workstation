#!/usr/bin/bash

set -e

BIN_DIR="$HOME/bin"
EARTHLY_VERSION='0.8.15'

mkdir -p $BIN_DIR

# Install Just
echo "Installing Just..."
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $BIN_DIR
echo "Installation Complete."

# Install Earthly
echo "Installing Earthly..."
curl -L -o $BIN_DIR/earthly https://github.com/earthly/earthly/releases/download/v$EARTHLY_VERSION/earthly-linux-amd64
chmod +x $HOME/bin/earthly
sudo $BIN_DIR/earthly bootstrap --with-autocomplete
echo "Installation Complete."

# Install Task
echo "Installing Task..."
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b $BIN_DIR/
echo "Installation Complete."

echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc
. $HOME/.bashrc
exec "$SHELL"
