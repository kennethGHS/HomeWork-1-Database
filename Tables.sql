CREATE TABLE  Aeropuerto(

    IdAeropuerto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Localizacion TEXT NOT NULL  ,
    Horario TEXT NOT NULL ,
    CodigoAeropuerto TEXT NOT NULL
);
CREATE TABLE  Numeros(

    IdNumeros INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Numero INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL ,
    FOREIGN KEY(IdAeropuerto)  REFERENCES Aeropuerto(IdAeropuerto)
);
CREATE TABLE  EmpleadoAeropuerto(

    IdEmpleado INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL  ,
    CodigoEmpleado TEXT NOT NULL ,
    Nombre TEXT NOT NULL  ,
    Apellido1 TEXT NOT NULL ,
    Apellido2 TEXT NOT NULL  ,
    Cedula TEXT NOT NULL ,
    Pais TEXT NOT NULL  ,
    Ciudad TEXT NOT NULL ,
    Calle TEXT NOT NULL  ,
    Horario TEXT NOT NULL ,
    Casa TEXT NOT NULL  ,
    Puesto TEXT NOT NULL ,
    Salario DOUBLE NOT NULL,
    FOREIGN KEY(IdAeropuerto)  REFERENCES Aeropuerto(IdAeropuerto)
);

CREATE TABLE  Aerolinea(
    IdAerolinea INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CodigoAerolinea TEXT NOT NULL ,
    Nombre TEXT NOT NULL
);
CREATE TABLE  EmpleadoAerolinea(

    IdEmpleado INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAerolinea INTEGER NOT NULL  ,
    CodigoEmpleado TEXT NOT NULL ,
    Nombre TEXT NOT NULL  ,
    Apellido1 TEXT NOT NULL ,
    Apellido2 TEXT NOT NULL  ,
    Cedula TEXT NOT NULL ,
    Horario TEXT NOT NULL ,
    Puesto TEXT NOT NULL  ,
    Salario DOUBLE NOT NULL,
    FOREIGN KEY(IdAerolinea)  REFERENCES Aerolinea(IdAerolinea)
);
CREATE TABLE  Avion(
    IdAvion INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAerolinea INTEGER NOT NULL  ,
    CodigoAvion TEXT NOT NULL ,
    Modelo TEXT NOT NULL  ,
    CapacidadTrip INTEGER NOT NULL ,
    CapacidadIter INTEGER NOT NULL  ,
    Estado TEXT NOT NULL ,
    Fabricante TEXT NOT NULL ,
    FOREIGN KEY(IdAerolinea)  REFERENCES Aerolinea(IdAerolinea)
);
CREATE TABLE  ClasesAvion(
    IdClase INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NomClase TEXT NOT NULL
);
CREATE TABLE  RelClasesAvion(
    IdClase INTEGER NOT NULL,
    IdVuelo INTEGER NOT NULL ,
    FOREIGN KEY(IdClase)  REFERENCES ClasesAvion(IdClase),
    FOREIGN KEY(IdVuelo)  REFERENCES Avion(IdAvion)
);
CREATE TABLE  Taller(
    IdTaller INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL
);
CREATE TABLE  Factura(
    IdFactura INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAvion INTEGER NOT NULL  ,
    IdTaller INTEGER NOT NULL ,
    Costo DOUBLE NOT NULL  ,
    HoraLlegada TEXT NOT NULL ,
    HoraSalida TEXT NOT NULL  ,
    FechaLlegada TEXT NOT NULL ,
    FechaSalida TEXT NOT NULL ,
    FOREIGN KEY(IdAvion)  REFERENCES Avion(IdAvion),
    FOREIGN KEY(IdTaller)  REFERENCES Taller(IdTaller)
);
CREATE TABLE  Damage(
    IdDamage INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    IdFactura INTEGER NOT NULL ,
    FOREIGN KEY(IdFactura)  REFERENCES Factura(IdFactura)
);

CREATE TABLE  Repuesto(
    IdRepuesto INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NombreRepuesto TEXT NOT NULL,
    IdFactura INTEGER NOT NULL ,
    FOREIGN KEY(IdFactura)  REFERENCES Factura(IdFactura)
);
CREATE TABLE  Vuelo(

    IdVuelo INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL  ,
    IdAerolinea INTEGER NOT NULL  ,
    IdAvion INTEGER NOT NULL  ,
    Destino TEXT NOT NULL ,
    Origen TEXT NOT NULL  ,
    NumeroVuelo TEXT NOT NULL  ,
    FechaSalida DATE NOT NULL ,
    FechaLlegada DATE  NOT NULL ,
    HoraSalida  TIME NOT NULL ,
    HoraLlegada TIME NOT NULL  ,
    Precio DOUBLE NOT NULL ,
    Estado TEXT NOT NULL  ,
    FOREIGN KEY(IdAeropuerto)  REFERENCES Aeropuerto(IdAeropuerto),
    FOREIGN KEY(IdAerolinea)  REFERENCES Aerolinea(IdAerolinea),
    FOREIGN KEY(IdAvion)  REFERENCES Avion(IdAvion)

);
CREATE TABLE  Pasajero(

    IdPasajero INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdVuelo INTEGER NOT NULL  ,
    CodigoPasajero TEXT NOT NULL ,
    Nombre TEXT NOT NULL ,
    Apellido1 TEXT  NOT NULL ,
    Apellido2  TEXT NOT NULL ,
    NumPasaporte TIME NOT NULL  ,
    PaisPasaporte TEXT NOT NULL  ,
    FOREIGN KEY(IdVuelo)  REFERENCES Vuelo(IdVuelo)

);
CREATE TABLE  NumeroPasajero(
    IdNumeroINTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NumeroTelefono INTEGER NOT NULL,
    IdPasajero INTEGER NOT NULL ,
    FOREIGN KEY(IdPasajero)  REFERENCES Pasajero(IdPasajero)
);
CREATE TABLE  Equipaje(
    IdEquipaje INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Peso DOUBLE NOT NULL,
    CodigoPasajero TEXT NOT NULL,
    IdPasajero INTEGER NOT NULL ,
    FOREIGN KEY(IdPasajero)  REFERENCES Pasajero(IdPasajero)
);
CREATE TABLE  Controlador(
    IdControlador INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Apellido TEXT NOT NULL ,
    CodigoControlador TEXT NOT NULL
);
CREATE TABLE  Conexion(
    IdConexion INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdControlador TEXT NOT NULL,
    IdVuelo TEXT NOT NULL ,
    CodigoComun TEXT NOT NULL,
    HoraLlegada TIME NOT NULL,
    Latitud INTEGER NOT NULL,
    Longitud INTEGER NOT NULL,
    FOREIGN KEY(IdControlador)  REFERENCES Controlador(IdControlador),
    FOREIGN KEY(IdVuelo)  REFERENCES Vuelo(IdVuelo)
);

select  aero.*
FROM (select avion.IdAerolinea
FROM Avion avion
GROUP BY avion.IdAerolinea
ORDER BY COUNT(avion.IdAerolinea) desc ) result,Aerolinea aero
WHERE aero.IdAerolinea = result.IdAerolinea
LIMIT  10;
-- INSERT INTO Aerolinea(CodigoAerolinea,Nombre)
-- values ('123K','AMERICAN AIRLINES'),
--        ('123L','AMERICAN HAIRLINES'),
--        ('123M','AMERICAN CARLINES');
--        ('123B','CRHOY'),
--        ('123C','NACION'),
--        ('123D','AMERICANBEATINGS'),
--        ('123E','HITYOU'),
--        ('123F','NOTYOURSIT'),
--        ('123G','YOUTSIT'),
--        ('123H','MALASIA LOSTYOU'),
--        ('123I','MALASIA FOUNDYOU'),
--        ('123J','MALASIA CRAHSINTHEOCEAN');

INSERT INTO Avion(idaerolinea, codigoavion, modelo, capacidadtrip, capacidaditer, estado, fabricante)
 VALUES
        (1,'ABC1','REDDRAGON',2,234,'ACTIVO','YAMAHA'),
        (1,'ABC2','ASUS',2,234,'ACTIVO','YAMAHA'),
        (1,'ABC3','ASUS',2,234,'ACTIVO','YAMAHA'),
        (1,'ABC4','USA',2,234,'ACTIVO','ZUZUKI'),
        (2,'ABC5','CR',2,234,'ACTIVO','ZUZUKI'),
        (2,'ABC6','COLA',2,234,'ACTIVO','ZUZUKI'),
        (2,'ABC7','MEME',2,234,'ACTIVO','ZUZUKI'),
        (3,'ABC8','NOMBRE',2,234,'ACTIVO','YAMAHA'),
        (3,'ABC9','REDDRAGON',2,234,'ACTIVO','USA'),
        (3,'ABC10','INTELLIJ',2,234,'ACTIVO','USA'),
        (4,'ABC11','JETBRAINS',2,234,'ACTIVO','USA'),
        (4,'ABC12','MOIR',2,234,'ACTIVO','USA'),
        (4,'ABC13','MORA',2,234,'ACTIVO','USA'),
        (5,'ABC14','CASA123',2,234,'ACTIVO','USA'),
        (5,'ABC15','BOEING',2,234,'ACTIVO','USA'),
        (6,'ABC16','MODELNAME2',2,234,'ACTIVO','MIKSA'),
        (6,'ABC17','COLA',2,234,'ACTIVO','MIKSA'),
        (7,'ABC18','COLA',2,234,'ACTIVO','YAMAHA'),
        (7,'ABC19','COLA',2,234,'ACTIVO','MIKSA'),
        (8,'ABC20','ASUS',2,234,'ACTIVO','YAMAHA'),
        (8,'ABC21','ASUS',2,234,'ACTIVO','MIKSA'),
        (9,'ABC22','ASUS',2,234,'ACTIVO','LOL'),
        (9,'ABC23','POLO12',2,234,'ACTIVO','YAMAHA'),
        (10,'ABC24','POLO12',2,234,'ACTIVO','YAMAHA'),
        (11,'ABC25','POLO12',2,234,'ACTIVO','LOL'),
        (11,'ABC26','REDDRAGON',2,234,'ACTIVO','LOL');





