# Tour of Heroes API

Este repositorio se ha confeccionado usando Github Copilot con su agente Coding. Es una API REST para la gestión de superhéroes implementada con Node.js y TypeScript.

## Estructura del Proyecto

```
src/
├── config/         # Configuración de la aplicación
├── controllers/    # Controladores para manejar las solicitudes
├── middlewares/    # Middlewares de Express
├── models/         # Definición de modelos/interfaces
├── routes/         # Rutas de la API
├── services/       # Lógica de negocio
└── utils/          # Utilidades y funciones auxiliares
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
