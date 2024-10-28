#!/bin/bash

# Variables
ODOO_IMAGE_TAG="odoo:15.0"
DOCKERFILE="Dockerfile"

# Verificar si el token de empresa de Odoo está definido
if [ -z "$ODOO_ENTERPRISE_TOKEN" ]; then
  echo "Error: La variable de entorno ODOO_ENTERPRISE_TOKEN no está definida."
  echo "Por favor, define ODOO_ENTERPRISE_TOKEN y vuelve a ejecutar el script."
  exit 1
fi

# Construir la imagen de Docker con el token de empresa
echo "Construyendo la imagen de Odoo con el token de empresa..."
docker build --build-arg ODOO_ENTERPRISE_TOKEN=$ODOO_ENTERPRISE_TOKEN -t $ODOO_IMAGE_TAG .

# Construir la imagen de Docker sin cache y usando el Dockerfile
echo "Construyendo la imagen de Odoo con Dockerfile..."
docker build --pull --rm -f "$DOCKERFILE" -t $ODOO_IMAGE_TAG .

echo "Construcción de imágenes completada exitosamente."
