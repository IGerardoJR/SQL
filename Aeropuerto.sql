-- Script para la creacion de una base de datos completa de un Aeropuerto y sus 
-- Distintas areas.

-- Autor : Isaias Gerardo Cordova Palomares
-- Fecha original de creacion : Junio 2020
-- Creamos la base de datos con el siguiente comando
create database Aeropuerto;
-- Usamos la base de datos creada
use Aeropuerto;
-- ENTIDADES FUERTES
-- Creacion de tabla aerolinea
create table aerolinea(
claveAero  varchar(20) primary key not null,
nombAero1  varchar(20)
);

-- Creacion de tabla avion
create table avion(
claveAvion	 varchar(20) primary key not null,
tipoAvion   	varchar(20),
numPasajeros	 int,
nombreCia	 varchar(20),
claveAero   varchar(20),
foreign key(claveAero) references aerolinea(claveAero)
); -- //1:M

-- Creacion de tabla vuelo
create table vuelo(
claveVue varchar(20) primary key not null,
estadoV  varchar(20),
tipoV	 varchar(20)
);

-- Creacion de tabla reservaciones
create table reservaciones(
claveRes varchar(20) primary key not null ,
horarioV datetime,
fechaV 	date,
costoReserv double
);

-- Creacion de tabla tarjeta
create table tarjeta(
numTarjeta varchar(20) primary key not null,
fechaVenc  date,
añoIni     int,
tipoTarj   varchar(20),
nombTitular varchar(20),
claveRes   varchar(20),
foreign key (claveRes) references reservaciones(claveRes)
); -- 1:M

-- ENTIDADES DEBILES
-- Creacion de tabla tarifa
create table tarifa(
claveVue varchar(20) not null,
costo double,
tipoC varchar(20),
impuestos double,
primary key(claveVue),
foreign key (claveVue) references vuelo(claveVue)
); -- 1:M

-- Creacion de tabla asiento
create table asiento(
claveVue varchar(20) not null,
categoria varchar(10),
letra_num 	varchar(10),
fila	int,
primary key(claveVue),
foreign key (claveVue) references vuelo(claveVue)
); -- 1:M

-- Creacion de tabla aeropuerto
create table aeropuerto(
claveVue varchar(20) not null,
nombAero varchar(20),
cdAero 	 varchar(20),
paisAero varchar(20),
calleAero varchar(20),
numAero	  int,
colAero   varchar(20),
cpAero	varchar(20),
horaD	int,
diaD	int,
horaO 	int,
diaO	int,
primary key(claveVue),
foreign key (claveVue) references vuelo(claveVue)
); -- 1:1 , 1:1

-- Creacion de tabla cliente
create table cliente(
claveRes varchar(20) not null,
emailCte varchar(20),
contraseña varchar(20),
nombreCte	varchar(20),
apPatCte	varchar(20),
apMatCte	varchar(20),
calle 	varchar(20),
num		int,
col		varchar(20),
cp		varchar(20),
cd		varchar(20),
paisCte	varchar(20),
primary key(claveRes),
foreign key (claveRes) references reservaciones(claveRes)
);

-- Creacion de tabla pago 
create table pago(
numTarjeta varchar(20)not null,
cargoCosto double,
fechaPago  date,
tipoPago	varchar(20),
claveRes	varchar(20)not null,
primary key(numTarjeta,claveRes),
foreign key (numTarjeta) references tarjeta(numTarjeta),
foreign key (claveRes) references reservaciones(claveRes)
); -- 1:M

-- RELACIONES N:M
-- Creacion de tabla avion_vuelo utiliza las tablas de avion y la de vuelo
create table avion_vuelo(
claveAvion varchar(20) not null,
claveVue   varchar(20) not null,
primary key(claveAvion,claveVue),
foreign key(claveAvion) references avion(claveAvion),
foreign key(claveVue) references vuelo(claveVue)
); -- M:N

-- Creacion de tabla vuelo_reservaciones utiliza las tablas de vuelo y reservaciones
create table vuelo_reservaciones(
claveVue varchar(20) not null,
claveRes varchar(20) not null,
primary key(claveVue,claveRes),
foreign key(claveVue) references vuelo(claveVue),
foreign key(claveRes) references reservaciones(claveRes)
); -- M:N

-- Creacion de tabla reservaciones_cliente utiliza la tabla de reservaciones.
create table reservaciones_cliente(
claveRes varchar(20)not null,
primary key(claveRes),
foreign key(claveRes) references reservaciones(claveRes)
); -- M:N

create table tarjeta_pago(
numTarjeta varchar(20) not null,
primary key(numTarjeta),
foreign key(numTarjeta) references tarjeta(numTarjeta)
); -- M:N

-- ATRIBUTOS MULTIVALUADOS
create table cliente_tel(
claveRes varchar(20) not null,
telCte int,
primary key(claveRes,telCte),
foreign key(claveRes) references reservaciones(claveRes)
); -- M:N

