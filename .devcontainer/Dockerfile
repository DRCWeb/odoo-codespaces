FROM odoo:15.0
USER root

# Instalar wget primero
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    postgresql-client-13 \
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
    python3-pandas \
    && rm -rf /var/lib/apt/lists/*

# Configurar Git para clonar Enterprise
ARG ODOO_ENTERPRISE_TOKEN
RUN git config --global user.name "Dayron Romero" && \
    git config --global user.email "dr@dfvz.org" && \
    git config --global credential.helper store

# Clonar Odoo y Enterprise
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /var/lib/odoo/odoo && \
    if [ ! -z "$ODOO_ENTERPRISE_TOKEN" ]; then \
    git clone https://oauth2:${ODOO_ENTERPRISE_TOKEN}@github.com/odoo/enterprise.git --depth 1 --branch 15.0 /var/lib/odoo/enterprise; \
    fi

# Actualizar pip e instalar herramientas básicas
RUN python3 -m pip install --upgrade pip setuptools wheel

# Pre-instalar dependencias problemáticas
RUN pip3 install --no-cache-dir \
    greenlet==0.4.17 \
    gevent==20.9.0

# Copiar e instalar requirements
COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -r /requirements.txt && \
    rm /requirements.txt

# Crear directorios necesarios y establecer permisos
RUN mkdir -p /mnt/extra-addons \
    && mkdir -p /mnt/repository \
    && mkdir -p /var/lib/odoo \
    && chown -R odoo:odoo /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/repository \
    && chown -R odoo:odoo /var/lib/odoo

# Configurar Python
ENV PYTHONPATH=/var/lib/odoo
ENV PATH="/var/lib/odoo/odoo/bin:${PATH}"

USER odoo

# Exponer puertos
EXPOSE 8069 8071 8072

# Directorio de trabajo
WORKDIR /var/lib/odoo