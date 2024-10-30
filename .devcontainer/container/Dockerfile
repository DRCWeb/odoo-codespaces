FROM odoo:15.0

USER root

COPY ./requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN apt-get update && apt-get install -y git

# Define el argumento para recibir el token
ARG ODOO_ENTERPRISE_TOKEN
RUN git clone --depth 1 --branch 14.0 https://github.com/odoo/odoo.git /var/lib/odoo/odoo
RUN git clone --depth 1 --branch 14.0 https://${ODOO_ENTERPRISE_TOKEN}@github.com/odoo/enterprise.git /var/lib/odoo/enterprise

USER odoo
