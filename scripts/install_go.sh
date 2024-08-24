#!/usr/bin/bash

# To Uninstall:
# sudo rm -rf /usr/local/go

set -e

GO_VERSION='1.21.4'

echo "Downloading Go v$GO_VERSION"
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O go.tar.gz

echo 'Extracting to /usr/local/go ...'
sudo tar -xzvf go.tar.gz -C /usr/local

echo 'export PATH=$HOME/go/bin:/usr/local/go/bin:$PATH' >> $HOME/.profile

rm go.tar.gz

. $HOME/.profile
exec "$SHELL"
