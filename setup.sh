#!/bin/bash

set -e

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd-lsa"

INSTALL_PATH="$CONFIG_DIR/systemd-lsa.sh"
HELP_PATH="$CONFIG_DIR/systemd-lsa-help.sh"

BASHRC="${BASHRC:-$HOME/.bashrc}"

mkdir -p "$CONFIG_DIR"

curl -sL "https://raw.githubusercontent.com/rockberpro-dev/systemd-lsa/main/systemd-lsa.sh" -o "$INSTALL_PATH"

if ! grep -qF "source \"$INSTALL_PATH\"" "$BASHRC" 2>/dev/null; then
    echo "" >> "$BASHRC"
    echo "source \"$INSTALL_PATH\"" >> "$BASHRC"
fi

curl -sL "https://raw.githubusercontent.com/rockberpro-dev/systemd-lsa/main/systemd-lsa-help.sh" -o "$HELP_PATH"
chmod +x "$HELP_PATH"

echo "systemd-lsa installed: $INSTALL_PATH"
echo "systemd-lsa help installed: $HELP_PATH"
echo "Run 'source ~/.bashrc' or open a new terminal to activate."
