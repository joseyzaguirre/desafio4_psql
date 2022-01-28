-- primero se crea la base de datos

CREATE DATABASE supermercado;

-- luego importamos la base de datos desde el archivo .sql estando parados desde la terminal en la carpeta donde se encuentra el archivo

psql -U postgres -f unidad2.sql supermercado 

-- una vez cargada la base de datos exitosamente, procedemos a realizar los requerimientos

begin transaction;
update producto set stock = stock-5 where id=9;
insert into compra (cliente_id, fecha) values (1, now());
insert into detalle_compra (producto_id, compra_id, cantidad) values (9, (select id from compra order by fecha desc limit 1), 5);
commit;
end transaction;

begin transaction;
update producto set stock = stock-3 where id=1;
update producto set stock = stock-3 where id=2;
update producto set stock = stock-3 where id=8;
insert into compra (cliente_id, fecha) values (2, now());
insert into detalle_compra (producto_id, compra_id, cantidad) values (1, (select id from compra order by fecha desc limit 1), 3);
insert into detalle_compra (producto_id, compra_id, cantidad) values (2, (select id from compra order by fecha desc limit 1), 3);
insert into detalle_compra (producto_id, compra_id, cantidad) values (8, (select id from compra order by fecha desc limit 1), 3);
commit;
end transaction; -- LA TRANSACCIÓN NO SE REALIZA PORQUE EL PRODUCTO DE ID=8 NO TIENE STOCK SUFICIENTE

\set AUTOCOMMIT off

begin;
insert into cliente (nombre, email) values ('juan', 'juan@hotmail.com');
select * from cliente;
ROLLBACK;
commit;
end transaction;

\set AUTOCOMMIT on