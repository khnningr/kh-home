#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

mkdir -p ~/.themes ~/.config/gtk-4.0

dir_themes=(
    "Kvantum-Tokyo-Night"
    "Tokyonight-Dark"
    "Tokyonight-Light"
)

contador=0

for i in "${dir_themes[@]}"; do
    if [ -d "$HOME/.themes/$i/" ]; then
        contador=$((contador + 1))
    fi
done

if [[ "$contador" -eq 3 ]]; then
    echo -e "Deseas actualizar los temas? (s/n)"
    read -p "> " elegir_actualizar_temas
    echo ""
fi

elegir_actualizar_temas=${elegir_actualizar_temas:="n"}

elegir_actualizar_temas=${elegir_actualizar_temas^^}

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_theme[@]}"
fi

if [[ "$elegir_actualizar_temas" == "S" ]] || [[ ! -d "$HOME/.themes/Kvantum-Tokyo-Night/" ]]; then
    git clone https://github.com/0xsch1zo/Kvantum-Tokyo-Night.git "$tempdir/Kvantum-Tokyonight"
    cp -r "$tempdir/Kvantum-Tokyonight/Kvantum-Tokyo-Night/" ~/.themes/
fi

if [[ "$elegir_actualizar_temas" == "S" ]] || [[ ! -d "$HOME/.themes/Tokyonight-Dark" ]] || [[ ! -d "$HOME/.themes/Tokyonight-Light" ]]; then
    git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git "$tempdir/Tokyonight-GTK-Theme"
    (
        cd "$tempdir/Tokyonight-GTK-Theme/themes/" && ./install.sh
    )
fi
