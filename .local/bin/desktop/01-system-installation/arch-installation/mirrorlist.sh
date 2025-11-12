#!/usr/bin/env bash

# Esté script es solo para distro basadas
# en Arch Linux. Se usa para generar los
# mirrorlist más adecuados.

set -euo pipefail

# Este script solo funciona en Arch
if ! command -v "pacman" &>/dev/null; then
	echo "Este script es exclusivo para Arch Linux"
	exit 1
fi

# Validar la instalación de Gum
if ! command -v gum &>/dev/null; then
	sudo pacman -S gum
fi

# --- Varables de entorno
# Textos dentro de Gum
STYLE_TITLE="Generación de $(gum style --foreground 212 'Mirrorlist')"
export GUM_CHOOSE_HEADER="Seleccione un generador:"

# Diseño del Prefix en Choose
export GUM_CHOOSE_CURSOR_PREFIX="[ ] "
export GUM_CHOOSE_SELECTED_PREFIX="[×] "
export GUM_CHOOSE_UNSELECTED_PREFIX="[ ] "
export GUM_CHOOSE_CURSOR="  "

# Opciones de Confirm
export GUM_CONFIRM_TIMEOUT=10s

# Estilo del título
STYLE_BORDER="double"
STYLE_MARGIN="1"
STYLE_PADDING="1 2"
STYLE_ALIGN="center"
STYLE_WIDTH="50"
STYLE_BORDER_FOREGROUND="212"

if gum confirm --affirmative="Respaldar" "Deseas respaldar tus mirrorlist actuales?"; then
	sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
fi

OPC_GENERADOR=(
	"reflector"
	"rate-mirrors"
)

if command -v yay &>/dev/null; then
	AUR_HELPER="yay"
fi

if command -v paru &>/dev/null; then
	AUR_HELPER="paru"
fi

# Este while true ejecuta un loop hasta que se elije un helper
while true; do
	clear
	# Banner de instalación
	gum style \
		--border "${STYLE_BORDER}" \
		--margin "${STYLE_MARGIN}" \
		--padding "${STYLE_PADDING}" \
		--align "${STYLE_ALIGN}" \
		--width "${STYLE_WIDTH}" \
		--border-foreground "${STYLE_BORDER_FOREGROUND}" \
		"${STYLE_TITLE}"
	echo -e "Método de actualización de mirrorlist (elija una opción)"
	echo -e "...el archivo generado se guarda en /etc/pacman.d/mirrorlist\n"
	# Choose que permite seleccionar un helper
	ELEGIR_GENERADOR=$(gum choose "${OPC_GENERADOR[@]}")
	if [[ ! -z "${ELEGIR_GENERADOR}" ]]; then
		break
	fi
done

# Valida si el helper elegido es yay e instala sus dependencias
if echo "${ELEGIR_GENERADOR}" | grep -q "reflector"; then
	sudo pacman -S --needed reflector

	sudo reflector --latest 10 \
		--country "Sweden,Finland,Mexico,Austria,Japan,Spain,United Kingdom,United States,Switzerland,Italy" \
		--sort rate --save /etc/pacman.d/mirrorlist
	sudo systemctl enable --now reflector.timer

fi

case "${ELEGIR_GENERADOR}" in
"reflector")
	sudo pacman -S --needed reflector

	sudo reflector --latest 10 \
		--country "Sweden,Finland,Mexico,Austria,Japan,Spain,United Kingdom,United States,Switzerland,Italy" \
		--sort rate --save /etc/pacman.d/mirrorlist
	sudo systemctl enable --now reflector.timer
	;;
"rate-mirrors")
	sudo pacman -S --needed --noconfirm rate-mirrors ||
		"${AUR_HELPER}" -S --needed rate-mirrors

	if command -v rate-mirrors &>/dev/null; then
		rate-mirrors --allow-root --protocol https arch |
			sudo tee /etc/pacman.d/mirrorlist
	fi
	;;
*)
	echo -e "Opción no válida. Intente de nuevo.\n"
	./mirrorlist.sh
	;;
esac
