#!/usr/bin/env bash

# Esté script es solo para distro basadas
# en Arch Linux. Se usa para generar los
# mirrorlist más adecuados.

set -euo pipefail

if ! command -v pacman &> /dev/null; then
	echo "Este script es exclusivo para Arch."
	exit 1
fi

echo -e "Método de actualización de mirrorlist (elija una opción)"
echo "...el archivo generado se guarda en /etc/pacman.d/mirrorlist"
echo "1. reflector"
echo "2. rate-mirrors"
read -p "> " elegir_generador
echo ""

elegir_generador=${elegir_generador:="2"}

case "$elegir_generador" in
    1) # reflector
        sudo pacman -S --needed reflector
        echo "...espere mistras se generan los mirrorlist!"
        sudo reflector --latest 10 \
            --country "Sweden,Finland,Mexico,Austria,Japan,Spain,United Kingdom,United States,Switzerland,Italy" \
            --sort rate --save /etc/pacman.d/mirrorlist
        sudo systemctl enable reflector.timer
        ;;
    2) # rate-mirrors
        sudo pacman -S --needed --noconfirm rate-mirrors || \
            paru -S --needed rate-mirrors
        rate-mirrors --allow-root --protocol https arch | \
            sudo tee /etc/pacman.d/mirrorlist
        ;;
    *) # Opción no válida.
        echo -e "Opción no válida. Intente de nuevo.\n"
        ./mirrorlist_arch.sh
        ;;
esac
