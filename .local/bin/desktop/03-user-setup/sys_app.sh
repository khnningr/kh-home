#!/usr/bin/env bash

set -euo pipefail



pkg_base=(
	"wezterm-git"
	"git"
	"github-cli"
	"curl"
	"wget"
	"nano"
	"neovim"
	"man-db"
	"man-pages"
	"man-pages-es"
	"tldr"
	"p7zip"
	"zip"
	"unzip"
	"unrar"
	"vlc"
	"vlc-plugins-all"
	"cameractrls"
	"btop"
	"downgrade"
	"ncspot"
	"stow"
	"python-pip"
	# "zed"
#	"openssh"
	"wiremix"
)

dir_obsidian="$HOME/Obsidian"

mkdir -p "$dir_obsidian/.obsidian/plugins/" "$HOME/.config/obsidian/"

if command -v pacman &> /dev/null; then
    sudo pacman -S --needed --noconfirm "${pkg_base[@]}"
fi
