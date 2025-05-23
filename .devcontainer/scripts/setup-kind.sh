#!/bin/bash
# Script para inicializar y configurar un cluster Kind para desarrollo

set -e

CLUSTER_NAME="heroes-cluster"

# Verificar si el cluster ya existe
if kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
    echo "✅ El cluster '${CLUSTER_NAME}' ya existe."
else
    echo "🚀 Creando cluster Kind '${CLUSTER_NAME}'..."
    
    # Configuración del cluster con port mappings
    cat <<EOF | kind create cluster --name=${CLUSTER_NAME} --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
    
    echo "✅ Cluster '${CLUSTER_NAME}' creado exitosamente."
fi

# Verificar conexión al cluster
kubectl cluster-info --context kind-${CLUSTER_NAME}

# Instalar Ingress NGINX Controller
echo "📦 Instalando NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Esperar a que el Ingress Controller esté listo
echo "⏳ Esperando a que el Ingress Controller esté listo..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

echo "🔄 Configurando /etc/hosts para heroes-api.local..."
if ! grep -q "heroes-api.local" /etc/hosts; then
    echo "127.0.0.1 heroes-api.local" | sudo tee -a /etc/hosts
fi

echo "📄 Aplicando manifiestos de Kubernetes..."
kubectl apply -f /workspaces/$(basename $PWD)/k8s/

echo "🎉 ¡Listo! El cluster está configurado y los manifiestos aplicados."
echo "⚡ Puedes acceder a la API en: http://heroes-api.local"