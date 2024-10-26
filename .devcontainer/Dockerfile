FROM mcr.microsoft.com/devcontainers/python:3.8

# Evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    postgresql \
    postgresql-client \
    nodejs \
    npm \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    && rm -rf /var/lib/apt/lists/*

# Crear directorios necesarios
WORKDIR /workspace
RUN mkdir -p /var/log/odoo && \
    chown -R 1000:1000 /var/log/odoo && \
    mkdir -p /etc/odoo

# Clonar Odoo Community y Enterprise
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /workspace/odoo && \
    git clone https://github.com/odoo/enterprise.git --depth 1 --branch 15.0 /workspace/enterprise

# Instalar dependencias de Python
RUN pip3 install -r /workspace/odoo/requirements.txt

# Copiar archivos de configuración
COPY config/odoo.conf /etc/odoo/
COPY scripts/start-odoo.sh /workspace/
RUN chmod +x /workspace/start-odoo.sh

# Exponer puertos
EXPOSE 8069 5432

# Comando por defecto
CMD ["/workspace/start-odoo.sh"]