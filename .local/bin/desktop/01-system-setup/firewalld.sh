#!/usr/bin/env bash

set -euo pipefail

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed --noconfirm firewalld
elif command -v dnf &> /dev/null; then
    . ./list_fedora.sh
    sudo dnf install -y firewalld
else
    echo "Distro no soportada."
    exit 1
fi

. ./firewalld_config.sh
