#!/usr/bin/env bash

set -euo pipefail

# Este script define las aplicaciones por defecto, según el
# tipo de archivo es decir, filetype.

# 1. Verificar que programa está asociado al "filetype"
# Para verificar que programa usa para abrir un archivo
# use el comando: 'xdg-mime query default «mimetype»',
# Ejemplo: 'xdg-mime query default image/png'
#
# 2. Verificar que "filetype" tiene un archivo
# Para verificar de qué tipo es un archivo use el comando:
# 'xdg-mime query filetype «archivo»'
# Ejemplo: 'xdg-mime query filetype imagen_de_gatito.png'
#
# 3. Abrir un archivo
# Para abrir un archivo que ya este asociado a un programa
# use el comando:
# 'xdg-open «archivo»'
# Ejemplo: 'xdg-open imagen_de_gatito.png'
#
# 4. Verificar el nombre del programa instalado
# Para verificar como se nombra el programa puedes usa
# el comando:
# 'locate -i «programa».desktop'
# Ejemplo: 'locate -i zed.desktop'
#
# 5. Definir el programa asociado al "filetype"
# Para definir que programa abre el "mimetype" o el
# archivo en si, usa este comando:
# 'xdg-mime default «programa».desktop «mimetype»'
# Ejemplo: 'xdg-mime default feh.desktop image/png'
#
# Referencias: https://youtu.be/z3F0hTigMvU

if command -v pacman &>/dev/null; then
	. ./list_arch.sh
	# Al instalar plocate, para usar el siguiente comando: locate -i «programa»
	sudo pacman -S --needed --noconfirm xdg-utils plocate
fi

sudo updatedb

mkdir -p ~/.local/share/applications

# Copiar archivos del sistema
cp -n /usr/share/applications/*.desktop ~/.local/share/applications/

update-desktop-database "$HOME"/.local/share/applications

# LibreOffice
open_doc="libreoffice-writer.desktop"
xdg-mime default ${open_doc} application/vnd.oasis.opendocument.text
xdg-mime default ${open_doc} application/vnd.oasis.opendocument.spreadsheet
xdg-mime default ${open_doc} application/vnd.oasis.opendocument.presentation

open_pka="cisco-pt.desktop"
xdg-mime default ${open_pka} application/pka

# Zed
# open_ide="dev.zed.Zed.desktop"
open_ide="nvim.desktop"

if [[ "${open_ide}" == "nvim.desktop" ]]; then
	sed -i 's/Exec=nvim %F/Exec=wezterm -e -- nvim %F/' \
		"$HOME/.local/share/applications/nvim.desktop"
fi

xdg-mime default ${open_ide} text/plain
xdg-mime default ${open_ide} application/x-shellscript
xdg-mime default ${open_ide} text/x-python

# Open PDFs with the Document Viewer
open_doc_viewer="org.gnome.Evince.desktop"
xdg-mime default ${open_doc_viewer} application/pdf

# Default browser
open_browser="zen.desktop"
# open_browser="vivaldi-stable.desktop"
xdg-settings set default-web-browser ${open_browser}
xdg-mime default ${open_browser} x-scheme-handler/http
xdg-mime default ${open_browser} x-scheme-handler/https
xdg-mime default ${open_browser} text/html

# Archivo de imagen
open_visor="org.gnome.Loupe.desktop"
# visor="imv.desktop"
xdg-mime default ${open_visor} image/png
xdg-mime default ${open_visor} image/jpeg
xdg-mime default ${open_visor} image/jpg
xdg-mime default ${open_visor} image/gif
xdg-mime default ${open_visor} image/webp
xdg-mime default ${open_visor} image/bmp
xdg-mime default ${open_visor} image/tiff
xdg-mime default ${open_visor} image/svg+xml

# Torrents
open_torrents="de.haeckerfelix.Fragments.desktop"
xdg-mime default ${open_torrents} application/x-bittorrent
xdg-mime default ${open_torrents} x-scheme-handler/magneta

# Open video files
open_video="vlc.desktop"
xdg-mime default ${open_video} video/mp4
xdg-mime default ${open_video} video/x-msvideo
xdg-mime default ${open_video} video/x-matroska
xdg-mime default ${open_video} video/x-flv
xdg-mime default ${open_video} video/x-ms-wmv
xdg-mime default ${open_video} audio/mpeg
xdg-mime default ${open_video} video/ogg
xdg-mime default ${open_video} video/webm
xdg-mime default ${open_video} video/quicktime
xdg-mime default ${open_video} video/3gpp
xdg-mime default ${open_video} video/3gpp2
xdg-mime default ${open_video} video/x-ms-asf
xdg-mime default ${open_video} video/x-ogm+ogg
xdg-mime default ${open_video} video/x-theora+ogg
xdg-mime default ${open_video} application/ogg

open_file="org.gnome.FileRoller.desktop"
xdg-mime default ${open_file} application/zip
xdg-mime default ${open_file} application/x-tar

xdg-mime default kitty-open.desktop inode/directory
