FROM ubuntu:20.04

# Evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    python3-venv \
    python3-wheel \
    build-essential \
    wget \
    nodejs \
    npm \
    postgresql \
    postgresql-client \
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

# Crear usuario vscode
RUN useradd -ms /bin/bash vscode
USER vscode
WORKDIR /workspace

# Configurar entorno virtual Python
RUN python3 -m venv /workspace/venv
ENV PATH="/workspace/venv/bin:$PATH"

# Instalar Odoo
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /workspace/odoo \
    && pip3 install -r /workspace/odoo/requirements.txt

# Configurar PostgreSQL
USER root
RUN service postgresql start \
    && su - postgres -c "createuser -s vscode" \
    && su - postgres -c "createdb vscode"

# Volver al usuario vscode
USER vscode

# Script de inicio
COPY --chown=vscode:vscode ./start-odoo.sh /workspace/
RUN chmod +x /workspace/start-odoo.sh

CMD ["/workspace/start-odoo.sh"]
