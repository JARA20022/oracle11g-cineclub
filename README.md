# Mini-Proyecto Oracle 11g: Cineclub

Proyecto académico con instalación, configuración y conexión a Oracle Database 11g XE, incluyendo:
- Diseño de esquema relacional  
- Creación de tablas y datos de ejemplo  
- Conexión desde Python usando `oracledb` (modo Thick)  
- Ejecución de consulta simple y documentación con capturas  

---

## Estructura del proyecto
```
cineclub_oracle11g/
│
├── docs/
│   ├── ERD.md                   # Diagrama entidad-relación y explicación del modelo
│   └── Entrega_Oracle11g_RodrigoJara.docx  # Documento Word con instalación, pasos y capturas
│
├── sql/
│   ├── 01_schema.sql            # Creación de tablas, secuencias y triggers
│   ├── 02_sample_data.sql       # Inserción de datos de ejemplo
│   └── 03_entrega2.sql          # (Nuevo) CRUD, consultas avanzadas, índices y transacciones
│
├── src/
│   └── connect_and_query.py     # Script Python para conexión y consulta básica
│
├── requirements.txt             # Dependencias Python
├── README.md                    # Esta guía
└── .gitignore
```

---

## Ejecución rápida (Entrega 1)

1. Instalar Oracle Database 11g XE  
   Crear usuario y contraseña (`system / asd123`)  
   Probar conexión:
   ```sql
   sqlplus system/asd123@localhost/XE
   ```

2. (Opcional) Crear entorno virtual:
   ```powershell
   py -3.12 -m venv .venv
   .\.venv\Scripts\activate
   ```

3. Instalar dependencias:
   ```powershell
   pip install oracledb
   ```

4. Instalar Oracle Instant Client:  
   ```
   C:\Program Files\Oracle\instantclient_11_2
   ```

5. Ejecutar los scripts SQL:
   ```sql
   @sql/01_schema.sql
   @sql/02_sample_data.sql
   ```

6. Ejecutar script Python:
   ```powershell
   python src\connect_and_query.py
   ```

Salida esperada:
```
Conectado a Oracle Database versión: 21.0.0.0.0
(1, 'Barbie', 'Sala 1', '2025-11-01 22:14', 'Ana Pérez', 'A10', 25.0)
(2, 'Barbie', 'Sala 1', '2025-11-01 22:14', 'Luis Gómez', 'A11', 25.0)
(3, 'Parasite', 'Sala 2', '2025-11-03 04:14', 'Ana Pérez', 'B05', 30.0)
```

---

## Errores comunes y soluciones aplicadas
| Problema | Causa | Solución aplicada |
|-----------|--------|------------------|
| No matching distribution found for python-oracledb | Python 3.13 sin binario compatible | Usar Python 3.12 |
| Microsoft Visual C++ 14.0 required | cx_Oracle requiere compilación | Usar oracledb |
| ModuleNotFoundError: oracledb | Usando Python global | Activar `.venv` |
| DPI-1047 | No se detecta Instant Client | Instalar y configurar ruta |
| Caracteres raros | Codificación | Usar UTF-8 |

---

## Documentación incluida

- Archivo Word original:  
  *Entrega_Oracle11g_RodrigoJara.docx*  
  Con:
  - Instalación de Oracle
  - Configuración
  - Capturas de SQL*Plus
  - Carga de datos
  - Conexión desde Python
  - Resultados finales

---

## Notas adicionales
- Probado en Windows 11 + Oracle 11g XE + Instant Client 11.2 + Python 3.12  
- Editor utilizado: Visual Studio Code  
- Repositorio organizado por carpetas para entrega académica  

---

# **Entrega 2 — Extensión del Proyecto**

En esta entrega se agregaron:

- Operaciones CRUD completas (INSERT, UPDATE, DELETE)  
- Consultas SQL avanzadas (JOIN, GROUP BY, HAVING, subconsultas)  
- Creación de índices  
- Transacciones con SAVEPOINT, ROLLBACK y COMMIT  
- Capturas de ejecución en SQLPlus  

---

## Archivos añadidos
- `sql/03_entrega2.sql` – Script completo de la entrega 2  
- `docs/Entrega2_Capturas.docx` – Documento con evidencias  

---

## Contenido del script 03_entrega2.sql

### 1. Operaciones CRUD
- INSERT de nuevo cliente y película  
- UPDATE de email y precio de función  
- DELETE de boleto y eliminación segura de cliente sin compras:

```sql
DELETE FROM cliente
WHERE id_cliente = 5
  AND id_cliente NOT IN (SELECT id_cliente FROM boleto);
```

---

### 2. Consultas avanzadas
Incluye:

- JOIN entre varias tablas  
- SUM y COUNT para ingresos y boletos  
- GROUP BY y HAVING  
- Subconsultas de funciones con mayor precio  

Ejemplo:

```sql
SELECT f.id_funcion, p.titulo,
       COUNT(b.id_boleto) AS boletos_vendidos,
       SUM(f.precio) AS ingreso_total
FROM funcion f
JOIN pelicula p ON p.id_pelicula = f.id_pelicula
LEFT JOIN boleto b ON b.id_funcion = f.id_funcion
GROUP BY f.id_funcion, p.titulo;
```

---

### 3. Índices

```sql
CREATE INDEX ix_cliente_email ON cliente(email);
```

Resultado generado por Oracle:
```
ORA-01408: esta lista de columnas ya está indexada
```

(La columna ya tenía índice UNIQUE.)

---

### 4. Transacciones

Demostración realizada con:

```sql
SAVEPOINT antes_compra;

INSERT INTO boleto (id_funcion, id_cliente, asiento)
VALUES (1, 1, 'B15');

ROLLBACK TO antes_compra;

INSERT INTO boleto (id_funcion, id_cliente, asiento)
VALUES (1, 1, 'B16');

COMMIT;
```

---

## Ejecución de la entrega 2

```sql
@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql
```

---

## Evidencias de la Entrega 2

Se encuentran en:

```
docs/Entrega2_Capturas.docx
```
# **Entrega 3 — Procedimientos, triggers, vistas y app avanzada**

En esta entrega se agregaron:

- Procedimientos almacenados:
  - `sp_registrar_boleto(p_id_funcion, p_id_cliente, p_asiento)`
  - `sp_actualizar_precio_funcion(p_id_funcion, p_nuevo_precio)`
- Triggers básicos:
  - `bi_log_boleto` (AFTER INSERT ON boleto, registra en `log_boleto`)
  - `bu_cliente_email_lower` (BEFORE INSERT OR UPDATE ON cliente, normaliza el email a minúsculas)
- Vistas:
  - `vw_boletos_detalle` (detalle de boletos con película, sala, cliente, fecha y precio)
  - `vw_ingresos_por_pelicula` (boletos vendidos e ingreso total por película)
- Script Python:
  - `src/app_entrega3.py`:
    - Invoca el procedimiento almacenado `sp_registrar_boleto`
    - Muestra las vistas `vw_boletos_detalle` y `vw_ingresos_por_pelicula`

---

## Archivos añadidos (Entrega 3)

- `sql/04_entrega3.sql` – Script con procedimientos, triggers, vistas y pruebas  
- `src/app_entrega3.py` – Script Python avanzado  
- `docs/Entrega3_Capturas.docx` – Evidencias de la entrega 3  

---

## Ejecución de la Entrega 3

1. Ejecutar scripts en SQL*Plus:

```sql
@sql/01_schema.sql
@sql/02_sample_data.sql
@sql/03_entrega2.sql
@sql/04_entrega3.sql
Ejecutar aplicación en Python:

powershell
Copiar código
python src\app_entrega3.py
Consultas opcionales para evidencias:

sql
Copiar código
SELECT * FROM vw_boletos_detalle;
SELECT * FROM vw_ingresos_por_pelicula;
SELECT * FROM log_boleto;
Evidencias de la Entrega 3
Se encuentran en:

Copiar código
docs/Entrega3_Capturas.docx
Incluyen:

Prueba de procedimientos almacenados

Ejecución de triggers

Resultados de vistas

Salida del script app_entrega3.py
---

