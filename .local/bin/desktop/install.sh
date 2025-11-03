#!/usr/bin/env bash

set -euo pipefail

clear

echo -e "Agregar controladores AMD? (s/n)"
read -p "> " elegir_graficos
echo ""

echo -e "Display manager (elija opción)"
echo "1. ly"
echo "2. tty"
read -p "> " elegir_display
echo ""

echo -e "Barra de estado (elija opción)"
echo "1. Ax-Shell"
echo "2. Waybar"
read -p "> " elegir_barra
echo ""

echo -e "Elija su administrador de archivos (elija opción)"
echo "1. Thunar"
echo "2. Yazi"
read -p "> " elegir_file_manager
echo ""

echo -e "Instalar algunas utilidades? (s/n)"
echo "...agrega el paquete openrazer."
read -p "> " elegir_utils
echo ""

echo -e "Instalar Virt-Manager? (s/n)"
echo "...permite ejecutar maquinas virtuales."
read -p "> " elegir_virt_manager
echo ""

# echo -e "Instalar UFW? (s/n)"
# echo "...es un firewall"
# read -p "> " elegir_ufw
# echo ""

echo -e "Instalar firewalld? (s/n)"
echo "...es un firewall"
read -p "> " elegir_firewalld
echo ""

echo -e "Soporte a videojuegos? (s/n)"
read -p "> " elegir_juegos
echo ""

echo -e "Agregar android-tools? (s/n)"
echo "...es el soporte de ADB en Linux."
read -p "> " elegir_android
echo ""

echo -e "Desea instalar LibreOffice? (s/n)"
read -p "> " elegir_libreoffice
echo ""

echo -e "Soporte para algunos perifericos Corsair? (s/n)"
echo "...agrega el paquete ckn-next."
read -p "> " elegir_corsair
echo ""

echo -e "Soporte para algunos perifericos Razer? (s/n)"
echo "...agrega el paquete openrazer."
read -p "> " elegir_razer
echo ""

#echo -e "Habilitar soporte para plugins de Hyprland? (s/n)"
#read -p "> " elegir_plugins
#echo ""

elegir_graficos=${elegir_graficos:="S"}
elegir_display=${elegir_display:="1"}
elegir_barra=${elegir_barra:="1"}
elegir_file_manager=${elegir_file_manager:="2"}
elegir_utils=${elegir_utils:="S"}
elegir_virt_manager=${elegir_virt_manager:="S"}
elegir_ufw=${elegir_ufw:="S"}
elegir_firewalld=${elegir_firewalld:="S"}
elegir_juegos=${elegir_juegos:="S"}
elegir_android=${elegir_android:="S"}
elegir_libreoffice=${elegir_libreoffice:="S"}
elegir_corsair=${elegir_corsair:="S"}
elegir_razer=${elegir_razer:="S"}
elegir_plugins=${elegir_plugins:="n"}

if command -v pacman &> /dev/null; then
    . ./pacman.sh
    . ./pkg_arch.sh
fi

. ./hyprland.sh

. ./base.sh

. ./themes.sh

. ./fonts.sh

. ./icons.sh

if [[ "$elegir_graficos" == "s" ]] || [[ "$elegir_graficos" == "S" ]]; then
    . ./amd.sh
fi

if [[ "$elegir_display" == "1" ]]; then
    . ./ly.sh
elif [[ "$elegir_display" == "2" ]]; then
    . ./tty_display.sh
fi

if [[ ! "$elegir_barra" == "1" ]]; then
    . ./ax_shell.sh
elif [[ "$elegir_barra" == "2" ]]; then
    . ./waybar.sh
fi

if [[ "$elegir_file_manager" == "1" ]]; then
    . ./thunar.sh
elif [[ "$elegir_file_manager" == "2" ]]; then
    . ./yazi.sh
fi

if [[ "$elegir_utils" == "s" ]] || [[ "$elegir_utils" == "S" ]]; then
    . ./utils.sh
fi

if [[ "$elegir_virt_manager" == "s" ]] || [[ "$elegir_virt_manager" == "S" ]]; then
    . ./virt_manager.sh
fi

# if [[ "$elegir_ufw" == "s" ]] || [[ "$elegir_ufw" == "S" ]]; then
#    . ./ufw.sh
# fi

if [[ "$elegir_firewalld" == "s" ]] || [[ "$elegir_firewalld" == "S" ]]; then
    . ./firewalld.sh
fi

if [[ "$elegir_juegos" == "s" ]] || [[ "$elegir_juegos" == "S" ]]; then
    . ./games.sh
fi

if [[ "$elegir_android" == "s" ]] || [[ "$elegir_android" == "S" ]]; then
    . ./android.sh
fi

if [[ "$elegir_libreoffice" == "s" ]] || [[ "$elegir_libreoffice" == "S" ]]; then
    . ./libreoffice.sh
fi

if [[ "$elegir_corsair" == "s" ]] || [[ "$elegir_corsair" == "S" ]]; then
    . ./ckb-next.sh
fi

if [[ "$elegir_razer" == "s" ]] || [[ "$elegir_razer" == "S" ]]; then
    . ./openrazer.sh
fi

if [[ "$elegir_plugins" == "s" ]] || [[ "$elegir_plugins" == "S" ]]; then
    . ./plugins_hyprland.sh
fi

. ./stow.sh

. ./default_applications.sh

. ./zsh.sh
