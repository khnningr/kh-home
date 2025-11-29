#!/usr/bin/env bash
set -euo pipefail

PART=$(lsblk -rpo NAME,SIZE,TYPE,MOUNTPOINT |
  awk '$3=="part"{print $1 " (" $2 ")"}' |
	gum choose --header="Selecciona la partición")

PART=${PART%% *} # Quitar el tamaño y dejar solo /dev/xxx
echo "${PART}"

gum confirm \
	"¿Deseas formatear la partición $PART como ext4?" &&
	DO_FORMAT=1 || DO_FORMAT=0

echo "$DO_FORMAT"

# sudo chown -R usuario:grupo /punto/de/montaje
#

# sudo chown -R kh:kh /media/kh
# -R → aplica recursivamente a todos los archivos.
# usuario:grupo → generalmente el grupo tiene el mismo nombre que el usuario.
# /mnt/datos → es la carpeta donde está montado el disco.
#
#
# Agregar un confirm que vuelva a ejecutar el mismo script por si se desea agregar otra particion
