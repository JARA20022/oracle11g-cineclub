# Mini-Proyecto Oracle 11g: Cineclub

Proyecto académico que incluye:

- Diseño del esquema relacional.
- Creación de tablas y datos de ejemplo.
- Conexión desde Python usando `oracledb` (modo Thick).
- Ejecución de consultas y documentación con capturas.

---

## Estructura del proyecto

```txt
cineclub_oracle11g/
│
├── docs/
│   ├── ERD.md
│   ├── Entrega_Oracle11g_RodrigoJara.docx
│   └── Entrega2_Capturas.docx
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_sample_data.sql
│   └── 03_entrega2.sql
│
├── src/
│   └── connect_and_query.py
│
├── requirements.txt
├── README.md
└── .gitignore
Ejecución rápida (Entrega 1)
Instalar Oracle Database 11g XE.

Probar conexión:

bash
Copiar código
sqlplus system/asd123@localhost/XE
Crear entorno virtual (opcional):

bash
Copiar código
py -3.12 -m venv .venv
.\.venv\Scripts\activate
Instalar dependencias:

bash
Copiar código
pip install oracledb
Instalar Oracle Instant Client (11.2) en:

txt
Copiar código
C:\Program Files\Oracle\instantclient_11_2
Ejecutar scripts SQL:

sql
Copiar código
@sql/01_schema.sql
@sql/02_sample_data.sql
Ejecutar script Python:

bash
Copiar código
python src\connect_and_query.py
Errores comunes y soluciones
Problema	Causa	Solución
python-oracledb no instala	Python 3.13	Usar Python 3.12
ModuleNotFoundError: oracledb	Entorno no activado	Activar .venv
DPI-1047	Falta InstantClient	Instalar y configurar
Caracteres raros	Codificación	Ajustar a UTF-8

Entrega 2 – Extensión del proyecto
La segunda entrega agrega operaciones CRUD, consultas avanzadas, manejo de índices y transacciones sobre el mismo esquema de base de datos.

Archivos añadidos
txt
Copiar código
sql/03_entrega2.sql
docs/Entrega2_Capturas.docx
Contenido del script 03_entrega2.sql
1. Operaciones CRUD
INSERT de clientes y películas.

UPDATE de correos y precios.

DELETE de boletos y de clientes sin compras asociadas.

2. Consultas SQL avanzadas
Incluye consultas que utilizan:

JOIN entre múltiples tablas.

Funciones agregadas (COUNT, SUM).

GROUP BY y HAVING.

Subconsultas (por ejemplo, clientes de la función con mayor precio).

3. Índices
sql
Copiar código
CREATE INDEX ix_cliente_email ON cliente(email);
Oracle devuelve:

txt
Copiar código
ORA-01408: esta lista de columnas ya está indexada
lo que indica que la columna ya tiene un índice por la restricción UNIQUE.

4. Transacciones
Se ejemplifica el uso de:

SAVEPOINT

ROLLBACK TO SAVEPOINT

COMMIT

mostrando el control de cambios en la base de datos.

Ejecución de la entrega 2
sql
Copiar código
@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql
Evidencias
Las capturas de ejecución en SQLPlus se encuentran en:

txt
Copiar código
docs/Entrega2_Capturas.docx
