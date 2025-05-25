#!/bin/bash
# Script de utilidades para trabajar con AKS

set -e

# Colores para salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Mostrar menú
show_menu() {
    echo -e "${BLUE}=== 🔧 Utilidades para AKS - Tour of Heroes ===${NC}"
    echo -e "${YELLOW}1.${NC} Ver todos los recursos"
    echo -e "${YELLOW}2.${NC} Ver logs de la aplicación"
    echo -e "${YELLOW}3.${NC} Escalar el número de replicas"
    echo -e "${YELLOW}4.${NC} Ejecutar shell en un pod de la aplicación"
    echo -e "${YELLOW}5.${NC} Reiniciar despliegue (rollout restart)"
    echo -e "${YELLOW}6.${NC} Ver información del clúster"
    echo -e "${YELLOW}7.${NC} Eliminar todos los recursos de la aplicación"
    echo -e "${YELLOW}0.${NC} Salir"
    echo ""
    echo -n "Selecciona una opción: "
}

# Verificar conexión con AKS
check_connection() {
    if ! kubectl cluster-info &> /dev/null; then
        echo -e "${RED}❌ No se puede conectar al clúster AKS. Asegúrate de ejecutar:${NC}"
        echo "az aks get-credentials --resource-group <nombre-grupo-recursos> --name <nombre-cluster>"
        exit 1
    fi
}

# Principal
main() {
    check_connection
    
    while true; do
        show_menu
        read option
        
        case $option in
            1)
                echo -e "${BLUE}📊 Mostrando todos los recursos en el namespace 'heroes':${NC}"
                kubectl get all -n heroes
                echo ""
                read -p "Presiona Enter para continuar..."
                ;;
            2)
                echo -e "${BLUE}📋 Mostrando logs de la aplicación:${NC}"
                kubectl logs -l app=heroes-api -n heroes --tail=100
                echo ""
                read -p "Presiona Enter para continuar..."
                ;;
            3)
                echo -n "Ingresa el número de réplicas deseadas: "
                read replicas
                echo -e "${YELLOW}⚙️ Escalando a $replicas réplicas...${NC}"
                kubectl scale deployment heroes-api -n heroes --replicas=$replicas
                echo -e "${GREEN}✅ Aplicación escalada a $replicas réplicas${NC}"
                echo ""
                read -p "Presiona Enter para continuar..."
                ;;
            4)
                echo -e "${YELLOW}🔄 Ejecutando shell en un pod de la aplicación...${NC}"
                POD=$(kubectl get pod -l app=heroes-api -n heroes -o jsonpath="{.items[0].metadata.name}")
                kubectl exec -it $POD -n heroes -- /bin/sh
                ;;
            5)
                echo -e "${YELLOW}🔄 Reiniciando despliegue...${NC}"
                kubectl rollout restart deployment heroes-api -n heroes
                echo -e "${GREEN}✅ Reinicio iniciado${NC}"
                echo ""
                read -p "Presiona Enter para continuar..."
                ;;
            6)
                echo -e "${BLUE}ℹ️ Información del clúster:${NC}"
                kubectl cluster-info
                echo ""
                echo -e "${BLUE}🔍 Nodos del clúster:${NC}"
                kubectl get nodes -o wide
                echo ""
                read -p "Presiona Enter para continuar..."
                ;;
            7)
                echo -e "${RED}⚠️ ¿Estás seguro de que quieres eliminar todos los recursos? (s/n):${NC} "
                read confirm
                if [[ $confirm == "s" || $confirm == "S" ]]; then
                    echo -e "${YELLOW}🗑️ Eliminando recursos...${NC}"
                    kubectl delete namespace heroes
                    echo -e "${GREEN}✅ Recursos eliminados${NC}"
                else
                    echo -e "${BLUE}Operación cancelada${NC}"
                fi
                echo ""
                read -p "Presiona Enter para continuar..."
                ;;
            0)
                echo -e "${GREEN}👋 ¡Hasta luego!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opción inválida${NC}"
                sleep 1
                ;;
        esac
    done
}

# Ejecutar función principal
main