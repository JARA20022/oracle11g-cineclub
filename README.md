# Mini-Proyecto Oracle 11g: Cineclub

Proyecto académico que incluye:

- Diseño del esquema relacional.
- Creación de tablas y datos de ejemplo.
- Conexión desde Python usando oracledb (modo Thick).
- Ejecución de consultas y documentación con capturas.

---

## Estructura del proyecto

**docs/**
- ERD.md  
- Entrega_Oracle11g_RodrigoJara.docx  
- Entrega2_Capturas.docx  

**sql/**
- 01_schema.sql  
- 02_sample_data.sql  
- 03_entrega2.sql  

**src/**
- connect_and_query.py  

**Otros archivos**
- requirements.txt  
- README.md  
- .gitignore  

---

## Ejecución rápida (Entrega 1)

1. Instalar Oracle Database 11g XE  
2. Probar conexión:  
   `sqlplus system/asd123@localhost/XE`

3. Crear entorno virtual:  
   `py -3.12 -m venv .venv`  
   `.\\.venv\\Scripts\\activate`

4. Instalar dependencias:  
   `pip install oracledb`

5. Instalar Oracle Instant Client (11.2):  
   `C:\Program Files\Oracle\instantclient_11_2`

6. Ejecutar scripts SQL:  
   `@sql/01_schema.sql`  
   `@sql/02_sample_data.sql`

7. Ejecutar script Python:  
   `python src\connect_and_query.py`

---

## Errores comunes y soluciones

- python-oracledb no instala → usar Python 3.12  
- ModuleNotFoundError: oracledb → activar `.venv`  
- DPI-1047 → falta Instant Client  
- Caracteres raros → usar UTF-8  

---

# Entrega 2 – Extensión del proyecto

Se agregan operaciones CRUD, consultas avanzadas, índices y transacciones.

## Archivos añadidos
- sql/03_entrega2.sql  
- docs/Entrega2_Capturas.docx  

## Contenido del script 03_entrega2.sql

### Operaciones CRUD
- INSERT de clientes y películas  
- UPDATE de correos y precios  
- DELETE de boletos y de clientes sin compras  

### Consultas avanzadas
- JOIN  
- COUNT y SUM  
- GROUP BY y HAVING  
- Subconsultas  

### Índices
`CREATE INDEX ix_cliente_email ON cliente(email);`  
Oracle devuelve ORA-01408 (ya está indexado).

### Transacciones
- SAVEPOINT  
- ROLLBACK  
- COMMIT  

---

## Ejecución de la entrega 2

`@sql/01_schema.sql`  
`@sql/02_sample_data.sql`  
`@sql/03_entrega2.sql`

---

## Evidencias

Las capturas están en:  
`docs/Entrega2_Capturas.docx`

---
