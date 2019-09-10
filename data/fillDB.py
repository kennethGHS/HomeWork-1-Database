import sqlite3
import json
import random

numOfAirports = 30


def fillAeropuerto():
    with open('data/airports.json', 'r') as f:
        data = json.load(f)
    for i in range(0, numOfAirports):
        c.execute(f"INSERT INTO Aeropuerto VALUES"
                  f"({i}, '{data[i]['iata_code']}', '{data[i]['name']}', '{data[i]['country']}', '{data[i]['city']}',"
                  f" '{'horario'}')")


def fillNumTelAeropuerto():
    idAeropuerto = 0
    idNumTelAeropuerto = 0
    while idAeropuerto < numOfAirports:
        numRandom = random.randrange(5)
        for j in range(0, numRandom):
            c.execute(f"INSERT INTO NumTelAeropuerto VALUES"
                      f"({idNumTelAeropuerto}, {random.randrange(11111111, 999999999)}, {idAeropuerto})")

            idNumTelAeropuerto += 1
        idAeropuerto += 1


# def fillEmpleadoAeropuerto():


if __name__ == '__main__':
    conn = sqlite3.connect('database.db')
    c = conn.cursor()

    fillAeropuerto()
    # fillNumTelAeropuerto()
    # fillEmpleadoAeropuerto()

    conn.commit()
    c.close()
    conn.close()
