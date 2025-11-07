#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

# Menu de selección de paquetes: retro, mango y mods.

pkg_wine=(
	"wine-staging"
	"wine-mono"
	"wine-gecko"
	"winetricks"
)
# Puedes usar el comando 'wine winecfg'
# para configurar Wine con una GUI.

pkg_proton=(
	"steam"
	"protonplus"
	# "bottles"
	"heroic-games-launcher-bin"
)

pkg_retro=(
	"retroarch"
	"retroarch-assets-xmb"
	"retroarch-assets-ozone"
)

pkg_mods_aur=(
	"nexusmods-app-bin"
	"faugus-launcher"
)

if command -v pacman &>/dev/null; then
	sudo pacman -S --needed --noconfirm "${pkg_wine[@]}"
	sudo pacman -S --needed --noconfirm "${pkg_proton[@]}"
	# True que menciona si instalar los paquetes, retro, mango y mods.
	sudo pacman -S --needed --noconfirm "${pkg_retro[@]}"
	paru -S --needed --noconfirm "${pkg_mods_aur[@]}"
fi
