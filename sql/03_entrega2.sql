
PROMPT ====== 1. INSERCIONES ======;

INSERT INTO cliente (nombre, email)
VALUES ('Carlos López', 'carlos.lopez@gmail.com');

INSERT INTO pelicula (titulo, anio, genero, id_director)
VALUES ('Interestelar', 2014, 'Ciencia ficción', 1);

COMMIT;


PROMPT ====== 2. ACTUALIZACIONES ======;

UPDATE cliente
SET email = 'ana.actualizada@gmail.com'
WHERE nombre = 'Ana Pérez';

UPDATE funcion
SET precio = precio + 5
WHERE id_funcion = 1;

COMMIT;


PROMPT ====== 3. ELIMINACIONES ======;

DELETE FROM boleto
WHERE id_boleto = 3;

DELETE FROM cliente
WHERE id_cliente = 5
  AND id_cliente NOT IN (SELECT id_cliente FROM boleto);

COMMIT;


PROMPT ====== 4. CONSULTAS AVANZADAS ======;

SELECT f.id_funcion,
       p.titulo,
       COUNT(b.id_boleto)     AS boletos_vendidos,
       SUM(f.precio)          AS ingreso_total
FROM funcion f
JOIN pelicula p ON p.id_pelicula = f.id_pelicula
LEFT JOIN boleto b ON b.id_funcion = f.id_funcion
GROUP BY f.id_funcion, p.titulo;

SELECT DISTINCT c.nombre, c.email
FROM cliente c
JOIN boleto b  ON b.id_cliente = c.id_cliente
JOIN funcion f ON f.id_funcion = b.id_funcion
WHERE f.precio = (
    SELECT MAX(precio) FROM funcion
);

SELECT d.nombre, COUNT(DISTINCT p.id_pelicula) AS cantidad_peliculas
FROM director d
JOIN pelicula p ON p.id_director = d.id_director
JOIN funcion f  ON f.id_pelicula = p.id_pelicula
GROUP BY d.nombre
HAVING COUNT(DISTINCT p.id_pelicula) > 1;


PROMPT ====== 5. ÍNDICES ======;

CREATE INDEX ix_cliente_email ON cliente(email);


PROMPT ====== 6. TRANSACCIÓN (ejemplo) ======;

SAVEPOINT antes_compra;

INSERT INTO boleto (id_funcion, id_cliente, asiento)
VALUES (1, 1, 'B15');

ROLLBACK TO antes_compra;

INSERT INTO boleto (id_funcion, id_cliente, asiento)
VALUES (1, 1, 'B16');

COMMIT;

PROMPT ====== FIN DE ENTREGA 2 ======;
