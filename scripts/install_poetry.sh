#!/bin/bash

set -e

# Ensure pipx bin is in PATH
pipx ensurepath -f

# Install Poetry
echo "Installing Poetry with Pipx..."
pipx install poetry
poetry completions bash >> $HOME/.bash_completion
. $HOME/.bash_completion
exec "$SHELL"
