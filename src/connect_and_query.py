import os
import oracledb

oracledb.init_oracle_client(
    lib_dir=r'C:\\Program Files\\Oracle\\instantclient_11_2')
DB_USER = os.getenv('DB_USER', 'SYSTEM')
DB_PASS = os.getenv('DB_PASS', 'asd123')
DB_DSN = os.getenv('DB_DSN',  'localhost:1521/XE')


def main():
    try:
        with oracledb.connect(user=DB_USER, password=DB_PASS, dsn=DB_DSN) as conn:
            print('Conectado a Oracle Database versión:', conn.version)

            with conn.cursor() as cur:
                cur.execute("""
                    SELECT b.id_boleto, p.titulo, s.nombre AS sala,
                           TO_CHAR(f.fecha_hora, 'YYYY-MM-DD HH24:MI') AS fecha,
                           c.nombre AS cliente, b.asiento, f.precio
                    FROM boleto b
                    JOIN funcion f   ON f.id_funcion = b.id_funcion
                    JOIN pelicula p  ON p.id_pelicula = f.id_pelicula
                    JOIN sala s      ON s.id_sala = f.id_sala
                    JOIN cliente c   ON c.id_cliente = b.id_cliente
                    ORDER BY b.id_boleto
                """)
                for row in cur:
                    fixed_row = tuple(
                        str(x).encode('latin1').decode(
                            'utf-8') if isinstance(x, str) else x
                        for x in row
                    )
                    print(fixed_row)
    except Exception as e:
        print('Error de conexión o consulta:', e)


if __name__ == '__main__':
    main()
