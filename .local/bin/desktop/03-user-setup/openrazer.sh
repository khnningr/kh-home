#!/usr/bin/env bash

set -euo pipefail

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_openrazer[@]}"
    paru -s --needed --noconfirm "${pkg_openrazer_aur[@]}"
fi

sudo gpasswd -a $USER plugdev
