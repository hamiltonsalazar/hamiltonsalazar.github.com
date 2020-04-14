SELECT CONCAT(nombre, " ", apellido) AS nombre_completo FROM autores
UNION
SELECT CONCAT("-",nombre, " ", apellido) AS nombre_completo FROM usuarios;


SELECT CONCAT(nombre, " ", apellido) AS nombre_completo, "" AS email, pais_origen  FROM autores
UNION
SELECT CONCAT("-",nombre, " ", apellido) AS nombre_completo, email, "" AS pais_origen FROM usuarios;


SELECT AVG(ventas) FROM libros; -- 252.1091

-- SET @promedio = (SELECT AVG(ventas) FROM libros);

SELECT
  autor_id
FROM libros
GROUP BY autor_id
HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros); -- HAVING SUM(ventas) > @promedio

SELECT CONCAT(nombre, " ", apellido), autor_id
FROM autores
WHERE autor_id IN(
  SELECT
    autor_id
  FROM libros
  GROUP BY autor_id
  HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros));


SELECT IF(
  EXISTS(SELECT libro_id FROM libros WHERE titulo = "El hobbit"),
  "Disponible",
  "No Disponible"
) AS mensaje;
