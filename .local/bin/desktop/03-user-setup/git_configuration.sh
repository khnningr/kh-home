#!/usr/bin/env bash

set -euo pipefail

# Para definir el nombre de usuario Git:
# git config --global user.name <username>
# Para definir el mail del usuario Git:
# git config --global user.email <email>

# Agregar una opción para agregar un nuevo usuario.

sudo pacman -S --needed git gum

# --- Definir el nombre del usuario.
echo -e "\n› Comprobando configuración de 'user.name'..."
# Comprueba usando git si 'user.name' no se ha configurado.
if ! git config --global user.name > /dev/null 2>&1; then
    # Solicita el con gum nombre.
    export USER_NAME=$(gum input --placeholder "Ingresa el nombre de usuario" --prompt "  Usuario> ")
    # Válida que el nombre no este vacío antes de configurarlo.
    if [[ -n "${USER_NAME//[[:space:]]/}" ]]; then
        git config --global user.name "$USER_NAME"
        echo "  Nombre configurado como: $USER_NAME"
    else
        echo "  × Entrada vacía. No se configuró el nombre."
    fi
else
    # Si ya está configurado, muestra el valor actual.
    CURRENT_NAME=$(git config --global user.name)
    echo "  Nombre ya configurado como: $CURRENT_NAME"
fi

# --- Definir el mail del usuario.
echo -e "\n› Comprobando configuración de 'user.email'..."
# Comprueba usando git si 'user.email' no se ha configurado.
if ! git config --global user.email > /dev/null 2>&1; then
    echo "  Email no encontrado. Por favor, ingrésalo:"
    # Solicita el con gum email.
    export USER_EMAIL=$(gum input --placeholder "usuario@ejemplo.com" --prompt "  Email> ")
    # Válida que el email no este vacío antes de configurarlo.
    if [[ -n "${USER_EMAIL//[[:space:]]/}" ]]; then
        git config --global user.email "$USER_EMAIL"
        echo "  Email configurado como: $USER_EMAIL"
    else
        echo "  × Entrada vacía. No se configuró el email."
    fi
else
    # Si ya está configurado, muestra el valor actual.
    CURRENT_EMAIL=$(git config --global user.email)
    echo "  Email ya configurado como: $CURRENT_EMAIL"
fi

mkdir -p "$XDG_CONFIG_HOME"/git/

[[ -f "$HOME"/.gitconfig ]] && mv "$HOME"/.gitconfig "$XDG_CONFIG_HOME"/git/config
