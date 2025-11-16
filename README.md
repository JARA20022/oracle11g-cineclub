Mini-Proyecto Oracle 11g: Cineclub

Proyecto académico con instalación, configuración y conexión a Oracle Database 11g XE, incluyendo:

Diseño de esquema relacional

Creación de tablas y datos de ejemplo

Conexión desde Python usando oracledb (modo Thick)

Ejecución de consulta simple y documentación con capturas

Estructura del proyecto
cineclub_oracle11g/
│
├── docs/
│   ├── ERD.md                                # Diagrama entidad-relación
│   └── Entrega_Oracle11g_RodrigoJara.docx    # Documento Word (Entrega 1)
│
├── sql/
│   ├── 01_schema.sql                         # Creación de tablas, secuencias y triggers
│   ├── 02_sample_data.sql                    # Inserción de datos iniciales
│   └── 03_entrega2.sql                       # CRUD, consultas avanzadas, índices y transacciones
│
├── src/
│   └── connect_and_query.py                  # Script Python de conexión y consulta
│
├── docs/Entrega2_Capturas.docx               # Evidencias de entrega 2
│
├── requirements.txt                          # Dependencias Python
├── README.md                                 # Este archivo
└── .gitignore

Ejecución rápida

Instalar Oracle Database 11g XE
Crear usuario y contraseña (system / asd123)
Probar conexión con SQLPlus:

sqlplus system/asd123@localhost/XE


Clonar este repositorio.

(Opcional) Crear entorno virtual:

py -3.12 -m venv .venv
.\.venv\Scripts\activate


Instalar dependencias:

pip install oracledb


Instalar Oracle Instant Client 11g y ubicarlo en:

C:\Program Files\Oracle\instantclient_11_2


Ejecutar scripts SQL básicos:

@sql/01_schema.sql
@sql/02_sample_data.sql


Ejecutar script Python:

python src\connect_and_query.py

Errores comunes y soluciones
Problema	Causa	Solución aplicada
No matching distribution found for python-oracledb	Python 3.13 incompatible	Se usó Python 3.12
ModuleNotFoundError: oracledb	Python global ejecutado	Activación del entorno virtual
DPI-1047	No detecta Instant Client	Instalar y configurar ruta
Caracteres raros	Diferencia de codificación	Ajuste de impresión
Documentación incluida (Entrega 1)

Esquema E/R

Instalación y configuración de Oracle 11g XE

Scripts base

Conexión desde Python

Capturas de SQLPlus

Documento:

docs/Entrega_Oracle11g_RodrigoJara.docx

ENTREGA 2 – Extensión del Proyecto

La entrega 2 amplía el proyecto con nuevas funcionalidades SQL:
CRUD, consultas avanzadas, índices y transacciones.

Nuevos archivos incluidos
sql/03_entrega2.sql
docs/Entrega2_Capturas.docx

Contenido del script 03_entrega2.sql
1. Operaciones CRUD

Inserción de clientes y películas.

Actualización de correos y precios.

Eliminación de boletos y clientes sin compras.

2. Consultas SQL avanzadas

Incluyen:

JOIN entre múltiples tablas

COUNT, SUM

GROUP BY y HAVING

Subconsultas

3. Índices
CREATE INDEX ix_cliente_email ON cliente(email);


Resultado:
Oracle devuelve ORA-01408 porque la columna ya tiene un índice por la restricción UNIQUE.

4. Transacciones

Uso de:

SAVEPOINT

ROLLBACK TO SAVEPOINT

COMMIT

Demostrando control de integridad.

Ejecución de la Entrega 2
@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql

Evidencias

Las capturas de ejecución en SQLPlus están documentadas en:

docs/Entrega2_Capturas.docx
