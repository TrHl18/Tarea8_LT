/*
TAREA 8 - JOINS 
Lilia T.

*/
-- Consulta que muestre la planta que cuente con mas medidores
SELECT TOP 1 Planta, COUNT(*) AS CantidadMedidores
FROM Medidores
GROUP BY Planta
ORDER BY COUNT(*) DESC;

-- Consulta que muestre la planta que cuente con menos medidores
SELECT TOP 1 Planta, COUNT(*) AS CantidadMedidores
FROM Medidores
GROUP BY Planta
ORDER BY COUNT(*) ASC;

-- Consulta que devuelva los Datos de los medidores con un Source 1
SELECT *
FROM Medidores m 
WHERE SOURCE = 1;

-- Consulta que devuelva el valor de cada lectura (tabla Datos) multiplicado por su multiplicador segun la tabla medidores
SELECT d.*, m.Multiplicador , d.Valor *m.Multiplicador AS ValorMultiplicado
FROM  Datos d 
JOIN Medidores m ON d.Medidor = m.id 

-- Consulta que muestre el consumo de la planta 1 en el mes de Junio del presente a;o
SELECT p.Nombre AS Planta, m.Nombre AS Medidor, SUM(d.Valor) as Consumo
FROM Medidores m 
LEFT JOIN Datos d ON m.id = d.Medidor AND MONTH(d.Fecha)= 6 AND YEAR(d.Fecha)= 2018
LEFT JOIN Plantas p ON m.Planta = p.id 
WHERE  p.id = 1
GROUP BY p.Nombre, m.Nombre 

-- Consulta que muestre la lectura maxima de los medidores de la planta 5
SELECT MAX(d.Valor) AS LecturaMaxima, p.id AS Planta
FROM Datos d
JOIN Medidores m ON d.Medidor = m.Id
JOIN Plantas p ON m.Planta = p.id
WHERE p.id = 5
GROUP BY p.id;

-- Consulta que muestre el promedio de consumos de todas las plantas para el mes de Mayo
SELECT p.Nombre AS Planta, m.Nombre AS Medidor, AVG(d.Valor) as ConsumoMayo 
FROM Medidores m 
LEFT JOIN Datos d  ON m.id = d.Medidor
LEFT JOIN Plantas p ON m.Planta = p.id
WHERE MONTH(d.Fecha)= 5 
GROUP BY p.Nombre, m.Nombre 
ORDER BY p.Nombre, m.Nombre  ASC

-- Consulta que saque el valor maximo del medidor GN1_ENEE1 con variable _DP
SELECT MAX(d.Valor) AS ValorMaximo, m.Codigo AS Medidor, v.Codigo 
FROM Datos d
JOIN Variables v ON d.Variable = v.Id 
JOIN Medidores m  ON m.id = d.Medidor 
WHERE m.Codigo = 'GN1_ENEE1' AND v.Codigo = '_DP'
GROUP BY m.Codigo, v.Codigo 
;
-- Consulta que muestre los datos de fecha minima y maxima de los medidores con valor "C" Especial
SELECT  m.Especial AS ValorEspecial , MIN(d.Fecha) AS FechaMin, MAX(d.Fecha) AS FechaMax
FROM Datos d 
JOIN Medidores m ON d.Medidor = m.id 
WHERE m.Especial = 'C'
GROUP BY m.Especial 
;
-- Consulta que muestre la cantidad de medidores del sourcetype "IntelaTrac"
SELECT COUNT(*) AS CantidadMedidores, st.Nombre AS SourceType 
FROM Medidores m 
JOIN SourceType st ON m.[Source]  = st.id  
WHERE st.Nombre = 'IntelaTrac'
GROUP BY st.Nombre 
;	
-- Consulta que muestre el nombre del medidor concatenado con el nombre de la variable.
SELECT CONCAT(m.Nombre, '-', d.Variable) AS Medidor_Variable
FROM Datos d 
JOIN Medidores m ON d.Medidor = m.id  
JOIN Variables v ON d.Variable = v.Id 
;

-- Mostrar la cantida de registros Nulos de la tabla Datos
SELECT COUNT(*) AS Cant_Registros_Nulos 
FROM Datos d 
WHERE d.Fecha IS NULL OR d.Medidor IS NULL OR 
d.Variable IS NULL OR d.Valor IS NULL 
;

-- Mostrar los datos de los medidores del 10 al 20 con variable 1 y 4
SELECT m.id, m.Nombre AS Medidor, d.Fecha, d.Variable, d.Valor 
FROM Medidores m
JOIN Datos d ON m.id = d.Medidor 
WHERE m.id >= 10 AND m.id <=20
	AND d.Variable >=1 AND d.Variable <=4
;

-- Mostrar los datos que se encuentre en la fecha '20180401' al '20180501' Y '20180801' al ''20180901'
SELECT *
FROM Datos d 
WHERE (d.Fecha  BETWEEN '2018-04-01 00:00:00' AND '2018-05-01 23:59:59')
OR (d.Fecha  BETWEEN '2018-08-01 00:00:00' AND '2018-09-01 23:59:59')
;
	
-- Realizar una consulta utilizando LEFT JOIN con las tablas Datos y Variables
SELECT *
FROM Datos d 
LEFT JOIN Variables v ON d.Variable = v.Id 

-- Realizar dos consultas una con las lecturas del medidor 1 y otra consulta con el medidor 100 y unirlas con el UNION ALL
SELECT *
FROM Medidores m 
WHERE m.id = 1

UNION ALL 

SELECT *
FROM Medidores m 
WHERE m.id = 100
;

-- Realizar una consulta de los datos de los medidores que contenga una X en su codigo, del mes de Junio del 2018 y mostrando su informacion ordenada de forma descendente segun la fecha.
SELECT m.*, d.Fecha 
FROM Medidores m 
JOIN Datos d ON m.id = d.Medidor 
WHERE UPPER(m.Codigo) LIKE '%X%'
AND MONTH(d.Fecha)= 6 AND YEAR(d.Fecha)= 2018
ORDER BY d.Fecha DESC
;

-- Realizar una consulta que devuelva las primeros 10 registros del mes de Abril de la tabla Datos
SELECT TOP 10 *
FROM Datos d 
WHERE MONTH(d.Fecha)= 4
ORDER BY d.Fecha ASC
;
-- Realizar una consulta que devuelva los ultimos 10 registros del mes de Abril de la tabla Datos
SELECT TOP 10 *
FROM Datos d 
WHERE MONTH(d.Fecha)= 4
ORDER BY d.Fecha DESC
;

-- Realizar una consulta que muestre los valores Nullos de la tabla Datos
SELECT *
FROM Datos d 
WHERE d.Fecha IS NULL OR d.Medidor IS NULL OR 
d.Variable IS NULL OR d.Valor IS NULL 
;
