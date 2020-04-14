SET GLOBAL log_bin_trust_function_creators = 1;


DELIMITER &#


CREATE FUNCTION agregar_horas(fecha DATE, horas INT)
RETURNS DATE
BEGIN
  RETURN fecha + INTERVAL horas HOUR;
END&#

CREATE FUNCTION obtener_paginas()
RETURNS INT
BEGIN
  SET @paginas = (SELECT(ROUND( RAND()*100)*4));
  RETURN @paginas;
END&#

CREATE FUNCTION obtener_ventas()
RETURNS INT
BEGIN
  SET @paginas = (SELECT (ROUND (RAND () * 100)*6));
  RETURN @paginas;
END&#


DELIMITER ;


UPDATE libros SET paginas = obtener_paginas();
UPDATE libros SET ventas = obtener_ventas();
