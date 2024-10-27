FROM odoo:15.0
USER root

# Instalar dependencias adicionales
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Configurar Git para clonar Enterprise
ARG ODOO_ENTERPRISE_TOKEN
RUN git config --global user.name "Your Name" && \
    git config --global user.email "you@example.com" && \
    git config --global credential.helper store

# Clonar Odoo y Enterprise
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /var/lib/odoo/odoo && \
    if [ ! -z "$ODOO_ENTERPRISE_TOKEN" ]; then \
    git clone https://oauth2:${ODOO_ENTERPRISE_TOKEN}@github.com/odoo/enterprise.git --depth 1 --branch 15.0 /var/lib/odoo/enterprise; \
    fi

# Copiar requirements e instalarlos
COPY ./requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt
RUN rm /requirements.txt

# Crear directorios necesarios y establecer permisos
RUN mkdir -p /mnt/extra-addons \
    && mkdir -p /mnt/repository \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/repository \
    && chown -R odoo:odoo /var/lib/odoo/odoo \
    && chown -R odoo:odoo /var/lib/odoo/enterprise

USER odoo