# 👥 Contribución

¡Las contribuciones a este proyecto son bienvenidas! Este documento proporciona directrices para contribuir al proyecto Tour of Heroes API.

## Proceso de Contribución

Para contribuir al proyecto, sigue estos pasos:

1. **Haz un fork del repositorio**
   
   Crea tu propia copia del repositorio en tu cuenta de GitHub.

2. **Crea una rama para tu funcionalidad**
   
   ```bash
   git checkout -b feature/funcionalidad-increible
   ```
   
   Utiliza una convención de nomenclatura clara:
   - `feature/nombre-funcionalidad` para nuevas funcionalidades
   - `fix/nombre-error` para correcciones de errores
   - `docs/nombre-documentacion` para cambios en la documentación
   - `refactor/nombre-refactorizacion` para refactorizaciones de código

3. **Haz commit de tus cambios**
   
   ```bash
   git commit -m 'Añadir funcionalidad increíble'
   ```
   
   Utiliza mensajes de commit claros y descriptivos. Sigue el formato:
   ```
   tipo: descripción breve
   
   Descripción más detallada si es necesario
   ```
   
   Donde `tipo` puede ser:
   - `feat`: Nueva funcionalidad
   - `fix`: Corrección de error
   - `docs`: Cambios en documentación
   - `style`: Cambios de formato (que no afectan al código)
   - `refactor`: Refactorización de código
   - `test`: Añadir o modificar pruebas
   - `chore`: Cambios en el proceso de construcción o herramientas auxiliares

4. **Haz push a la rama**
   
   ```bash
   git push origin feature/funcionalidad-increible
   ```

5. **Abre un Pull Request**
   
   Desde tu repositorio en GitHub, abre un nuevo Pull Request hacia el repositorio original.

## Estándares de Codificación

Antes de enviar tu contribución, asegúrate de que tu código sigue los estándares del proyecto:

### Linting y Formateo

Todo el código debe pasar las verificaciones de linting y formateo:

```bash
npm run lint
npm run format
```

### Convenciones de Código

- Utiliza TypeScript con tipos explícitos
- Sigue el principio de responsabilidad única
- Escribe comentarios para código complejo
- Nombra variables y funciones de manera descriptiva
- Utiliza async/await para código asíncrono

### Pruebas

Si añades una nueva funcionalidad, incluye pruebas unitarias y/o de integración adecuadas.

## Proceso de Revisión

Después de enviar un Pull Request:

1. Los mantenedores revisarán tu código
2. Puede que se soliciten cambios o mejoras
3. Las pruebas automatizadas deben pasar
4. Una vez aprobado, tu código será fusionado

## Informe de Errores

Si encuentras un error, verifica primero si ya ha sido reportado. Si no es así, abre un nuevo issue con:

- Una descripción clara del error
- Pasos para reproducirlo
- Comportamiento esperado vs. comportamiento actual
- Capturas de pantalla si es posible
- Cualquier información relevante (sistema operativo, navegador, etc.)

## Solicitud de Funcionalidades

Las solicitudes de nuevas funcionalidades son bienvenidas. Para enviar una:

1. Utiliza el título `[Feature Request]` seguido de una descripción corta
2. Describe claramente la funcionalidad propuesta
3. Explica por qué sería útil para el proyecto
4. Sugiere una implementación si es posible

## Código de Conducta

Se espera que todos los contribuyentes respeten el código de conducta del proyecto. Esto incluye:

- Utilizar un lenguaje inclusivo y respetuoso
- Aceptar críticas constructivas
- Priorizar el interés del proyecto
- Mostrar empatía hacia otros miembros de la comunidad

## ¡Gracias!

Tu contribución es valiosa y ayuda a mejorar este proyecto para todos. ¡Gracias por dedicar tu tiempo y esfuerzo!