import os
import oracledb
import sys
sys.stdout.reconfigure(encoding="utf-8")


# Inicializar el cliente de Oracle
oracledb.init_oracle_client(
    lib_dir=r"C:\Program Files\Oracle\instantclient_11_2"
)

# Configuración de UTF-8 compatible con modo Thick
oracledb.defaults.encoding = "UTF-8"
oracledb.defaults.nencoding = "UTF-8"

# Datos de conexión
DB_USER = os.getenv("DB_USER", "SYSTEM")
DB_PASS = os.getenv("DB_PASS", "asd123")
DB_DSN = os.getenv("DB_DSN", "localhost:1521/XE")


def generar_asiento_libre(cursor, id_funcion: int) -> str:
    cursor.execute(
        """
        SELECT asiento
        FROM boleto
        WHERE id_funcion = :id_funcion
        """,
        {"id_funcion": id_funcion},
    )
    ocupados = {row[0] for row in cursor}

    for n in range(1, 100):
        candidato = f"C{n:02d}"
        if candidato not in ocupados:
            return candidato

    raise RuntimeError("No hay asientos libres para la función.")


def llamar_procedimiento_registrar_boleto(cursor):
    print("\n=== Llamando procedimiento sp_registrar_boleto ===")

    id_funcion = 1
    id_cliente = 2
    asiento = generar_asiento_libre(cursor, id_funcion)

    print(
        f"Insertando boleto (funcion={id_funcion}, cliente={id_cliente}, asiento='{asiento}')..."
    )

    cursor.callproc("sp_registrar_boleto", [id_funcion, id_cliente, asiento])
    print("Procedimiento ejecutado correctamente.")

    print("\nVerificando que el boleto se haya insertado:")
    cursor.execute(
        """
        SELECT id_boleto, id_funcion, id_cliente, asiento
        FROM boleto
        WHERE id_funcion = :id_funcion
          AND id_cliente = :id_cliente
          AND asiento = :asiento
        """,
        {"id_funcion": id_funcion, "id_cliente": id_cliente, "asiento": asiento},
    )

    print(f"{'ID':<5} {'FUNCION':<8} {'CLIENTE':<8} {'ASIENTO':<8}")
    print("-" * 35)
    for row in cursor:
        print(f"{row[0]:<5} {row[1]:<8} {row[2]:<8} {row[3]:<8}")


def mostrar_vista_boletos(cursor):
    print("\n=== Vista: vw_boletos_detalle ===")
    cursor.execute(
        """
        SELECT id_boleto, titulo, sala, fecha, cliente, asiento, precio
        FROM vw_boletos_detalle
        ORDER BY id_boleto
        """
    )

    header = f"{'ID':<4} {'TITULO':<15} {'SALA':<8} {'FECHA':<17} {'CLIENTE':<15} {'ASIENTO':<8} {'PRECIO':>8}"
    print(header)
    print("-" * len(header))

    for row in cursor:
        id_boleto, titulo, sala, fecha, cliente, asiento, precio = row
        print(
            f"{id_boleto:<4} "
            f"{str(titulo)[:15]:<15} "
            f"{str(sala)[:8]:<8} "
            f"{str(fecha)[:17]:<17} "
            f"{str(cliente)[:15]:<15} "
            f"{str(asiento)[:8]:<8} "
            f"{precio:>8.2f}"
        )


def mostrar_vista_ingresos(cursor):
    print("\n=== Vista: vw_ingresos_por_pelicula ===")
    cursor.execute(
        """
        SELECT titulo, boletos_vendidos, ingreso_total
        FROM vw_ingresos_por_pelicula
        ORDER BY titulo
        """
    )

    header = f"{'TITULO':<20} {'BOLETOS':>8} {'INGRESO_TOTAL':>15}"
    print(header)
    print("-" * len(header))

    for row in cursor:
        titulo, boletos, ingreso = row
        print(
            f"{str(titulo)[:20]:<20} "
            f"{boletos:>8} "
            f"{ingreso:>15.2f}"
        )


def main():
    try:
        with oracledb.connect(
            user=DB_USER,
            password=DB_PASS,
            dsn=DB_DSN
        ) as conn:

            print("Conectado a Oracle Database versión:", conn.version)

            with conn.cursor() as cursor:
                llamar_procedimiento_registrar_boleto(cursor)
                conn.commit()

                mostrar_vista_boletos(cursor)
                mostrar_vista_ingresos(cursor)

    except oracledb.Error as err:
        print("Error de conexión o ejecución:", err)


if __name__ == "__main__":
    main()
