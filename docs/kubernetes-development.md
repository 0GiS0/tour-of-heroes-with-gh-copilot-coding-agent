# ⎈ Desarrollo con Kubernetes

Este proyecto incluye soporte completo para Kubernetes, permitiendo desarrollar y probar la aplicación en un entorno más cercano al de producción.

## Introducción a Kubernetes en el Proyecto

Kubernetes proporciona una plataforma para automatizar el despliegue, escalado y operaciones de contenedores de aplicaciones. En este proyecto, se utiliza para:

- Simular un entorno de producción durante el desarrollo
- Probar la orquestación de múltiples servicios (API y MongoDB)
- Validar los manifiestos de Kubernetes antes del despliegue real
- Experimentar con características avanzadas como Ingress y ConfigMaps

## Requisitos Previos

Para desarrollar con Kubernetes en este proyecto, necesitas:

- Dev Container configurado y funcionando (recomendado)
  - O alternativamente: Docker, kubectl y kind instalados manualmente
- Conocimientos básicos de Kubernetes (pods, deployments, services)

> **Nota**: Si estás utilizando el Dev Container proporcionado, todas las herramientas necesarias ya están preinstaladas.

## Estructura de Manifiestos

Los manifiestos de Kubernetes se encuentran en la carpeta `k8s/` y están organizados de la siguiente manera:

```
k8s/
├── deployment.yaml           # Despliegue principal de la API
├── service.yaml              # Servicio para exponer la API
├── mongodb-deployment.yaml   # Despliegue de MongoDB
├── mongodb-service.yaml      # Servicio para MongoDB
├── configmap.yaml            # Configuración de la aplicación
├── secret.yaml               # Secretos (credenciales)
├── ingress.yaml              # Ingress para acceso externo
```

Cada archivo está comentado para facilitar la comprensión de su propósito y configuración.

## Configurando el Cluster de Desarrollo

### Usando el Script Automatizado

Si estás utilizando el Dev Container, puedes configurar rápidamente un cluster de desarrollo con:

```bash
~/.devcontainer/scripts/setup-kind.sh
```

Este script realiza automáticamente los siguientes pasos:

1. Crea un cluster kind llamado "heroes-cluster"
2. Configura NGINX Ingress Controller para gestionar tráfico externo
3. Actualiza `/etc/hosts` para resolver "heroes-api.local"
4. Aplica los manifiestos de Kubernetes del proyecto

### Configuración Manual del Cluster

Si prefieres configurar el cluster manualmente:

1. Crea un cluster kind:
   ```bash
   kind create cluster --name heroes-cluster
   ```

2. Instala NGINX Ingress Controller:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
   ```

3. Aplica los manifiestos:
   ```bash
   kubectl apply -f k8s/
   ```

4. Añade una entrada a `/etc/hosts`:
   ```
   127.0.0.1 heroes-api.local
   ```

## Desarrollo con Kubernetes

### Ciclo de Desarrollo

1. Realiza cambios en el código de la aplicación
2. Reconstruye la imagen Docker:
   ```bash
   ~/.devcontainer/scripts/build-and-load.sh
   ```
   Este script:
   - Construye la imagen Docker
   - La carga directamente en el cluster kind
   - Reinicia el deployment para usar la nueva imagen

3. Verifica el estado:
   ```bash
   kubectl get pods
   ```

4. Accede a la API a través de: http://heroes-api.local

### Comandos Útiles para Trabajo Diario

#### Verificar Recursos Desplegados
```bash
# Ver todos los recursos en el namespace default
kubectl get all

# Ver detalles de un pod específico
kubectl describe pod <nombre-del-pod>

# Ver todos los pods con una etiqueta específica
kubectl get pods -l app=heroes-api
```

#### Logs y Depuración
```bash
# Ver logs de la aplicación
kubectl logs -l app=heroes-api

# Ver logs en tiempo real
kubectl logs -f deployment/heroes-api

# Ejecutar un shell en el contenedor
kubectl exec -it deployment/heroes-api -- /bin/sh
```

#### Gestión de Configuración
```bash
# Ver ConfigMaps
kubectl get configmaps

# Editar un ConfigMap
kubectl edit configmap heroes-config

# Ver Secrets
kubectl get secrets
```

#### Actualización y Eliminación
```bash
# Aplicar cambios en los manifiestos
kubectl apply -f k8s/

# Eliminar todos los recursos definidos
kubectl delete -f k8s/

# Reiniciar un deployment
kubectl rollout restart deployment/heroes-api
```

## Acceso a la Aplicación

Con la configuración predeterminada, puedes acceder a la API a través de:

- **URL**: http://heroes-api.local
- **Puerto**: 80 (redirigido al puerto 3000 dentro del pod)

## Monitoreo del Cluster

Para monitorear el estado del cluster:

```bash
# Información general del cluster
kubectl cluster-info

# Nodos del cluster
kubectl get nodes

# Estado de los componentes del cluster
kubectl get componentstatuses
```

## Limpieza

Cuando hayas terminado de trabajar con el cluster, puedes eliminarlo:

```bash
kind delete cluster --name heroes-cluster
```

## Despliegue en un Cluster Real

Para instrucciones sobre cómo desplegar la aplicación en Azure Kubernetes Service (AKS), consulta la [documentación de Terraform](../terraform/README.md).