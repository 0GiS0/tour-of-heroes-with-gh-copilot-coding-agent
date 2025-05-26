---
applyTo: '**/*.tf'
---

Sigue las indicaciones de #fetch https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs cuando escribas código Terraform.

## Módulos

Sigue las buenas prácticas de Terraform al crear módulos. Asegúrate de que los módulos sean reutilizables y bien documentados.
Aquí puedes encontrar la última versión #fetch https://developer.hashicorp.com/terraform/language/modules/develop

Proveedores dentro de módulos: https://developer.hashicorp.com/terraform/language/modules/develop/providers

## Buenas prácticas y módulos en Terraform

### Documentación oficial de proveedores

Es fundamental consultar siempre la documentación oficial del proveedor que estás utilizando:

- #fetch https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

Revisa periódicamente la versión más reciente del proveedor para aprovechar nuevas características y correcciones de seguridad.

### Creación y uso de módulos

Los módulos en Terraform son componentes reutilizables que encapsulan recursos relacionados. Permiten organizar el código, promover la reutilización y facilitar el mantenimiento.

#### Principios básicos para crear módulos efectivos:

- **Propósito único**: Cada módulo debe tener una responsabilidad bien definida
- **Interfaces claras**: Define entradas (variables) y salidas (outputs) documentadas
- **Configuración flexible**: Diseña módulos que puedan adaptarse a diferentes escenarios
- **Versiona tus módulos**: Utiliza control de versiones para módulos compartidos

#### Declaración de proveedores en módulos

La gestión correcta de proveedores en módulos es crucial:

- Los módulos secundarios no deben declarar configuraciones de proveedores
- Usa la configuración de dependencias de proveedores #fetch https://developer.hashicorp.com/terraform/language/modules/develop/providers para pasar proveedores a módulos

```hcl
# Ejemplo de paso de proveedor a un módulo
module "network" {
  source = "./modules/network"
  
  # Otras variables...
  
  providers = {
    azurerm = azurerm.this
  }
}
```

### Recursos adicionales

Para profundizar en el desarrollo y uso de módulos, consulta:

- #fetch https://developer.hashicorp.com/terraform/language/modules/develop
- #fetch https://developer.hashicorp.com/terraform/language/modules/develop/providers

La inversión en módulos bien diseñados mejora la calidad, mantenibilidad y escalabilidad de tu infraestructura como código.
