#!/usr/bin/bash

set -e

ACT_VERSION='0.2.65'

# curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
# https://github.com/nektos/act/releases/latest/download/act_Linux_x86_64.tar.gz
# https://github.com/nektos/act/releases/download/v$ACT_VERSION/act_Linux_x86_64.tar.gz

if [ ! -d $HOME/bin ]; then
    mkdir -p $HOME/bin
fi
wget https://github.com/nektos/act/releases/latest/download/act_Linux_x86_64.tar.gz -O act.tar.gz
mkdir -p /tmp/act
sudo tar -xzvf act.tar.gz -C /tmp/act
mv /tmp/act/act $HOME/bin/
rm act.tar.gz
rm -rf /tmp/act

# TODO: Check if 'export PATH="$PATH:$HOME/bin"' already in ~/.bashrc
echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc
. $HOME/.bashrc
exec "$SHELL"
