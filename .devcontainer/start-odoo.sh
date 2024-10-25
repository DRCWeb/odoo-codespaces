#!/bin/bash

# Iniciar PostgreSQL como usuario postgres
su postgres -c "pg_ctl -D /var/lib/postgresql/data start"

# Esperar a que PostgreSQL esté listo
until pg_isready; do
    echo "Esperando a que PostgreSQL esté listo..."
    sleep 2
done

# Crear usuario y base de datos si no existen
su postgres -c "psql -c \"CREATE USER odoo WITH PASSWORD 'odoo'\" || true"
su postgres -c "psql -c \"CREATE DATABASE odoo OWNER odoo\" || true"

# Iniciar Odoo
python3 /workspace/odoo/odoo-bin \
    --addons-path=/workspace/odoo/addons \
    --db_host=localhost \
    --db_user=odoo \
    --db_password=odoo \
    --dev=all
