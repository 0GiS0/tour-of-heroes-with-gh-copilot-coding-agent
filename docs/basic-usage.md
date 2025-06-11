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

### Héroes

#### Obtener lista de héroes

- **Endpoint**: `GET /api/heroes`
- **Descripción**: Obtiene la lista de héroes con soporte para filtrado y paginación
- **Parámetros de consulta**:
  - `name` (opcional): Filtrar héroes por nombre
  - `powers` (opcional): Filtrar héroes por poderes
  - `team` (opcional): Filtrar héroes por equipo
  - `page` (opcional): Número de página para paginación (por defecto: 1)
  - `limit` (opcional): Número de héroes por página (por defecto: 10)
- **Respuesta**:
  ```json
  {
    "data": [
      {
        "id": 1,
        "name": "Superman",
        "alterEgo": "Clark Kent",
        "powers": ["Super Strength", "Flight", "Invulnerability"],
        "team": "Justice League"
      },
      // ... más héroes
    ],
    "metadata": {
      "totalHeroes": 100,
      "page": 1,
      "limit": 10,
      "totalPages": 10
    }
  }
  ```

#### Obtener un héroe por ID

- **Endpoint**: `GET /api/heroes/:id`
- **Descripción**: Obtiene la información detallada de un héroe específico
- **Parámetros de ruta**:
  - `id`: ID numérico del héroe
- **Respuesta exitosa** (código 200):
  ```json
  {
    "data": {
      "id": 1,
      "name": "Superman",
      "alterEgo": "Clark Kent",
      "powers": ["Super Strength", "Flight", "Invulnerability"],
      "team": "Justice League"
    }
  }
  ```
- **Respuesta de error** (código 404):
  ```json
  {
    "error": "Hero not found"
  }
  ```

- `POST /api/heroes`: Crea un nuevo héroe
- `PUT /api/heroes/:id`: Actualiza un héroe existente
- `DELETE /api/heroes/:id`: Elimina un héroe por su ID

#### Eliminar un héroe por ID

- **Endpoint**: `DELETE /api/heroes/:id`
- **Descripción**: Elimina un héroe específico de la base de datos
- **Parámetros de ruta**:
  - `id`: ID numérico del héroe
- **Respuesta exitosa** (código 200):
  ```json
  {
    "message": "Hero deleted successfully"
  }
  ```
- **Respuesta de error** (código 404):
  ```json
  {
    "error": "Hero not found"
  }
  ```

## Ejemplos de Uso

### Obtener todos los héroes

```bash
curl http://localhost:3000/api/heroes
```

### Filtrar héroes por nombre

```bash
curl http://localhost:3000/api/heroes?name=man
```

### Filtrar héroes por poder

```bash
curl http://localhost:3000/api/heroes?powers=flight
```

### Filtrar héroes por equipo

```bash
curl http://localhost:3000/api/heroes?team=Justice
```

### Paginación de resultados

```bash
# Obtener segunda página con 5 héroes por página
curl http://localhost:3000/api/heroes?page=2&limit=5
```

### Combinar filtros y paginación

```bash
# Filtrar héroes con 'man' en el nombre, página 1, 3 resultados por página
curl http://localhost:3000/api/heroes?name=man&page=1&limit=3
```

### Obtener un héroe específico por ID

```bash
curl http://localhost:3000/api/heroes/1
```

### Eliminar un héroe por ID

```bash
curl -X DELETE http://localhost:3000/api/heroes/1
```

## Próximos Pasos

Para desarrollar en entornos más avanzados, consulta:

- [Desarrollo con Docker](./docker-development.md)
- [Desarrollo con Dev Containers](./dev-containers.md)
- [Desarrollo con Kubernetes](./kubernetes-development.md)