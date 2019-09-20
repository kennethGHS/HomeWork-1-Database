CREATE TABLE IF NOT EXISTS Aeropuerto
(
    IdAeropuerto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo       TEXT    NOT NULL,
    Nombre       TEXT    NOT NULL,
    Pais         TEXT    NOT NULL,
    Ciudad       TEXT    NOT NULL,
    Horario      TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS NumTelAeropuerto
(
    IdNumTelAeropuerto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto       INTEGER NOT NULL,
    NumTelefonico      TEXT    NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);

CREATE TABLE IF NOT EXISTS Aerolinea
(
    IdAerolinea INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo      TEXT    NOT NULL,
    Nombre      TEXT    NOT NULL
);


CREATE TABLE IF NOT EXISTS Avion
(
    IdAvion       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAerolinea   INTEGER NOT NULL,
    CodigoAvion   TEXT    NOT NULL,
    Modelo        TEXT    NOT NULL,
    CapacidadTrip INTEGER NOT NULL,
    CapacidadIter INTEGER NOT NULL,
    Estado        TEXT    NOT NULL,
    Fabricante    TEXT    NOT NULL,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea)
);
CREATE TABLE IF NOT EXISTS AvionAeropuerto
(
    IdAvion      INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL,
    Dentro       BOOLEAN NOT NULL,
    HoraLlegada  TIME    NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);

CREATE TABLE IF NOT EXISTS AeropuertoAerolinea
(
    IdAerolinea  INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);

CREATE TABLE IF NOT EXISTS ClasesAvion
(
    IdClasesAvion INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NomClase      TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS RelClasesAvion
(
    IdClase INTEGER NOT NULL,
    IdVuelo INTEGER NOT NULL,
    FOREIGN KEY (IdClase) REFERENCES ClasesAvion (IdClasesAvion),
    FOREIGN KEY (IdVuelo) REFERENCES Avion (IdAvion)
);

CREATE TABLE IF NOT EXISTS Taller
(
    IdTaller     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL,
    Nombre       TEXT    NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);
CREATE TABLE IF NOT EXISTS Bodega
(
    IdBodega     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL,
    Nombre       TEXT    NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);
CREATE TABLE IF NOT EXISTS BodegaAvion
(
    IdBodega INTEGER NOT NULL,
    IdAvion  INTEGER NOT NULL,
    Dentro   BOOLEAN NOT NULL,
    FOREIGN KEY (IdBodega) REFERENCES Bodega (IdBodega),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion)
);
CREATE TABLE IF NOT EXISTS Factura
(
    IdFactura    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAvion      INTEGER NOT NULL,
    IdTaller     INTEGER NOT NULL,
    Costo        DOUBLE  NOT NULL,
    HoraLlegada  TEXT    NOT NULL,
    HoraSalida   TEXT,
    FechaLlegada TEXT    NOT NULL,
    FechaSalida  TEXT,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdTaller) REFERENCES Taller (IdTaller)
);

CREATE TABLE IF NOT EXISTS Damage
(
    IdDamage  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre    TEXT    NOT NULL,
    IdFactura INTEGER NOT NULL,
    FOREIGN KEY (IdFactura) REFERENCES Factura (IdFactura)
);

CREATE TABLE IF NOT EXISTS Repuesto
(
    IdRepuesto     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NombreRepuesto TEXT    NOT NULL,
    IdFactura      INTEGER NOT NULL,
    FOREIGN KEY (IdFactura) REFERENCES Factura (IdFactura)
);

CREATE TABLE IF NOT EXISTS Vuelo
(
    IdVuelo             INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAvion             INTEGER NOT NULL,
    IdAerolinea         INTEGER NOT NULL,
    IdEstado            INTEGER NOT NULL,
    IdAeropuertoOrigen  INTEGER NOT NULL,
    IdAeropuertoDestino INTEGER NOT NULL,
    Destino             TEXT    NOT NULL,
    Origen              TEXT    NOT NULL,
    NumeroVuelo         TEXT    NOT NULL,
    FechaSalida         DATE    NOT NULL,
    FechaLlegada        DATE    NOT NULL,
    HoraSalida          TIME    NOT NULL,
    HoraLlegada         TIME    NOT NULL,
    Precio              DOUBLE  NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdAeropuertoOrigen) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdAeropuertoDestino) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdEstado) REFERENCES EstadoVuelo (IdEstado)
);

CREATE TABLE IF NOT EXISTS EstadoVuelo
(
    IdEstado INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre   TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS Pasajero
(
    IdPasajero      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdVuelo         INTEGER NOT NULL,
    CodigoPasajero  TEXT    NOT NULL,
    Nombre          TEXT    NOT NULL,
    Apellido1       TEXT    NOT NULL,
    Apellido2       TEXT    NOT NULL,
    NumPasaporte    TEXT    NOT NULL,
    PaisPasaporte   TEXT    NOT NULL,
    FechaImprenta   DATE    NOT NULL,
    FechaNacimiento DATE    NOT NULL,
    FOREIGN KEY (IdVuelo) REFERENCES Vuelo (IdVuelo)

);

CREATE TABLE IF NOT EXISTS NumTelPasajero
(
    IdNumTelPasajero INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdPasajero       INTEGER NOT NULL,
    NumTelefonico    TEXT    NOT NULL,
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero)
);

CREATE TABLE IF NOT EXISTS Equipaje
(
    IdEquipaje INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Peso       DOUBLE  NOT NULL,
    IdPasajero INTEGER NOT NULL,
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero)
);

CREATE TABLE IF NOT EXISTS Controlador
(
    IdControlador     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre            TEXT    NOT NULL,
    Apellido          TEXT    NOT NULL,
    CodigoControlador TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS Conexion
(
    IdConexion    INTEGER NOT NULL,
    IdControlador INTEGER NOT NULL,
    IdVuelo       INTEGER NOT NULL,
    CodigoComun   TEXT    NOT NULL,
    HoraLlegada   TIME    NOT NULL,
    Latitud       INTEGER NOT NULL,
    Longitud      INTEGER NOT NULL,
    FOREIGN KEY (IdControlador) REFERENCES Controlador (IdControlador),
    FOREIGN KEY (IdVuelo) REFERENCES Vuelo (IdVuelo)
);

CREATE TABLE IF NOT EXISTS EmpleadoAeropuerto
(
    IdEmpleado   INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL,
    IdPuesto     INTEGER NOT NULL,
    Salario      TEXT    NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    FOREIGN KEY (IdPuesto) REFERENCES PuestoAeropuerto (IdPuesto)

);
CREATE TABLE IF NOT EXISTS EmpleadoAerolinea
(
    IdEmpleado  INTEGER NOT NULL,
    IdPuesto    INTEGER NOT NULL,
    IdAerolinea INTEGER NOT NULL,
    Salario     TEXT    NOT NULL,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado),
    FOREIGN KEY (IdPuesto) REFERENCES PuestoAerolinea (IdPuesto)
);

CREATE TABLE IF NOT EXISTS Empleado
(
    IdEmpleado  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Codigo      TEXT    NOT NULL,
    Nombre      TEXT    NOT NULL,
    Apellido1   TEXT    NOT NULL,
    Apellido2   TEXT    NOT NULL,
    Cedula      TEXT    NOT NULL,
    CuentaBanco TEXT    NOT NULL,
    Pais        TEXT    NOT NULL,
    Ciudad      TEXT    NOT NULL,
    Calle       TEXT    NOT NULL,
    Casa        TEXT    NOT NULL,
    Horario     TEXT    NOT NULL
);


CREATE TABLE IF NOT EXISTS PuestoAeropuerto
(
    IdPuesto     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NombreEmpleo TEXT    NOT NULL
);

-- INSERT INTO PuestoAeropuerto
-- VALUES (0, 'Despachador de vuelos'),
--        (1, 'Tecnico administrativos'),
--        (2, 'Agente de servicios aeroportuarios'),
--        (3, 'Auxiliar de tierra');

CREATE TABLE IF NOT EXISTS PuestoAerolinea
(
    IdPuesto     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NombreEmpleo TEXT    NOT NULL
);

-- INSERT INTO PuestoAerolinea
-- VALUES (0, 'Piloto'),
--        (1, 'Azafata'),
--        (2, 'Copiloto');

CREATE TABLE IF NOT EXISTS Intervalos
(
    IdIntervalo INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Hora1       TIME    NOT NULL,
    Hora2       TIME    NOT NULL
);

INSERT INTO Intervalos(IdIntervalo, Hora1, Hora2)
VALUES (0, '08:00', '12:00'),
       (1, '12:00', '16:00'),
       (2, '16:00', '20:00'),
       (3, '20:00', '23:59')

