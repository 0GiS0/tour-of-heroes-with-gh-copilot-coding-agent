#!/bin/bash
# Script para inicializar y configurar un cluster Kind para desarrollo

set -e

CLUSTER_NAME="heroes-cluster"

# Verificar si el cluster ya existe y eliminarlo si es necesario
if kind get clusters | grep -q "^${CLUSTER_NAME}$"; then
    echo "🗑️  El cluster '${CLUSTER_NAME}' ya existe. Eliminándolo..."
    kind delete cluster --name=${CLUSTER_NAME}
    echo "✅ Cluster '${CLUSTER_NAME}' eliminado exitosamente."
fi

echo "🚀 Creando cluster Kind '${CLUSTER_NAME}'..."

# Configuración del cluster simplificada
cat <<EOF | kind create cluster --name=${CLUSTER_NAME} --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
EOF

echo "✅ Cluster '${CLUSTER_NAME}' creado exitosamente."

# Verificar conexión al cluster
kubectl cluster-info --context kind-${CLUSTER_NAME}

# Esperar a que el nodo esté completamente listo
echo "⏳ Esperando a que el nodo del cluster esté listo..."
max_node_wait=240  # Aumentado a 4 minutos
node_wait_time=0

while [ $node_wait_time -lt $max_node_wait ]; do
    node_status=$(kubectl get nodes --no-headers -o custom-columns=STATUS:.status.conditions[-1].type 2>/dev/null || echo "NotReady")
    if [ "$node_status" = "Ready" ]; then
        echo "✅ Nodo está listo"
        
        # Verificar específicamente que no hay taints problemáticos
        echo "🔍 Verificando que los taints del nodo estén eliminados..."
        taint_check=$(kubectl get nodes -o jsonpath='{.items[0].spec.taints[?(@.key=="node.kubernetes.io/not-ready")].key}' 2>/dev/null || echo "")
        if [ -z "$taint_check" ]; then
            echo "✅ Taints problemáticos eliminados, nodo completamente listo"
            break
        else
            echo "⏳ Nodo Ready pero aún tiene taint 'not-ready', esperando..."
        fi
    fi
    echo "Esperando que el nodo esté listo... ($node_wait_time/$max_node_wait segundos) - Estado actual: $node_status"
    sleep 10
    node_wait_time=$((node_wait_time + 10))
done

if [ $node_wait_time -ge $max_node_wait ]; then
    echo "⚠️  Warning: El nodo no está completamente listo después de $max_node_wait segundos"
    echo "Estado actual del nodo:"
    kubectl describe nodes | head -20
    echo "Continuando de todos modos..."
fi

# Espera adicional para asegurar estabilidad del cluster
echo "⏳ Esperando unos segundos adicionales para asegurar estabilidad..."
sleep 15

echo "📄 Aplicando manifiestos de Kubernetes..."
# Aplicar todos los manifiestos de k8s/
kubectl apply -f /workspaces/$(basename $PWD)/k8s/

echo "🎉 ¡Listo! El cluster está configurado y los manifiestos aplicados."
echo "⚡ Para acceder a la API, usa port-forward:"
echo "   kubectl port-forward service/heroes-api-service 3000:3000"
echo "   Luego accede a: http://localhost:3000"

