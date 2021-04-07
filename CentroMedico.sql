use CENTROMEDICO

Create table tbl_Paciente(
idPaciente int primary key not null,
nombre varchar(50),
apellido varchar(50),
fNacimiento date,
domicilio varchar(50),
idPais char(3),
telefono varchar(20),
email  varchar(30),
observacion varchar(100)
);


create table tbl_HistoriaClinica(
idHistoria int identity not null,
fechaHistoria datetime,
observacion varchar(2000),
idPaciente int,
idMedico int
Constraint PK_idHistoria Primary Key(idHistoria)
);
---PERMITE ELIMINAR LAS COLUMNAS
Alter table tbl_Historiaclinica DROP column idPaciente,idMedico

create table tbl_HistoriaPaciente(
idHistoria int not null,
idPaciente int not null,
idMedico int not null,
constraint PK_idHistoria_1 primary key(idHistoria,idPaciente,idMedico)
);


create table tbl_Turno(
idTurno int identity not null,
fechaTurno datetime,
estado smallint,
observacion varchar(300)
constraint PK_idTurno primary key(idTurno)
);

create table tbl_TurnoEstado(
idestado int identity(1,1) primary key not null,
descripcion varchar(300)
);

create table tbl_TurnoPaciente(
idTurno int not null,
idPaciente int not null,
idMedico int not null,
constraint PK_idTurno_1 primary key(idTurno,idPaciente,idMedico)
);

create table tbl_Pais(
idPais char(3) not null,
pais varchar(30),
constraint PK_idPais Primary key(idPais)
);

create table tbl_Especialidad(
idEspecialidad int identity not null,
especialidad varchar(30),
constraint PK_idEspecialidad Primary key(idEspecialidad)
);

create table tbl_Medico(
idMedico int identity not null,
nombre varchar(50),
apellido varchar(50)
constraint PK_idMedico Primary Key(idMedico)
);

create table tbl_MedicoEspecialidad(
idMedico int not null,
idEspecialidad int not null,
descripcion varchar(300),
constraint PK_idMedico_1 Primary key(idMedico,idEspecialidad)
);

create table tbl_Pago(
idPago int identity(1,1) not null Primary key,
concepto tinyint not null,
fecha datetime not null,
monto money not null,
estado tinyint not null,
observacion varchar(1000)
);

--Otra forma de crear las llaves compuestas sin usar el constraint
create table tbl_PagoPaciente(
idPago int not null,
idPaciente int not null,
idTurno int not null,
PRIMARY KEY(idPago,idPaciente,idTurno)
);

create table tbl_Concepto(
idConcepto int identity(1,1) not null primary key,
descripcion varchar(100) not null
);


--Comando para reiniciar la cuenta de un incremental del identity
--primero se debe eliminar todos los registros de la tabla
use CENTROMEDICO
create table tabla1(
idcodigo int identity primary key not null,
descripcion varchar(60)
);

select * from tabla1;
insert into tabla1 values('Hola')
 delete from tabla1
  

dbcc CHECKIDENT('tabla1',RESEED,0);


--- Haciendo Uso del comando Insert
select * from tbl_Paciente

--Hacemos la insercion de datos a tabla pais
select * from tbl_Pais
insert into tbl_Pais 
values
(100,'Peru'),
(101,'Chile'),
(102,'Argentina'),
(103,'Brasil'),
(104,'Colombia'),
(105,'Ecuador');

update tbl_Pais SET pais='Ecuador' where idPais=105

-- Hacemos la insercion de datos en la tabla Paciente
select * from tbl_Paciente
insert into tbl_Paciente 
values
(200,'Avimael','Gervacio Requena','17/07/1995','Huacho',100,'921873007','avimael95@gmail.com','Ninguna'),
(201,'Juan','Gamarra Solis','17/07/1996','Lima',100,'921873007','Juan5@gmail.com','Ninguna'),
(202,'Carlos','Perez Requena','17/07/1997','Barranca',102,'921873007','Carlos97@gmail.com','Ninguna'),
(203,'Navila','Quiñones Vasquez','17/07/1998','Cajamarca',103,'921873007','navila98@gmail.com','Ninguna'),
(204,'Jhadira','Suni Maguiña','17/07/1999','Puno',101,'921873007','Jhadira99@gmail.com','Ninguna'),
(205,'Licet','Inocente Gamarra','17/07/1992','Ucayali',104,'921873007','Licet92@gmail.com','Ninguna'),
(206,'Rosita','Orbegozo Diaz','17/07/1996','Huacho',100,'921873007','Rosita96@gmail.com','Ninguna');

--Hacemos la inserción de datos tabla Turno Estado-------------
select * from tbl_TurnoEstado
insert into tbl_TurnoEstado 
values
('Nueva'),
('Sin Confirmar'),
('Confirmada'),
('No se presentó'),
('Cancelada/Reagendada');
---CHECKIDENT(([NombreDeTuTabla], RESEED,400) Con este vamos a decirle a sql que el campo va iniciar en 400
dbcc CHECKIDENT('tbl_TurnoEstado',RESEED,400)

---Hacemos la inserción de datos a la tabla Turno
select * from tbl_Turno
dbcc CHECKIDENT('tbl_Turno',RESEED,500)
Insert into tbl_Turno
values
('07/12/2019',404,'Sin observacion'),
('07/04/2020',402,'Sin observacion'),
('07/04/2020',402,'Sin observacion'),
('07/04/2020',401,'Sin observacion');


----HACIENDO USO DE LAS CLAUSULAS SQL------------------
---======CLAUSULA WHERE: Nos permite filtrar de acuerdo a la condicion que le podemos facilitar
--1.SELECCIONAR LOS PACIENTES CON EN SU NOMBRE CONTENGAN LA LETRA "A"
SELECT * FROM tbl_Paciente WHERE nombre like '%a'
---2.-SELECCIONAR A LAS PACIENTES QUE TENGAN 25 AÑOS CON SUS RESPECTIVOS PAISES
SELECT p.nombre,p.apellido,pa.pais, DATEDIFF(YEAR,fNacimiento,GETDATE()) as Edad 
FROM tbl_Paciente p
INNER JOIN tbl_Pais pa ON p.idPais=pa.idPais
WHERE DATEDIFF(YEAR,fNacimiento,GETDATE())=25

---HACIENDO USO DE LA CLASULA TOP -------------------
---TOP:Nos permite mostrar una cierta cantidad de registros 
select * from tbl_Paciente
SELECT TOP 3 nombre,apellido,domicilio,telefono FROM tbl_Paciente
---Se puede colocar los campos o el *(Todo el registro) para decirle que campos queremos que se muestre
select Top 3 * from tbl_Paciente

--SE PIDE MOSTRAR EL ÚLTIMO TURNO O EL TURNO MÁS RECIENTE
--Haremos uso de la clausula TOP
SELECT * FROM tbl_Turno
select TOP 1 * from tbl_Turno order by fechaTurno desc

---Haciendo uso de la clausuala ORDER BY
--Nota: Está clausuala nos permite ordenar de dos maneras ascendentemente y Descendentemente
--Ejercicio: Se pide ordenar a los paciendes alfabeticamente por su nombre
select * from tbl_Paciente order by nombre asc

/*
  CLAUSULA: DISTINCT
  Nota: La claúsula DISTINCT nos devuelve valores únicos. En una tabla, una columna puede contener valores duplicados; 
  y algunas veces sólo se necesita un listado de los valores diferentes.
*/
select * from tbl_Paciente

insert into tbl_Paciente 
values 
(210,'Avimael','Gervacio Requena','10/06/1993','Huacho',100,'921876004','avimael97@gmail.com','En falta');

select distinct nombre,apellido from tbl_Paciente

/*
CLAUSULA: GROUP BY
Nota: La función GROUP BY se utiliza para juntar filas de resultados que coincidan en el valor de alguna columna seleccionada
*/

SELECT * FROM tbl_Paciente
SELECT * FROM tbl_Concepto

INSERT INTO tbl_Concepto VALUES
('Cosulta Medica'),
('Cirugia'),
('Ortodoncia'),
('Oftamologia');



