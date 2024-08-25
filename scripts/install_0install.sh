#!/usr/bin/bash

set -e

sudo apt update
sudo apt install 0install-core -y --no-install-recommends

echo 'export PATH=$HOME/bin:$PATH' >> $HOME/.bashrc
source $HOME/.bashrc
exec "$SHELL"
