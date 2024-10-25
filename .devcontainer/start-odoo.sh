#!/bin/bash

# Iniciar PostgreSQL
pg_ctl -D /var/lib/postgresql/15/main start || true

# Esperar a que PostgreSQL esté listo
until pg_isready; do
    echo "Esperando a que PostgreSQL esté listo..."
    sleep 2
done

# Construir ruta de addons
ADDONS_PATH="/workspace/odoo/addons"
if [ -d "/workspace/enterprise" ]; then
    ADDONS_PATH="/workspace/enterprise,${ADDONS_PATH}"
    echo "Odoo Enterprise detectado, agregado al addons_path"
fi

# Iniciar Odoo
python3 /workspace/odoo/odoo-bin \
    --addons-path=/workspace/odoo/addons \
    --db_host=localhost \
    --db_user=odoo \
    --db_password=odoo \
    --database=odoo \
    -i base \
    --dev=all
