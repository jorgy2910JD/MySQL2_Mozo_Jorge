-- ######################################################
-- #######DIA 5- eventos y triggers #####################
-- ######################################################


use mysql2_dia5 ; 


-- trigger para insertar o actualizar una ciudad en pais con
-- la nueva población
delimiter //
create trigger after_city_insert_update
after insert on city 
for each row
begin
	update country 
	set population = population + new.population
	where code = new.countrycode;
end //
delimiter ;

-- trigger para eliminar una ciudad en pais con
-- la nueva población
delimiter //
create trigger after_city_delete
after delete on city 
for each row
begin
	update country 
	set population = population + old.population
	where code = old.countrycode;
end //
delimiter ;


-- crear una tabla para auditoria de ciudad 
create table if not exists city_audit (
audit_id int auto_increment primary key,
city_id int,
action varchar (10),
old_population int,
new_population int,
change_time timestamp default current_timestamp 
);

-- trigger para auditoria de ciudades cuando se inserta 

delimiter //
create trigger after_city_insert_audit
after insert on city 
for each row 
begin
	insert into city_audit(city_id, action, new_population)
    values (new.id, 'insert', new.population); 
end //
delimiter ;

-- test 
select * from city_audit;
insert into city (name, CountryCode, District, Population)
values ("Artemis", "AFG", "Piso 6", 1250000);


-- trigger para auditoria de ciudades cuando se actualiza
delimiter //
create trigger after_city_update_audit
after update on city 
for each row 
begin
	insert into city_audit(city_id, action, new_population)
    values (old.id, 'update',old.population, new.population); 
end //
delimiter ;

-- test 
update city set population = 1550000 where id= 4081;
select * from city_audit;



-- ########################## EVENTOS #########################

-- creacion de tablas para BK de ciudades 
create table if not exists city_backUp (
id int not null, 
name char (35) not null,
CountryCode char(3) not null,
district char(20) not null, 
pupulation int not null, 
primary key (id)
)engine = InnoDB default charset= utf8mb4;

delimiter //
create event if not exists weekly_city_backup
on schedule every 1 week
do
begin
	truncate table city_backUp;
    insert into city_backup(id,name, CountryCode, District, population)
    select id, name, CountryCode, district, Population from city;
end //
delimiter ;

