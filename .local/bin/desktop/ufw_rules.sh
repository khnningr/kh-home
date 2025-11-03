#!/usr/bin/env bash

set -euo pipefail

# Función para definir reglas de Uncomplicated Firewall o UFW.
#
# Para eliminar un una regla puedes usar los siguientes
# comandos:
#
# 1. Imprime un estado y sus reglas definidas pero enumeradas.
# sudo ufw status numbered
#
# 2. Para eliminar como tal la regla.
# sudo ufw delete «NÚMERO DE LA REGLA A BORRAR»
#
# También podemos ver una lista de nombres de
# servicios conocidos por ufw, con el comando:
# sudo ufw app list
#
# Para bloquear una IP en especifico, usas el comando:
# sudo ufw deny from «DIRECCIÓN IP»
#
# Referencia: https://www.youtube.com/watch?v=fcxirBuDnXY

sudo ufw status # Verifica el estado de ufw (activo/inactivo)
sudo ufw reset # Elimina las reglas establecidas.
sudo ufw default deny incoming # Niega el tráfico que entra.
sudo ufw default deny outgoing # Niega todo lo que sale.
# Para desabilitar ufw, basta con usar el comando:
# sudo ufw disable
sudo ufw enable # Activa el firewall ahora, y al inicio del sistema.

sudo ufw allow out https/tcp # Salida por el puerto 443 o https.
sudo ufw allow in https/tcp # Entrada por el puerto 443 o https.

# sudo ufw allow out http/tcp # Salida por el puerto 80 o http.
# sudo ufw allow in http/tcp # Entrada por el puerto 80 o http.

# Es necesario habilitar el puerto 53 para,
# habilitar el acceso a internet, no basta
# con habilitar los puertos 80 y 443.
sudo ufw allow out 53/tcp # Salida por el puerto 53 o dns.
sudo ufw allow in 53/tcp # Entrada por el puerto 53 o dns.
# Reglas parar Warframe.
sudo ufw allow out 4950/tcp
sudo ufw allow in 4950/tcp

sudo ufw allow out 4955/tcp
sudo ufw allow in 4955/tcp

sudo ufw allow out 6695/tcp
sudo ufw allow in 6695/tcp

sudo ufw allow out 6696/tcp
sudo ufw allow in 6696/tcp

sudo ufw allow out 6697/tcp
sudo ufw allow in 6697/tcp

sudo ufw allow out 6698/tcp
sudo ufw allow in 6698/tcp

sudo ufw allow out 6699/tcp
sudo ufw allow in 6699/tcp

sudo ufw allow out 51413/tcp  # Permitir tráfico saliente en el puerto 51413
sudo ufw allow in 51413/tcp   # Permitir tráfico entrante en el puerto 51413

sudo ufw logging on

sudo ufw reload # Recarga el servicio al hacer cambios en reglas.
sudo ufw status
