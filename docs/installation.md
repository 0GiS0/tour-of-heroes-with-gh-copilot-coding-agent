# 🚀 Instalación y Requisitos

## Requisitos Previos

Para trabajar con este proyecto, necesitarás tener instalado lo siguiente:

- Node.js (v22+)
- npm (v6+)
- MongoDB (para desarrollo local sin contenedores)

Opcionalmente, para los entornos containerizados:
- [Docker](https://www.docker.com/get-started) y [Docker Compose](https://docs.docker.com/compose/install/)
- [Visual Studio Code](https://code.visualstudio.com/) con la [extensión Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Instalación

### Clonación del Repositorio

Primero, clona el repositorio a tu máquina local:

```bash
git clone https://github.com/0GiS0/tour-of-heroes-with-gh-copilot-coding-agent.git
cd tour-of-heroes-with-gh-copilot-coding-agent
```

### Instalación de Dependencias

Instala todas las dependencias del proyecto usando npm:

```bash
npm install
```

### Configuración de Variables de Entorno

El proyecto utiliza variables de entorno para la configuración. Puedes crear un archivo `.env` en la raíz del proyecto con las siguientes variables:

```
PORT=3000
MONGODB_URI=mongodb://localhost:27017/heroes
```

> **Nota**: Si estás utilizando Docker o Dev Containers, las variables de entorno ya están configuradas en los archivos `docker-compose.yml` y `.devcontainer/devcontainer.json`.

## Verificación de la Instalación

Para verificar que todo está correctamente instalado, puedes ejecutar:

```bash
npm run build
```

Si no hay errores, la instalación se ha completado correctamente.

## Desarrollo en Diferentes Entornos

Para obtener instrucciones detalladas sobre cómo desarrollar en diferentes entornos, consulta:

- [Desarrollo Básico](./basic-usage.md)
- [Desarrollo con Docker](./docker-development.md)
- [Desarrollo con Dev Containers](./dev-containers.md)
- [Desarrollo con Kubernetes](./kubernetes-development.md)