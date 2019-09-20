-- Este es el de top 10 aerolineas con mas empleados
SELECT aero.*
FROM (SELECT Empleado.IdAerolinea, COUNT(Empleado.IdAerolinea) CUENTA
      FROM EmpleadoAerolinea Empleado
      GROUP BY Empleado.IdAerolinea
      ORDER BY CUENTA DESC
      LIMIT 10) Result
         INNER JOIN Aerolinea aero USING (IdAerolinea);

-- Top 10 aeropuertos con mas aerolineas
SELECT Aero.*
FROM (SELECT Relacion.*
      FROM AeropuertoAerolinea Relacion
      GROUP BY Relacion.IdAeropuerto
      ORDER BY COUNT(Relacion.IdAeropuerto) DESC
      limit 10) Resulta
         INNER JOIN Aeropuerto Aero USING (IdAeropuerto);

-- Promedio del salario del los 5 aeropuertos con mas empleados
SELECT AVG(Empleado.Salario) AS 'Promedio salario top 5 aeropuertos'
FROM (SELECT Aero.IdAeropuerto, COUNT(Result.IdAeropuerto) AS Cuenta
      FROM EmpleadoAeropuerto Result
               INNER JOIN Aeropuerto Aero USING (IdAeropuerto)
      GROUP BY Aero.IdAeropuerto
      ORDER BY Cuenta DESC
      LIMIT 5
     ) Resultado
         INNER JOIN EmpleadoAeropuerto Empleado USING (IdAeropuerto)
GROUP BY Empleado.IdAeropuerto;

-- Empleado mas pagado de aeropuerto y aerolinea
SELECT EmpleadoAerolinea.*
FROM (SELECT Empleado.*, E.*
      FROM EmpleadoAeropuerto Empleado
               INNER JOIN Empleado E ON Empleado.IdEmpleado = E.IdEmpleado
      WHERE 1 = Empleado.IdAeropuerto
      ORDER BY (Empleado.Salario) DESC
      LIMIT 1) AS EmpleadoAerolinea
UNION ALL
SELECT EmpleadoAeropuerto.*
FROM (SELECT Empleado.*, E2.*
      FROM empleadoAerolinea Empleado
               INNER JOIN Empleado E2 ON Empleado.IdEmpleado = E2.IdEmpleado
      WHERE 1 = Empleado.IdAerolinea
      ORDER BY (Empleado.Salario) DESC
      LIMIT 1) AS EmpleadoAeropuerto;

-- Empleado mas pagado de todos
SELECT EmpleadoAeropuerto.*
FROM (SELECT Trabajador.*, E.*
      FROM EmpleadoAeropuerto Trabajador
               INNER JOIN Empleado E ON Trabajador.IdEmpleado = E.IdEmpleado
      ORDER BY Trabajador.Salario
      LIMIT 1
     ) AS EmpleadoAeropuerto
UNION ALL
SELECT EmpleadoAerolinea.*
FROM (SELECT Trabajador2.*, E2.*
      FROM EmpleadoAerolinea Trabajador2
               INNER JOIN Empleado E2 ON Trabajador2.IdEmpleado = E2.IdEmpleado
      ORDER BY Trabajador2.Salario
      LIMIT 1
     ) AS EmpleadoAerolinea;

-- Cantidad de aviones en estado de reparación de una aerolinea
SELECT COUNT(*) AS 'Cantidad de aviones en estado de reparacion en Aerolinea'
FROM Avion aviones
WHERE aviones.IdAerolinea = 2
  AND aviones.Estado = 'reparacion';

-- La suma de los costos que tienen unos aviones que pertenecen  en un aeropuerto
SELECT SUM(Facturas.Costo) AS 'Costo reparaciones en aeropuerto'
FROM (SELECT Talleres.*
      FROM Taller Talleres,
           Aeropuerto aeropuertos
      WHERE Talleres.IdAeropuerto = 4
     ) Talleres
         INNER JOIN
     Factura Facturas USING (IdTaller);

-- Cuenta la cantidad de aviones dentro de una bodega
SELECT count(*) AS 'Cantidad de aviones en una bodega'
FROM BodegaAvion Bodegas
WHERE Bodegas.IdBodega = 25
  AND Bodegas.Dentro = 'True';

-- Cantidad de aviones activos en un aeropuerto.
SELECT COUNT(*) AS 'Aviones activos en un aeropuerto'
FROM (SELECT A.IdAerolinea -- Busca las aerolinea de un aeropuesto
      FROM Aerolinea A
               INNER JOIN AeropuertoAerolinea AA ON AA.IdAerolinea = A.IdAerolinea
      WHERE AA.IdAeropuerto = 1) Aeros -- Aeropuerto especifico
         INNER JOIN Avion ON Avion.IdAerolinea = Aeros.IdAerolinea
WHERE Avion.Estado == 'activo';

-- Promedio de costo de reparación de los aviones para un aeropuerto específico'.
SELECT AVG(Factura.Costo) AS 'Promedio de costo de reparacion de los aviones para un aeropuerto especifico'
FROM (SELECT Avion.IdAvion -- Aviones de las aerolineas del aeropuerto escogido
      FROM (SELECT A.IdAerolinea -- Busca las aerolinea de un aeropuesto
            FROM Aerolinea A
                     INNER JOIN AeropuertoAerolinea AA ON AA.IdAerolinea = A.IdAerolinea
            WHERE AA.IdAeropuerto = 0) aeros -- Aeropuerto especifico
               INNER JOIN Avion ON Avion.IdAerolinea = aeros.IdAerolinea) Aviones
         INNER JOIN Factura ON Factura.IdAvion = Aviones.IdAvion;

-- Cantidad de aviones inactivos dentro de una bodega.
SELECT COUNT(*) AS 'Cantidad de aviones inactivos dentro de una bodega'
FROM Avion A
         INNER JOIN BodegaAvion BA ON A.IdAvion = BA.IdAvion
WHERE BA.IdBodega = 2 -- Bodega especifica
  AND A.Estado == 'inactivo';

-- Nombre de los fabricantes con la mayor cantidad de modelos.
SELECT Fabricante, COUNT(Fabricante) AS 'Cantidad de modelos'
FROM Avion
GROUP BY Fabricante
ORDER BY COUNT(Fabricante) DESC
LIMIT 5;

-- Cantidad de aerolíneas que contienen la letra “A” en el nombre. De este resultado además deben de mostrar cuáles tienen más vuelos activos.
SELECT Aerolinea.Nombre, Result.CantidadVuelosActivos
FROM (SELECT V.IdAerolinea,
             COUNT(V.IdEstado) AS CantidadVuelosActivos -- Busca la catidad de vuelos en aerolineas con A en el nombre y las ordena
      FROM (SELECT A.IdAerolinea -- busca las aerolineas que tienen la letra A en el nombre
            FROM Aerolinea A
            WHERE A.Nombre LIKE '%a%'
               OR A.Nombre LIKE '%A%') Aerolineas
               INNER JOIN Vuelo V ON V.IdAerolinea = Aerolineas.IdAerolinea
      WHERE V.IdEstado == '1'
      GROUP BY V.IdAerolinea
      ORDER BY COUNT(V.IdEstado) DESC) Result
         INNER JOIN Aerolinea ON Aerolinea.IdAerolinea = Result.IdAerolinea;

SELECT COUNT(Nombre)
FROM Aerolinea
WHERE Nombre LIKE '%a%'
   OR Nombre LIKE '%A%';

-- Intervalo de horas con la mayor llegada de aviones para un aeropuerto.
SELECT I.Hora1, I.Hora2, Result.*
FROM (SELECT COUNT(*) AS 'Numero de vuelos'
      FROM (SELECT V.HoraLlegada
            FROM Vuelo V
            WHERE IdAeropuertoDestino = 13) Vuelos -- Aeropuerto deseado)
      WHERE Vuelos.HoraLlegada BETWEEN '08:00' AND '12:00'
      UNION ALL
      SELECT COUNT(*)
      FROM (SELECT V.HoraLlegada
            FROM Vuelo V
            WHERE IdAeropuertoDestino = 13) Vuelos -- Aeropuerto deseado)
      WHERE Vuelos.HoraLlegada BETWEEN '12:00' AND '16:00'
      UNION ALL
      SELECT COUNT(*)
      FROM (SELECT V.HoraLlegada
            FROM Vuelo V
            WHERE IdAeropuertoDestino = 13) Vuelos -- Aeropuerto deseado)
      WHERE Vuelos.HoraLlegada BETWEEN '16:00' AND '20:00'
      UNION ALL
      SELECT COUNT(*)
      FROM (SELECT V.HoraLlegada
            FROM Vuelo V
            WHERE IdAeropuertoDestino = 13) Vuelos -- Aeropuerto deseado)
      WHERE Vuelos.HoraLlegada BETWEEN '20:00' AND '23:59') AS Result
         INNER JOIN Intervalos I ON I.IdIntervalo = Result.ROWID - 1
ORDER BY "Numero de vuelos" DESC