#!/usr/bin/env bash

set -euo pipefail

# mesa is the DRI driver for 3D acceleration.
pkg_mesa_git=(
	"mesa-git"
	"lib32-mesa-git"
)

pkg_mesa=(
    "mesa"
    "lib32-mesa"
)

# vulkan-intel adds Vulkan support.
# intel-media-driver adds VA-API accelerated video decoding.
pkg_intel=(
    "vulkan-intel"
    "lib32-vulkan-intel"
    "intel-media-driver"
)

if command -v "pacman" &> /dev/null; then
    sudo pacman -S --needed "${pkg_intel[@]}"
    if grep -q "mesa-git" /etc/pacman.conf; then
        sudo pacman -S --needed "${pkg_mesa_git[@]}"
    else
        sudo pacman -S --needed "${pkg_mesa[@]}"
    fi

elif command -v "dnf" &> /dev/null; then
    sudo dnf install -y

else
    echo "Distro no soportada."
    exit 1
fi

echo -e "\nEs necesario un reboot."
