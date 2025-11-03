#!/usr/bin/env bash

# Revisar la configuración de ejemplo, y el modulo de media, escrito en python.

set -euo pipefail

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_waybar[@]}"
fi

# /etc/group
# input:x:994:($whoami)
sudo usermod -a -G input $(whoami)

cargo install gpu-usage-waybar

. ./rofi.sh
