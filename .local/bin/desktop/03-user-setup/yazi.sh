#!/usr/bin/env bash

set -euo pipefail

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_yazi[@]}"
    paru -S --needed --noconfirm "${pkg_yazi_aur[@]}"
fi

git clone https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser "$tempdir/termfilechooser"

sudo cp -r "$tempdir/termfilechooser/termfilechooser.portal" /usr/share/xdg-desktop-portal/portals/

find /usr/share/xdg-desktop-portal/portals -name '*.portal' -not -name\
    'termfilechooser.portal' -exec grep -q 'FileChooser' '{}' \; -exec \
    sudo sed -i'.bak' 's/org\.freedesktop\.impl\.portal\.FileChooser;\?//g' '{}' \;

# redirigir


systemctl --user restart xdg-desktop-portal.service

systemctl --user restart xdg-desktop-portal-termfilechooser.service
