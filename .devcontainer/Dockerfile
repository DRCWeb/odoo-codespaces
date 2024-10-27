FROM odoo:15.0
USER root

# Habilitar modo debug en shell
SHELL ["/bin/bash", "-xeo", "pipefail", "-c"]

# Agregar repositorio de PostgreSQL y su clave
RUN set -x && \
    apt-get update && apt-get install -y wget gnupg2 \
    && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && apt-get update

# Remover paquetes conflictivos
RUN set -x && \
    apt-get remove -y postgresql postgresql-client libpq5 libpq-dev

# Instalar dependencias
RUN set -x && \
    apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    postgresql-client-13 \
    postgresql-13 \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    libpython3-dev \
    python3-setuptools \
    python3-wheel \
    python3-venv \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario y grupo odoo
RUN set -x && \
    groupadd -r odoo && \
    useradd -r -g odoo -d /opt/odoo -s /bin/bash odoo && \
    id odoo

# Configurar directorios y permisos iniciales con verbose
RUN set -x && \
    mkdir -pv /opt/odoo && \
    mkdir -pv /mnt/extra-addons && \
    mkdir -pv /mnt/repository && \
    mkdir -pv /var/lib/odoo && \
    ls -la /opt/odoo && \
    ls -la /mnt/extra-addons && \
    ls -la /mnt/repository && \
    ls -la /var/lib/odoo && \
    chown -Rv odoo:odoo /opt/odoo && \
    chown -Rv odoo:odoo /mnt/extra-addons && \
    chown -Rv odoo:odoo /mnt/repository && \
    chown -Rv odoo:odoo /var/lib/odoo && \
    chmod -Rv 755 /opt/odoo && \
    chmod -Rv 755 /mnt/extra-addons && \
    chmod -Rv 755 /mnt/repository && \
    chmod -Rv 755 /var/lib/odoo

# Configurar Git para clonar Enterprise
ARG ODOO_ENTERPRISE_TOKEN
RUN set -x && \
    git config --global user.name "Your Name" && \
    git config --global user.email "you@example.com" && \
    git config --global credential.helper store

# Clonar Odoo y Enterprise con verbose
RUN set -x && \
    git clone -v https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /var/lib/odoo/odoo && \
    if [ ! -z "$ODOO_ENTERPRISE_TOKEN" ]; then \
        git clone -v https://oauth2:${ODOO_ENTERPRISE_TOKEN}@github.com/odoo/enterprise.git --depth 1 --branch 15.0 /var/lib/odoo/enterprise; \
    fi && \
    ls -la /var/lib/odoo/odoo && \
    chown -Rv odoo:odoo /var/lib/odoo/odoo && \
    if [ -d "/var/lib/odoo/enterprise" ]; then \
        ls -la /var/lib/odoo/enterprise && \
        chown -Rv odoo:odoo /var/lib/odoo/enterprise; \
    fi

# Actualizar pip e instalar herramientas básicas
RUN set -x && \
    python3 -m pip install -v --upgrade pip setuptools wheel

# Pre-instalar dependencias problemáticas con verbose
RUN set -x && \
    pip3 install -v --no-cache-dir \
    greenlet==0.4.17 \
    gevent==20.9.0 \
    pandas==1.1.5

# Copiar e instalar requirements con verbose
COPY requirements.txt /requirements.txt
RUN set -x && \
    pip3 install -v --no-cache-dir -r /requirements.txt && \
    rm /requirements.txt

# Asegurar permisos finales con verbose y verificación
RUN set -x && \
    chown -Rv odoo:odoo /opt/odoo && \
    chown -Rv odoo:odoo /mnt/extra-addons && \
    chown -Rv odoo:odoo /mnt/repository && \
    chown -Rv odoo:odoo /var/lib/odoo && \
    ls -la /opt/odoo && \
    ls -la /mnt/extra-addons && \
    ls -la /mnt/repository && \
    ls -la /var/lib/odoo && \
    id odoo && \
    getfacl /var/lib/odoo

# Configurar Python
ENV PYTHONPATH=/var/lib/odoo
ENV PATH="/var/lib/odoo/odoo/bin:${PATH}"

# Debug final antes de cambiar usuario
RUN set -x && \
    ls -la /var/lib/odoo && \
    id odoo && \
    ps aux && \
    df -h && \
    uname -a

# Cambiar al usuario odoo
USER odoo

# Debug después de cambiar usuario
RUN set -x && \
    id && \
    ls -la /var/lib/odoo

# Exponer puertos
EXPOSE 8069 8071 8072

# Directorio de trabajo
WORKDIR /var/lib/odoo
