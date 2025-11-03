#!/usr/bin/env bash

#set -euo pipefail

# =================================================================================================
# Ejemplo de selección de paquetes.

pkg_mesa_git=(
	"mesa-git"
	"lib32-mesa-git"
	"vulkan-radeon-git"
	"lib32-vulkan-radeon-git"
	"llvm-libs-git"
	"lib32-llvm-libs-git"
)

echo "Seleccione los paquetes ha instalar:"
ELEGIR_PAQUETES=$(gum choose --no-limit --header "Elige los paquetes:" "${pkg_mesa_git[@]}")

if [[ -z "${ELEGIR_PAQUETES}" ]]; then
	echo "No se ha seleccionado ningún paquete."
	exit 0
fi

mapfile -t PAQUETES_ELEGIDOS < <(echo -e "${ELEGIR_PAQUETES}")

# Muestra los paquetes elegidos
echo "Se instalarán los siguientes paquetes:"
printf " - %s\n" "${PAQUETES_ELEGIDOS[@]}"

sudo pacman -S --noconfirm "${PAQUETES_ELEGIDOS[@]}" >./logs/logs.log

# logs de la ejecusion actual.

# =================================================================================================

# Ejemplos de variables de entorno para confirm

export GUM_CONFIRM_AFFIRMATIVE="Sí"
export GUM_CONFIRM_NEGATIVE="Cancelar"
export GUM_CONFIRM_TIMEOUT=30s

export GUM_CONFIRM_DEFAULT=false
export GUM_CONFIRM_SHOW_OUTPUT=true

export GUM_CONFIRM_PROMPT_FOREGROUND="#7571F9"
export GUM_CONFIRM_PROMPT_FOREGROUND="#7571F9"
export GUM_CONFIRM_SELECTED_BACKGROUND="212"
export GUM_CONFIRM_SELECTED_FOREGROUND="230"

#Confirmación

if gum confirm --affirmative="Sí" --timeout="10s" "Deseas ver los logs? (y/n)"; then
	gum pager <./logs/logs.log
fi

# Logs general.
while gum confirm --affirmative="Sí" --timeout="10s" "Deseas ver los logs? (y/n)"; do
	$EDITOR $(gum file ./logs/)
done
#cat ./logs/logs.log

# Otro ejemplo de confirmación.

CONFIRMAR_SERIE=$(gum choose --header="Posees una gráfica AMD Radeon 7000 series? (s/n):" "Sí" "No")

if [[ "$CONFIRMAR_SERIE" != "Sí" ]]; then
	exit 1
fi

if ! grep -q "amdgpu.vm_update_mode=3" /etc/default/grub; then
	sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/"$/ amdgpu.vm_update_mode=3"/' /etc/default/grub
	echo "Es necesario reiniciar la configuración del GRUB..."
fi

if gum confirm --affirmative="Sí" --timeout="10s" "Deseas reiniciar la configuración del GRUB? (y/n)"; then
	sudo grub-mkconfig -o /boot/grub/grub.cfgs
fi

echo -e "\nEs necesario un reboot."

# =================================================================================================

# Ejemplo de variables de entorno choose
# 
# 
# 
export GUM_CHOOSE_CURSOR_PREFIX=" "
export GUM_CHOOSE_SELECTED_PREFIX="[ ]"
export GIM_CHOOSE_UNSELECTED_PREFIX="[  ]"

export GUM_CHOOSE_HEADER="Seleccione entre las siguientes opciones:"
export GUM_CHOOSE_TIMEOUT=30s

# Estilos de variables de entorno

export GUM_CHOOSE_CURSOR_FOREGROUND="212"
export GUM_CHOOSE_HEADER_FOREGROUND="99"
export GUM_CHOOSE_SELECTED_FOREGROUND="212"

# Ejemplo de un Menu con selección única.

OPCIONES=(
	"Opción 1"
	"Opción 2"
	"Opción 3"
	"Opción 4"
)

CHOICE=$(gum choose --header "Elige una opción para realizar:" "${OPCIONES[@]}")

echo ${OPCIONES}

if [ "$CHOICE" == "Opción 3" ]; then
	echo "Opción 3"
	exit 1
fi

# Multi selección

ELEGIR_OPCION=$(gum choose --no-limit --header "Seleccione que opciones realizar:" "${OPCIONES[@]}")

if echo "${ELEGIR_OPCION}" | grep -q "Opción 4"; then
	echo "Script"
fi

# =================================================================================================

# Ejemplo de un Banner.

gum style \
	--border double \
	--margin "1" \
	--padding "1 2" \
	--align center --width 50 \
	--border-foreground 212 "Hypr$(gum style --foreground 212 'crow')"

gum style --foreground 212 "✓ Instalación completada"

# =================================================================================================

# Ejemplo de variables de entorno de Input

export GUM_INPUT_PLACEHOLDER="Escriba algo..."
export GUM_INPUT_PROMPT=" "
export GUM_INPUT_WIDTH=80
export GUM_INPUT_TIMEOUT=60s
export GUM_INPUT_CURSOR_FOREGROUND="212"
export GUM_INPUT_PROMPT_FOREGROUND="#0FF"

# Ejemplo de Input

NUEVO_REPO=$(gum input --placeholder "Nombre del repositorio")

echo "${NUEVO_REPO}"
