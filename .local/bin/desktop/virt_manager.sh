#!/usr/bin/env bash

set -euo pipefail

if command -v pacman &> /dev/null; then
    . ./list_arch.sh
    sudo pacman -S --needed "${pkg_virt_manager[@]}"
fi

if command -v dnf &> /dev/null; then
    sudo dnf install @virtualization
fi

# Descomentar las lineas 85 y 108.
# unix_socket_group = "libvirt"
# unix_socket_rw_perms = "0770"
# sudo nano /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf
sudo sed -i 's/#unix_sock_group = "libvirt"/unix_socket_group = "libvirt"/' \
  /etc/libvirt/libvirtd.conf

# Añadir el usuario actual al grupo kvm y libvirt.
sudo usermod -a -G kvm,libvirt $(whoami)

# Cambiar el grupo actual del usuario sin necesidad de cerrar sesion.
#newgrp libvirt

# Habilitar servicios necesarios.
sudo systemctl enable --now libvirtd.service

# Iniciamos el servicio.
#sudo systemctl start libvirtd.service

# Descomentar las líneas 519 y 523.
# user = "usuario"
# group = "libvirt"
sudo sed -i 's/^#user = "libvirt-qemu"/user = "'"$(whoami)"'"/' \
  /etc/libvirt/qemu.conf
sudo sed -i 's/^#group = "libvirt-qemu"/group = "'"$(whoami)"'"/' \
  /etc/libvirt/qemu.conf

 # Reiniciar el servicio.
sudo systemctl restart libvirtd.service

# Configuración de redes virtuales.
sudo virsh net-autostart default

# Habilitar la virtualización con el firewall activo.
# Descomentar línea 29.
# firewall_backend = "nftables"
#sudo sed -i 's/^#firewall_backend = "nftables"/firewall_backend = "iptables"/' /etc/libvirt/network.conf

# Comprobar que se han habilitado los servicios.
# sudo systemctl status libvirtd.service
