#!/usr/bin/bash

set -e

echo "Installing Nix Package Manager..."
sudo apt update && sudo apt install -y xz-utils
sh <(curl -L https://nixos.org/nix/install) --daemon --yes

echo "Adding Nix Command and Flakes in Nix Configuration File..."
nix_conf="$HOME/.config/nix/nix.conf"
mkdir -p "$(dirname $nix_conf)"
echo 'experimental-features = nix-command flakes' >> $nix_conf
exec "$SHELL"
