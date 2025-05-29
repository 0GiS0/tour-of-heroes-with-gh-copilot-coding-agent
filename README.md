# Tour of Heroes API

Una API REST para gestionar superhéroes, implementada con Node.js y TypeScript. Este proyecto proporciona un backend sencillo para la aplicación "Tour of Heroes" con endpoints para obtener, crear, actualizar y eliminar datos de héroes.

## Repositorio de ejemplo de mi vídeo de Youtube

Este repo fue creado como parte de mi vídeo de YouTube [Asigna tareas a GitHub Copilot como a un dev más 🧑‍💻 | Copilot Coding Agent](https://youtu.be/UiJj7pjTN_Y):

[![Tour of Heroes API - YouTube Video](docs/images/Cómo%20usar%20el%20nuevo%20Coding%20Agent%20de%20GitHub%20Copilot.png)](https://youtu.be/UiJj7pjTN_Y)

## 📋 Resumen

- **Tipo**: API REST
- **Tecnologías**: TypeScript, Express, MongoDB
- **Plataformas**: Docker, Kubernetes, Azure (AKS)
- **Estado**: En desarrollo

## 🚀 Inicio Rápido

```bash
# Clonar el repositorio
git clone https://github.com/0GiS0/tour-of-heroes-with-gh-copilot-coding-agent.git
cd tour-of-heroes-with-gh-copilot-coding-agent

# Instalar dependencias
npm install

# Configurar la base de datos MongoDB
# Asegúrate de tener MongoDB ejecutándose en localhost:27017 o configura la variable de entorno MONGODB_URI

# Cargar datos iniciales en la base de datos
npm run seed

# Iniciar en modo desarrollo
npm run dev
```

Para opciones de inicio avanzadas (Docker, Kubernetes, etc.), consulta la [documentación de instalación](./docs/installation.md).

## 📦 Características Principales

- CRUD completo para gestionar héroes
- Validación de datos y manejo de errores
- Documentación API integrada
- Soporte para múltiples entornos de desarrollo
- Configuración completa para CI/CD

## 📚 Documentación

La documentación completa del proyecto está organizada en la [carpeta de docs](./docs/README.md).

### Guías de Inicio

- [Estructura del Proyecto](./docs/project-structure.md)
- [Instalación y Requisitos](./docs/installation.md)
- [Uso Básico](./docs/basic-usage.md)

### Entornos de Desarrollo

- [Desarrollo con Docker](./docs/docker-development.md)
- [Desarrollo con Dev Containers](./docs/dev-containers.md)
- [Desarrollo con Kubernetes](./docs/kubernetes-development.md)

### Operaciones y Despliegue

- [Integración Continua](./docs/ci-cd.md)
- [Terraform para AKS](./terraform/README.md)

### Tecnología y Contribución

- [Tecnologías Utilizadas](./docs/technologies.md)
- [GitHub Copilot y Coding Agent](./docs/github-copilot.md)
- [Guía de Contribución](./docs/contributing.md)
- [Licencia](./docs/license.md)

## 👥 Contribución

¡Las contribuciones a este proyecto son bienvenidas! Consulta nuestra [guía de contribución](./docs/contributing.md) para comenzar.

## 📝 Licencia

Este proyecto está licenciado bajo la Licencia ISC. Consulta el [archivo de licencia](./docs/license.md) para más detalles.
