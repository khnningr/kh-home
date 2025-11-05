#!/usr/bin/env bash

set -euo pipefail

pkg_libreoffice=(
	"libreoffice-fresh"
	"libreoffice-fresh-es"
	"hyphen"
	"hyphen-es"
	"mythes-es"
)

if command -v pacman &> /dev/null; then
    sudo pacman -S --needed --noconfirm "${pkg_libreoffice[@]}"
fi

if command -v dnf &> /dev/null; then
    pkg_libreoffice=(
        "curl"
        "cabextract"
        "xorg-x11-font-utils"
        "fontconfig"
    )
    sudo dnf install "${pkg_libreoffice[@]}" -y
    sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
fi
