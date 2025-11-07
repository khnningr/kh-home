#!/usr/bin/env bash

set -euo pipefail

if command -v "pacman" &>/dev/null; then
	. ./list_arch.sh
	sudo pacman -S --needed --noconfirm "${pkg_thunar[@]}"
fi

bookmarks="$HOME/.config/gtk-3.0/bookmarks"

mkdir -p "$HOME/.config/gtk-3.0"

[[ -f "${bookmarks}" ]] || touch "${bookmarks}"

dir_acceso=(
	"Descargas"
	"Documentos"
	"Música"
	"Vídeos"
	"Imágenes"
	"Wallpapers"
	"hyprcrow"
	".config"
)

for dir in "${dir_acceso[@]}"; do
	if [[ -d "$HOME/${dir}" ]] && ! grep -q "${dir}" "${bookmarks}"; then

		echo "file:///home/$(whoami)/${dir}" >>"${bookmarks}"
	fi
done
