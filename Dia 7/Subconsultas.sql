-- ######################################################
-- #######DIA 7- MySQL 2 ################################
-- ######################################################

use mysql2_dia5;


-- subconsulta Escalar: Toda subconsulta que devuelve un solo valor (fila y columna)
-- EJ: Devuelve el nombre de el país con Mayor poblacion 
select name 
from country
where Population = (select max(Population)from country); 

-- Subsonsulta de columna única: Devuelve una columna con multiples filas.
-- EJ: Encuentre los nombres de todas la ciudades en los paises  
-- que tienen un area mayor a 1000000 km2
select name 
from city 
where CountryCode in (select code from country where SurfaceArea > 1000000);

-- Subconsulta de multiples columnas: Devuelve múltiples columnas de multiples filas.
-- EJ: Encontrar las ciudades que tengan la misma poblacion y distrito
-- que cualquier ciudad del país. USA

select name, CountryCode,DIstrict, POpulation
from city 
where (district, Population) in (select District, Population from city where CountryCode= 'USA');

-- Subconsulta correlacionada: depende de la consulta externa para cada 
-- fila procesada 
-- EJ: Liste las ciudades con una poblacion mayor que el promedio de la población
-- de las ciudades en el mismo pais.
select name, CountryCode, Population
from city c1
where Population > (select avg (Population) from city c2 where c1.CountryCode = 
c2.CountryCode); 


-- INDEXACION: Es cuando quiero crear una instancia o una consulta adentro de la base de datos.


-- Crear Indice en la columna 'Name' de city 

create index idx_city_name on city(name);
select * from city; 
select name from city; 



-- TRANSACCIONES
-- Son secuencias de uno o más operaciones SQL, las cuales son ejecutadas como
-- una única unidad de trabajo. En otras palabras, las transacciones
-- aseguran que todas las operaciones se realicen de manera correcta antes
-- de ser ejecutadas en la bbdd real, buscando cumplir con las propiedades
-- ACID. (ATOMICIDAD, CONSISTENCIA, AISLAMIENTO, DURABILIDAD).

-- Primer paso : INICIAR LA TRANSACCIÓN
start transaction;
-- Segundo Paso: HACER COMANDOS
-- EJ: Actualizar la población de la ciudad de 'New York'
update city
set population = 9000000
where Name = 'New York';

select * from city where Name='New York';

-- Tercer Paso: Si quiero que los cambios se mantengan pongo COMMIT, sino
-- revierto mis cambios con ROLLBACK.
commit; -- Mandar cambios a produccion
rollback;-- Revertir cambios





