CREATE TABLE curso (
    codigo_curso varchar(20) NOT NULL,
    nombre_curso varchar(20) NOT NULL
);

CREATE TABLE solicitud_general (
	id_sol_gen int IDENTITY(1,1) PRIMARY KEY,
	cedula_est int,
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
	id_curso varchar(20) not null,
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
	id_curso varchar(20) not null,
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

ALTER TABLE curso ADD CONSTRAINT codigo_curso PRIMARY KEY (codigo_curso);

ALTER TABLE solicitud_estudiante ADD CONSTRAINT SolEst_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuro_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);
ALTER TABLE solicitud_especial ADD CONSTRAINT SolEsp_x_Estudiante FOREIGN KEY (id_estudiante) REFERENCES estudiantes(carne);

ALTER TABLE solicitud_estudiante ADD CONSTRAINT SolEst_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);
ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuro_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);
ALTER TABLE solicitud_especial ADD CONSTRAINT SolEsp_x_SolGeneral FOREIGN KEY (id_sol_general) REFERENCES solicitud_general(id_sol_gen);

ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_Profesor FOREIGN KEY (id_prof_asistir) REFERENCES usuario(id);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuro_x_Profesor FOREIGN KEY (id_prof_asistir) REFERENCES usuario(id);

ALTER TABLE solicitud_asistente ADD CONSTRAINT SolAsis_x_Curso FOREIGN KEY (id_curso) REFERENCES curso(codigo_curso);
ALTER TABLE solicitud_tutoria ADD CONSTRAINT SolTuro_x_Curso FOREIGN KEY (id_curso) REFERENCES curso(codigo_curso);