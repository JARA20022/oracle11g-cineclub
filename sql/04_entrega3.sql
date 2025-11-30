PROMPT ====== ENTREGA 3: PROCEDIMIENTOS, TRIGGERS Y VISTAS ======;
PROMPT ==== LIMPIEZA OBJETOS DE ENTREGA 3 ====;

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE log_boleto CASCADE CONSTRAINTS';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE seq_log_boleto';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

------------------------------------------------------------
-- 1. PROCEDIMIENTOS ALMACENADOS
------------------------------------------------------------

-- Procedimiento para registrar un boleto nuevo
-- Usa el trigger bi_boleto para autogenerar el id_boleto.
CREATE OR REPLACE PROCEDURE sp_registrar_boleto(
    p_id_funcion IN boleto.id_funcion%TYPE,
    p_id_cliente IN boleto.id_cliente%TYPE,
    p_asiento    IN boleto.asiento%TYPE
) AS
BEGIN
    INSERT INTO boleto (id_funcion, id_cliente, asiento)
    VALUES (p_id_funcion, p_id_cliente, p_asiento);

    COMMIT;
END;
/
SHOW ERRORS;


-- Procedimiento para actualizar el precio de una función
CREATE OR REPLACE PROCEDURE sp_actualizar_precio_funcion(
    p_id_funcion   IN funcion.id_funcion%TYPE,
    p_nuevo_precio IN funcion.precio%TYPE
) AS
BEGIN
    UPDATE funcion
       SET precio = p_nuevo_precio
     WHERE id_funcion = p_id_funcion;

    COMMIT;
END;
/
SHOW ERRORS;


------------------------------------------------------------
-- 2. TRIGGERS BÁSICOS
------------------------------------------------------------

-- Tabla de log para registrar inserciones de boletos
CREATE TABLE log_boleto (
    id_log     NUMBER PRIMARY KEY,
    id_boleto  NUMBER,
    fecha_log  DATE,
    accion     VARCHAR2(50)
);

CREATE SEQUENCE seq_log_boleto START WITH 1 INCREMENT BY 1 NOCACHE;


-- Trigger: cuando se inserta un boleto, se guarda un registro en log_boleto
CREATE OR REPLACE TRIGGER bi_log_boleto
AFTER INSERT ON boleto
FOR EACH ROW
BEGIN
    INSERT INTO log_boleto (id_log, id_boleto, fecha_log, accion)
    VALUES (seq_log_boleto.NEXTVAL, :NEW.id_boleto, SYSDATE, 'ALTA');
END;
/
SHOW ERRORS;


-- Trigger: siempre guarda el email del cliente en minúsculas
CREATE OR REPLACE TRIGGER bu_cliente_email_lower
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW
BEGIN
    :NEW.email := LOWER(:NEW.email);
END;
/
SHOW ERRORS;


------------------------------------------------------------
-- 3. VISTAS
------------------------------------------------------------

-- Vista con el detalle de los boletos (similar a tu consulta principal)
CREATE OR REPLACE VIEW vw_boletos_detalle AS
SELECT b.id_boleto,
       p.titulo,
       s.nombre AS sala,
       TO_CHAR(f.fecha_hora, 'YYYY-MM-DD HH24:MI') AS fecha,
       c.nombre AS cliente,
       b.asiento,
       f.precio
FROM boleto b
JOIN funcion f   ON f.id_funcion = b.id_funcion
JOIN pelicula p  ON p.id_pelicula = f.id_pelicula
JOIN sala s      ON s.id_sala = f.id_sala
JOIN cliente c   ON c.id_cliente = b.id_cliente;


-- Vista con el resumen de ingresos por película
CREATE OR REPLACE VIEW vw_ingresos_por_pelicula AS
SELECT p.titulo,
       COUNT(b.id_boleto) AS boletos_vendidos,
       SUM(f.precio)      AS ingreso_total
FROM funcion f
JOIN pelicula p ON p.id_pelicula = f.id_pelicula
LEFT JOIN boleto b ON b.id_funcion = f.id_funcion
GROUP BY p.titulo;


------------------------------------------------------------
-- 4. PRUEBAS RÁPIDAS (para capturas de pantalla)
------------------------------------------------------------

PROMPT === Probar procedimiento sp_registrar_boleto ===;
EXEC sp_registrar_boleto(1, 1, 'C01');
SELECT id_boleto, id_funcion, id_cliente, asiento
FROM boleto
WHERE asiento = 'C01';


PROMPT === Probar procedimiento sp_actualizar_precio_funcion ===;
EXEC sp_actualizar_precio_funcion(1, 40);
SELECT id_funcion, precio
FROM funcion
WHERE id_funcion = 1;


PROMPT === Probar vista vw_boletos_detalle ===;
SELECT * FROM vw_boletos_detalle ORDER BY id_boleto;


PROMPT === Probar vista vw_ingresos_por_pelicula ===;
SELECT * FROM vw_ingresos_por_pelicula ORDER BY titulo;


PROMPT === Probar log de boletos ===;
SELECT * FROM log_boleto ORDER BY id_log;


-- Prueba extra del trigger de email en minúsculas
PROMPT === Probar trigger bu_cliente_email_lower ===;
INSERT INTO cliente (nombre, email)
VALUES ('Prueba Mayus', 'MAYUS@EJEMPLO.COM');

SELECT nombre, email
FROM cliente
WHERE nombre = 'Prueba Mayus';

COMMIT;

PROMPT ====== FIN DE ENTREGA 3 ======;
