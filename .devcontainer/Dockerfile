# 🖥️ Imagen base oficial de Microsoft para TypeScript/Node.js
FROM mcr.microsoft.com/devcontainers/typescript-node:22-bookworm

# 🔧 Argumentos para configurar el usuario
ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# 📦 Instalar herramientas adicionales útiles para desarrollo
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git curl wget nano apt-transport-https gnupg2 ca-certificates

# 🔧 Instalar kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

# 🔧 Instalar kind (Kubernetes IN Docker)
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64 \
    && chmod +x ./kind \
    && mv ./kind /usr/local/bin/kind

# 🧹 Limpiar caché de APT para reducir el tamaño de la imagen
RUN apt-get autoremove -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# 🔄 Configurar directorio de trabajo
WORKDIR /workspaces/${localWorkspaceFolderBasename}

# 👤 Cambiar al usuario node para ejecutar comandos (por seguridad)
USER $USERNAME