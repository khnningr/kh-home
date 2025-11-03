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

# Confirmación

if gum confirm --affirmative="Sí" --timeout="10s" "Deseas ver los logs? (y/n)"; then
	gum pager <./logs/logs.log
fi

# Logs general.
while gum confirm --affirmative="Sí" --timeout="10s" "Deseas ver los logs? (y/n)"; do
	$EDITOR $(gum file ./logs/)
done
#cat ./logs/logs.log

echo "Prueba de GUM."

# Ejemplo de un Menu.

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

# Ejemplo de un Banner.

gum style --border normal \
	--margin "1" \
	--padding "1 2" \
	--border-foreground 212 "Hypr$(gum style --foreground 212 'crow')"

# Ejemplo de confirmación.

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

NUEVO_REPO=$(gum input --placeholder "Nombre del repositorio")
