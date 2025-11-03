#!/usr/bin/env bash

set -euo pipefail

# Referencias: https://github.com/fairyglade/ly

displays=(
    lightdm
    gdm
    lxdm
    lxdm-gtk3
    sddm
)

if command -v pacman &> /dev/null; then
    sudo pacman -S --needed --noconfirm ly
fi

for display_manager in "${displays[@]}"; do
    if sudo pacman -Q "$display_manager" &> /dev/null; then
        echo -e "Desactivando $display_manager..."
        sudo systemctl disable "$display_manager" 2>&1
        echo -e "Eliminando el paquete $display_manager y sus dependencias ..."
        sudo pacman -Rns "$display_manager"
        echo
    fi
done

if whereis ly &> /dev/null; then
    echo -e "Activando ly service..."
    sudo systemctl enable ly.service 2>&1

    sudo sed -i 's/animation = none/animation = doom/' /etc/ly/config.ini
    sudo sed -i 's/clear_password = false/clear_password = true/' /etc/ly/config.ini
    sudo sed -i 's/clock = null/clock = %I:%M %P/' /etc/ly/config.ini
    sudo sed -i 's/lang = en/lang = es/' /etc/ly/config.ini
fi
