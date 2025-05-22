# Tour of Heroes API

This repository was created using GitHub Copilot with its Coding agent. It is a REST API for managing superheroes, implemented with Node.js and TypeScript.

## Project Structure

```

## Requisitos

- Node.js (v14+)
- npm (v6+)

## Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/0GiS0/tour-of-heroes-with-gh-copilot-coding-agent.git
cd tour-of-heroes-with-gh-copilot-coding-agent
```

2. Instalar dependencias:
```bash
npm install
```

## Desarrollo

Para ejecutar la aplicación en modo de desarrollo:
```bash
npm run dev
```

## Construir y Ejecutar para Producción

1. Construir la aplicación:
```bash
npm run build
```

2. Ejecutar la aplicación:
```bash
npm start
```

## Linting y Formateo

Para ejecutar el linter:
```bash
npm run lint
```

Para corregir automáticamente los problemas de linting:
```bash
npm run lint:fix
```

Para formatear el código con Prettier:
```bash
npm run format
```


## Integración Continua

Este proyecto utiliza GitHub Actions para implementar un flujo de Integración Continua (CI). El flujo se ejecuta automáticamente en cada push a la rama main y en los pull requests hacia main.

El flujo de CI realiza las siguientes operaciones:
- Checkout del repositorio
- Configuración de Node.js
- Instalación de dependencias
- Ejecución del linter
- Compilación del proyecto
- Ejecución de pruebas (cuando estén implementadas)

Puedes ver el estado de las ejecuciones de CI en la pestaña "Actions" del repositorio.
## Desarrollo con Dev Containers

Este proyecto está configurado para usar Dev Containers con Visual Studio Code, lo que permite desarrollar dentro de un entorno containerizado con todas las herramientas necesarias preinstaladas.

### Requisitos para Dev Containers

- [Visual Studio Code](https://code.visualstudio.com/)
- [Extensión Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)

### Inicio del Dev Container

1. Abrir el proyecto en Visual Studio Code
2. Cuando aparezca la notificación "Folder contains a Dev Container configuration file", hacer clic en "Reopen in Container"
   - O usar el comando `Remote-Containers: Reopen in Container` desde la paleta de comandos (F1)

### Características incluidas

- 🖥️ Entorno Node.js/TypeScript preconfigurado (Node.js 22 con Debian Bookworm)
- 🗃️ MongoDB como servicio de base de datos (versión 8.0)
- 🧩 Extensiones recomendadas para desarrollo ya instaladas:
  - TypeScript y JavaScript (linting, formateo)
  - Soporte para MongoDB
  - Herramientas Docker
  - Mejoras Git (GitLens)
- ⚙️ Configuración automática de formateo y linting
