#!/usr/bin/bash

set -e

JAMMY=jammy
PY_VERSION='3.11'

echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu $JAMMY main" | sudo tee /etc/apt/sources.list.d/deadsnakes-ppa.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6A755776
sudo apt update
sudo apt install -y python$PY_VERSION
sudo ln -s /usr/bin/python$PY_VERSION /usr/local/bin/python
sudo apt install -y python3-pip python3-venv
