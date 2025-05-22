# Tour of Heroes API

Una API REST para gestionar superhéroes, implementada con Node.js y TypeScript. Este proyecto proporciona un backend sencillo para la aplicación "Tour of Heroes" con endpoints para obtener, crear, actualizar y eliminar datos de héroes.

## 📁 Estructura del Proyecto

```
.
├── .devcontainer/   # Configuración de Dev Container
├── .github/         # Flujos de trabajo de GitHub Actions
├── src/
│   ├── config/      # Configuración de la aplicación
│   ├── controllers/ # Manejadores de peticiones
│   ├── middlewares/ # Middlewares de Express
│   ├── models/      # Modelos de datos e interfaces
│   ├── routes/      # Definiciones de rutas API
│   ├── services/    # Lógica de negocio
│   ├── utils/       # Funciones de utilidad
│   └── index.ts     # Punto de entrada de la aplicación
├── eslint.config.js # Configuración de ESLint
├── package.json     # Dependencias del proyecto
└── tsconfig.json    # Configuración de TypeScript
```

## 🚀 Instalación y Requisitos

### Requisitos

- Node.js (v22+)
- npm (v6+)
- MongoDB (para desarrollo local sin contenedores)

### Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/0GiS0/tour-of-heroes-with-gh-copilot-coding-agent.git
cd tour-of-heroes-with-gh-copilot-coding-agent
```

2. Instalar dependencias:
```bash
npm install
```

## 🛠️ Uso Básico

### Desarrollo

Para ejecutar la aplicación en modo de desarrollo con recarga automática:
```bash
npm run dev
```

### Construir y Ejecutar para Producción

1. Construir la aplicación:
```bash
npm run build
```

2. Ejecutar la aplicación:
```bash
npm start
```

### Linting y Formateo

Ejecutar el linter:
```bash
npm run lint
```

Corregir automáticamente los problemas de linting:
```bash
npm run lint:fix
```

Formatear el código con Prettier:
```bash
npm run format
```

## 📦 Tecnologías Utilizadas

- **TypeScript**: Lenguaje de programación fuertemente tipado que se basa en JavaScript
- **Express**: Framework web rápido y minimalista para Node.js
- **MongoDB**: Base de datos de documentos NoSQL
- **Docker**: Plataforma de contenedores
- **ESLint & Prettier**: Herramientas de calidad y formateo de código
- **GitHub Actions**: Flujos de trabajo de Integración Continua

## 🤖 Sobre GitHub Copilot y Coding Agent

Este repositorio fue creado con la ayuda de GitHub Copilot y su Coding agent. GitHub Copilot sirvió como un programador par de IA para:

- Generar la estructura inicial del proyecto y el código base
- Sugerir detalles de implementación para controladores, servicios y modelos
- Ayudar a diseñar las rutas de la API y los esquemas de datos
- Asistir con la configuración de Docker, ESLint y otras herramientas

El Coding agent facilitó asistencia estructurada de IA directamente dentro de los pull requests, ayudando a implementar funcionalidades, corregir errores y mejorar la calidad del código durante todo el proceso de desarrollo.

## 👥 Contribución

¡Las contribuciones a este proyecto son bienvenidas! Para contribuir:

1. Haz un fork del repositorio
2. Crea una rama para tu funcionalidad (`git checkout -b feature/funcionalidad-increible`)
3. Haz commit de tus cambios (`git commit -m 'Añadir funcionalidad increíble'`)
4. Haz push a la rama (`git push origin feature/funcionalidad-increible`)
5. Abre un Pull Request

Por favor, asegúrate de que tu código sigue los estándares de codificación del proyecto ejecutando los linters y formateadores antes de enviar.

## ⚡ Integración Continua

Este proyecto utiliza GitHub Actions para implementar un flujo de Integración Continua (CI). El flujo se ejecuta automáticamente en cada push a la rama main y en los pull requests hacia main.

El flujo de CI realiza las siguientes operaciones:
- Checkout del repositorio
- Configuración de Node.js
- Instalación de dependencias
- Ejecución del linter
- Compilación del proyecto
- Ejecución de pruebas (cuando estén implementadas)

Puedes ver el estado de las ejecuciones de CI en la pestaña "Actions" del repositorio.

## 🐳 Desarrollo con Dev Containers

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

## 📝 Licencia

Este proyecto está licenciado bajo la Licencia ISC - consulta el archivo `package.json` para más detalles.
