# 🐳 Desarrollo con Docker

Este proyecto está completamente preparado para desarrollo con Docker, ofreciendo múltiples opciones para diferentes escenarios de trabajo.

## Opciones de Desarrollo con Docker

El proyecto proporciona tres métodos principales para trabajar con Docker:

1. **Dockerfile específico para desarrollo** - Ideal para desarrollo rápido
2. **Dockerfile para producción** - Optimizado para entornos de producción
3. **Docker Compose** - Para orquestar múltiples servicios (aplicación y MongoDB)

## Usando Dockerfiles

### Dockerfile.dev (Entorno de Desarrollo)

Este Dockerfile está específicamente configurado para el desarrollo, con las siguientes características:

- Recarga automática del código cuando se detectan cambios
- Volúmenes montados para editar el código en tiempo real
- Dependencias de desarrollo incluidas

```bash
# Construir la imagen de desarrollo
docker build -t heroes-api-dev -f Dockerfile.dev .

# Ejecutar el contenedor
docker run -p 3000:3000 -v $(pwd):/app -v /app/node_modules --name heroes-dev heroes-api-dev
```

Al utilizar `-v $(pwd):/app`, los cambios realizados en los archivos locales se reflejarán inmediatamente en el contenedor. La opción `-v /app/node_modules` evita que los node_modules locales sobrescriban los del contenedor.

### Dockerfile (Entorno de Producción)

Este Dockerfile implementa un proceso de construcción en múltiples etapas para crear una imagen optimizada para producción:

1. **Etapa de construcción**: Instala dependencias y compila el código TypeScript
2. **Etapa de producción**: Incluye solo los archivos necesarios para la ejecución

```bash
# Construir la imagen de producción
docker build -t heroes-api .

# Ejecutar el contenedor
docker run -p 3000:3000 --name heroes-prod heroes-api
```

La imagen resultante es más pequeña, segura y eficiente, ideal para entornos de producción.

## Usando Docker Compose

Para simplificar el proceso de desarrollo, el proyecto incluye un archivo `docker-compose.yml` que define varios servicios:

### Iniciando el Entorno de Desarrollo

```bash
# Iniciar el entorno de desarrollo con MongoDB
docker-compose up app-dev

# O en modo detached (background)
docker-compose up -d app-dev
```

### Iniciando el Entorno de Producción

```bash
# Iniciar el entorno de producción
docker-compose --profile prod up app-prod

# O en modo detached (background)
docker-compose --profile prod up -d app-prod
```

### Deteniendo los Contenedores

```bash
# Detener y eliminar contenedores
docker-compose down

# Para eliminar también los volúmenes
docker-compose down -v
```

## Servicios Definidos en Docker Compose

El archivo `docker-compose.yml` define tres servicios principales:

### `app-dev`
- Basado en `Dockerfile.dev`
- Configurado para desarrollo con recarga automática
- Volúmenes montados para editar código en tiempo real
- Conectado a MongoDB

### `app-prod`
- Basado en `Dockerfile` (optimizado para producción)
- Sin volúmenes montados
- Solo se ejecuta cuando se especifica el perfil `prod`
- Conectado a MongoDB

### `mongodb`
- Base de datos MongoDB para persistencia de datos
- Versión 8.0
- Datos persistidos en un volumen Docker
- Expuesta solo a los servicios de la aplicación (no al host)

## Consejos para el Desarrollo con Docker

1. **Logs en tiempo real**:
   ```bash
   docker-compose logs -f app-dev
   ```

2. **Ejecución de comandos dentro del contenedor**:
   ```bash
   docker-compose exec app-dev npm run lint
   ```

3. **Reconstrucción de imágenes**:
   ```bash
   docker-compose build app-dev
   ```

4. **Verificación de recursos**:
   ```bash
   docker stats
   ```

5. **Limpieza de recursos**:
   ```bash
   # Eliminar contenedores parados
   docker container prune
   
   # Eliminar imágenes sin usar
   docker image prune
   
   # Eliminar todo lo no utilizado (¡usar con precaución!)
   docker system prune
   ```

## Opciones Avanzadas

Para escenarios más complejos, considera utilizar:

- [Dev Containers con Visual Studio Code](./dev-containers.md)
- [Desarrollo con Kubernetes](./kubernetes-development.md)