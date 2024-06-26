-- ####################################
-- #####Seguridad_Permisos- DIA 4######
-- ####################################

Create database mysql_dia4;
use mysql_dia4;

-- creacion de usuario campert con acceso desde cualquier parte 
create user 'camper'@'%' identified by 'campus2023';

-- revisar permisos de x usuario 
show grants for 'camper'@'%';

-- crerar tabla de personas 

create table persona ( id int primary key, nombre varchar (255), apellido varchar (255));

insert into persona (id,nombre,apellido) values (1,'Juan','Diaz');
insert into persona (id,nombre,apellido) values (2,'Daniel','Delgado');
insert into persona (id,nombre,apellido) values (3,'Alberto','Lopez');
insert into persona (id,nombre,apellido) values (4,'Jimmy','Zambrano');
insert into persona (id,nombre,apellido) values (5,'Sofia','Perez');
insert into persona (id,nombre,apellido) values (6,'Oscar','Castro');
insert into persona (id,nombre,apellido) values (7,'Jorge','Mozo');
insert into persona (id,nombre,apellido) values (8,'Dylan','Pascual');
insert into persona (id,nombre,apellido) values (9,'Lina','Jimenez');
insert into persona (id,nombre,apellido) values (10,'Andrés','Naranjo');

-- asignar a X usuario para que acceda a la tabla persona de, y 
-- base de datos
grant select on mysql_dia4.persona to 'camper'@'%';

-- refrescar permisos de la BBDD
flush privileges;

-- añadir permisos para hacer un CRUD
grant update,insert,delete on mysql2_dia2.persona to 'camper'@'%';


-- PELIGROSO: CREAR UN USUARIO CON PERMISOS A TODO DESDE CUALQUIER LADO 
-- CON MALA CONTRASEÑA
 create user 'todito'@'%' identified by 'todito';
 grant all on *.* to 'todito'@'%';
 show grants for 'todito'@'%';
 
 -- denegar todos los permisos 
revoke all on *.* from 'todito'@'%';


-- crear un limite para que solamente se hagan X consultas por hora 

alter user 'camper'@'%' with max_queries_per_hour 5;
flush privileges;

-- create user 'camper'@'%' identified by 'campus2023';


-- revisar los limites o permisos que tiene un usuario
-- a nivel motor  
select * from mysql.user; 

-- pedir un dato en especifico
select * 
from mysql.user 
where host = '%';

-- eliminar usuarios
drop user 'todito'@'%';

-- solo poner permisos para que consulte una 
-- x base de datos, una Y tabla y una Z columna 

grant select (nombre) on mysql2_dia4.persona to 'camper'@'%';  

 

