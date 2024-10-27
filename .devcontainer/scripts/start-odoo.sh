#!/bin/bash

echo "Configurando PostgreSQL..."

# Detener PostgreSQL y recrear el cluster
sudo service postgresql stop
sudo pg_dropcluster --stop 15 main
sudo pg_createcluster --locale=C.UTF-8 --start 15 main

# Configurar autenticación
sudo sed -i 's/peer/trust/g' /etc/postgresql/15/main/pg_hba.conf
sudo sed -i 's/scram-sha-256/trust/g' /etc/postgresql/15/main/pg_hba.conf

# Reiniciar PostgreSQL
sudo service postgresql restart

# Esperar a que PostgreSQL esté listo
until pg_isready; do
    echo "Esperando a que PostgreSQL esté listo..."
    sleep 2
done

echo "PostgreSQL está listo"

# Crear usuarios y base de datos
echo "Configurando usuarios y base de datos..."
psql -U postgres << EOF
DROP DATABASE IF EXISTS odoo;
DROP USER IF EXISTS odoo;
CREATE USER odoo WITH PASSWORD 'odoo' SUPERUSER;
CREATE DATABASE odoo OWNER odoo;
EOF

# Asegurarse que el directorio de logs existe y tiene permisos correctos
echo "Configurando directorios y permisos..."
sudo mkdir -p /var/log/odoo
sudo chown -R $(whoami):$(whoami) /var/log/odoo
sudo chmod -R 755 /var/log/odoo

# Limpiar logs anteriores
sudo rm -f /var/log/odoo/odoo-server.log
sudo touch /var/log/odoo/odoo-server.log
sudo chown $(whoami):$(whoami) /var/log/odoo/odoo-server.log

# Verificar permisos de addons
sudo chown -R $(whoami):$(whoami) /workspace/odoo
sudo chown -R $(whoami):$(whoami) /workspace/enterprise

# Inicializar la base de datos con el módulo base
echo "Inicializando base de datos con módulo base..."
python3 /workspace/odoo/odoo-bin \
    -c /etc/odoo/odoo.conf \
    --db_host=localhost \
    --db_port=5432 \
    --db_user=odoo \
    --db_password=odoo \
    --database=odoo \
    --without-demo=all \
    -i base \
    --stop-after-init

# Mostrar mensaje de inicio
echo "Iniciando Odoo en modo debug..."

# Iniciar Odoo con la configuración establecida
exec python3 /workspace/odoo/odoo-bin \
    -c /etc/odoo/odoo.conf \
    --db_host=localhost \
    --db_port=5432 \
    --db_user=odoo \
    --db_password=odoo \
    --database=odoo \
    --without-demo=all \
    --log-level=debug \
    --dev=all