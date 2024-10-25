FROM mcr.microsoft.com/devcontainers/python:3.8

# Evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Instalar PostgreSQL y otras dependencias
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
RUN mkdir -p /workspace/odoo

# Clonar Odoo e instalar dependencias
WORKDIR /workspace
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /workspace/odoo \
    && pip3 install -r /workspace/odoo/requirements.txt

# Copiar script de inicio
COPY start-odoo.sh /workspace/
RUN chmod +x /workspace/start-odoo.sh

# Exponer puertos
EXPOSE 8069 5432

# Comando por defecto
CMD ["/workspace/start-odoo.sh"]
