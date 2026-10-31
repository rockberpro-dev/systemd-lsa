#!/bin/bash

set -e

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd-lsa"

INSTALL_PATH="$CONFIG_DIR/systemd-lsa.sh"
HELP_PATH="$CONFIG_DIR/systemd-lsa-help.sh"

BASHRC="${BASHRC:-$HOME/.bashrc}"

mkdir -p "$CONFIG_DIR"

cp "$SRC_DIR/systemd-lsa.sh" "$INSTALL_PATH"

if ! grep -qF "source \"$INSTALL_PATH\"" "$BASHRC" 2>/dev/null; then
    echo "" >> "$BASHRC"
    echo "source \"$INSTALL_PATH\"" >> "$BASHRC"
fi

cp "$SRC_DIR/systemd-lsa-help.sh" "$HELP_PATH"
chmod +x "$HELP_PATH"

echo "systemd-lsa installed: $INSTALL_PATH"
echo "systemd-lsa help installed: $HELP_PATH"
echo "Run 'source ~/.bashrc' or open a new terminal to activate."
