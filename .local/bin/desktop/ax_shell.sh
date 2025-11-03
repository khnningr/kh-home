#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

paru -S --needed python-fabric

if [[ ! -d "$HOME/.config/Ax-Shell" ]]; then
    git clone https://github.com/Axenide/Ax-Shell.git ~/.config/Ax-Shell
    python ~/.config/Ax-Shell/main.py > /dev/null 2>&1 & disown

    curl -fsSL https://raw.githubusercontent.com/Axenide/Ax-Shell/main/install.sh | bash

fi

rm -rf "$HOME/.config/Ax-Shell/config/hypr"

sed -i 's/# Ax-Shell//' "$HOME/.config/hypr/hyprland.conf"
sed -i 's|source = ~/.config/Ax-Shell/config/hypr/ax-shell.conf||' "$HOME/.config/hypr/hyprland.conf"

hyprctl reload
