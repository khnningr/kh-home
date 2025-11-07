#!/usr/bin/env bash

set -euo pipefail

. ./list_arch.sh

# Podria agregar ifs que confirmen la instalación de paquetes.

sudo pacman -S --needed --noconfirm "${pkg_theme[@]}"

paru -S --needed --noconfirm "${pkg_theme_aur[@]}"

sudo pacman -S --needed --noconfirm "${pkg_gtk[@]}"

sudo pacman -S --needed --noconfirm "${pkg_browser[@]}"

sudo pacman -S --needed --noconfirm "${pkg_msg[@]}"
