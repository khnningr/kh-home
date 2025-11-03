#!/usr/bin/env bash

set -euo pipefail

echo -e "Elija su administrador de archivos (elija opción)"
echo "1. Thunar"
echo "2. Yazi"
echo "3. Dolphin"
read -p "> " elegir_file_manager
echo ""

elegir_file_manager=${elegir_file_manager:="1"}

case "$elegir_drivers" in
    1) # Opción Thunar
        . ./thunar.sh
        ;;
    2) # Opción Yazi
        . ./yazi.sh
        ;;
    3) # Opción Dolphin
        . ./dolphin.sh
        ;;
    *) # Opción no válida.
        echo "Opción no válida."
        ;;
esac
