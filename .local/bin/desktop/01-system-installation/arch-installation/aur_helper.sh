#!/usr/bin/env bash

# - Paru

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

URL="https://aur.archlinux.org"

declare -A HELPER=(
	#	["paru-bin"]="${URL}/paru-bin.git"
	["paru"]="${URL}/paru.git"
	#	["yay-bin"]="${URL}/yay-bin.git"
	["yay"]="${URL}/yay.git"
)

for i in "${!HELPER[@]}"; do
	if command -v "${i}" &>/dev/null; then
		echo "$i"
		unset HELPER["${i}"]
		HELPER+=(["${i} (Instalado)"]="${URL}/${i}")
	fi
done

ELEGIR_HELPER=$(gum choose --no-limit "${!HELPER[@]}")
echo "${ELEGIR_HELPER}"

if echo "${ELEGIR_HELPER}" | grep -q "Instalado"; then
	CONFIRMAR_HELPER=$(echo "${ELEGIR_HELPER}" | sed 's/ (Instalado)//')
else
	CONFIRMAR_HELPER="${ELEGIR_HELPER}"
fi

BIN=$(gum confirm \
	--affirmative="${CONFIRMAR_HELPER}-bin" \
	--negative="${CONFIRMAR_HELPER}" \
	"Qué versión de ${CONFIRMAR_HELPER} deseas instalar?")

if [[ "${BIN}" -eq 0 ]]; then
	echo "Binario"
	git clone "${HELPER[$ELEGIR_HELPER]}" "$tempdir/${CONFIRMAR_HELPER}"
	cd "$tempdir/${CONFIRMAR_HELPER}" && makepkg -si
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
