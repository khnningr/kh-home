#!/usr/bin/env bash

set -euo pipefail

pkg_fonts=(
    "gnu-free-fonts"
	"noto-fonts"
	"noto-fonts-cjk"
	"noto-fonts-emoji"
	"noto-fonts-extra"
	"nerd-fonts"
	"ttf-nerd-fonts-symbols"
)

if command -v "pacman" &> /dev/null; then
    sudo pacman -S --needed "${pkg_fonts[@]}"

elif command -v "dnf" &> /dev/null; then
    sudo dnf install -y

else
    echo "Distro no soportada."
    exit 1
fi
