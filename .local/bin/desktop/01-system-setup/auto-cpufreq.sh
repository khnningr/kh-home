#!/usr/bin/env bash

# TITULO : auto-cpufreq
# 
# LINKS :
#   > github: https://github.com/AdnanHodzic/auto-cpufreq
# 
# DESCRIPCIÓN : Este script tiene el proposito de instalar y configurar 'auto-cpufreq' automáticamente 
# en una máquina con Linux. La herramienta gestiona la frecuencia del CPU del equipo,en especial para 
# laptops; aunque es posible usarlo en una equipo de escritorio. Su archivo de configuración se encuentra
# en '$XDG_CONFIG_HOME/auto-cpufreq/auto-cpufreq.conf'.
# 
# DEPENDENCIAS : auto-cpufreq
# 
# !IMPORTANTE : No usar con prower-profiles-daemon, de preferencia, no tenerlo instalado en el equipo.

set -euo pipefail

[ -d "$HOME"/.clone ] || mkdir -p "$HOME"/.clone

git clone https://github.com/AdnanHodzic/auto-cpufreq.git "$HOME"/.clone/auto-cpufreq

cd "$HOME"/.clone/auto-cpufreq && sudo ./auto-cpufreq-installer

sudo systemctl enable --now auto-cpufreq || sudo auto-cpufreq --install
