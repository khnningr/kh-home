#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

FONT_DIR="~/.local/share/fonts/"

mkdir -p "${FONT_DIR}"

dir_fonts=(
    "IosevkaTerm"
    "Hack"
    "JetBrainsMono"
    "Mononoki"
)

contador=0

for i in "${dir_fonts[@]}"; do
    if [ -d "$HOME/.local/share/fonts/$i/" ]; then
        contador=$((contador + 1))
    fi
done

if [[ "$contador" -eq 4 ]]; then
    echo -e "Deseas actualizar las fonts? (s/n)"
    read -p "> " elegir_actualizar_fonts
    echo ""
fi

elegir_actualizar_fonts=${elegir_actualizar_fonts:="n"}

elegir_actualizar_fonts=${elegir_actualizar_fonts^^}

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_fonts[@]}"
fi

if [[ "$elegir_actualizar_fonts" == "S" ]] || [[ ! -d ~/.local/share/fonts/IosevkaTerm/ ]]; then
    wget -O "$tempdir/IosevkaTerm.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip
    unzip -o "$tempdir/IosevkaTerm.zip" -d ~/.local/share/fonts/IosevkaTerm/
fi

if [[ "$elegir_actualizar_fonts" == "S" ]] || [[ ! -d ~/.local/share/fonts/Hack/ ]]; then
    wget -O "$tempdir/Hack.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
    unzip -o "$tempdir/Hack.zip" -d ~/.local/share/fonts/Hack/
fi

if [[ "$elegir_actualizar_fonts" == "S" ]] || [[ ! -d ~/.local/share/fonts/JetBrainsMono/ ]]; then
    wget -O "$tempdir/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
    unzip -o "$tempdir/JetBrainsMono.zip" -d ~/.local/share/fonts/JetBrainsMono/
fi

if [[ "$elegir_actualizar_fonts" == "S" ]] || [[ ! -d ~/.local/share/fonts/Mononoki/ ]]; then
    wget -O "$tempdir/Mononoki.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip
    unzip -o "$tempdir/Mononoki.zip" -d ~/.local/share/fonts/Mononoki/
fi

if ! fc-list | grep -qi "IosevkaTerm"; then

    curl -fLo "${tempdir}/IosevkaTerm.zip" \
      https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip

    unzip -o IosevkaTerm.zip -d "${FONT_DIR}"

fi

fc-cache -fv
