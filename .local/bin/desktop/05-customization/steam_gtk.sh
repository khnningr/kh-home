#!/usr/bin/env bash

# Referencia: https://github.com/Foldex/AdwSteamGtk

set -euo pipefail

sudo pacman -S --needed steam

paru -S --needed adwsteamgtk

color_theme="Tokyo-Night"

adwaita-steam-gtk -i -o "color_theme:${color_theme};\
rounded_corners:false;\
win_controls:adwaita;\
win_controls_layout:none;\
library_sidebar:show;\
library_whats_new:true;\
login_qr:show"

# paru -Rns adwsteamgtk
