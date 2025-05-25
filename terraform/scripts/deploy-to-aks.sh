#!/bin/bash
# Script para desplegar la aplicación Tour of Heroes en AKS

set -e

# Colores para salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== 🚀 Desplegando Tour of Heroes en AKS ===${NC}"

# Verificar si kubectl está configurado para AKS
echo -e "${YELLOW}Verificando conexión con AKS...${NC}"
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}❌ No se puede conectar al clúster AKS. Asegúrate de ejecutar:${NC}"
    echo "az aks get-credentials --resource-group <nombre-grupo-recursos> --name <nombre-cluster>"
    exit 1
fi

echo -e "${GREEN}✅ Conexión exitosa con AKS${NC}"

# Crear namespace si no existe
echo -e "${YELLOW}Creando namespace heroes...${NC}"
kubectl create namespace heroes --dry-run=client -o yaml | kubectl apply -f -

# Aplicar todos los manifiestos desde el directorio k8s
echo -e "${YELLOW}Aplicando manifiestos de Kubernetes...${NC}"
kubectl apply -f ../k8s/ -n heroes

# Esperar a que todos los pods estén listos
echo -e "${YELLOW}Esperando a que todos los pods estén listos...${NC}"
kubectl wait --for=condition=Ready pods --all -n heroes --timeout=300s

# Obtener la IP del servicio
echo -e "${YELLOW}Obteniendo información del servicio...${NC}"
EXTERNAL_IP=""
while [ -z $EXTERNAL_IP ]; do
  echo "Esperando IP externa..."
  EXTERNAL_IP=$(kubectl get service heroes-api-service -n heroes -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || echo "")
  [ -z "$EXTERNAL_IP" ] && sleep 10
done

echo -e "${GREEN}=== ✅ Despliegue completado ===${NC}"
echo -e "${GREEN}🌐 La aplicación está disponible en: http://$EXTERNAL_IP:3000${NC}"
echo -e "${BLUE}📊 Para ver los recursos desplegados: kubectl get all -n heroes${NC}"
echo -e "${BLUE}📋 Para ver los logs: kubectl logs -l app=heroes-api -n heroes${NC}"