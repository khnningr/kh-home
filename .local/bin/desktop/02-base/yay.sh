#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

# yay
if ! command -v "yay" &>/dev/null; then
	sudo pacman -S --needed --noconfirm base-devel git
	(
		git clone https://aur.archlinux.org/yay.git "$tempdir/yay"
		cd "$tempdir/yay" && makepkg -si
	)
fi
