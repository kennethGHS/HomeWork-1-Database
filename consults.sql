--Este es el de top 10 aerolineas con mas empleados
SELECT aero.*
FROM (SELECT empleado.IdAerolinea, COUNT(empleado.IdAerolinea) CUENTA
      FROM EmpleadoAerolinea empleado
      GROUP BY empleado.IdAerolinea
      ORDER BY CUENTA DESC
      LIMIT 10) result
         INNER JOIN Aerolinea aero USING (IdAerolinea);
--Top 10 aeropuertos con mas aerolineas
select aero.*
FROM (SELECT relacion.*
      FROM AeropuertoAerolinea relacion
      GROUP BY relacion.IdAeropuerto
      ORDER BY COUNT(relacion.IdAeropuerto) DESC
      limit 10) resulta
         inner join Aeropuerto aero USING (IdAeropuerto);
--Promedio del salario del los 5 aeropuertos con mas empleados
SELECT AVG(empleado.Salario) AS 'Promedio salario top 5 aeropuertos'
FROM (SELECT aero.IdAeropuerto, COUNT(result.IdAeropuerto) AS cuenta
      FROM EmpleadoAeropuerto result
               INNER JOIN Aeropuerto aero USING (IdAeropuerto)
      GROUP BY aero.IdAeropuerto
      ORDER BY cuenta DESC
      LIMIT 5
     ) resultado
         INNER JOIN EmpleadoAeropuerto empleado USING (IdAeropuerto)
GROUP BY empleado.IdAeropuerto
;

--Empleado mas pagado de aeropuerto y aerolinea
SELECT empleadoAerolinea.*, empleadoAeropuerto.*
FROM (SELECT empleado.*
      FROM EmpleadoAeropuerto empleado
      WHERE 1 = empleado.IdAeropuerto
      ORDER BY (empleado.Salario) DESC
      LIMIT 1) AS empleadoAerolinea,
     (SELECT empleado.*
      FROM empleadoAerolinea empleado
      WHERE 1 = empleado.IdAerolinea
      ORDER BY (empleado.Salario) DESC
      LIMIT 1) AS empleadoAeropuerto;
--Empleado mas pagado de todos
SELECT empleadoAerolinea.*, empleadoAeropuerto.*
FROM (SELECT trabajador.*, E.*
      FROM EmpleadoAeropuerto trabajador
               INNER JOIN Empleado E on trabajador.IdEmpleado = E.IdEmpleado
      ORDER BY trabajador.Salario
      LIMIT 1
     ) AS empleadoAeropuerto,
     (SELECT  trabajador2.*, E2.*
         FROM EmpleadoAerolinea trabajador2
         INNER JOIN  Empleado E2 on trabajador2.IdEmpleado = E2.IdEmpleado
         ORDER BY trabajador2.Salario
         LIMIT 1
         ) AS empleadoAerolinea;

--Cantidad de aviones activos de una aerolinea

SELECT COUNT(*) AS 'Cantidad de aviones activos en Aerolinea'
FROM Avion aviones
WHERE aviones.IdAerolinea = 2
  AND aviones.Estado = 'activo';
--La suma de los costos que tienen unos aviones que pertenecen  en un aeropuerto
SELECT SUM(facturas.Costo) AS 'Costo reparaciones en aeropuerto'
FROM (SELECT talleres.*
      FROM Taller talleres,
           Aeropuerto aeropuertos
      WHERE talleres.IdAeropuerto = 4
     ) talleres
         INNER JOIN
     Factura facturas USING (IdTaller);
--Cuenta la cantidad de aviones dentro de una bodega
SELECT count(*)
FROM BodegaAvion bodegas
WHERE bodegas.IdBodega = 25
  AND bodegas.Dentro = 'True';
