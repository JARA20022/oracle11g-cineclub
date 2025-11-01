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
│
├── src/
│   └── connect_and_query.py     # Script Python para conexión y consulta básica
│
├── requirements.txt             # Dependencias Python
├── README.md                    # Esta guía
└── .gitignore
```

---

## Ejecución rápida
1. Instalar Oracle Database 11g XE  
   Crear usuario y contraseña (`system / asd123`)  
   Probar conexión con SQL*Plus:
   ```sql
   sqlplus system/asd123@localhost/XE
   ```

2. Clonar este repositorio o descomprimir el ZIP.

3. (Opcional) Crear entorno virtual:
   ```powershell
   py -3.12 -m venv .venv
   .\.venv\Scripts\activate
   ```

4. Instalar dependencias:
   ```powershell
   pip install oracledb
   ```

5. Instalar Oracle Instant Client:  
   Descargar desde [Oracle Instant Client Downloads](https://www.oracle.com/database/technologies/instant-client/downloads.html)  
   Extraer en:
   ```
   C:\Program Files\Oracle\instantclient_11_2
   ```

6. Ejecutar los scripts SQL:
   ```sql
   @sql/01_schema.sql
   @sql/02_sample_data.sql
   ```

7. Editar `src/connect_and_query.py`:  
   Verificar usuario, contraseña y ruta del Instant Client:
   ```python
   oracledb.init_oracle_client(lib_dir=r'C:\\Program Files\\Oracle\\instantclient_11_2')
   ```

8. Ejecutar el script:
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
| No matching distribution found for python-oracledb | Python 3.13 no tiene binario compatible aún | Se instaló Python 3.12 y se creó un entorno virtual |
| Microsoft Visual C++ 14.0 required al instalar cx_Oracle | Librería antigua requería compilador | Se reemplazó por oracledb, que no requiere compilación |
| ModuleNotFoundError: No module named 'oracledb' | Se ejecutaba con Python 3.13 global | Se activó el entorno .venv con Python 3.12 |
| DPI-1047: Cannot locate Oracle Client | Faltaba el Instant Client o la ruta era incorrecta | Se instaló Instant Client en C:\Program Files\Oracle\instantclient_11_2 y se configuró correctamente |
| Caracteres raros (Ana PÃ©rez) | Codificación UTF-8 vs Latin1 | Se ajustó el print() en Python para corregir acentos |

---

## Documentación incluida
- Entrega_Oracle11g_RodrigoJara.docx: documento completo con:
  - Instalación y configuración de Oracle 11g XE  
  - Capturas de SQL*Plus y pruebas de conexión  
  - Diseño del esquema E-R  
  - Creación de tablas y carga de datos  
  - Conexión desde Python (VS Code)  
  - Resultados de consulta y explicación  

---

## Notas adicionales
- Proyecto probado en Windows 11 + Oracle Database 11g XE + Instant Client 11.2 + Python 3.12  
- Entorno ejecutado en Visual Studio Code  
- Compatible también con Instant Client 21.x  
- Incluye código, scripts SQL y documentación en Word para revisión académica  

---
