-- sql/01_schema.sql
-- Ejecutar con tu usuario de proyecto (o SYSTEM si crearás usuario primero).
-- Si usarás otro esquema, ajusta los nombres o anteponer el esquema (SCHEMA.OBJETO).

-- Limpieza segura (ignora errores si no existe)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE boleto CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE cliente CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE funcion CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE sala CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE pelicula CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE director CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
  FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE '||s.sequence_name;
  END LOOP;
EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Tablas base
CREATE TABLE director (
  id_director NUMBER PRIMARY KEY,
  nombre      VARCHAR2(100) NOT NULL,
  pais        VARCHAR2(60)
);

CREATE TABLE pelicula (
  id_pelicula NUMBER PRIMARY KEY,
  titulo      VARCHAR2(150) NOT NULL,
  anio        NUMBER(4) CHECK (anio BETWEEN 1888 AND 2100),
  genero      VARCHAR2(40),
  id_director NUMBER NOT NULL REFERENCES director(id_director)
);

CREATE TABLE sala (
  id_sala    NUMBER PRIMARY KEY,
  nombre     VARCHAR2(50) UNIQUE NOT NULL,
  capacidad  NUMBER CHECK (capacidad > 0)
);

CREATE TABLE funcion (
  id_funcion  NUMBER PRIMARY KEY,
  id_pelicula NUMBER NOT NULL REFERENCES pelicula(id_pelicula),
  id_sala     NUMBER NOT NULL REFERENCES sala(id_sala),
  fecha_hora  DATE   NOT NULL,
  precio      NUMBER(8,2) DEFAULT 0 CHECK (precio >= 0)
);

CREATE TABLE cliente (
  id_cliente NUMBER PRIMARY KEY,
  nombre     VARCHAR2(100) NOT NULL,
  email      VARCHAR2(150) UNIQUE NOT NULL
);

CREATE TABLE boleto (
  id_boleto   NUMBER PRIMARY KEY,
  id_funcion  NUMBER NOT NULL REFERENCES funcion(id_funcion),
  id_cliente  NUMBER NOT NULL REFERENCES cliente(id_cliente),
  asiento     VARCHAR2(10) NOT NULL,
  fecha_compra DATE DEFAULT SYSDATE,
  CONSTRAINT uq_boleto_asiento UNIQUE (id_funcion, asiento)
);

-- Secuencias (11g no tiene IDENTITY)
CREATE SEQUENCE seq_director START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_pelicula START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_sala     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_funcion  START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_cliente  START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_boleto   START WITH 1 INCREMENT BY 1 NOCACHE;

-- Triggers para autoincremento estilo 11g
CREATE OR REPLACE TRIGGER bi_director
BEFORE INSERT ON director
FOR EACH ROW
BEGIN
  IF :NEW.id_director IS NULL THEN :NEW.id_director := seq_director.NEXTVAL; END IF;
END;
/

CREATE OR REPLACE TRIGGER bi_pelicula
BEFORE INSERT ON pelicula
FOR EACH ROW
BEGIN
  IF :NEW.id_pelicula IS NULL THEN :NEW.id_pelicula := seq_pelicula.NEXTVAL; END IF;
END;
/

CREATE OR REPLACE TRIGGER bi_sala
BEFORE INSERT ON sala
FOR EACH ROW
BEGIN
  IF :NEW.id_sala IS NULL THEN :NEW.id_sala := seq_sala.NEXTVAL; END IF;
END;
/

CREATE OR REPLACE TRIGGER bi_funcion
BEFORE INSERT ON funcion
FOR EACH ROW
BEGIN
  IF :NEW.id_funcion IS NULL THEN :NEW.id_funcion := seq_funcion.NEXTVAL; END IF;
END;
/

CREATE OR REPLACE TRIGGER bi_cliente
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
  IF :NEW.id_cliente IS NULL THEN :NEW.id_cliente := seq_cliente.NEXTVAL; END IF;
END;
/

CREATE OR REPLACE TRIGGER bi_boleto
BEFORE INSERT ON boleto
FOR EACH ROW
BEGIN
  IF :NEW.id_boleto IS NULL THEN :NEW.id_boleto := seq_boleto.NEXTVAL; END IF;
END;
/

-- Índices útiles
CREATE INDEX ix_funcion_pelicula   ON funcion(id_pelicula);
CREATE INDEX ix_funcion_sala       ON funcion(id_sala);
CREATE INDEX ix_boleto_funcion     ON boleto(id_funcion);
CREATE INDEX ix_boleto_cliente     ON boleto(id_cliente);

PROMPT Esquema creado.
