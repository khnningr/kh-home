#!/usr/bin/env bash

set -euo pipefail

if command -v "pacman" &> /dev/null; then
    sudo pacman -S --needed gum
fi

# Selección de drivers de vídeo (AMD | Nvidia | Virtual Machine)

GPU=(
    "AMD"
    "Intel"
    "Nvidia"
    "Máquina virtual"
)

ELEGIR_GPU=$(gum choose --header "Tarjeta gráfica (elija una opción):" "${GPU[@]}")

case "$ELEGIR_GPU" in
    "AMD") # Opción AMD
        ./amd.sh
        ;;
    2) # Opción Intel
        ./intel.sh
        ;;
    3) # Opción Nvidia
        ./nvidia.sh
        ;;
    4)
        echo "Agregar paquetes de VM drivers." # sudo pacman -S mesa xf86-video-vesa xf86-video-fbdev qemu-guest-agent spice-vdagent
        sudo sed -i \
            's/Exec=Hyprland/Exec=env WLR_NO_HARDWARE_CURSORS=1 WLR_RENDERER_ALLOW_SOFTWARE=1 Hyprland/' \
            /usr/share/wayland-sessions/hyprland.desktop
        # Configurar resolución
        echo "monitor = pendiente, 1920x1080@pendiente, auto, auto" > .config/hypr/extra/monitors/VM.conf
        sed -i 's/source = ../extra/monitors/*.conf/source = ../extra/monitors/VM.conf/' \
            "$HOME/.config/hypr/core/monitor.conf"


        ;;
    *) # Opción no válida.
        echo -e "Opción no válida. Intente de nuevo.\n"
        ./graphics.sh
        ;;
esac
