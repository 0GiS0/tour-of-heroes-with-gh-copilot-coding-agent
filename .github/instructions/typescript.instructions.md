---
applyTo: '**/*.ts'
---

# 📝 Buenas Prácticas para TypeScript

Este documento proporciona directrices y buenas prácticas para escribir código TypeScript productivo y de desarrollo, optimizado para ser utilizado con GitHub Copilot.

## 🏗️ Organización de Carpetas y Archivos

### Estructura de Proyecto Recomendada

Para proyectos pequeños y medianos, como este Tour of Heroes:

```
src/
├── config/         # Configuraciones de la aplicación
├── controllers/    # Controladores HTTP
├── middlewares/    # Middleware de Express
├── models/         # Definiciones de tipos e interfaces
├── routes/         # Rutas de la API
├── services/       # Lógica de negocio
├── utils/          # Funciones de utilidad
└── index.ts        # Punto de entrada
```

Para proyectos más grandes, considera una estructura basada en características (feature-based) o dominios:

```
src/
├── features/
│   ├── heroes/
│   │   ├── components/
│   │   ├── models/
│   │   ├── services/
│   │   └── index.ts  # Barrel file para exportaciones
│   └── auth/
│       ├── components/
│       ├── models/
│       └── index.ts
├── shared/
│   ├── components/
│   ├── utils/
│   └── index.ts
└── index.ts
```

### Archivos Barrel (index.ts)

Utiliza archivos barrel para simplificar las importaciones:

```typescript
// models/index.ts
export * from './hero.model';
export * from './user.model';

// En otro archivo
import { Hero, User } from './models';
```

## 📏 Definición y Uso de Tipos e Interfaces

### Cuándo Usar Type vs Interface

- **Interfaces**: Para definir contratos de objetos, especialmente cuando se extenderán o implementarán
- **Types**: Para uniones, intersecciones y tipos más complejos

```typescript
// Usar interface para modelos de datos
interface Hero {
  id: number;
  name: string;
  alterEgo?: string;
  powers: string[];
  team?: string;
}

// Usar type para uniones o tipos más complejos
type HeroId = number | string;
type HeroWithPowers = Hero & { powerLevel: number };
```

### Prácticas Recomendadas

1. **Nombres descriptivos**: Usa PascalCase para interfaces y tipos
2. **Propiedades opcionales**: Usa `?` para propiedades opcionales en lugar de `| undefined`
3. **Readonly**: Usa `readonly` para propiedades inmutables

```typescript
interface ReadonlyHero {
  readonly id: number;
  readonly name: string;
  alterEgo?: string;  // Propiedad opcional
  readonly powers: ReadonlyArray<string>;
}
```

4. **Genéricos**: Usa para crear tipos reutilizables

```typescript
interface ApiResponse<T> {
  data: T;
  status: number;
  message: string;
}

// Uso
type HeroResponse = ApiResponse<Hero>;
```

## 🛡️ Estrategias de Tipado Estricto

### Evitar `any`

El tipo `any` elude el sistema de tipos y debe evitarse. Alternativas:

1. **unknown**: Cuando no conoces el tipo exacto pero quieres mantener seguridad

```typescript
// Mal
function parseData(data: any): any {
  return JSON.parse(data);
}

// Bien
function parseData(data: string): unknown {
  return JSON.parse(data);
}

// Uso con type narrowing
const result = parseData('{"name": "Superman"}');
if (typeof result === 'object' && result && 'name' in result) {
  console.log(result.name);
}
```

2. **Type narrowing**: Refinar tipos con validaciones

```typescript
function processHero(hero: unknown): void {
  if (
    typeof hero === 'object' && 
    hero !== null && 
    'id' in hero && 
    'name' in hero && 
    'powers' in hero
  ) {
    // TypeScript ahora sabe que hero tiene las propiedades id, name y powers
    console.log(`Processing hero: ${hero.name}`);
  }
}
```

3. **Type guards**: Funciones para validar tipos

```typescript
function isHero(obj: unknown): obj is Hero {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    'id' in obj &&
    'name' in obj &&
    'powers' in obj &&
    Array.isArray((obj as Hero).powers)
  );
}

function processEntity(entity: unknown): void {
  if (isHero(entity)) {
    // TypeScript sabe que entity es de tipo Hero
    console.log(`Hero name: ${entity.name}`);
  }
}
```

### Utilizar `strict: true` en tsconfig.json

Siempre activa el modo estricto en tsconfig.json para obtener mejor seguridad de tipos:

```json
{
  "compilerOptions": {
    "strict": true,
    // Otras opciones...
  }
}
```

### Utility Types

Utiliza los tipos de utilidad incorporados para transformaciones de tipos comunes:

```typescript
// Objeto parcial (todas las propiedades opcionales)
type HeroUpdate = Partial<Hero>;

// Selecciona solo ciertas propiedades
type HeroSummary = Pick<Hero, 'id' | 'name'>;

// Omite ciertas propiedades
type HeroWithoutId = Omit<Hero, 'id'>;

// Hace todas las propiedades requeridas
type RequiredHero = Required<Hero>;

// Hace todas las propiedades de solo lectura
type ImmutableHero = Readonly<Hero>;
```

## 🔄 Uso de Herramientas de Linting y Formateo

### ESLint

Este proyecto utiliza ESLint para el análisis estático de código. Configuración básica:

```javascript
// eslint.config.js
import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import prettierPlugin from 'eslint-plugin-prettier';
import prettierConfig from 'eslint-config-prettier';

export default tseslint.config(
  eslint.configs.recommended,
  ...tseslint.configs.recommended,
  prettierConfig,
  {
    // Configuración específica
    rules: {
      '@typescript-eslint/no-explicit-any': 'warn',
      '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    },
  },
);
```

Reglas recomendadas:
- `no-explicit-any`: Previene el uso de `any`
- `explicit-function-return-type`: Requiere tipos de retorno explícitos
- `no-unused-vars`: Detecta variables no utilizadas
- `naming-convention`: Aplica convenciones de nomenclatura

### Prettier

Para formateo consistente de código. Configuración básica en `.prettierrc`:

```json
{
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 100,
  "tabWidth": 2
}
```

### Scripts NPM

Utiliza estos scripts en package.json:

```json
{
  "scripts": {
    "lint": "eslint './src/**/*.ts'",
    "lint:fix": "eslint './src/**/*.ts' --fix",
    "format": "prettier --write \"src/**/*.ts\""
  }
}
```

## 🚫 Manejo de Errores y Excepciones

### Clases de Error Personalizadas

Define clases de error específicas para diferentes tipos de errores:

```typescript
// utils/errors.ts
export class ApiError extends Error {
  constructor(
    public statusCode: number,
    message: string,
    public isOperational = true,
    public stack = ''
  ) {
    super(message);
    if (stack) {
      this.stack = stack;
    } else {
      Error.captureStackTrace(this, this.constructor);
    }
  }
}

export class NotFoundError extends ApiError {
  constructor(message = 'Resource not found') {
    super(404, message);
  }
}

export class BadRequestError extends ApiError {
  constructor(message = 'Bad request') {
    super(400, message);
  }
}
```

### Manejo de Errores Asíncronos

Utiliza async/await con try/catch para manejar errores asíncronos:

```typescript
async function fetchHero(id: number): Promise<Hero> {
  try {
    const response = await fetch(`/api/heroes/${id}`);
    if (!response.ok) {
      throw new ApiError(response.status, `Error fetching hero: ${response.statusText}`);
    }
    const data = await response.json();
    return data as Hero;
  } catch (error) {
    // Rethrow con información adicional
    if (error instanceof Error) {
      throw new ApiError(500, `Failed to fetch hero: ${error.message}`);
    }
    throw new ApiError(500, 'Unknown error occurred');
  }
}
```

### Middleware de Error para Express

```typescript
// middlewares/error.middleware.ts
import { Request, Response, NextFunction } from 'express';
import { ApiError } from '../utils/errors';

export const errorHandler = (
  err: Error | ApiError,
  _req: Request,
  res: Response,
  _next: NextFunction
): void => {
  let statusCode = 500;
  let message = 'Internal Server Error';
  
  if (err instanceof ApiError) {
    statusCode = err.statusCode;
    message = err.message;
  } else if (err instanceof Error) {
    message = err.message;
  }
  
  res.status(statusCode).json({
    status: 'error',
    statusCode,
    message,
    stack: process.env.NODE_ENV === 'development' ? err.stack : undefined,
  });
};
```

## 🧪 Pruebas Unitarias e Integración

### Configuración Recomendada

Para pruebas con Jest o Vitest:

```typescript
// jest.config.js
export default {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  transform: {
    '^.+\\.tsx?$': 'ts-jest',
  },
  testRegex: '(/__tests__/.*|(\\.|/)(test|spec))\\.tsx?$',
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
  coverageDirectory: 'coverage',
};
```

### Pruebas Unitarias

Ejemplo de prueba unitaria para un servicio:

```typescript
// services/__tests__/hero.service.test.ts
import { createHero, getHeroById } from '../hero.service';
import { Hero } from '../../models/hero.model';

describe('Hero Service', () => {
  // Datos de prueba
  const mockHero: Hero = {
    id: 1,
    name: 'Superman',
    powers: ['flight', 'strength'],
  };
  
  // Prueba de creación
  test('should create a hero', () => {
    const hero = createHero('Superman', ['flight', 'strength']);
    expect(hero).toHaveProperty('id');
    expect(hero.name).toBe('Superman');
    expect(hero.powers).toContain('flight');
  });
  
  // Prueba con mock
  test('should get hero by id', async () => {
    // Mock del repositorio o base de datos
    jest.spyOn(global, 'fetch').mockResolvedValueOnce({
      ok: true,
      json: async () => mockHero,
    } as Response);
    
    const hero = await getHeroById(1);
    expect(hero).toEqual(mockHero);
  });
  
  // Prueba de manejo de errores
  test('should throw error when hero not found', async () => {
    jest.spyOn(global, 'fetch').mockResolvedValueOnce({
      ok: false,
      status: 404,
      statusText: 'Not Found',
    } as Response);
    
    await expect(getHeroById(999)).rejects.toThrow('not found');
  });
});
```

### Pruebas de Integración

Para probar la integración entre componentes:

```typescript
// routes/__tests__/hero.routes.test.ts
import request from 'supertest';
import express from 'express';
import heroRoutes from '../hero.routes';

describe('Hero API Routes', () => {
  const app = express();
  app.use(express.json());
  app.use('/api/heroes', heroRoutes);
  
  test('GET /api/heroes should return all heroes', async () => {
    const response = await request(app).get('/api/heroes');
    expect(response.status).toBe(200);
    expect(Array.isArray(response.body)).toBe(true);
  });
  
  test('POST /api/heroes should create a new hero', async () => {
    const newHero = {
      name: 'Wonder Woman',
      powers: ['strength', 'agility'],
    };
    
    const response = await request(app)
      .post('/api/heroes')
      .send(newHero);
      
    expect(response.status).toBe(201);
    expect(response.body).toHaveProperty('id');
    expect(response.body.name).toBe(newHero.name);
  });
});
```

## 📄 Documentación con JSDoc

### Documentación de Funciones

```typescript
/**
 * Busca un héroe por su ID
 * 
 * @param id - El identificador único del héroe
 * @returns Una promesa que resuelve al objeto héroe
 * @throws {NotFoundError} Si el héroe no existe
 * @throws {ApiError} Si ocurre un error en la API
 * 
 * @example
 * ```ts
 * // Obtener un héroe por id
 * const hero = await getHeroById(1);
 * console.log(hero.name); // Superman
 * ```
 */
async function getHeroById(id: number): Promise<Hero> {
  // implementación...
}
```

### Documentación de Interfaces

```typescript
/**
 * Representa un héroe en el sistema
 * 
 * @interface Hero
 * @property {number} id - Identificador único del héroe
 * @property {string} name - Nombre del héroe
 * @property {string} [alterEgo] - Identidad secreta del héroe (opcional)
 * @property {string[]} powers - Lista de poderes del héroe
 * @property {string} [team] - Equipo al que pertenece el héroe (opcional)
 */
interface Hero {
  id: number;
  name: string;
  alterEgo?: string;
  powers: string[];
  team?: string;
}
```

### Comentarios de Código

- Usa comentarios para explicar "por qué", no "qué" o "cómo"
- El código bien escrito debe ser autoexplicativo
- Usa comentarios para decisiones no obvias o soluciones complejas

```typescript
// Mal: Explica lo que hace el código (ya evidente)
// Incrementar contador en 1
counter++;

// Bien: Explica por qué se toma una decisión
// Usamos un timeout de 3s para dar tiempo suficiente a la API externa
// que tiene límites de frecuencia de 20 peticiones/minuto
setTimeout(processBatch, 3000);
```

## 🛠️ Configuración de tsconfig.json

### Para Desarrollo

```json
{
  "compilerOptions": {
    "target": "es2020",
    "module": "esnext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "sourceMap": true,
    "declaration": false,
    "noUnusedLocals": false,
    "noUnusedParameters": false
  }
}
```

### Para Producción

```json
{
  "compilerOptions": {
    "target": "es2020",
    "module": "esnext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "sourceMap": false,
    "declaration": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "removeComments": true
  }
}
```

### Para Pruebas

```json
{
  "compilerOptions": {
    "target": "es2020",
    "module": "esnext",
    "moduleResolution": "node",
    "outDir": "./dist",
    "rootDir": "./",
    "strict": true,
    "esModuleInterop": true,
    "sourceMap": true,
    "declaration": false,
    "allowJs": true,
    "types": ["jest", "node"]
  },
  "include": ["src/**/*", "tests/**/*"]
}
```

### Explicación de Opciones Clave

- `target`: Versión de ECMAScript para la salida compilada
- `module`: Sistema de módulos para la salida
- `strict`: Activa todas las comprobaciones de tipo estricto
- `esModuleInterop`: Facilita la interoperabilidad con módulos CommonJS
- `sourceMap`: Genera archivos .map para depuración
- `declaration`: Genera archivos .d.ts para bibliotecas
- `paths`: Configura alias de importación para rutas absolutas

## 🏷️ Gestión de Dependencias

### Dependencias de Desarrollo vs Producción

```bash
# Dependencias de producción
npm install express mongoose 

# Dependencias de desarrollo
npm install --save-dev typescript @types/express @types/node eslint prettier
```

### Manejo de Tipos

- Siempre instala los @types correspondientes para bibliotecas JavaScript
- Para bibliotecas sin tipos disponibles, crea un archivo de declaración:

```typescript
// types/missing-library/index.d.ts
declare module 'missing-library' {
  export function someFunction(param: string): boolean;
  export interface SomeInterface {
    property: string;
  }
}
```

### Actualizaciones Seguras

Usa el modo exacto en package.json para dependencias críticas:

```json
{
  "dependencies": {
    "express": "4.18.2"  // Versión exacta
  },
  "devDependencies": {
    "typescript": "^5.0.0"  // Actualizaciones menores permitidas
  }
}
```

## 🛠️ Instrucciones de Mantenimiento 

Para mantener actualizado este documento:

1. Revisa regularmente las actualizaciones en TypeScript, ESLint y herramientas relacionadas
2. Actualiza las versiones recomendadas en la sección correspondiente
3. Añade nuevas secciones para prácticas emergentes
4. Asegúrate de que los ejemplos sigan siendo compatibles con la versión actual del proyecto
5. Verifica que las recomendaciones estén alineadas con el resto del código base

---

Estas directrices ayudarán a mantener un código TypeScript limpio, eficiente y mantenible. Consulta también la [documentación oficial de TypeScript](https://www.typescriptlang.org/docs/) para obtener información más detallada sobre características específicas.