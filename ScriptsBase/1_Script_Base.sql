CREATE TABLE sistema_informacion (
    id_sistema integer IDENTITY(1,1) NOT NULL,
    nombre varchar(15) NOT NULL
);

ALTER TABLE sistema_informacion ADD CONSTRAINT sistema_informacion_pkey PRIMARY KEY (id_sistema);

CREATE TABLE rol (
    id_rol integer IDENTITY(1,1) NOT NULL,
    nombre varchar(50) NOT NULL,
    sistema integer  NOT NULL
);

ALTER TABLE rol ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);

ALTER TABLE rol ADD CONSTRAINT rol_sistema_fkey FOREIGN KEY (sistema) REFERENCES sistema_informacion(id_sistema);

CREATE TABLE usuario (
	id integer IDENTITY(1,1),
	cedula varchar(9) NOT NULL UNIQUE,
    correo_electronico varchar(100) NOT NULL UNIQUE,
    contrasenna varchar(MAX) NOT NULL,
    primer_nombre varchar(20) NOT NULL,
    segundo_nombre varchar(20) NULL,
    primer_apellido varchar(20) NOT NULL,
    segundo_apellido varchar(20) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);

CREATE TABLE roles_por_usuario (
    usuario integer NOT NULL,
    rol integer NOT NULL
);

ALTER TABLE roles_por_usuario ADD CONSTRAINT roles_por_usuario_pkey PRIMARY KEY (usuario, rol);

ALTER TABLE roles_por_usuario ADD CONSTRAINT rol_rol_p_usario_fkey FOREIGN KEY (rol) REFERENCES rol(id_rol);

ALTER TABLE roles_por_usuario ADD CONSTRAINT email_rol_p_usario_fkey FOREIGN KEY (usuario) REFERENCES usuario(id);

CREATE TABLE estudiantes (
	carne varchar(11) NOT NULL,
	correo_electronico varchar(100) NOT NULL UNIQUE,
	primer_nombre varchar(20) NOT NULL,
    segundo_nombre varchar(20) NULL,
    primer_apellido varchar(20) NOT NULL,
    segundo_apellido varchar(20) NOT NULL
)

ALTER TABLE estudiantes ADD CONSTRAINT estudiantes_pkey PRIMARY KEY (carne);

INSERT sistema_informacion (nombre) VALUES ('Inclusiones');
INSERT sistema_informacion (nombre) VALUES ('Horas Beca');

INSERT rol (nombre, sistema) VALUES ('Administrador Inclusiones', 1);
INSERT rol (nombre, sistema) VALUES ('Administrador Horas Beca', 2);

INSERT usuario (correo_electronico, cedula, contrasenna, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido) VALUES ('lcortes@itcr.ac.cr', '116608924','ZzZEihOPJEsejtOvvwwgZznM/Qd4X6gCC0YVI3W98uNOjIJYETb7a6thErlkUWtbvUP/HTV1TCiX+dy2gSnHWRdUbQPgWimmBZdAhHs0+87+WQRo/sH0VGop6bbTDens', 'Laura', 'Maria', 'Cortes', 'Ugalde');

INSERT roles_por_usuario (usuario, rol) VALUES (1, 1);
INSERT roles_por_usuario (usuario, rol) VALUES (1, 2);

INSERT estudiantes (carne, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, correo_electronico) VALUES ('2015028430', 'David', 'Eduardo', 'Gomez', 'Vargas', 'daedgomez@gmail.com')


/*---------------------------------------------------------------------------------------*/
INSERT rol (nombre, sistema) VALUES ('Administrador Comisión', 2);
INSERT rol (nombre, sistema) VALUES ('Responsable', 2);
INSERT rol (nombre, sistema) VALUES ('Asistente', 2);

INSERT usuario (correo_electronico, cedula, contrasenna, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido) VALUES ('N/A', 'N/A','N/A', 'N/A', 'N/A', 'N/A', 'N/A');


CREATE TABLE curso (
    codigo_curso varchar(10) NOT NULL,
    nombre_curso varchar(max) NOT NULL,
	activo bit not null
);

CREATE TABLE solicitud_general (
	id_sol_gen int IDENTITY(1,1) PRIMARY KEY,
	cedula_est int,
	id_carrera int not null,
	prom_pond_gen float not null,
	prom_pond_sem float not null,
	creds_gen int not null,
	creds_sem int not null,
	cuenta_banco int not null,
	banco varchar(20) not null,
	fecha_solicitud datetime not null,
	prom_pond_gen_img varbinary(max) not null,
	prom_pond_sem_img varbinary(max) not null,
	creds_gen_img varbinary(max) not null,
	creds_sem_img varbinary(max) not null,
	cuenta_banco_img varbinary(max) not null,
	cedula_img varbinary(max) not null,
	carne_img varbinary(max) not null,
	anios_TEC int not null,
	telefono int not null,
	estado int not null,
	horas_cumplidas float not null,
	comentario varchar(max) null,
	activo bit not null
	
);

CREATE TABLE solicitud_estudiante ( /*Mover las imagenes a solicitud general*/
	id_sol int IDENTITY(1,1) PRIMARY KEY,
	id_estudiante varchar(11) not null,
	id_sol_general int not null,
	horas int,
	activo bit not null
);

CREATE TABLE solicitud_asistente (
	id_sol int IDENTITY(1,1) PRIMARY KEY,
	id_estudiante varchar(11) not null,
	id_sol_general int not null,
	id_curso varchar(10) not null,
	horas int,
	id_prof_asistir int not null,
	nota_curso_asist int not null,
	nota_curso_asist_img varbinary(max) not null,
	activo bit not null
);

CREATE TABLE solicitud_tutoria (
	id_sol int IDENTITY(1,1) PRIMARY KEY,
	id_estudiante varchar(11) not null,
	id_sol_general int not null,
	id_curso varchar(10) not null,
	horas int,
	nota_curso_tut int not null,
	id_prof_asistir int, /*Lo incluye area academica*/
	nota_curso_tut_img varbinary(max) not null,
	activo bit not null

);

CREATE TABLE solicitud_especial (
	id_sol int IDENTITY(1,1) PRIMARY KEY,
	id_estudiante varchar(11) not null,
	id_sol_general int not null,
	horas_solicitadas int,
	horas_asignadas int,
	activo bit not null
);

CREATE TABLE estados_solicitud (
	id_estado int PRIMARY KEY,
	nombre varchar(max),
	activo bit not null
);

CREATE TABLE otras_asistencias (
	id_otras_asistencia int IDENTITY(1,1) PRIMARY KEY,
	id_estudiante varchar(11),
	id_sol_gen int,
	horas int,
	descripcion varchar(max),
	activo bit not null
);
CREATE TABLE control_estudiante(
	id_control int IDENTITY(1,1) PRIMARY KEY,
	id_estudiante varchar(11) not null,
	id_profesor int not null,
	comentario varchar(max) null,
	horas_cumplidas float null,
	activo bit not null

);

CREATE TABLE config(
	id_periodo int IDENTITY(1,1) PRIMARY KEY,
	fecha_apertura datetime not null,
	fecha_cierre datetime not null,
	activo bit not null
);

CREATE TABLE carrera(
	id_carrera int IDENTITY(1,1) PRIMARY KEY,
	nombre varchar(max) not null,
	activo bit not null
);

/*
CREATE TABLE comentario_solicitud(
	id_comentario int IDENTITY(1,1) PRIMARY KEY,
	id_sol_gen varchar(11) not null,
	comentario varchar(max) null,
	activo bit not null

);*/

/*ALTER TABLE comentario_solicitud ADD CONSTRAINT ComentSol_x_SolGeneral FOREIGN KEY (id_sol_gen) REFERENCES solicitud_general(id_sol_gen);*/

ALTER TABLE control_estudiante ADD CONSTRAINT ContEst_x_Estudiante FOREIGN KEY (id_estudiante ) REFERENCES estudiantes(carne);
ALTER TABLE control_estudiante ADD CONSTRAINT ContEst_x_Usuario FOREIGN KEY (id_profesor ) REFERENCES usuario(id);

ALTER TABLE curso ADD CONSTRAINT codigo_curso PRIMARY KEY (codigo_curso);

ALTER TABLE solicitud_estudiante ADD CONSTRAINT SolEst_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuto_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
ALTER TABLE solicitud_especial ADD CONSTRAINT SolEsp_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);

ALTER TABLE solicitud_estudiante ADD CONSTRAINT SolEst_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);
ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuto_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);
ALTER TABLE solicitud_especial ADD CONSTRAINT SolEsp_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);

ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_Profesor FOREIGN KEY (id_prof_asistir) REFERENCES usuario(id);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuto_x_Profesor FOREIGN KEY (id_prof_asistir) REFERENCES usuario(id);

ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_Curso FOREIGN KEY (id_curso) REFERENCES curso(codigo_curso);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuto_x_Curso FOREIGN KEY (id_curso) REFERENCES curso(codigo_curso);

ALTER TABLE solicitud_general ADD CONSTRAINT SolGen_x_Estado FOREIGN KEY (estado) REFERENCES estados_solicitud(id_estado); 
ALTER TABLE solicitud_general ADD CONSTRAINT SolGen_x_Carrera FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera);

ALTER TABLE otras_asistencias ADD CONSTRAINT OtrasAsistencias_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
