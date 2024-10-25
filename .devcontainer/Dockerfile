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

# Configurar Git para clonar Enterprise
ARG GITHUB_TOKEN
RUN if [ ! -z "$GITHUB_TOKEN" ]; then \
    git config --global credential.helper store && \
    echo "https://oauth2:${GITHUB_TOKEN}@github.com" > ~/.git-credentials; \
    fi

# Clonar Odoo y Enterprise
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /workspace/odoo && \
    if [ ! -z "$GITHUB_TOKEN" ]; then \
    git clone https://github.com/odoo/enterprise.git --depth 1 --branch 15.0 /workspace/enterprise; \
    fi

# Instalar dependencias de Python
RUN pip3 install -r /workspace/odoo/requirements.txt

# Copiar script de inicio
COPY start-odoo.sh /workspace/
RUN chmod +x /workspace/start-odoo.sh

# Exponer puertos
EXPOSE 8069 5432

# Comando por defecto
CMD ["/workspace/start-odoo.sh"]
