#!/usr/bin/env bash

set -euo pipefail

if ! command -v firewalld &> /dev/null; then
    . ./firewalld.sh
fi

if ! systemctl list-units --type=service | grep -q "firewalld.service"; then
    systemctl enable --now firewalld
fi

if ! firewall-cmd --get-zones | grep -qw "crow"; then
    sudo firewall-cmd --new-zone=crow --permanent
    sudo systemctl restart firewalld
fi

if ! firewall-cmd --get-default | grep -qw "crow"; then
    ip addr | grep "enp" # Ver la interface del equipo.

    echo -e "\nEscriba la interface de la máquina"
    echo "...dada por 'ip addr'"
    read -p "> " elegir_interface

    if [[ -z $elegir_interface ]]; then
        echo "Interface no definida... vuelva intentarlo..."
        exit 1
    fi

    sudo firewall-cmd --zone=crow --change-interface=${elegir_interface}
    sudo firewall-cmd --set-default=crow
fi

puertos=(
    "53" # DNS
    # Warframe
    "4950"
    "4955"
    "6695"
    "6696"
    "6697"
    "6698"
    "6699"
    "51413" # Torrents
)

for puerto in ${puertos[@]}; do
    if ! sudo firewall-cmd --list-port | grep -qw "$puerto/tcp"; then
        sudo firewall-cmd --add-port=${puerto}/tcp
    fi
done

servicios=(
    "https"
)

for servicio in ${servicios[@]}; do
    if ! sudo firewall-cmd --list-service | grep -qw "$servicio"; then
        sudo firewall-cmd --add-service=${servicio}
    fi
done

if ! sudo firewall-cmd --list-icmp-blocks | grep -qw "echo-request"; then
    # Block ping
    sudo firewall-cmd --add-icmp-block=echo-request
fi

sudo firewall-cmd --runtime-to-permanent

sudo firewall-cmd --reload

sudo systemctl restart firewalld
