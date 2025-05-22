# 🖥️ Imagen base oficial de Microsoft para TypeScript/Node.js
FROM mcr.microsoft.com/devcontainers/typescript-node:18

# 🔧 Argumentos para configurar el usuario
ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# 📦 Instalar herramientas adicionales útiles para desarrollo
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl wget nano

# 🧹 Limpiar caché de APT para reducir el tamaño de la imagen
RUN apt-get autoremove -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# 🔄 Configurar directorio de trabajo
WORKDIR /workspaces/${localWorkspaceFolderBasename}

# 👤 Cambiar al usuario node para ejecutar comandos (por seguridad)
USER $USERNAME