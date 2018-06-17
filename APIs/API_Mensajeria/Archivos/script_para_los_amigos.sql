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
	id integer IDENTITY(1,1)
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

