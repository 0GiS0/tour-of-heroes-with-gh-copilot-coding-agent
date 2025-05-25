# 🛠️ Uso Básico

Este documento cubre las operaciones básicas para trabajar con el proyecto Tour of Heroes API.

## Entorno de Desarrollo

### Ejecución en Modo Desarrollo

Para ejecutar la aplicación en modo de desarrollo con recarga automática del código:

```bash
npm run dev
```

Este comando utiliza `ts-node-dev` para ejecutar la aplicación y reiniciarla automáticamente cuando detecta cambios en los archivos.

La aplicación estará disponible en `http://localhost:3000` (o el puerto que hayas configurado).

## Entorno de Producción

### Compilación del Proyecto

Para compilar el proyecto a JavaScript:

```bash
npm run build
```

Este comando transpila el código TypeScript a JavaScript y lo coloca en el directorio `dist/`.

### Ejecución en Modo Producción

Para ejecutar la aplicación compilada en modo producción:

```bash
npm start
```

Este comando ejecuta la aplicación compilada desde el directorio `dist/`.

## Linting y Formateo de Código

### Ejecutar el Linter

Para verificar el código en busca de problemas:

```bash
npm run lint
```

### Corregir Problemas de Linting

Para corregir automáticamente los problemas de linting:

```bash
npm run lint:fix
```

### Formatear el Código

Para formatear el código con Prettier:

```bash
npm run format
```

## API Endpoints

La API proporciona los siguientes endpoints principales:

- `GET /heroes`: Obtiene la lista de todos los héroes
- `GET /heroes/:id`: Obtiene un héroe por su ID
- `POST /heroes`: Crea un nuevo héroe
- `PUT /heroes/:id`: Actualiza un héroe existente
- `DELETE /heroes/:id`: Elimina un héroe por su ID

## Ejemplo de Uso

Para crear un nuevo héroe, puedes usar:

```bash
curl -X POST http://localhost:3000/heroes \
  -H "Content-Type: application/json" \
  -d '{"name": "Batman", "alterEgo": "Bruce Wayne", "power": 8}'
```

Para obtener todos los héroes:

```bash
curl http://localhost:3000/heroes
```

## Próximos Pasos

Para desarrollar en entornos más avanzados, consulta:

- [Desarrollo con Docker](./docker-development.md)
- [Desarrollo con Dev Containers](./dev-containers.md)
- [Desarrollo con Kubernetes](./kubernetes-development.md)