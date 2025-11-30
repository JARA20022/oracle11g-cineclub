-- sql/02_sample_data.sql

INSERT INTO director (nombre, pais) VALUES ('Greta Gerwig', 'EEUU');
INSERT INTO director (nombre, pais) VALUES ('Bong Joon Ho', 'Corea del Sur');
INSERT INTO director (nombre, pais) VALUES ('Alfonso Cuaron', 'Mexico');

INSERT INTO pelicula (titulo, anio, genero, id_director) VALUES ('Barbie', 2023, 'Comedia', 1);
INSERT INTO pelicula (titulo, anio, genero, id_director) VALUES ('Parasite', 2019, 'Thriller', 2);
INSERT INTO pelicula (titulo, anio, genero, id_director) VALUES ('Roma', 2018, 'Drama', 3);

INSERT INTO sala (nombre, capacidad) VALUES ('Sala 1', 120);
INSERT INTO sala (nombre, capacidad) VALUES ('Sala 2', 80);

-- Funciones: hoy y manana como ejemplo
INSERT INTO funcion (id_pelicula, id_sala, fecha_hora, precio)
VALUES (1, 1, SYSDATE + 0.25, 25.00);

INSERT INTO funcion (id_pelicula, id_sala, fecha_hora, precio)
VALUES (2, 2, SYSDATE + 1 + 0.5, 30.00);

-- Clientes sin tildes para que no se rompan en Windows
INSERT INTO cliente (nombre, email) VALUES ('Ana Perez', 'ana@gmail.com');
INSERT INTO cliente (nombre, email) VALUES ('Luis Gomez', 'luis@gmail.com');

-- Boletos
INSERT INTO boleto (id_funcion, id_cliente, asiento) VALUES (1, 1, 'A10');
INSERT INTO boleto (id_funcion, id_cliente, asiento) VALUES (1, 2, 'A11');
INSERT INTO boleto (id_funcion, id_cliente, asiento) VALUES (2, 1, 'B05');

COMMIT;

-- Consulta simple sugerida
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
JOIN cliente c   ON c.id_cliente = b.id_cliente
ORDER BY b.id_boleto;
