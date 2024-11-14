# Script de Instalación Automatizada de Docker para Debian 12

Este script automatiza el proceso de instalación de Docker y Docker Compose en sistemas Debian 12 (Bookworm). El script realiza una instalación completa incluyendo todas las dependencias necesarias y configura los permisos de usuario apropiados.

## 🚀 Características

- Instalación completa de Docker Engine
- Instalación de Docker Compose
- Configuración automática de repositorios
- Adición del usuario al grupo Docker
- Verificación de la versión de Debian
- Comprobación de la instalación

## 📋 Prerrequisitos

- Sistema operativo Debian 12 (Bookworm)
- Acceso root o privilegios sudo
- Conexión a Internet

## 💻 Instalación

1. Clonar este repositorio o descargue el script `install_docker.sh`:
```bash
git clone https://github.com/frbadillo/Install_Docker.git
```

2. Otorgue permisos de ejecución al script:
```bash
chmod +x install_docker.sh
```

3. Ejecute el script con privilegios sudo:
```bash
sudo ./install_docker.sh
```

## ⚙️ ¿Qué hace el script?

1. Actualiza el sistema
2. Instala paquetes y dependencias necesarias
3. Configura el repositorio oficial de Docker
4. Instala Docker Engine y Docker Compose
5. Inicia y habilita el servicio Docker
6. Añade el usuario actual al grupo Docker (si se ejecuta con sudo)
7. Verifica la instalación mostrando las versiones instaladas

## ⚠️ Notas importantes

- El script está optimizado para Debian 12 (Bookworm)
- Si se ejecuta en una versión diferente de Debian, mostrará una advertencia
- Después de la instalación, es necesario cerrar sesión y volver a iniciarla para que los cambios en el grupo Docker surtan efecto
- Se recomienda revisar el script antes de ejecutarlo en un entorno de producción

## 🔍 Verificación post-instalación

Para verificar que Docker se instaló correctamente, puede ejecutar:
```bash
docker --version
docker compose version
docker run hello-world
```

## 🛠️ Solución de problemas

Si encuentra el error "Permission denied":
1. Verifique que se haya agregado al grupo Docker:
```bash
groups
```
2. Si no ve 'docker' en la lista, ejecute:
```bash
sudo usermod -aG docker $USER
```
3. Cierre sesión y vuelva a iniciarla
