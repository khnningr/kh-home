#!/usr/bin/env bash

set -euo pipefail

pkg_hyprland=(
	"hyprland"
	"gcc"
	"jq"
	"xdg-desktop-portal-hyprland"
	"xdg-desktop-portal-gtk"
	"xdg-desktop-portal"
	"xdg-user-dirs"
	"hyprpicker"
	"gtk3"
	"gtk4"
	"libnotify"
	"hyprshot"
	"swww"
	"slurp"
	"grim"
	"cliphist"
	"wl-clipboard"
	"hyprcursor"
	"hyprlock"
	"hypridle"
	"libsecret"
	"gnome-keyring"
	"playerctl"
	"udiskie"
	"nwg-dock-hyprland"
	"imagemagick"
	"hyprsunset"
)

pkg_brightness=(
	"brightnessctl"
)

if command -v pacman &>/dev/null; then
	sudo pacman -S --needed --noconfirm "${pkg_hyprland[@]}"

	sudo pacman -S --needed --noconfirm "${pkg_brightness[@]}"
fi

if command -v dolphin &>/dev/null; then
	balooctl6 disable # Desactiva el indexador y buscador de archivos KDE
fi
