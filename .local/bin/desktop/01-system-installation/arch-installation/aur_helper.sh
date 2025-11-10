#!/usr/bin/env bash

# - Paru

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

URL="https://aur.archlinux.org"

declare -A HELPER=(
	#	["paru-bin"]="${URL}/paru-bin.git"
	["paru"]="${URL}/paru"
	#	["yay-bin"]="${URL}/yay-bin.git"
	["yay"]="${URL}/yay"
)

declare -A OPC_HELPER

for i in "${!HELPER[@]}"; do
	if command -v "${i}" &>/dev/null; then
		# unset HELPER["${i}"]
		OPC_HELPER+=(["${i} (Instalado)"]="${URL}/${i}")
	else
		OPC_HELPER+=(["${i}"]="${URL}/${i}")
	fi
done

ELEGIR_HELPER=$(gum choose --no-limit "${!OPC_HELPER[@]}")

for i in "${!HELPER[@]}"; do
	if echo "${ELEGIR_HELPER}" | grep -q "${i}"; then
		AUR_HELPER=${i}
	fi
done
# yay-bin-debug paru-bin-debug
# Hacer validacion del debug instalado si actualmente es el mismo, en caso de cambiar de bin a normal o viseversa para evitar conflictos de paquetes

echo -e "${HELPER[$AUR_HELPER]}"

PLACE_CONFIRM="Qué versión de ${AUR_HELPER} deseas instalar?"

if gum confirm --affirmative="${AUR_HELPER}-bin" --negative="${AUR_HELPER}" "${PLACE_CONFIRM}"; then
	git clone "${HELPER[$AUR_HELPER]}-bin.git" "$tempdir/${AUR_HELPER}-bin"
	cd "$tempdir/${AUR_HELPER}-bin" && makepkg -si
else
	git clone "${HELPER[$AUR_HELPER]}.git" "$tempdir/${AUR_HELPER}"
	cd "$tempdir/${AUR_HELPER}" && makepkg -si
fi

exit 0

if echo "${ELEGIR_HELPER}" | grep -q "paru"; then
	sudo pacman -S --needed --noconfirm base-devel rustup
	rustup default stable
fi

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
