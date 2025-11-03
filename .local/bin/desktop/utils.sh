#!/usr/bin/env bash

set -euo pipefail

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_utils[@]}"
    paru -S --needed --noconfirm "${pkg_utils_aur[@]}"
fi
