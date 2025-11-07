#!/usr/bin/env bash

set -euo pipefail

pkg_utils=(
	"fragments"
	"kooha"
	"pinta"
	"obsidian"
	"handbrake"
	"btop"
	"obs-studio"
	"ffmpegthumbnailer"
	"zathura"
	"zathura-cb"
	"zathura-pdf-mupdf"
	"imv"
	"copyq"
	"wf-recorder"
)

pkg_utils_aur=(
	"ventoy"
	"calligraphy"
	"headsetcontrol-git"
)

if command -v pacman &>/dev/null; then
	sudo pacman -S --needed --noconfirm "${pkg_utils[@]}"
	paru -S --needed --noconfirm "${pkg_utils_aur[@]}"
fi
