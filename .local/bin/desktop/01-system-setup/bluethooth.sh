#!/usr/bin/env bash

set -euo pipefail

pkg_blue=(
	"bluez"
	"bluez-utils"
	"blueman"
)

if command -v "pacman" &> /dev/null; then
    sudo pacman -S --needed --noconfirm "${pkg_blue[@]}"
elif command -v "dnf" &> /dev/null; then
    sudo dnf install -y "${pkg_blue[@]}"
else
    echo "Distro no soportada."
    exit 1
fi

if command -v "bluetoothctl" &> /dev/null; then
    if ! systemctl list-units --type=service | grep -q "bluetooth.service"; then
        sudo systemctl enable --now bluetooth.service
    fi
fi
