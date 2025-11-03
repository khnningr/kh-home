#!/usr/bin/env bash

set -euo pipefail

pkg_pipewire=(
	"pipewire"
	"pipewire-audio"
	"pipewire-alsa"
	"pipewire-jack"
	"pipewire-pulse"
	"wireplumber"
)

if command -v "pacman" &> /dev/null; then
    sudo pacman -S --needed --noconfirm "${pkg_pipewire[@]}"

elif command -v "dnf" &> /dev/null; then
    sudo dnf install -y

else
    echo "Distro no soportada."
    exit 1
fi

# Pipewire
# Referencias: https://materiageek.com/como-instalar-y-configurar-pipewire-en-linux/
if ! pactl info | grep -q "Server Name: PulseAudio (on PipeWire"; then
    systemctl --user enable --now pipewire.socket
    systemctl --user enable --now pipewire-pulse.socket
    systemctl --user enable --now wireplumber.service
fi
