#!/usr/bin/env bash

#set -euo pipefail

# Validar la instalación de Gum
if ! command -v gum &>/dev/null; then
	sudo pacman -S gum
fi

# --- Varables de entorno
# Textos dentro de Gum
STYLE_TITLE="Agregar $(gum style --foreground 212 'Repositorios')"
export GUM_CHOOSE_HEADER="Seleccione repositorios:"

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

export GUM_STYLE_BORDER="double"
export GUM_STYLE_MARGIN="1"
export GUM_STYLE_PADDING="1 2"
export GUM_STYLE_ALIGN="center"
export GUM_STYLE_WIDTH="50"
export GUM_STYLE_BORDER_FOREGROUND="212"

# Diccionario con los repositorios
declare -A REPOS=(
	["multilib"]="[multilib]\nInclude = /etc/pacman.d/mirrorlist"
	["mesa-git"]="[mesa-git]\nSigLevel = PackageOptional\nServer = https://pkgbuild.com/~lcarlier/\$repo/\$arch"
	["chaotic-aur"]="[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist"
)

# Diccionario para guardar los repositorios activos
declare -A REPOS_ACTIVOS

# Archivo de configuración de PACMAN
PACMAN_CONF="/etc/pacman.conf"

FORMATO=$(tail -n 1 "${PACMAN_CONF}")

if [[ -z "${FORMATO}" ]]; then
	sudo sed -i ':a;/^[[:space:]]*$/{$d;N;ba}' "${PACMAN_CONF}"
fi

# Este for, validar si los repositorios ya estan activos en 'PACMAN_CONF'
for i in "${!REPOS[@]}"; do
	if grep -q "${i}" "${PACMAN_CONF}"; then
		REPOS_ACTIVOS+=(["${i}"]="${REPOS[${i}]}")
		unset REPOS["${i}"]
	fi
done

#
if [[ "${#REPOS_ACTIVOS[@]}" -gt 0 ]]; then

	STYLE_TITLE="Remover $(gum style --foreground 212 'Repositorios')"
	gum style \
		--border "${STYLE_BORDER}" \
		--margin "${STYLE_MARGIN}" \
		--padding "${STYLE_PADDING}" \
		--align "${STYLE_ALIGN}" \
		--width "${STYLE_WIDTH}" \
		--border-foreground "${STYLE_BORDER_FOREGROUND}" \
		"${STYLE_TITLE}"

	if gum confirm --affirmative="Remover" "Deseas remover los repositorios activos?"; then

		ELEGIR_REMOVER=$(gum choose --no-limit "${!REPOS_ACTIVOS[@]}")

		for i in "${!REPOS_ACTIVOS[@]}"; do
			if echo "${ELEGIR_REMOVER}" | grep -q "${i}"; then
				REPOS+=(["${i}"]="${REPOS_ACTIVOS[${i}]}")
				sudo sed -i "/^\[$i\]/,/^$/d" "${PACMAN_CONF}"
				unset REPOS_ACTIVOS["${i}"]
			fi
		done

	fi

	if [[ -z "${FORMATO}" ]]; then
		sudo sed -i ':a;/^[[:space:]]*$/{$d;N;ba}' "${PACMAN_CONF}"
	fi

	if ! gum confirm --affirmative="Agregar" "Deseas agregar repositorios?"; then
		exit 0
	fi

	STYLE_TITLE="Agregar $(gum style --foreground 212 'Repositorios')"
	clear
fi

# Válido la exitencia de repositorios disponibles para agregar
# NOTA: Es necesario para Gum
if [[ "${#REPOS[@]}" -eq 0 ]]; then
	echo "Todos los repositorios ya estan agregados"
	exit 0
fi

# Título para agregar un repositorio
gum style \
	--border "${STYLE_BORDER}" \
	--margin "${STYLE_MARGIN}" \
	--padding "${STYLE_PADDING}" \
	--align "${STYLE_ALIGN}" \
	--width "${STYLE_WIDTH}" \
	--border-foreground "${STYLE_BORDER_FOREGROUND}" \
	"${STYLE_TITLE}"

# Choose para elegir cuales repositorios se agregan
ELEGIR_AGREGAR=$(gum choose --no-limit "${!REPOS[@]}")

# Válida si el repositorio elegido se encuentra en el diccionario de
# repositorios disponibles para agregar, de ser el caso, lo agrega
for i in "${!REPOS[@]}"; do
	if echo "${ELEGIR_AGREGAR}" | grep -q "${i}"; then
		echo "${i}"
		echo -e "\n${REPOS[$i]}" | sudo tee -a "$PACMAN_CONF" >/dev/null
	fi
done

# Válida si el repositorio elegido es chaotic-aur e instala
# lo que es necesario para el mismo
# Referencia: https://aur.chaotic.cx
if echo "${ELEGIR_AGREGAR}" | grep -q "chaotic-aur"; then
	sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
	sudo pacman-key --lsign-key 3056513887B78AEB
	sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
	sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
fi

# Sincroniza los repositorios
sudo pacman -Sy

echo ""

gum style --foreground 212 "Repositorios agregados"

exit 0
OPCIONES=(
	"Agregar"
	"Eliminar"
	"Ver activos"
	"Volver"
)

ELEGIR_OPCION=$(gum choose "${OPCIONES[@]}")

case "${ELEGIR_OPCION}" in
"Agregar")
	echo "Agregar"
	;;
"Eliminar")
	echo "Eliminar"
	;;
"Ver activos")
	echo "Ver activos"
	;;
*)
	echo "salir"
	;;
esac

echo "${REPOS[@]}"
if grep -q "[mesa-git]" "${PACMAN_CONF}"; then
	echo "eliminar mesa git"
fi
