/*
¿Qué tipos de entidades? autores
Nombre : autores
*/

/*
Nombre
Genero
Fecha de nacimiento
País de origen
*/
CREATE TABLE autores(
  autor_id INT,
  nombre VARCHAR(25),
  apellido VARCHAR(25),
  genero CHAR(1), -- M o F
  fecha_nacimiento DATE,
  pais_origen VARCHAR(40)
);

-- ALTER TABLE libros ADD   FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE;

/* Insertar registros*/
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES (1, 'Test autor', 'Test autor', 'M', '2020-04-10', 'Colombia');

INSERT INTO autores (autor_id, nombre) VALUES (1, 'Test autor');

INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES (2, 'Test autor', 'Test autor', 'M', '2020-04-10', 'Colombia');

INSERT INTO autores (autor_id, nombre, apellido) VALUES (3, 'Test autor', 'Test autor');

INSERT INTO autores (autor_id) VALUES (4);

INSERT INTO autores () VALUES ();

INSERT INTO autores (autor_id, nombre, apellido, genero) VALUES (6, 'Test autor', 'Test autor', 'M');


/* Insertar registros multiples */
INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) VALUES  (7, 'Test autor', 'Test autor', 'M', '2020-04-10', 'Colombia'),
        (8, 'Test autor', 'Test autor', 'M', '2020-04-10', 'Colombia'),
        (9, 'Test autor', 'Test autor', 'M', '2020-04-10', 'Colombia'),
        (10, 'Test autor', 'Test autor', 'M', '2020-04-10', 'Colombia');

SELECT titulo, fecha_publicacion FROM libros WHERE fecha_publicacion BETWEEN '1995-01-01' AND '2015-01-31';


-- OR OR OR OR ... 'Ojos de fuego', 'Cujo', 'El hobbit', 'La torre oscura 7 La torre oscura'
SELECT * FROM libros WHERE titulo IN ('Ojos de fuego',
                                              'Cujo',
                                              'El hobbit',
                                              'La torre oscura 7 La torre oscura');

-- SELECT autor_id, titulo FROM libros WHERE titulo LIKE 'H%' OR titulo LIKE 'L%';
-- SELECT autor_id, titulo FROM libros WHERE LEFT(titulo, 1) = 'H' OR LEFT(titulo, 1) = 'L';

-- SELECT titulo FROM libros WHERE titulo REGEXP '^[HL]';


-- SELECT autor_id, SUM(ventas) AS total FROM libros GROUP BY autor_id ORDER BY total ASC LIMIT 1;
