#!/usr/bin/env bash

set -euo pipefail

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm "${pkg_ckb_next[@]}"
fi

# Si sale el mensaje: "Unit ckb-next-daemon.service is masked.", ejecutar
# antes este otro comando primero:
# sudo systemctl unmask ckb-next-daemon
sudo systemctl enable --now ckb-next-daemon
