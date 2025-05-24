# Tour of Heroes - Terraform para AKS

Este directorio contiene la configuración de Terraform para desplegar un clúster de Azure Kubernetes Service (AKS) que alojará la aplicación Tour of Heroes.

## 📁 Estructura del Proyecto

```
terraform/
├── modules/                     # Módulos reutilizables
│   ├── resource_group/          # Módulo para grupo de recursos
│   ├── network/                 # Módulo para red virtual y subredes
│   └── aks/                     # Módulo para cluster AKS
├── main.tf                      # Configuración principal de Terraform
├── variables.tf                 # Definición de variables
├── outputs.tf                   # Valores de salida
├── providers.tf                 # Configuración de proveedores
├── versions.tf                  # Restricciones de versiones
└── terraform.tfvars.example     # Ejemplo de archivo de variables
```

## 🚀 Requisitos

- [Terraform](https://www.terraform.io/downloads.html) (versión >= 1.0.0)
- [Azure CLI](https://docs.microsoft.com/es-es/cli/azure/install-azure-cli) instalado y configurado
- Una suscripción de Azure con permisos suficientes para crear recursos

## 🔧 Configuración

1. Inicializa una sesión con Azure CLI:

```bash
az login
```

2. (Opcional) Selecciona la suscripción de Azure que deseas usar:

```bash
az account set --subscription "ID-de-Suscripción"
```

3. Copia el archivo de ejemplo de variables y modifícalo según tus necesidades:

```bash
cp terraform.tfvars.example terraform.tfvars
```

4. Edita `terraform.tfvars` con los valores específicos para tu despliegue.

## 🏗️ Despliegue

1. Inicializa Terraform en el directorio:

```bash
terraform init
```

2. Valida la configuración:

```bash
terraform validate
```

3. Revisa el plan de ejecución:

```bash
terraform plan
```

4. Aplica la configuración para crear los recursos:

```bash
terraform apply
```

5. Confirma la creación escribiendo "yes" cuando se te solicite.

## 🔄 Configuración de kubectl

Una vez desplegado el clúster, puedes configurar kubectl para conectarte a él:

```bash
az aks get-credentials --resource-group <nombre-grupo-recursos> --name <nombre-cluster>
```

O utilizando el output de Terraform:

```bash
echo "$(terraform output -raw kube_config)" > ~/.kube/config
```

## 🗑️ Eliminación de recursos

Para eliminar todos los recursos creados:

```bash
terraform destroy
```

## 📝 Notas sobre costos

- Este despliegue utiliza nodos de tipo `Standard_B2s`, que son máquinas virtuales de bajo costo adecuadas para desarrollo y pruebas.
- El auto-escalado está habilitado por defecto, con un mínimo de 1 y un máximo de 3 nodos para optimizar costos.
- Recuerda destruir los recursos cuando no los necesites para evitar cargos innecesarios.

## 🔄 Escalar el clúster

### Escalado horizontal (número de nodos)

Puedes modificar el número de nodos actualizando las variables:

- `node_count` - Para un número fijo de nodos
- `min_node_count` y `max_node_count` - Para ajustar los límites del auto-escalado

```bash
# Ejemplo para actualizar el número máximo de nodos
terraform apply -var="max_node_count=5"
```

### Escalado vertical (tamaño de VM)

Para cambiar el tamaño de las máquinas virtuales:

1. Actualiza la variable `node_size` con un tamaño de VM más potente, como `Standard_D2s_v3`.
2. Aplica los cambios (esto recreará el grupo de nodos).

```bash
terraform apply -var="node_size=Standard_D2s_v3"
```

## 🔐 Consideraciones de seguridad

Esta configuración incluye:

- RBAC de Azure AD habilitado
- Política de red Calico para seguridad entre pods
- Identidad administrada para el clúster
- Subredes dedicadas para los componentes del clúster