#!/usr/bin/env bash

set -euo pipefail

# yay
if ! command -v "yay" &> /dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
    (
        git clone https://aur.archlinux.org/yay.git "$tempdir/yay"
        cd "$tempdir/yay" && makepkg -si
    )
fi
