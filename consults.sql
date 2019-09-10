--Este es el de top 10 aerolineas con mas empleados
SELECT result.*
FROM (SELECT empleado.IdAerolinea
      FROM EmpleadoAerolinea empleado
      GROUP BY empleado.IdAerolinea
      ORDER BY COUNT(empleado.IdAerolinea) DESC
      LIMIT 10) result,
     Aerolinea aero
WHERE aero.IdAerolinea = result.IdAerolinea;
--Top 10 aeropuertos con mas aerolineas
select aero.*
FROM (SELECT relacion.*
      FROM AeropuertoAerolinea relacion
      GROUP BY relacion.IdAeropuerto
      ORDER BY COUNT(relacion.IdAeropuerto) DESC
      limit 10) resulta,
     Aeropuerto aero
WHERE aero.IdAeropuerto = resulta.IdAeropuerto;
--Promedio del salario del los 5 aeropuertos con mas empleados
SELECT AVG(empleado.Salario)
FROM (SELECT aero.IdAeropuerto
      FROM EmpleadoAeropuerto result,
           Aeropuerto aero
      WHERE aero.IdAeropuerto = result.IdAeropuerto
      ORDER BY COUNT(result.IdAeropuerto) DESC
      LIMIT 5
     ) resultado,
     EmpleadoAeropuerto empleado
WHERE empleado.IdAeropuerto = resultado.IdAeropuerto;

--Empleado mas pagado de aeropuerto y aerolinea
SELECT empleadoAerolinea.*, empleadoAeropuerto.*
FROM (SELECT empleado.*
      FROM EmpleadoAeropuerto empleado
      WHERE 123 = empleado.IdAeropuerto
      ORDER BY (empleado.Salario) DESC
      LIMIT 1) empleadoAerolinea,
     (SELECT empleado.*
      FROM empleadoAerolinea empleado
      WHERE 123 = empleado.IdAerolinea
      ORDER BY (empleado.Salario) DESC
      LIMIT 1) empleadoAeropuerto;
--Cantidad de aviones activos de una aerolinea
SELECT COUNT(*)
FROM Avion aviones
WHERE aviones.IdAerolinea = 23345
  AND aviones.Estado = 'Activo';
--La suma de los costos que tienen unos aviones que pertenecen hay en un aeropuerto
SELECT AVG(facturas.Costo)
FROM (SELECT talleres.*
      FROM Taller talleres,
           Aeropuerto aeropuertos
      WHERE talleres.IdAeropuerto = 54254
     ) talleres,
     Factura facturas
WHERE facturas.IdTaller = talleres.IdTaller;

SELECT COUNT(*)
FROM BodegaAvion bodegas
WHERE bodegas.IdBodega = 1243 AND bodegas.CurrentlyIn =1;
