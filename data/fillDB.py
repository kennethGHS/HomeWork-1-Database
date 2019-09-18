import sqlite3
import json
import random
# import xlrd
import string

import xlrd as xlrd

numOfAirports = 30
numOfAirlines = 8


def fillAeropuerto():
    """
    inserta datos a tabla Aeropuerto(IdAeropuerto, Codigo, Nombre, Pais, Ciudad, Horario)
    """
    with open('data/Aeropuertos.json', 'r') as f:
        data = json.load(f)
    for i in range(0, numOfAirports):
        c.execute(f"INSERT INTO Aeropuerto VALUES"
                  f"({i}, '{data[i]['iata_code']}', '{data[i]['name']}', '{data[i]['country']}', '{data[i]['city']}',"
                  f" '{'horario'}')")


def fillNumTelAeropuerto():
    """
    inserta datos a tabla NumTelAeropuerto(IdNumTelAeropuerto, IdAeropuerto, NumeroTelefonico)
    """
    idAeropuerto = 0
    idNumTelAeropuerto = 0
    while idAeropuerto < numOfAirports:
        numRandom = random.randrange(1, 5)  # cada aeropuerto tiene entre 1 y 5 numeros de telefono
        for j in range(0, numRandom):
            c.execute(f"INSERT INTO NumTelAeropuerto VALUES"
                      f"({idNumTelAeropuerto}, {idAeropuerto}, '{random.randrange(11111111, 999999999)}')")

            idNumTelAeropuerto += 1
        idAeropuerto += 1


def fillAerolinea():
    with open('data/Aerolineas.json', 'r') as f:
        data = json.load(f)
    for i in range(0, numOfAirlines):
        c.execute(f"INSERT INTO Aerolinea VALUES({i}, '{data[i]['iata']}', '{data[i]['name']}')")


def fillAeropuertoAerolinea():
    idAeropuerto = 0
    while idAeropuerto < numOfAirports:
        numRandom = random.randrange(3, 9)  # cada aeropuerto tiene entre 3 y 8 Aerolineas
        for j in range(0, numRandom):
            c.execute(f"INSERT INTO AeropuertoAerolinea VALUES({j}, {idAeropuerto})")
        idAeropuerto += 1


def addEmpleado(idEmpleado):
    """
    inserta datos a tabla Empleado(IdEmpleado, Codigo, Nombre, Apellido1, Apellido2, Cedula, CuentaBanco, Pais,
                                   Ciudad, Calle, Casa, Horario)
    """
    with open('data/Empleado.json', 'r') as f:
        dataEmpleado = json.load(f)

    c.execute(
        f"INSERT INTO Empleado VALUES({idEmpleado}, '{dataEmpleado[idEmpleado]['Codigo']}', "
        f"'{dataEmpleado[idEmpleado]['Nombre']}', '{dataEmpleado[idEmpleado]['Apellido1']}', "
        f"'{dataEmpleado[idEmpleado]['Apellido2']}', '{dataEmpleado[idEmpleado]['Cedula']}', "
        f"'{dataEmpleado[idEmpleado]['CuentaBanco']}', '{dataEmpleado[idEmpleado]['Pais']}', "
        f"'{dataEmpleado[idEmpleado]['Cuidad']}', '{dataEmpleado[idEmpleado]['Calle']}', "
        f"'{dataEmpleado[idEmpleado]['Casa']}', '{'horario'}')")


def fillEmpleadoAerolinea():
    """
    inserta datos a tabla EmpleadoAerolinea(IdEmpleado, IdPuesto, IdAerolinea, Salario)
    """
    c.execute("SELECT MAX(IdEmpleado) FROM Empleado")
    value = c.fetchall()
    idEmpleado = value[0][0]
    if not isinstance(idEmpleado, int): idEmpleado = 0
    if idEmpleado > 0: idEmpleado += 1
    idAerolinea = 0

    while idAerolinea < numOfAirlines:
        numEmpleados = random.randrange(5, 10)
        puestos = choosePuestos(numEmpleados, "Aerolinea")
        for j in range(0, numEmpleados):
            addEmpleado(idEmpleado)
            c.execute(f"INSERT INTO EmpleadoAerolinea VALUES({idEmpleado}, {puestos[j]}, {idAerolinea}, "
                      f"'{random.randrange(1111111, 99999999)}')")
            idEmpleado += 1
        idAerolinea += 1


def fillEmpleadoAeropuerto():
    """
    inserta datos a tabla EmpleadoAeropuerto(IdEmpleado, IdAeropuerto, IdPuesto, Salario)
    """
    c.execute("SELECT MAX(IdEmpleado) FROM Empleado")
    value = c.fetchall()
    idEmpleado = value[0][0]
    if not isinstance(idEmpleado, int): idEmpleado = 0
    if idEmpleado > 0: idEmpleado += 1
    idAeropuerto = 0

    while idAeropuerto < numOfAirports:
        numEmpleados = random.randrange(5, 10)
        puestos = choosePuestos(numEmpleados, "Aeropuerto")
        for j in range(0, numEmpleados):
            addEmpleado(idEmpleado)
            c.execute(f"INSERT INTO EmpleadoAeropuerto VALUES({idEmpleado}, {idAeropuerto}, {puestos[j]}, "
                      f"'{random.randrange(1111111, 99999999)}')")
            idEmpleado += 1
        idAeropuerto += 1


def choosePuestos(num, key):
    """
    elige los puestos de trabajo de los EmpleadoAeropuerto y EmpleadoAerolinea asegurando que haya al menos
    un trabajador en cada puesto de trabajo
    :param num: numero de trabajores
    :param key: si es para aeropuerto o aerolinea
    :return: lista de los id de los puestos de trabajo correspondientes
    """
    result = []
    if key == "Aerolinea":
        for i in range(0, num):
            if i < 3:
                result.append(i)
            else:
                result.append(random.choice([0, 1, 2]))
        return result
    else:
        for i in range(0, num):
            if i < 4:
                result.append(i)
            else:
                result.append(random.choice([0, 1, 2, 3]))
        return result


def fillBodega():
    """
    inserta datos a tabla Bodega(IdBodega,IdAeropuerto,Nombre)
    """
    SecondPart = ["Ruca ", "Tapiz", "Joses", " Alfa", "Bravo ",
                  "Beta ", "Gama", "Epsilon ", "Delta ", "Xi ", "Pi ", "Ro ", "Sigma"]
    letras = string.ascii_lowercase
    for i in range(0, 100):
        Name = " ".join(random.choice(letras) for i in range(0, 1))
        Name += SecondPart[random.randrange(0, len(SecondPart))]
        print(Name)
        c.execute(f"INSERT INTO Bodega VALUES"
                  f"({i}, {random.randrange(0, 30)}, '{Name}')")


# def fillAerolineaAeropuerto():
#     """
#     Realiza las relaciones entre aeropuertos y aerolineas
#     """
#     letras = string.ascii_lowercase
#     for i in range(0, 60):
#         c.execute(f"INSERT INTO AeropuertoAerolinea VALUES"
#                   f"({numOfAirlines}, {numOfAirports})")


def fillClasesAvion():
    """
        Realiza las relaciones entre aeropuertos y aerolineas
        """
    letras = string.ascii_lowercase

    for i in range(0, 3):
        palabra = "Turista"
        if (i == 1):
            palabra = "Trabajador"
        if (i == 2):
            palabra = "Empresario"
        c.execute(f"INSERT INTO ClasesAvion VALUES"
                  f"({i}, '{palabra}')")


def fillDamage():
    """
        Realiza las relaciones entre aeropuertos y aerolineas
        """
    reparaciones = ["aceite", "motor", "turbina", "Ala", "Asientos", "Baño atacasdo"
        , "Combustible", "Llantas"]
    contadorIdDaño = 0
    for i in range(0, 100):
        for j in range(0, random.randrange(1, 5)):
            tipoDano = reparaciones[random.randrange(0, len(reparaciones))]
            c.execute(f"INSERT INTO Damage VALUES"
                      f"({contadorIdDaño}, '{tipoDano}',{i})")
            contadorIdDaño += 1


def fillRepuesto():
    """
        Realiza las relaciones entre aeropuertos y aerolineas
        """
    reparaciones = ["Transistor", "Llanta", "Motor", "Rotador", "Transmisor",
                    "Cables", "Combustible", "Llantas"]
    contadorIdRepuesto = 0
    for i in range(0, 100):
        for j in range(0, random.randrange(1, 5)):
            tipoRepuesto = reparaciones[random.randrange(0, len(reparaciones))]
            c.execute(f"INSERT INTO Repuesto VALUES"
                      f"({contadorIdRepuesto}, '{tipoRepuesto}',{i})")
            contadorIdRepuesto += 1


def fillRelClasesAvion():
    """
        Realiza las relaciones entre aeropuertos y aerolineas
        """
    letras = string.ascii_lowercase
    for i in range(0, 50):
        idsClases = ()
        valor = random.randrange(0, 3)
        if (valor == 0):
            idsClases = (0, 1)
        if (valor == 1):
            idsClases = (1, 2)
        else:
            idsClases = (0, 2)
        for j in range(0, 2):
            c.execute(f"INSERT INTO RelClasesAvion VALUES"
                      f"({idsClases[j]}, {random.randrange(0, 30)})")


def fillFactura():
    """
    inserta datos a tabla Factura(IdFactura,IdAvion,IdTaller,Costo,
    HoraLlegada,HoraSalida,FechaLLegada,fechaSalida)
    """
    for i in range(0, 100):
        FechaSal = str(random.randrange(2000, 2030)) + "-" + str(random.randrange(0, 12)) + "-" + str(
            random.randrange(0, 30))
        FechaEnt = str(random.randrange(2000, 2030)) + "-" + str(random.randrange(0, 12)) + "-" + str(
            random.randrange(0, 30))
        Hora = str(random.randrange(10, 24)) + ":" + str(random.randrange(10, 60))
        Hora2 = str(random.randrange(10, 24)) + ":" + str(random.randrange(10, 60))
        c.execute(f"INSERT INTO Factura VALUES"
                  f"({i}, {random.randrange(0, 30)}, {random.randrange(0, 20)},"
                  f"{random.randrange(0, 9999999)},'{Hora}','{Hora2}','{FechaEnt}','{FechaSal}')")


def fillTaller():
    """
    inserta datos a tabla Taller(IdTaller,IdAeropuerto,Nombre)
    """
    SecondPart = ["Ruca ", "Tapiz", "Joses", " Alfa", "Bravo ",
                  "Beta ", "Gama", "Epsilon ", "Delta ", "Xi ", "Pi ", "Ro ", "Sigma"]
    letras = string.ascii_lowercase
    for i in range(0, 50):
        Name = " ".join(random.choice(letras) for i in range(0, 1))
        Name += SecondPart[random.randrange(0, len(SecondPart))]
        print(Name)
        c.execute(f"INSERT INTO Taller VALUES"
                  f"({i}, {random.randrange(0, 30)}, '{Name}')")


avionesInactivos = []


def fillAvion():
    """
    sin terminar
    :return:
    """
    loc = ('data/Aviones.xlsx')
    wb = xlrd.open_workbook(loc)
    sheet = wb.sheet_by_index(0)

    idAerolinea = 0
    idAvion = 0
    estados = ['activo', 'activo', 'activo', 'inactivo', 'inactivo', 'reparacion']
    while idAerolinea < numOfAirlines:
        numRandom = random.randrange(6, 12)  # cada aerolinea tiene entre 5 y 10 aviones

        for i in range(0, numRandom):
            SecondPart = ["Ruca ", "Tapiz", "Joses", " Alfa", "Bravo ",
                          "Beta ", "Gama", "Epsilon ", "Delta ", "Xi ", "Pi ", "Ro ", "Sigma"]
            letras = string.ascii_lowercase
            codigo = " ".join(random.choice(letras) for i in range(0, 1))
            codigo += SecondPart[random.randrange(0, len(SecondPart))]
            codigo += str(random.randrange(0, 100))

            if i < 6:
                estado = estados[i]
                if estado == 'inactivo': avionesInactivos.append(idAvion)
                c.execute(f"INSERT INTO Avion VALUES({idAvion}, {idAerolinea}, '{codigo}', "
                          f"'{sheet.cell_value(idAvion, 0)}', {random.randrange(100, 200)}, {random.randrange(10, 100)},"
                          f"'{estado}', '{sheet.cell_value(idAvion, 1)}')")
            else:
                estado = random.choice(estados)
                if estado == 'inactivo': avionesInactivos.append(idAvion)
                c.execute(
                    f"INSERT INTO Avion VALUES({idAvion}, {idAerolinea}, '{codigo}', "
                    f"'{sheet.cell_value(idAvion, 0)}', {random.randrange(100, 200)}, {random.randrange(10, 100)},"
                    f"'{estado}', '{sheet.cell_value(idAvion, 1)}')")

            idAvion += 1
        idAerolinea += 1


def FillBodegaAvion():
    """
    inserta datos a tabla BodegaAvion
    """
    for i in range(0, 100):
        c.execute(f"INSERT INTO BodegaAvion VALUES"
                  f"({i}, {avionesInactivos[random.randrange(0, len(avionesInactivos))]},{random.uniform(0, 1)})")


def fillControlador():
    Nombres = ["Juan", "Ken", "Maria", "Juana", "Marco", "Jason", "Mario", "Luigi",
               "Somedude", "Wikitaker", "PrograVisor", "Valeria", "Randy", "Chelsey",
               "Sidney", "Jesus", "Belcebu", "Ana"]
    Apellidos = ["Hernandez", "Gutierres", "Santa", "Vargas", "Herrera",
                 "Dittel", "Guzman", "Renhberg", "Italy", "Vitaly", "Castro", "Mora",
                 "Walker", "Wanker", "Salvador", "Tortilla"]
    for i in range(1,30):
        c.execute(f"INSERT INTO Controlador VALUES"
                  f"({i}, '{Nombres[random.randrange(0, len(Nombres))]}','{Apellidos[random.randrange(0, len(Apellidos))]}','{random.randrange(0,1937265)}')")
def fillConexion():
    for i in range(0,30):
        Hora = str(random.randrange(10, 24)) + ":" + str(random.randrange(10, 60))
        c.execute(f"INSERT INTO Conexion VALUES"
                  f"({i}, {i},{i},'{random.randrange(0, 1937265)}','{Hora}',{random.randrange(0,200)},{random.randrange(0,200)})")

if __name__ == '__main__':
    try:
        global idEmpleado
        conn = sqlite3.connect('database.db')
        c = conn.cursor()
        # fillFactura()
        fillTaller()
        # fillControlador()
        # fillConexion()
        # fillAeropuerto()
        # fillNumTelAeropuerto()
        # fillAerolinea()
        # fillEmpleadoAerolinea()
        # fillEmpleadoAeropuerto()

    #    fillAerolineaAeropuerto()
      #  print(avionesInactivos)

        # fillAvion()

        # fillAeropuertoAerolinea()
        # fillControlador()
        # fillRepuesto()
        # fillFactura()
        # fillBodega()
        conn.commit()
        c.close()
        conn.close()

    except Exception as e:
        print("ERROR: " + str(e))
