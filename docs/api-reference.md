# 📚 API Reference

Este documento proporciona una referencia detallada de los endpoints disponibles en la API de Tour of Heroes.

## Héroes

### Obtener lista de héroes

Recupera una lista paginada de héroes, con opciones para filtrar por diferentes atributos.

**Endpoint**: `GET /api/heroes`

**Parámetros de consulta**:

| Parámetro | Tipo   | Descripción                                           | Ejemplo                |
|-----------|--------|-------------------------------------------------------|------------------------|
| name      | string | Filtrar héroes por nombre (búsqueda parcial)          | ?name=man              |
| powers    | string | Filtrar héroes por poderes (búsqueda parcial)         | ?powers=flight         |
| team      | string | Filtrar héroes por equipo (búsqueda parcial)          | ?team=Justice          |
| page      | number | Número de página para paginación (empieza en 1)       | ?page=2                |
| limit     | number | Número de héroes por página (por defecto: 10)         | ?limit=5               |

**Respuesta exitosa** (código 200):

```json
{
  "data": [
    {
      "id": 1,
      "name": "Superman",
      "alterEgo": "Clark Kent",
      "powers": [
        "Super Strength",
        "Flight",
        "Invulnerability",
        "Super Speed",
        "Heat Vision",
        "Freeze Breath",
        "X-Ray Vision",
        "Superhuman Hearing",
        "Healing Factor"
      ],
      "team": "Justice League"
    },
    {
      "id": 2,
      "name": "Batman",
      "alterEgo": "Bruce Wayne",
      "powers": [
        "Exceptional Martial Artist",
        "Combat Strategy",
        "Inexhaustible Wealth",
        "Brilliant Deductive Skill",
        "Advanced Technology"
      ],
      "team": "Justice League"
    }
  ],
  "metadata": {
    "totalHeroes": 6,
    "page": 1,
    "limit": 2,
    "totalPages": 3
  }
}
```

### Obtener un héroe por ID

Recupera la información detallada de un héroe específico usando su ID.

**Endpoint**: `GET /api/heroes/:id`

**Parámetros de ruta**:

| Parámetro | Tipo   | Descripción      | Ejemplo   |
|-----------|--------|------------------|-----------|
| id        | number | ID del héroe     | /api/heroes/1 |

**Respuesta exitosa** (código 200):

```json
{
  "data": {
    "id": 1,
    "name": "Superman",
    "alterEgo": "Clark Kent",
    "powers": [
      "Super Strength",
      "Flight",
      "Invulnerability",
      "Super Speed",
      "Heat Vision",
      "Freeze Breath",
      "X-Ray Vision",
      "Superhuman Hearing",
      "Healing Factor"
    ],
    "team": "Justice League"
  }
}
```

**Respuesta de error** (código 404):

```json
{
  "error": "Hero not found"
}
```

**Respuesta de error** (código 400):

```json
{
  "error": "Invalid hero ID. ID must be a number."
}
```

## Manejo de Errores

La API utiliza los siguientes códigos de estado HTTP:

| Código | Descripción                                          |
|--------|------------------------------------------------------|
| 200    | Éxito - La solicitud se procesó correctamente        |
| 400    | Error de solicitud - Parámetros inválidos o faltantes|
| 404    | No encontrado - El recurso solicitado no existe      |
| 500    | Error del servidor - Problema interno del servidor   |

## Ejemplos de uso con cURL

### Listar todos los héroes (primera página, 10 por página)

```bash
curl http://localhost:3000/api/heroes
```

### Listar héroes con paginación

```bash
curl http://localhost:3000/api/heroes?page=2&limit=3
```

### Filtrar héroes por nombre

```bash
curl http://localhost:3000/api/heroes?name=Super
```

### Obtener un héroe específico

```bash
curl http://localhost:3000/api/heroes/1
```

### Filtrar y paginar simultáneamente

```bash
curl http://localhost:3000/api/heroes?team=Justice&page=1&limit=2
```