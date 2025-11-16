🟦 Entrega 2 – Operaciones SQL Avanzadas y CRUD

Esta entrega amplía el proyecto original incorporando:

✔ Operaciones CRUD en SQL

Se añadieron operaciones completas mediante el archivo 03_entrega2.sql:

INSERT: registro de nuevos clientes y películas

UPDATE: actualización de correo y precio de funciones

DELETE: eliminación de boletos y clientes sin registros asociados

✔ Consultas SQL avanzadas

Incluye ejemplos de:

JOIN entre varias tablas

Funciones agregadas (COUNT, SUM)

Agrupación con GROUP BY y HAVING

Subconsultas correlacionadas

✔ Índices

Se implementó un índice adicional:

CREATE INDEX ix_cliente_email ON cliente(email);


Oracle devolvió el error ORA-01408 indicando que la columna ya tenía un índice creado automáticamente por la restricción UNIQUE, lo cual demuestra la correcta normalización del esquema.

✔ Transacciones (SAVEPOINT, ROLLBACK, COMMIT)

Se añadió un ejemplo de transacción:

SAVEPOINT antes_compra;

INSERT INTO boleto (...);

ROLLBACK TO antes_compra;

INSERT INTO boleto (...);

COMMIT;


Esto demuestra control de integridad y manejo seguro de cambios.

✔ Evidencias

Todas las evidencias de ejecución mediante SQLPlus (creación del esquema, inserción de datos, CRUD, consultas avanzadas, índices y transacciones) están documentadas con capturas dentro del archivo Word Entrega_Oracle11g_RodrigoJara_Sebastian_Espiritu.docx.

📁 Archivos nuevos añadidos en la Entrega 2
sql/
│── 03_entrega2.sql        # CRUD, consultas avanzadas, índices y transacciones
docs/
│── Entrega2_Capturas.docx # Documento con evidencias de SQLPlus

▶ Ejecución de la Entrega 2 en SQLPlus

Dentro de SQLPlus:

@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql
