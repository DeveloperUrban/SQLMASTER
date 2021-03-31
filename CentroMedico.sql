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













