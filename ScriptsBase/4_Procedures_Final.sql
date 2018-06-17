-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas estudiante con Otras Asistencias>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Estudiante_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY
	
AS
BEGIN

BEGIN TRANSACTION;

BEGIN TRY


    DECLARE @sol_gen_ID int
	DECLARE @ID_estudiante varchar(11)
	
	SELECT @ID_estudiante = carne FROM @solicitudWrapper

	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_estudiante( id_estudiante, id_sol_general, horas, activo )
	SELECT carne, @sol_gen_ID, horas, 1
	FROM @solicitudWrapper


	INSERT INTO otras_asistencias(id_estudiante, id_sol_gen, horas, descripcion,activo)
	SELECT @ID_estudiante,@sol_gen_ID, horas, descripcion, 1
	FROM @AsistenciasWrapper

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
END CATCH;

END
GO

-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas estudiante>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Estudiante_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN

BEGIN TRANSACTION;

BEGIN TRY

    DECLARE @sol_gen_ID int


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_estudiante( id_estudiante, id_sol_general, horas, activo )
	SELECT carne, @sol_gen_ID, horas, 1
	FROM @solicitudWrapper

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*--------------------------------------------------------------------------------------------------------------------------*/
-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente con otras asistencias>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Asistente_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
   	DECLARE @sol_gen_ID int
	DECLARE @ID_estudiante varchar(11)


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_asistente( id_estudiante, id_sol_general,id_curso, horas, id_prof_asistir, nota_curso_asist,nota_curso_asist_img, activo )
	SELECT carne, @sol_gen_ID, idCurso,  horas, idProfesor,notaCurso,imgNotaCurso, 1
	FROM @solicitudWrapper

	INSERT INTO otras_asistencias(id_estudiante, id_sol_gen, horas, descripcion,activo)
	SELECT @ID_estudiante,@sol_gen_ID, horas, descripcion, 1
	FROM @AsistenciasWrapper
   
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;



END
GO

-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Asistente_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
   	DECLARE @sol_gen_ID int


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_asistente( id_estudiante, id_sol_general,id_curso, horas, id_prof_asistir, nota_curso_asist,nota_curso_asist_img, activo )
	SELECT carne, @sol_gen_ID, idCurso,  horas, idProfesor,notaCurso,imgNotaCurso, 1
	FROM @solicitudWrapper
   
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;



END
GO
/*---------------------------------------------------------------------------------------------------------------------------------------*/
-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Tutor_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY
	
AS
BEGIN

	BEGIN TRANSACTION;

BEGIN TRY
   	DECLARE @sol_gen_ID int
	DECLARE @ID_estudiante varchar(11)


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_tutoria( id_estudiante, id_sol_general,id_curso, horas, nota_curso_tut, id_prof_asistir,nota_curso_tut_img, activo )
	SELECT carne, @sol_gen_ID, idCurso,  horas,notaCurso, idProfesor,imgNotaCurso, 1
	FROM @solicitudWrapper

	INSERT INTO otras_asistencias(id_estudiante, id_sol_gen, horas, descripcion,activo)
	SELECT @ID_estudiante,@sol_gen_ID, horas, descripcion, 1
	FROM @AsistenciasWrapper

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;



END
GO

-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Tutor_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN

	BEGIN TRANSACTION;

BEGIN TRY
   	DECLARE @sol_gen_ID int


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_tutoria( id_estudiante, id_sol_general,id_curso, horas, nota_curso_tut, id_prof_asistir,nota_curso_tut_img, activo )
	SELECT carne, @sol_gen_ID, idCurso,  horas,notaCurso, idProfesor,imgNotaCurso, 1
	FROM @solicitudWrapper

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;



END
GO
/*---------------------------------------------------------------------------------------------------------------------------------------*/

-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Especial_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @sol_gen_ID int
	DECLARE @ID_estudiante varchar(11)


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_especial( id_estudiante, id_sol_general, horas_solicitadas,horas_asignadas, activo )
	SELECT carne, @sol_gen_ID, horas,0 , 1
	FROM @solicitudWrapper	
	
	
	INSERT INTO otras_asistencias(id_estudiante, id_sol_gen, horas, descripcion,activo)
	SELECT @ID_estudiante,@sol_gen_ID, horas, descripcion, 1
	FROM @AsistenciasWrapper

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;



END
GO


-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Especial_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @sol_gen_ID int


	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_especial( id_estudiante, id_sol_general, horas_solicitadas,horas_asignadas, activo )
	SELECT carne, @sol_gen_ID, horas,0 , 1
	FROM @solicitudWrapper

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;



END
GO
/*---------------------------------------------------------------------------------------------------------------------------------------*/
/*
CREATE PROCEDURE Insert_Otras_Asistencias_UDP
	-- Add the parameters for the stored procedure here
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

declare @idColumn int

select @idColumn = min(contador) from @AsistenciasWrapper

while @idColumn is not null
begin
	INSERT INTO otras_asistencias(id_estudiante,horas, descripcion,activo)
	SELECT id_estudiante, horas, descripcion, 1
	FROM @AsistenciasWrapper
	WHERE contador = @idColumn

    SELECT @idColumn = min( contador ) from @AsistenciasWrapper where contador > @idColumn
end


COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO
*/
/*---------------------------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE Select_SolicitudesEspecialxCarne_Borrador_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,horas_solicitadas,horas_asignadas,horas_cumplidas,comentario
FROM ((solicitud_general FULL OUTER JOIN solicitud_especial ON solicitud_general.id_sol_gen = solicitud_especial.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera)
WHERE solicitud_general.activo = '1' AND solicitud_especial.activo = '1' AND solicitud_especial.id_estudiante = @carne AND solicitud_general.estado = '0'
FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

CREATE PROCEDURE Select_SolicitudesEspecialxCarne_Historial_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,horas_solicitadas,horas_asignadas,horas_cumplidas,comentario
FROM ((solicitud_general FULL OUTER JOIN solicitud_especial ON solicitud_general.id_sol_gen = solicitud_especial.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera)
WHERE solicitud_general.activo = '1' AND solicitud_especial.activo = '1' AND solicitud_especial.id_estudiante = @carne AND solicitud_general.estado != '0'
FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO
/*-------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE Select_SolicitudesTuroriaxCarne_Borrador_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,id_curso,nombre_curso,nota_curso_tut,nota_curso_tut_img,horas, nota_curso_tut,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_tutoria ON solicitud_general.id_sol_gen = solicitud_tutoria.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_tutoria.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_tutoria.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_tutoria.activo = '1' AND solicitud_tutoria.id_estudiante = @carne AND solicitud_general.estado = '0'
COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

CREATE PROCEDURE Select_SolicitudesTuroriaxCarne_Historial_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,id_curso,nombre_curso,nota_curso_tut,nota_curso_tut_img,horas, nota_curso_tut,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_tutoria ON solicitud_general.id_sol_gen = solicitud_tutoria.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_tutoria.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_tutoria.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_tutoria.activo = '1' AND solicitud_tutoria.id_estudiante = @carne AND solicitud_general.estado != '0'
COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE Select_SolicitudesAsistentexCarne_Borrador_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,id_curso,nombre_curso,nota_curso_asist_img,horas, nota_curso_asist,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_asistente ON solicitud_general.id_sol_gen = solicitud_asistente.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_asistente.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_asistente.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_asistente.activo = '1' AND solicitud_asistente.id_estudiante = @carne AND solicitud_general.estado = '0'
COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

CREATE PROCEDURE Select_SolicitudesAsistentexCarne_Historial_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,id_curso,nombre_curso,nota_curso_asist,nota_curso_asist_img,horas,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_asistente ON solicitud_general.id_sol_gen = solicitud_asistente.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_asistente.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_asistente.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_asistente.activo = '1' AND solicitud_asistente.id_estudiante = @carne AND solicitud_general.estado != '0'
COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE Select_SolicitudesEstudiantexCarne_Borrador_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,horas,horas_cumplidas,comentario
FROM ((solicitud_general FULL OUTER JOIN solicitud_estudiante ON solicitud_general.id_sol_gen = solicitud_estudiante.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera)
WHERE solicitud_general.activo = '1' AND solicitud_estudiante.activo = '1' AND solicitud_estudiante.id_estudiante = @carne AND solicitud_general.estado = '0'
FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

CREATE PROCEDURE Select_SolicitudesEstudiantexCarne_Historial_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,horas,horas_cumplidas,comentario
FROM ((solicitud_general FULL OUTER JOIN solicitud_estudiante ON solicitud_general.id_sol_gen = solicitud_estudiante.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera)
WHERE solicitud_general.activo = '1' AND solicitud_estudiante.activo = '1' AND solicitud_estudiante.id_estudiante = @carne AND solicitud_general.estado != '0'
FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE Update_Estado_Solicitud_UDP
	-- Add the parameters for the stored procedure here
	@id_solicitud int,
	@id_estado int,
	@comentario varchar(max)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

	UPDATE solicitud_general SET estado = @id_estado WHERE id_sol_gen = @id_solicitud
	UPDATE solicitud_general SET comentario = @comentario WHERE id_sol_gen = @id_solicitud

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO


/*-------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE Delete_Solicitud_UDP
	-- Add the parameters for the stored procedure here
	@id_solicitud int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

	UPDATE solicitud_general SET activo = '0' WHERE id_sol_gen = @id_solicitud

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------------------------------------------------------------------------*/