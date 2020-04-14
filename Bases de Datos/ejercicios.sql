-- SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL;

SELECT libro_id, titulo, autor_id
FROM libros
WHERE autor_id IN(
  SELECT autor_id
  FROM autores
  WHERE seudonimo IS NOT NULL
);


-- SELECT YEAR(NOW());

SELECT titulo FROM libros WHERE YEAR(fecha_publicacion) = ( SELECT YEAR( NOW() ) );


-- SELECT autor_id FROM autores WHERE seudonimo IS NOT NULL AND YEAR(fecha_nacimiento) < 1965;

SELECT titulo
FROM libros
WHERE autor_id IN(
  SELECT autor_id
  FROM autores
  WHERE seudonimo
    IS NOT NULL AND YEAR(fecha_nacimiento) < 1965
);

UPDATE libros SET descripcion = "No Disponible" WHERE YEAR(fecha_publicacion) < 2000;

SELECT libro_id FROM libros WHERE descripcion != "No Disponible";

SELECT titulo, fecha_publicacion FROM libros WHERE autor_id = 2 ORDER BY fecha_publicacion DESC LIMIT 3;

SELECT count(libro_id) AS "con seudónimo", ""  AS "sin seudónimo"
FROM libros
WHERE autor_id IN(
  SELECT autor_id
  FROM autores
  WHERE seudonimo IS NOT NULL
)
UNION
SELECT "", count(libro_id)
FROM libros
WHERE autor_id IN(
  SELECT autor_id
  FROM autores
  WHERE seudonimo IS  NULL
);

-- SELECT titulo, fecha_publicacion FROM libros WHERE YEAR(fecha_publicacion) BETWEEN 2000 AND 2005;

SELECT COUNT(libro_id) FROM libros WHERE YEAR(fecha_publicacion) BETWEEN 2000 AND 2005;

SELECT titulo, ventas FROM libros ORDER BY ventas DESC LIMIT 5;

SELECT SUM(ventas) FROM libros WHERE autor_id IN(1,2,3);
SELECT autor_id, SUM(ventas) FROM libros WHERE autor_id IN(1,2,3) GROUP BY autor_id;

SELECT titulo, paginas FROM libros ORDER BY paginas DESC LIMIT 1; -- Solo si hay uno.
-- SELECT MAX(paginas) FROM libros;
SELECT titulo, paginas FROM libros WHERE paginas = (SELECT MAX(paginas) FROM libros);

SELECT titulo FROM libros WHERE titulo LIKE "LA%";

SELECT titulo FROM libros WHERE titulo LIKE "LA%A";

UPDATE libros SET stock = 0 WHERE YEAR(fecha_publicacion) < 1995;


SELECT IF(
  stock > 5,
  "Disponible",
  "No Disponible"
) AS Dispobiblidad FROM LIBROS WHERE libro_id = 1;

SELECT titulo, fecha_publicacion FROM libros ORDER BY fecha_publicacion DESC;

SELECT nombre, fecha_nacimiento FROM autores WHERE YEAR(fecha_nacimiento) > 1950;

SELECT
  CONCAT(nombre, " ", apellido) AS "Nombre Completo",
  ( YEAR(NOW())-YEAR(fecha_nacimiento) ) AS "Edad"
FROM autores;
SELECT
  CONCAT(nombre, " ", apellido) AS "Nombre Completo",
  ( DATEDIFF(NOW(), fecha_nacimiento) )/365 AS "Edad"
FROM autores;


SELECT
  autor_id
FROM libros
WHERE YEAR(fecha_publicacion) > 2005
GROUP BY autor_id;

SELECT
  CONCAT(nombre, " ", apellido) AS "Nombre Completo"
FROM autores
WHERE autor_id IN(
  SELECT autor_id
  FROM libros
  WHERE YEAR(fecha_publicacion) > 2005
  GROUP BY autor_id
);

SELECT autor_id
FROM libros
WHERE ventas > (SELECT AVG(ventas) FROM libros)
GROUP BY autor_id;

SELECT AVG(ventas) FROM libros GROUP BY autor_id;

SELECT autor_id FROM libros WHERE ventas > 100 GROUP BY autor_id;

DROP FUNCTION prestamo;
DELIMITER &#

CREATE FUNCTION prestamo(id INT)
RETURNS VARCHAR(20)
BEGIN
    RETURN (SELECT IF(
                    stock > 1,
                    "Disponible",
                    "No Disponible"
                  ) AS Dispobiblidad FROM LIBROS WHERE libro_id = id);
END&#

DELIMITER ;
