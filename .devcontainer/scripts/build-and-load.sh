#!/bin/bash
# Script para construir y cargar la imagen Docker en el cluster Kind

set -e

CLUSTER_NAME="heroes-cluster"
IMAGE_NAME="heroes-api:latest"

echo "🔄 Verificando si el cluster Kind '${CLUSTER_NAME}' existe..."
if ! kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
    echo "❌ El cluster '${CLUSTER_NAME}' no existe. Ejecute primero 'setup-kind.sh'."
    exit 1
fi

echo "🏗️ Construyendo imagen Docker '${IMAGE_NAME}'..."
cd /workspaces/$(basename $PWD)
docker build -t ${IMAGE_NAME} -f Dockerfile.dev .

echo "📦 Cargando imagen en el cluster Kind..."
kind load docker-image ${IMAGE_NAME} --name=${CLUSTER_NAME}

echo "🔄 Reiniciando el despliegue para usar la nueva imagen..."
kubectl rollout restart deployment heroes-api

echo "⏳ Esperando a que el despliegue esté listo..."
kubectl rollout status deployment heroes-api

echo "✅ ¡Listo! La imagen ha sido actualizada en el cluster."
echo "⚡ Puedes acceder a la API en: http://heroes-api.local"