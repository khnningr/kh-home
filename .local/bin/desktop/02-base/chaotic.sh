#!/usr/bin/env bash

# - Chaotic
# - Mesa-git

set -euo pipefail

# Referencia: https://aur.chaotic.cx
if ! grep -q "chaotic-aur" /etc/pacman.conf; then
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    sudo cp ./pacman.conf /etc/pacman.conf
    sudo pacman -Sy
fi
