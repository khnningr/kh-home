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
STYLE_TITLE="Configuración de $(gum style --foreground 212 'Pacman')"

# Opciones de Confirm
export GUM_CONFIRM_TIMEOUT=10s

# Estilo del título
STYLE_BORDER="double"
STYLE_MARGIN="1"
STYLE_PADDING="1 2"
STYLE_ALIGN="center"
STYLE_WIDTH="50"
STYLE_BORDER_FOREGROUND="212"

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

if gum confirm --affirmative="Sí" "Deseas usar la conguración de estos dotfiles?"; then
	sudo tee /etc/pacman.conf >/dev/null <<'EOF'
#
# /etc/pacman.conf
#

[options]
HoldPkg     = pacman glibc
Architecture = auto
# IgnorePkg = «PKG»
Color
ILoveCandy
CheckSpace
VerbosePkgLists
ParallelDownloads = 5

SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist
EOF
fi
