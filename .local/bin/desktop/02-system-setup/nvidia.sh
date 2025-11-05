#!/usr/bin/env bash

set -euo pipefail

pkg_nvidia=(
    "nvidia"
    "nvidia-utils"
    "lib32-nvidia-utils"
    "nvidia-settings"
)

if command -v "pacman" &> /dev/null; then
    sudo pacman -S --needed "${pkg_nvidia[@]}"

elif command -v "dnf" &> /dev/null; then
    sudo dnf install -y

else
    echo "Distro no soportada."
    exit 1
fi

sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia_drm.modeset=1"' \
    /etc/default/grub

lspci -k | grep -B 2 nvidia

echo -e "\nEs necesario un reboot."
