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
│   ├── ERD.md                               # Diagrama entidad-relación y explicación del modelo
│   └── Entrega_Oracle11g_RodrigoJara.docx   # Documento Word con instalación, pasos y capturas
│
├── sql/
│   ├── 01_schema.sql                        # Creación de tablas, secuencias y triggers
│   ├── 02_sample_data.sql                   # Inserción de datos de ejemplo
│
├── src/
│   └── connect_and_query.py                 # Script Python para conexión y consulta básica
│
├── requirements.txt                          # Dependencias Python
├── README.md                                 # Esta guía
└── .gitignore

Ejecución rápida

Instalar Oracle Database 11g XE
Crear usuario y contraseña (system / asd123)
Probar conexión con SQL*Plus:

sqlplus system/asd123@localhost/XE


Clonar este repositorio o descomprimir el ZIP.

(Opcional) Crear entorno virtual:

py -3.12 -m venv .venv
.\.venv\Scripts\activate


Instalar dependencias:

pip install oracledb


Instalar Oracle Instant Client:
Descargar desde Oracle (Instant Client 11.2)
Extraer en:

C:\Program Files\Oracle\instantclient_11_2


Ejecutar los scripts SQL de la entrega 1:

@sql/01_schema.sql
@sql/02_sample_data.sql


Editar la ruta del cliente en:

oracledb.init_oracle_client(lib_dir=r'C:\\Program Files\\Oracle\\instantclient_11_2')


Ejecutar el script Python:

python src\connect_and_query.py

Errores comunes y soluciones aplicadas
Problema	Causa	Solución aplicada
No matching distribution found for python-oracledb	Python 3.13 no tiene binario compatible aún	Se instaló Python 3.12
ModuleNotFoundError: No module named 'oracledb'	Python ejecutado fuera del entorno virtual	Se activó .venv
DPI-1047: Cannot locate Oracle Client	Falta de Instant Client o ruta incorrecta	Se instaló y configuró correctamente
Caracteres raros (Ana PÃ©rez)	Codificación UTF-8 vs ANSI	Ajustes en impresión
Documentación incluida

Entrega_Oracle11g_RodrigoJara.docx: Documento con instalación, capturas, esquema E-R y prueba básica de conexión.

Actualización – Entrega 2

La entrega 2 amplía el proyecto con operaciones de manipulación de datos, consultas avanzadas, uso de índices y control de transacciones en Oracle 11g XE.

Archivos añadidos en esta entrega
sql/
│── 03_entrega2.sql                 # CRUD, consultas avanzadas, índices y transacciones
docs/
│── Entrega2_Capturas.docx          # Evidencias de ejecución

Contenido del script 03_entrega2.sql
Operaciones CRUD

Incluye:

Inserción de clientes y películas.

Actualización de datos (correo, precio).

Eliminación de boletos y clientes sin registros asociados.

Consultas SQL avanzadas

Se añadieron consultas que utilizan:

JOIN entre múltiples tablas.

Funciones agregadas (COUNT, SUM).

Agrupación con GROUP BY y HAVING.

Subconsultas para cálculos dependientes (por ejemplo, la función con mayor precio).

Índices

Se creó el índice:

CREATE INDEX ix_cliente_email ON cliente(email);


Oracle devolvió el error ORA-01408, indicando que la columna ya estaba indexada por la restricción UNIQUE.

Transacciones

El script demuestra el manejo transaccional:

SAVEPOINT

ROLLBACK TO SAVEPOINT

COMMIT

Como evidencia del control de cambios.

Ejecución de la Entrega 2

Ejecutar los scripts en orden dentro de SQLPlus:

@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql

Evidencias

Las capturas de SQLPlus de la ejecución completa se encuentran documentadas en:

docs/Entrega2_Capturas.docx
