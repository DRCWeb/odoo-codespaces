FROM ubuntu:20.04

# Evitar interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Crear usuario vscode primero
RUN useradd -ms /bin/bash vscode \
    && groupadd -g 1000 postgres \
    && useradd -u 1000 -g postgres postgres

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

# Configurar PostgreSQL
RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql \
    && mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql/data

# Configurar el directorio de trabajo
WORKDIR /workspace
RUN chown -R vscode:vscode /workspace

# Cambiar al usuario vscode para las operaciones restantes
USER vscode

# Configurar entorno virtual Python
RUN python3 -m venv /workspace/venv
ENV PATH="/workspace/venv/bin:$PATH"

# Instalar Odoo
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 15.0 /workspace/odoo \
    && pip3 install -r /workspace/odoo/requirements.txt

# Inicializar la base de datos de PostgreSQL (como usuario postgres)
USER postgres
RUN initdb -D /var/lib/postgresql/data
RUN echo "host all all all trust" >> /var/lib/postgresql/data/pg_hba.conf \
    && echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf

# Volver al usuario vscode
USER vscode

# Copiar script de inicio
COPY --chown=vscode:vscode start-odoo.sh /workspace/
RUN chmod +x /workspace/start-odoo.sh

CMD ["/workspace/start-odoo.sh"]
