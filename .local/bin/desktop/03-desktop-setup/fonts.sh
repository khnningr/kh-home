#!/usr/bin/env bash

set -euo pipefail

pkg_fonts=(
	"gnu-free-fonts"
	"noto-fonts"
	"noto-fonts-cjk"   # soporte a carácteres asiaticos.
	"noto-fonts-emoji" # Soporte a emojis.
	"noto-fonts-extra"
	"nerd-fonts"
	"ttf-nerd-fonts-symbols"
)

if command -v "pacman" &>/dev/null; then
	sudo pacman -S --needed "${pkg_fonts[@]}"

elif command -v "dnf" &>/dev/null; then
	sudo dnf install -y

else
	echo "Distro no soportada."
	exit 1
fi

FONT_PATH=$(fc-list | grep -i "NotoSansCJK-Regular.ttc" | cut -d: -f1 | head -n1)
if [[ -n "$FONT_PATH" ]] && command -v steam; then
	mkdir -p ~/.steam/steam/steamui/fonts
	cp "$FONT_PATH" ~/.steam/steam/steamui/fonts/
fi
