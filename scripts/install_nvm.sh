#!/usr/bin/bash

set -e

NVM_VERSION='0.40.0'

install_nvm() {
    local version=$1
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$version/install.sh | bash
. "$HOME/.bashrc"
exec "$SHELL"
}

install_nvm $NVM_VERSION

