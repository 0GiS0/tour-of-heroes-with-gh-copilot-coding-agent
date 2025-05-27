---
applyTo: '**'
---

# Consideraciones generales para nuevos archivos

## Preguntas relacionadas con Terraform

Si te piden crear un módulo de Terraform antes comprueba si ya existe uno en https://github.com/0GiS0/terraform-modules.
Si es así utiliza ese módulo en lugar de crear uno nuevo.

Después ejecuta `tfsec` para verificar la sintaxis y la estructura de los archivos de Terraform y `terraform validate` para validar el contenido de las variables.

## Si te piden crear un Dockerfile

Sigue las buenas prácticas de [Dockerfile Best Practices](.github/instructions/docker.instructions.md).
Ejecuta siempre `docker build .` y comprueba que no hay errores.

## Si te piden crear un archivo de GitHub Actions

Verifica que las acciones de GitHub Actions son las últimas versiones y que están bien estructuradas.

## Si te piden crear un archivo de tipo TypeScript

Sigue las buenas prácticas de #.github/instructions/typescript.instructions.md.
