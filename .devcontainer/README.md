# Tour of Heroes - Dev Container

Esta carpeta contiene la configuración del Dev Container para el proyecto Tour of Heroes API.

## 📁 Estructura

- `devcontainer.json`: Configuración principal para Visual Studio Code
- `docker-compose.yml`: Definición de servicios (app y MongoDB)
- `Dockerfile`: Configuración de la imagen base para la aplicación

## 🧩 Configuración principal

El Dev Container está configurado con:

1. **Base**: Imagen TypeScript-Node.js 22-bookworm oficial de Microsoft
2. **Servicios**:
   - **App**: El servicio principal para la aplicación
   - **MongoDB**: Base de datos (versión 8.0) para almacenar información de héroes

## 💡 Buenas prácticas implementadas

1. **Seguridad**:
   - Uso del usuario `node` en lugar de root
   - Volúmenes montados con permisos adecuados

2. **Rendimiento**:
   - Volumen dedicado para `node_modules` para mejorar velocidad
   - Caché de contenedor optimizada

3. **Desarrollo**:
   - Extensiones preinstaladas para TypeScript, MongoDB y más
   - Configuración de formateado y linting automáticos
   - Instalación automática de dependencias al crear el contenedor

4. **Conectividad**:
   - Puertos configurados para la aplicación y MongoDB
   - Red dedicada entre servicios

## 🛠️ Personalización

Si necesitas modificar aspectos del Dev Container:

- Para cambiar versiones de Node.js o MongoDB, edita `Dockerfile` y `docker-compose.yml`
- Para añadir extensiones, modifica el campo `extensions` en `devcontainer.json`
- Para añadir variables de entorno, edita `environment` en `docker-compose.yml`