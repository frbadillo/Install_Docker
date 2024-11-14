#!/bin/bash

# Actualizar el sistema
echo "Actualizando el sistema..."
apt update && apt upgrade -y

# Instalar paquetes necesarios
echo "Instalando los paquetes necesarios..."
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Obtener el nombre de la distribución de Debian
DEBIAN_CODENAME=$(lsb_release -cs)

# Verificar es válido
if [ "$DEBIAN_CODENAME" != "bookworm" ]; then
    echo "ADVERTENCIA: Este script está configurado para Debian 12 (bookworm)."
    echo "Detectado: $DEBIAN_CODENAME"
    echo "Si no está usando Debian 12, puede que necesite ajustar el repositorio de Docker manualmente."
    echo "Continuando con la instalación para la versión detectada..."
fi

# Agregar la clave GPG oficial de Docker
echo "Agregando la clave GPG de Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Configurar el repositorio para Docker
echo "Configurando el repositorio de Docker para Debian $DEBIAN_CODENAME..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $DEBIAN_CODENAME stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizar la lista de paquetes
echo "Actualizando lista de paquetes..."
apt update

# Instalar Docker
echo "Instalando Docker..."
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Iniciar y habilitar Docker
echo "Iniciando y habilitando Docker..."
systemctl start docker
systemctl enable docker

# Verificar la instalación
echo "Verificando la instalación..."
docker --version
docker compose version

# Agregar usuario actual al grupo docker
if [ "$SUDO_USER" ]; then
    echo "Agregando al usuario $SUDO_USER al grupo docker..."
    usermod -aG docker $SUDO_USER
    echo "IMPORTANTE: Cierra la sesión y vuelve a iniciarla para que se apliquen los cambios."
fi

echo "¡Instalación completada!"
