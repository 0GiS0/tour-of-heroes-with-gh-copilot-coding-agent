# 🐳 Desarrollo con Dev Containers

Este proyecto está configurado para usar Dev Containers con Visual Studio Code, lo que permite desarrollar dentro de un entorno containerizado con todas las herramientas necesarias preinstaladas.

## ¿Qué son los Dev Containers?

Los Dev Containers permiten utilizar un contenedor Docker como entorno de desarrollo completo. Esto garantiza que todos los desarrolladores trabajen con exactamente el mismo entorno, eliminando problemas de "funciona en mi máquina".

## Requisitos para Dev Containers

Para utilizar los Dev Containers de este proyecto, necesitas tener instalado:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Extensión Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)

## Inicio del Dev Container

Para iniciar el desarrollo en el contenedor:

1. Abre el proyecto en Visual Studio Code
2. Cuando aparezca la notificación "Folder contains a Dev Container configuration file", haz clic en "Reopen in Container"
   - Alternativamente, puedes usar el comando `Remote-Containers: Reopen in Container` desde la paleta de comandos (F1)
3. Espera a que VS Code reconstruya y conecte con el contenedor (esto puede tardar unos minutos la primera vez)
4. ¡Listo! Ahora estás trabajando dentro del contenedor

## Características Incluidas

El Dev Container de este proyecto viene preconfigurado con:

### Entorno Base
- 🖥️ Node.js 22 con Debian Bookworm (imagen oficial de Microsoft para TypeScript)
- 🗃️ MongoDB 8.0 como servicio de base de datos

### Extensiones Preinstaladas
- **TypeScript y JavaScript**: Soporte para desarrollo con TypeScript
  - ESLint
  - Prettier
  - TypeScript Import Sorter
- **Base de Datos**: Herramientas para trabajar con MongoDB
  - MongoDB for VS Code
- **Docker y Kubernetes**: Herramientas para contenedores
  - Docker
  - Kubernetes
  - YAML
- **Git**: Mejoras para control de versiones
  - GitLens
  - Git History

### Herramientas CLI
- Node.js y npm
- Docker CLI
- kubectl
- kind (Kubernetes IN Docker)
- curl, wget, git, etc.

### Configuraciones Automáticas
- Formateo automático al guardar
- Reglas de linting preconfigudadas
- Paths de importación optimizados

## Estructura del Dev Container

La configuración del Dev Container se encuentra en el directorio `.devcontainer/` y consta de:

- `devcontainer.json`: Configuración principal para VS Code
- `docker-compose.yml`: Definición de servicios (app y MongoDB)
- `Dockerfile`: Configuración de la imagen base para la aplicación
- `scripts/`: Scripts de utilidad para trabajar con Kubernetes

Para más detalles sobre la estructura y las buenas prácticas implementadas, consulta el [README específico de Dev Container](../.devcontainer/README.md).

## Personalización

Si necesitas modificar aspectos del Dev Container:

1. Edita los archivos en `.devcontainer/`
2. Utiliza el comando `Remote-Containers: Rebuild Container` para aplicar los cambios

## Soporte para Kubernetes

El Dev Container incluye soporte integrado para desarrollo con Kubernetes local:

- **kubectl** preinstalado para interactuar con clusters
- **kind** para crear clusters Kubernetes dentro de Docker
- **Scripts de utilidad** para configurar rápidamente un entorno de desarrollo

Para más información sobre el desarrollo con Kubernetes, consulta la [documentación de Kubernetes](./kubernetes-development.md).

## Consejos y Trucos

### Acceso a la Terminal
- Usa el terminal integrado en VS Code para ejecutar comandos dentro del contenedor
- Puedes abrir múltiples terminales para diferentes tareas

### Instalación de Dependencias Adicionales
- Puedes instalar paquetes npm adicionales con normalidad usando `npm install`
- Para instalar herramientas del sistema, usa `sudo apt-get install <paquete>`

### Persistencia de Datos
- Los cambios en el código se guardan en tu sistema local, no se pierden al detener el contenedor
- La base de datos MongoDB utiliza un volumen Docker para persistir los datos

### Depuración
- La configuración para depuración ya está preconfigurada
- Puedes añadir breakpoints y usar el depurador de VS Code normalmente

## Resolución de Problemas

### El contenedor no se inicia correctamente
- Verifica que Docker Desktop esté en ejecución
- Intenta usar el comando `Remote-Containers: Rebuild Container`

### No se puede conectar a MongoDB
- Verifica que el servicio MongoDB esté en ejecución dentro de Docker Compose
- Comprueba los logs con `docker-compose logs mongodb`

### Problemas con permisos de archivos
- El contenedor está configurado para usar el usuario `node` para evitar problemas de permisos
- Si encuentras problemas, verifica los permisos de los archivos en tu sistema host