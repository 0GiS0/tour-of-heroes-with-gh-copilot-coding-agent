# 📁 Estructura del Proyecto

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
├── Dockerfile       # Configuración Docker para producción
├── Dockerfile.dev   # Configuración Docker para desarrollo
├── docker-compose.yml # Configuración de Docker Compose
├── .dockerignore    # Archivos ignorados en el contexto de Docker
├── eslint.config.js # Configuración de ESLint
├── package.json     # Dependencias del proyecto
└── tsconfig.json    # Configuración de TypeScript
```

## Detalles de los Directorios Principales

### `/src`
El directorio principal que contiene todo el código fuente de la aplicación.

- **config/**: Contiene archivos para configurar la aplicación, como variables de entorno y opciones de base de datos.
- **controllers/**: Implementa los manejadores de peticiones HTTP que interactúan con los clientes.
- **middlewares/**: Define funciones intermedias que procesan las peticiones antes de llegar a los controladores.
- **models/**: Define las estructuras de datos e interfaces para los objetos de la aplicación.
- **routes/**: Configura las rutas API y las conecta con los controladores adecuados.
- **services/**: Implementa la lógica de negocio principal de la aplicación.
- **utils/**: Contiene funciones auxiliares y utilidades comunes.

### `/.devcontainer`
Configuración para desarrollo en contenedores con Visual Studio Code. Para más detalles, consulta la [documentación de Dev Containers](./dev-containers.md).

### `/.github`
Configuración de flujos de trabajo de GitHub Actions para integración continua. Para más detalles, consulta la [documentación de CI/CD](./ci-cd.md).

### `/k8s`
Manifiestos de Kubernetes para despliegue en entornos de desarrollo y producción. Para más detalles, consulta la [documentación de Kubernetes](./kubernetes-development.md).

### `/terraform`
Configuración de Terraform para despliegue de infraestructura en Azure. Para más detalles, consulta la documentación específica en el [directorio de Terraform](../terraform/README.md).