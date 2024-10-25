#!/bin/bash

# Iniciar PostgreSQL
sudo service postgresql start

# Esperar a que PostgreSQL esté listo
until pg_isready; do
    echo "Esperando a que PostgreSQL esté listo..."
    sleep 2
done

# Iniciar Odoo
python3 /workspace/odoo/odoo-bin \
    --addons-path=/workspace/odoo/addons \
    --db_host=localhost \
    --db_user=vscode \
    --db_password=vscode \
    --dev=all
