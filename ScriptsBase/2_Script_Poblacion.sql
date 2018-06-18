INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('0', 'Borrador', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('1', 'Enviado', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('2', 'Aprovado por Administración', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('3', 'Rechazado por Administración', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('4', 'Revizado por Administración', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('5', 'Aprobado por Comisión', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('6', 'Rechazado por Comisión', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('7', 'Activo en elSemestre', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('8', 'Finalizado en el Semestre', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('9', 'Corregido por el Usuario', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('10', 'Cancelado dentro de Tiempo', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('11', 'Cancelado Fuera de Tiempo', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('12', 'Pendiente de Cancelación', '1');
INSERT INTO estados_solicitud (id_estado,nombre,activo) VALUES ('13', 'Cancelación Rechazada', '1');

INSERT INTO curso(codigo_curso,nombre_curso,activo) VALUES('N/A','No Seleccionado','1');
INSERT INTO curso(codigo_curso,nombre_curso,activo) VALUES('CE4101','Especificacón y Deseño de Software','1');
INSERT INTO curso(codigo_curso,nombre_curso,activo) VALUES('CE3101','Bases de Datos','1');
INSERT INTO curso(codigo_curso,nombre_curso,activo) VALUES('CE3104','Lenguajes, Compiladores e Interpretes','1');

INSERT INTO carrera(nombre,activo) VALUES('N/A','1');
INSERT INTO carrera(nombre,activo) VALUES('CE','1');
INSERT INTO carrera(nombre,activo) VALUES('IC','1');
INSERT INTO carrera(nombre,activo) VALUES('IE','1');
INSERT INTO carrera(nombre,activo) VALUES('ATI','1');

INSERT INTO [dbo].[estudiantes]
([carne]
,[correo_electronico]
,[primer_nombre]
,[segundo_nombre]
,[primer_apellido]
,[segundo_apellido])
VALUES
('2015019679'
,'carva97valvi@gmail.com'
,'Efren'
,'Fabian'
,'Carvajal'
,'Valverde')
GO

INSERT INTO [dbo].[usuario]
([cedula]
,[correo_electronico]
,[contrasenna]
,[primer_nombre]
,[segundo_nombre]
,[primer_apellido]
,[segundo_apellido])
VALUES
('116740214'
,'carva97valvi@gmail.com'
,'12345'
,'Efren'
,'Fabian'
,'Carvajal'
,'Valverde')
GO