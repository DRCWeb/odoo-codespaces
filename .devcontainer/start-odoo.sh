#!/bin/bash

# Iniciar PostgreSQL
sudo service postgresql start

# Esperar a que PostgreSQL esté listo
until pg_isready; do
    echo "Esperando a que PostgreSQL esté listo..."
    sleep 2
done

# Crear usuario y base de datos si no existen
sudo -u postgres psql -c "CREATE USER odoo WITH PASSWORD 'odoo'" || true
sudo -u postgres psql -c "CREATE DATABASE odoo OWNER odoo" || true

# Iniciar Odoo
python3 /workspace/odoo/odoo-bin \
    --addons-path=/workspace/odoo/addons \
    --db_host=localhost \
    --db_user=odoo \
    --db_password=odoo \
    --database=odoo \
    -i base \
    --dev=all
