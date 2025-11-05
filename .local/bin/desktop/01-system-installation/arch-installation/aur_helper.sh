#!/usr/bin/env bash

# - Paru

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

echo -e "AUR Helper (elija una opción)"
echo "1. paru"
echo "2. yay"
read -p "> " elegir_helper
echo ""

elegir_helper=${elegir_helper:="1"}

case "$elegir_helper" in
    1) # Opción paru
        ./paru.sh
        ;;
    2) # Opción yay
        ./yay.sh
        ;;
    *) # Opción no válida.
        echo -e "Opción no válida. Intente de nuevo.\n"
        ./aur_helper.sh
        ;;
esac
