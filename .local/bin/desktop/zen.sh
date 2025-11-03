#!/usr/bin/env bash

set -euo pipefail

killall zen-bin
while pgrep -x zen-bin >/dev/null; do sleep 1; done

tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

zen_path="$HOME/.zen/Zen"
extensions_path="$zen_path/extensions/"

mkdir -p "$zen_path/chrome/" "$extensions_path"

addons_mozilla="https://addons.mozilla.org/en-US/firefox/addon"

addon_list=(
    "$addons_mozilla/bitwarden-password-manager/"
    "$addons_mozilla/ublock-origin/"
    "$addons_mozilla/deepl-translate/"
    "$addons_mozilla/languagetool/"
    "$addons_mozilla/feedbroreader/"
    "$addons_mozilla/privacy-badger17/"
    "$addons_mozilla/istilldontcareaboutcookies/"
    "$addons_mozilla/translatelocally-for-firefox/"
    "$addons_mozilla/darkreader/"
)

for addon in "${addon_list[@]}"; do
    # Obtiene la url de descarga de la extensión.
    addon_url=$(curl -s "$addon" | grep -oPm 1 "https://addons.mozilla.org/firefox/downloads/file/.*?\.xpi" || true)
    # Nombra la extensión para poder manipularlo.
    nombre_addon=$(basename "$addon_url" .xpi)
    # Descarga la extensión con la url obtenida en un dir temporal donde se nombra con el nombre dado anteriormente.
    wget -O "$tempdir/$nombre_addon.xpi" "$addon_url"
    # Crear un dir donde almacenar los archivos al descromprimir.
    mkdir -p "$tempdir/$nombre_addon"
    # Se descomprimen los archivos de la extensión.
    unzip -o "$tempdir/$nombre_addon.xpi" -d "$tempdir/$nombre_addon"
    # Busca la ID de la extensión dentro de manifest.json.
    id_addon=$(jq -r '.browser_specific_settings.gecko.id' "$tempdir/$nombre_addon/manifest.json")
    # Elimina la carpeta donde se descomprimio la extensión; ya no es necesario. (No es necesario)
    # rm -rf "$tempdir/$nombre_addon"
    # Se mueve al dir de extensiones del perfil con el nombre que corresponde; «id de la extensión.xpi».
    mv "$tempdir/$nombre_addon.xpi" "$extensions_path/$id_addon.xpi"
done






#zen-browser https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/

zen-browser --ProfileManager # Abre Profile manager, para elegir el perfil.
# zen-browser --setDefaultBrowser # Selecciona el navegador por defecto.




sleep 1000
