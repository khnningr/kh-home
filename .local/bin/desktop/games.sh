#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

# Menu de selección de paquetes: retro, mango y mods.

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_wine[@]}"
    sudo pacman -S --needed --noconfirm "${pkg_proton[@]}"
    # True que menciona si instalar los paquetes, retro, mango y mods.
    sudo pacman -S --needed --noconfirm "${pkg_retro[@]}"
    sudo pacman -S --needed --noconfirm "${pkg_mango[@]}"
    paru -S --needed --noconfirm "${pkg_mango_aur[@]}"
    paru -S --needed --noconfirm "${pkg_mods_aur[@]}"
fi
