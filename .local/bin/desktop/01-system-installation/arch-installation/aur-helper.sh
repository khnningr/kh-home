#!/usr/bin/env bash

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
STYLE_TITLE="Instalación de un $(gum style --foreground 212 'Helper AUR')"
export GUM_CHOOSE_HEADER="Seleccione un helper:"

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

# Crear un directorio temporal y lo elimina al terminar la ejecución
tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

# URL aur
URL="https://aur.archlinux.org"

# Diccionario con los helpers soportados por el script
declare -A HELPER=(
	["paru"]="${URL}/paru"
	["yay"]="${URL}/yay"
)

# Este diccionario es usado para crear el choose formateando
# los que están instalados
declare -A OPC_HELPER=()

# Este for itera el diccionario de HELPER y los guarda en
# OPC_HELPER e indica cual está instalado para mostrar en
# el choose
for i in "${!HELPER[@]}"; do
	if command -v "${i}" &>/dev/null; then
		OPC_HELPER+=(["${i} (Instalado)"]="${URL}/${i}")
	else
		OPC_HELPER+=(["${i}"]="${URL}/${i}")
	fi
done

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

	# Choose que permite seleccionar un helper
	ELEGIR_HELPER=$(gum choose "${!OPC_HELPER[@]}")
	if [[ ! -z "${ELEGIR_HELPER}" ]]; then
		break
	fi
done

# Este for itera el diccionario de HELPER y guarda la clave
# correcta ya que puede que ELEGIR_HELPER tenga "instalado"
# dentro de su valor, al formatearlo coincido con la clave
# del diccionario HELPER
for i in "${!HELPER[@]}"; do
	if echo "${ELEGIR_HELPER}" | grep -q "${i}"; then
		AUR_HELPER=${i}
	fi
done

# Valida si el helper elegido es paru e instala sus dependencias
if echo "${AUR_HELPER}" | grep -q "paru"; then
	sudo pacman -S --needed --noconfirm base-devel rustup
	rustup default stable
fi

# Valida si el helper elegido es yay e instala sus dependencias
if echo "${AUR_HELPER}" | grep -q "yay"; then
	sudo pacman -S --needed --noconfirm base-devel yay
fi

# Mensaje de confirmación para el confirm
PLACE_CONFIRM="Qué versión de ${AUR_HELPER} deseas instalar?"

# Condicional que dentro permite elegir entre las dos versiones: bin o copilar
if gum confirm --affirmative="${AUR_HELPER}-bin" --negative="${AUR_HELPER}" "${PLACE_CONFIRM}"; then

	# Valida si está instalado la versión copilada y desistala para evitar conflictos
	if pacman -Qq "${AUR_HELPER}-debug" &>/dev/null; then
		sudo pacman -Rns "${AUR_HELPER}-debug" "${AUR_HELPER}"
	fi

	# Hace un git clone dentro del directorio temporal
	git clone "${HELPER[$AUR_HELPER]}-bin.git" "$tempdir/${AUR_HELPER}-bin"
	# Hace un cd al directorio temporal e instala el helper
	cd "$tempdir/${AUR_HELPER}-bin" && makepkg -si

else

	# Valida si esta instalado la versión binaria y desinstala para evitar conflictos
	if pacman -Qq "${AUR_HELPER}-bin-debug" &>/dev/null; then
		sudo pacman -Rns "${AUR_HELPER}-bin-debug" "${AUR_HELPER}-bin"
	fi

	# Hace un git clone dentro del directorio temporal
	git clone "${HELPER[$AUR_HELPER]}.git" "$tempdir/${AUR_HELPER}"
	# Hace un cd al directorio temporal e instala el helper
	cd "$tempdir/${AUR_HELPER}" && makepkg -si

fi
