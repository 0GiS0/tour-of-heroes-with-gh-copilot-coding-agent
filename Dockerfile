# 🏗️ Etapa de construcción
FROM node:25-bookworm-slim AS builder

# 🔧 Establecer directorio de trabajo
WORKDIR /app

# 📦 Copiar archivos de configuración de dependencias
COPY package*.json ./

# 📦 Instalar dependencias incluyendo las de desarrollo (necesarias para build)
RUN npm ci

# 📁 Copiar el código fuente
COPY . .

# 🏗️ Construir la aplicación
RUN npm run build

# 🚀 Etapa de producción
FROM node:25-bookworm-slim AS production

# 🔧 Establecer directorio de trabajo
WORKDIR /app

# 📦 Copiar archivos de configuración de dependencias
COPY package*.json ./

# 📦 Instalar solo dependencias de producción
RUN npm ci --omit=dev

# 👤 Crear un usuario no root para mayor seguridad
RUN groupadd -r appuser && useradd -r -g appuser -s /bin/bash appuser \
    && chown -R appuser:appuser /app

# 📁 Copiar los archivos compilados desde la etapa de construcción
COPY --from=builder /app/dist ./dist

# 👤 Cambiar al usuario no root
USER appuser

# 🌐 Exponer el puerto para la aplicación
EXPOSE 3000

# ⚙️ Configurar variables de entorno para producción
ENV NODE_ENV=production

# 🧩 Definir comando para ejecutar en modo producción
CMD ["npm", "start"]