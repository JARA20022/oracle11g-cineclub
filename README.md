# Mini-Proyecto Oracle 11g: Cineclub

Proyecto académico con instalación, configuración y conexión a Oracle Database 11g XE, incluyendo:
- Diseño de esquema relacional  
- Creación de tablas y datos de ejemplo  
- Conexión desde Python usando `oracledb` (modo Thick)  
- Ejecución de consulta simple y documentación con capturas  

---

## Estructura del proyecto
cineclub_oracle11g/
│
├── docs/
│ ├── ERD.md # Diagrama entidad-relación y explicación del modelo
│ └── Entrega_Oracle11g_RodrigoJara.docx # Documento Word con instalación, pasos y capturas
│
├── sql/
│ ├── 01_schema.sql # Creación de tablas, secuencias y triggers
│ ├── 02_sample_data.sql # Inserción de datos de ejemplo
│
├── src/
│ └── connect_and_query.py # Script Python para conexión y consulta básica
│
├── requirements.txt # Dependencias Python
├── README.md # Esta guía
└── .gitignore

yaml
Copiar código

---

## Ejecución rápida
1. Instalar Oracle Database 11g XE  
   Crear usuario y contraseña (`system / asd123`)  
   Probar conexión con SQL*Plus:
   ```sql
   sqlplus system/asd123@localhost/XE
Clonar este repositorio o descomprimir el ZIP.

(Opcional) Crear entorno virtual:

powershell
Copiar código
py -3.12 -m venv .venv
.\.venv\Scripts\activate
Instalar dependencias:

powershell
Copiar código
pip install oracledb
Instalar Oracle Instant Client:
Descargar desde Oracle Instant Client Downloads
Extraer en:

makefile
Copiar código
C:\Program Files\Oracle\instantclient_11_2
Ejecutar los scripts SQL:

sql
Copiar código
@sql/01_schema.sql
@sql/02_sample_data.sql
Editar src/connect_and_query.py:
Verificar usuario, contraseña y ruta del Instant Client:

python
Copiar código
oracledb.init_oracle_client(lib_dir=r'C:\\Program Files\\Oracle\\instantclient_11_2')
Ejecutar el script:

powershell
Copiar código
python src\connect_and_query.py
Salida esperada:

nginx
Copiar código
Conectado a Oracle Database versión: 21.0.0.0.0
(1, 'Barbie', 'Sala 1', '2025-11-01 22:14', 'Ana Pérez', 'A10', 25.0)
(2, 'Barbie', 'Sala 1', '2025-11-01 22:14', 'Luis Gómez', 'A11', 25.0)
(3, 'Parasite', 'Sala 2', '2025-11-03 04:14', 'Ana Pérez', 'B05', 30.0)
Errores comunes y soluciones aplicadas
Problema	Causa	Solución aplicada
No matching distribution found for python-oracledb	Python 3.13 no tiene binario compatible aún	Se instaló Python 3.12 y se creó un entorno virtual
Microsoft Visual C++ 14.0 required al instalar cx_Oracle	Librería antigua requería compilador	Se reemplazó por oracledb, que no requiere compilación
ModuleNotFoundError: No module named 'oracledb'	Se ejecutaba con Python 3.13 global	Se activó el entorno .venv con Python 3.12
DPI-1047: Cannot locate Oracle Client	Faltaba el Instant Client o la ruta era incorrecta	Se instaló Instant Client en C:\Program Files\Oracle\instantclient_11_2
Caracteres raros (Ana Pérez → Ana PÃ©rez)	Codificación UTF-8 vs Latin1	Se ajustó la impresión en Python para corregir acentos

Documentación incluida
Entrega_Oracle11g_RodrigoJara.docx: documento completo con:

Instalación y configuración de Oracle 11g XE

Capturas de SQL*Plus

Diseño del esquema E-R

Creación de tablas y carga de datos

Conexión desde Python

Resultados de consulta y explicación

Notas adicionales
Proyecto probado en Windows 11 + Oracle 11g XE + Instant Client 11.2 + Python 3.12

Entorno ejecutado en Visual Studio Code

Compatible también con Instant Client 21.x

🔥 Entrega 2 – Extensión del Proyecto
La segunda entrega amplía el proyecto agregando operaciones CRUD, consultas avanzadas, creación de índices y manejo de transacciones usando el mismo esquema creado previamente.

Archivos añadidos en la Entrega 2
sql/03_entrega2.sql — Script con:

Inserciones

Actualizaciones

Eliminaciones

Consultas avanzadas (JOIN, GROUP BY, HAVING, subconsultas)

Creación de índices

Transacciones con SAVEPOINT, ROLLBACK y COMMIT

docs/Entrega2_Capturas.docx — Documento con todas las evidencias de ejecución en SQLPlus.

Contenido principal de 03_entrega2.sql
1. Operaciones CRUD
INSERT de nuevos clientes y películas.

UPDATE de correo electrónico y precios de funciones.

DELETE de boletos y eliminación segura de clientes sin compras (verificación con subconsulta).

2. Consultas SQL avanzadas
Incluye:

JOIN entre múltiples tablas

Funciones de agregación (COUNT, SUM)

GROUP BY y HAVING

Subconsultas para obtener, por ejemplo, funciones con precio máximo

3. Índices
sql
Copiar código
CREATE INDEX ix_cliente_email ON cliente(email);
Resultado:

makefile
Copiar código
ORA-01408: esta lista de columnas ya está indexada
(La columna ya tenía un índice por restricción UNIQUE.)

4. Transacciones
Uso de:

SAVEPOINT

ROLLBACK TO SAVEPOINT

COMMIT

Demostrado en SQLPlus dentro del script.

Ejecución de la Entrega 2
sql
Copiar código
@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql
Evidencias
Las capturas de pantalla solicitadas se encuentran en:

Copiar código
docs/Entrega2_Capturas.docx
