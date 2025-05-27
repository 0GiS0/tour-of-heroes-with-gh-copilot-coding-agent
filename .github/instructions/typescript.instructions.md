---
applyTo: '**/*.ts'
---

# 📝 Buenas Prácticas para TypeScript

- Usa una estructura de carpetas clara (por dominio o funcionalidad) y archivos barrel (index.ts) para simplificar importaciones.
- Prefiere interfaces para modelos de datos y types para uniones o tipos complejos.
- Usa nombres descriptivos en PascalCase, propiedades opcionales con ?, y readonly para inmutabilidad.
- Evita any; usa unknown, type narrowing y type guards para mayor seguridad.
- Activa strict: true en tsconfig.json.
- Aprovecha utility types como Partial, Pick, Omit, Required, Readonly.
- Usa ESLint y Prettier para mantener calidad y formato del código. Ejecútalos cada vez que hagas un cambio.
- Implementa clases de error personalizadas y maneja errores asíncronos con try/catch.
- Añade middleware de manejo de errores en Express.
- Escribe pruebas unitarias e integración (Jest/Vitest, Supertest).
- Documenta funciones y modelos con JSDoc; comenta el "por qué" del código.
- Mantén tsconfig.json adecuado para desarrollo, producción y pruebas.
- Separa dependencias de desarrollo y producción; instala los @types necesarios.
- Usa versiones exactas para dependencias críticas.
