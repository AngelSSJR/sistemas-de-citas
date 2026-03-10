# EPS Citas Pro (Flask + MySQL)

Aplicacion web profesional para gestionar citas medicas en una EPS.

## Funcionalidades

- Registro de pacientes con validaciones.
- Reserva de citas medicas con control de horario por medico.
- Consulta de historial de citas por documento.
- Actualizacion y cancelacion de citas.
- Tablero inicial con metricas y proximas citas.
- Mensajes de estado y manejo de errores 404/500.

## Estructura del proyecto

- `app.py`: rutas, reglas de negocio y validaciones.
- `config.py`: configuracion por variables de entorno.
- `database.py`: utilidades de acceso a MySQL.
- `database.sql`: esquema relacional con restricciones e inserts base.
- `templates/`: vistas Jinja2.
- `static/`: estilos y comportamiento de cliente.

## Requisitos

- Python 3.11+
- MySQL 8+

## Instalacion

1. Crear y activar entorno virtual.

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

2. Instalar dependencias.

```powershell
pip install -r requirements.txt
```

3. Crear archivo `.env` con base en `.env.example`.

```powershell
Copy-Item .env.example .env
```

4. Crear base de datos y tablas.

```powershell
mysql -u root -p < database.sql
```

5. Ejecutar la aplicacion.

```powershell
flask --app app run --debug
```

## Rutas principales

- `/` tablero principal.
- `/registrar` registrar paciente.
- `/reservar` reservar cita.
- `/consultar` consultar historial por documento.
- `/actualizar?cita_id=<id>` actualizar una cita.

## Recomendaciones de despliegue

- Configurar `SECRET_KEY` segura en produccion.
- Ejecutar Flask detras de un servidor WSGI (por ejemplo Gunicorn + Nginx en Linux).
- Usar un usuario MySQL dedicado con permisos limitados para la base de datos.
