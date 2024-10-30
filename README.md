# Odoo 15 Development Environment

Este repositorio contiene la configuración necesaria para ejecutar Odoo 15 en GitHub Codespaces, proporcionando un entorno de desarrollo completo y listo para usar.

## 🚀 Características

- Odoo 15 Community Edition
- PostgreSQL preconfigurado
- Entorno de desarrollo completo con todas las dependencias
- Configuración optimizada para GitHub Codespaces
- Soporte para hot-reload durante el desarrollo

## 📋 Requisitos Previos

- Una cuenta de GitHub
- Acceso a GitHub Codespaces
- Un navegador web moderno

## 🛠️ Configuración del Entorno

### Usando GitHub Codespaces

1. Haz clic en el botón "Code" en la página principal del repositorio
2. Selecciona la pestaña "Codespaces"
3. Haz clic en "Create codespace on main"
4. Espera a que el contenedor se construya (aproximadamente 10-15 minutos la primera vez)

### Localmente (usando VS Code)

1. Clona el repositorio:
```bash
git clone https://github.com/DRCWeb/odoo-codespace.git
cd odoo-codespace
```

2. Instala la extensión "Remote - Containers" en VS Code
3. Presiona F1 y selecciona "Remote-Containers: Open Folder in Container"

## 🏃‍♂️ Inicio Rápido

Una vez que el contenedor esté en funcionamiento:

1. El servidor Odoo se iniciará automáticamente en el puerto 8069
2. Accede a Odoo a través de la URL proporcionada por GitHub Codespaces
3. En el primer acceso:
   - Base de datos: `postgres`
   - Email: `admin`
   - Contraseña: Define tu contraseña en el primer inicio

## 📁 Estructura del Proyecto

```
.
├── .devcontainer/
│   ├── devcontainer.json    # Configuración del contenedor de desarrollo
│   ├── Dockerfile          # Definición del contenedor Docker
│   └── start-odoo.sh      # Script de inicio de Odoo
├── custom_addons/         # Directorio para módulos personalizados
└── README.md             # Este archivo
```

## 🛠️ Desarrollo de Módulos Personalizados

1. Crea tus módulos personalizados en el directorio `custom_addons/`
2. El directorio está configurado como una ruta de addons adicional
3. Los nuevos módulos serán detectados automáticamente
4. Usa el modo desarrollador de Odoo para instalar/actualizar módulos

## 🔧 Configuración

### Recursos del Contenedor

Por defecto, el contenedor está configurado para usar:
- 4 cores CPU
- 8GB RAM
- 32GB de almacenamiento

Para modificar estos recursos:
1. Detén el codespace
2. Ajusta la configuración en la interfaz de GitHub
3. Reinicia el codespace

### Puertos

- Odoo: 8069
- PostgreSQL: 5432

## 🤝 Contribuir

1. Haz un Fork del repositorio
2. Crea una rama para tu característica (`git checkout -b feature/AmazingFeature`)
3. Haz commit de tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Notas Importantes

- El entorno está configurado para desarrollo, no para producción
- Los cambios en el código se reflejan automáticamente (hot-reload)
- La base de datos se persiste mientras el codespace esté activo
- Se recomienda hacer respaldos regulares de la base de datos

## ⚠️ Instalacion y Uso

### Proceso de Instalacion

1. **Construir el Contenedor:**
   ```bash
   docker build --build-arg ODOO_ENTERPRISE_TOKEN=$ODOO_ENTERPRISE_TOKEN -t odoo:15.0 .   
   ```

2. **Cargar el DockerCompose**
   ```bash
   docker compose -f "docker-compose.yml" up -d --build
   ```

3. **Modificar Fecha de Expiracion de la DB**
   ```bash
   INSERT INTO ir_config_parameter (key, value) 
   VALUES ('database.expiration_date', '2099-12-31 00:00:00');
   ```
## 📚 Recursos Adicionales

- [Documentación oficial de Odoo](https://www.odoo.com/documentation/15.0/)
- [GitHub Codespaces](https://docs.github.com/en/codespaces)
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/remote-overview)

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para más detalles.

## 🤝 Soporte

Si encuentras un bug o tienes una sugerencia, por favor abre un issue en este repositorio.
