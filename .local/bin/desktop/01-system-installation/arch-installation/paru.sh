#!/usr/bin/env bash

set -euo pipefail
tempdir="$HOME"/.clone
# Paru
# Referencia: https://github.com/Morganamilo/paru
if ! command -v "paru" &>/dev/null; then
	sudo pacman -S --needed --noconfirm base-devel rustup
	rustup default stable
	(
		git clone https://aur.archlinux.org/paru.git "$tempdir/paru"
		cd "$tempdir/paru" && makepkg -si
	)
fi
