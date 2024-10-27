#!/bin/bash

# Iniciar PostgreSQL
pg_ctl -D /var/lib/postgresql/15/main start || true

# Esperar a que PostgreSQL esté listo
until pg_isready; do
    echo "Esperando a que PostgreSQL esté listo..."
    sleep 2
done

# Crear usuario de PostgreSQL si no existe
su - postgres -c "createuser -s odoo" 2>/dev/null || true

# Iniciar Odoo con archivo de configuración
python3 /workspace/odoo/odoo-bin -c /etc/odoo/odoo.conf
