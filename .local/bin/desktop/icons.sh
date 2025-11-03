#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

mkdir -p ~/.local/share/icons/

dir_icons=(
    "Bibata-Modern-Ice"
    "Papirus-Dark"
    "Papirus-Light"
)

contador=0

for i in "${dir_icons[@]}"; do
    if [ -d "$HOME/.local/share/icons/$i/" ]; then
        contador=$((contador + 1))
    fi
done

if [[ "$contador" -eq 3 ]]; then
    echo -e "Deseas actualizar los icons? (s/n)"
    echo "...iconos del sistema y cursores."
    read -p "> " elegir_actualizar_icons
    echo ""
fi

elegir_actualizar_icons=${elegir_actualizar_icons:="n"}

elegir_actualizar_icons=${elegir_actualizar_icons^^}

# Papirus
# wget -qO- https://git.io/papirus-icon-theme-install | sh
if [[ "$elegir_actualizar_icons" == "S" ]] || [[ ! -d ~/.local/share/icons/Papirus/ ]] || [[ ! -d ~/.local/share/icons/Papirus-Dark/ ]] || [[ ! -d ~/.local/share/icons/Papirus-Light/ ]]; then
    git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git "$tempdir/Papirus"
    cp -r "$tempdir/Papirus/Papirus" ~/.local/share/icons/
    cp -r "$tempdir/Papirus/Papirus-Dark" ~/.local/share/icons/
    cp -r "$tempdir/Papirus/Papirus-Light" ~/.local/share/icons/
fi

if [[ "$elegir_actualizar_icons" == "S" ]] || [[ ! -d ~/.local/share/icons/Bibata-Modern-Ice/ ]]; then
    wget -O "$tempdir/Bibata-Modern-Ice.tar.xz" https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz
    tar -xf "$tempdir/Bibata-Modern-Ice.tar.xz" -C ~/.local/share/icons/
fi
