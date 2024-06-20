-- ################################
-- ####### DIA 2-MY SQL 2 #########
-- ################################

-- CONSULTAS AVANZADAS--

create database mysql2_dia2;
use mysql2_dia2;

create table productos (
id int auto_increment,
nombre varchar (100),
precio decimal(10,2),
primary key (id)
);


insert  into productos values 
	(1,"Pepito",23.2),
    (2,"MousePad",100000.21),
    (3,"Espionap",2500.25),
    (4,"BOB-ESPONJA",1500.25),
    (5,"Cary",23540000.23),
    (6,"OvulAPP",198700.23),
    (7,"PapayAPP",2000.00),
    (8,"Menosprecio",3800.00),
    (9,"PerfumeMascotas",2300.00),
    (10,"Perfume La Cumbre", 35000.25),
    (11,"Nevera M800",3000.12),
    (12,"Crema Suave", 2845.00),
    (13,"juego de mesa La Cabellera",9800.00),
    (14,"Cargador iPhone",98000.00);

-- para crear una funcion la cual me retorne el
-- nombre del producto el precio mas iva 
-- donde si vale mas de 1000 se aplica un descuento del 20%

-- SINTAXIS DE FUNCION
delimiter //
create function TotalConIVA(precio decimal(10,2), iva decimal(5,3))
returns varchar (255) deterministic
begin
    if precio > 1000 then
        return (precio+(precio*iva))-((precio+(precio*iva))*0.2);
    else
        return precio+(precio*iva);
    end if;
end//
delimiter ;

-- utilizar la funcion  TotalConIva
select TotalConIva(25000,0.19);

-- eliminar la funcion
drop function TotalConIva; 


-- extrapolar función con datos de la base de datos 
select TotalConIva(precio,0.19) from productos;



-- EJEMPLO

-- Funcion para obtener el precio de un producto 
-- dado su nombre

delimiter //
Create function precio_producto (nombre_producto varchar (100))
returns decimal (10,2)
deterministic 
begin
	declare precio_producto decimal(10,2);
    select precio into precio_producto from productos 
    where nombre = nombre_producto;
    return precio_producto; 
end //
delimiter ;

-- utilizar funcion 
select precio_pruducto ('Pepito') as Precio;



-- calcular el precio promedio de los productos
delimiter //
create function precio_promedio ()
returns decimal (10,2)
deterministic 
begin 
declare promedio decimal (10,2);
select avg(precio) into promedio from productos;
return promedio;
end //
delimiter ;

select precio_promedio();


-- ###########################
-- ###### PROCEDIMIENTO ######
-- ###########################

-- Procedimiento para insertar un nuevo producto 
delimiter // 
create procedure insertar_producto( in nombre_producto varchar (100),
in precio_producto decimal (10,2))
begin
	insert into productos (nombre, precio)
    values (nombre_producto, precio_producto);
end //
delimiter ;

call insertar_producto('Gorra', 50000.00);


-- procedimiento para eliminar un producto dando su nombre
delimiter // 
create procedure eliminar_producto (in nombre_producto varchar (100))
begin
	delete from productos where nombre = nombre_producto;
end //
delimiter ;

call eliminar_producto('Gorra');
