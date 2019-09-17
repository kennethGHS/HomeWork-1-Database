--Este es el de top 10 aerolineas con mas empleados
SELECT aero.*
FROM (SELECT empleado.IdAerolinea
      FROM EmpleadoAerolinea empleado
      GROUP BY empleado.IdAerolinea
      ORDER BY COUNT(empleado.IdAerolinea) DESC
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
SELECT AVG(empleado.Salario)
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
SELECT empleadoAerolinea.* , empleadoAeropuerto.*
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
--Cantidad de aviones activos de una aerolinea
SELECT COUNT(*)
FROM Avion aviones
WHERE aviones.IdAerolinea = 2
  AND aviones.Estado = 'activo';
--La suma de los costos que tienen unos aviones que pertenecen hay en un aeropuerto
SELECT SUM(facturas.Costo)
FROM (SELECT talleres.*
      FROM Taller talleres,
           Aeropuerto aeropuertos
      WHERE talleres.IdAeropuerto = 54254
     ) talleres
         INNER JOIN
     Factura facturas USING (IdTaller);

SELECT COUNT(*)
FROM BodegaAvion bodegas
WHERE bodegas.IdBodega = 1243
  AND bodegas.CurrentlyIn = 1;
