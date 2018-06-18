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

	SELECT @ID_estudiante = carne FROM @solicitudWrapper

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

	SELECT @ID_estudiante = carne FROM @solicitudWrapper

	INSERT INTO solicitud_general (	cedula_est,id_carrera, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img,cedula_img, carne_img,anios_TEC,telefono, estado,horas_cumplidas,comentario, activo)
	SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado,0,'', 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_tutoria( id_estudiante, id_sol_general,id_curso, horas, nota_curso_tut, id_prof_asistir,nota_curso_tut_img, activo )
	SELECT carne, @sol_gen_ID, idCurso,  horas,notaCurso, '2',imgNotaCurso, 1
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
	SELECT carne, @sol_gen_ID, idCurso,  horas,notaCurso, '2',imgNotaCurso, 1
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
	
	SELECT @ID_estudiante = carne FROM @solicitudWrapper


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



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Periodo_UPD
		@Fecha_Inicio datetime,
		@Fecha_Cierre datetime

AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
	DECLARE @Ultimo_Periodo int
	DECLARE @Periodo_Activo bit

	SELECT @Ultimo_Periodo = max(id_periodo) FROM config 
	SELECT @Periodo_Activo = activo FROM config WHERE id_periodo = @Ultimo_Periodo

	IF (@Periodo_Activo = '1')
		BEGIN
		
		UPDATE config SET activo = '0' WHERE id_periodo = @Ultimo_Periodo
		INSERT INTO config(fecha_apertura,fecha_cierre,activo) VALUES (@Fecha_Inicio,@Fecha_Cierre,'1')
		COMMIT TRANSACTION;

		END
	ELSE
		BEGIN
		
		INSERT INTO config(fecha_apertura,fecha_cierre,activo) VALUES (@Fecha_Inicio,@Fecha_Cierre,'1')
		COMMIT TRANSACTION;

		END

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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,horas_solicitadas,horas_asignadas,horas_cumplidas,comentario
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,horas_solicitadas,horas_asignadas,horas_cumplidas,comentario
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,id_curso,nombre_curso,nota_curso_tut,nota_curso_tut_img,horas, nota_curso_tut,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_tutoria ON solicitud_general.id_sol_gen = solicitud_tutoria.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_tutoria.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_tutoria.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_tutoria.activo = '1' AND solicitud_tutoria.id_estudiante = @carne AND solicitud_general.estado = '0'
FOR JSON PATH; 
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,id_curso,nombre_curso,nota_curso_tut,nota_curso_tut_img,horas,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_tutoria ON solicitud_general.id_sol_gen = solicitud_tutoria.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_tutoria.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_tutoria.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_tutoria.activo = '1' AND solicitud_tutoria.id_estudiante = @carne AND solicitud_general.estado != '0'
FOR JSON PATH; 
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,id_curso,nombre_curso,nota_curso_asist_img,horas, nota_curso_asist,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_asistente ON solicitud_general.id_sol_gen = solicitud_asistente.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_asistente.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_asistente.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_asistente.activo = '1' AND solicitud_asistente.id_estudiante = @carne AND solicitud_general.estado = '0'
FOR JSON PATH; 
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,id_curso,nombre_curso,nota_curso_asist,nota_curso_asist_img,horas,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_asistente ON solicitud_general.id_sol_gen = solicitud_asistente.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_asistente.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_asistente.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_asistente.activo = '1' AND solicitud_asistente.id_estudiante = @carne AND solicitud_general.estado != '0'
FOR JSON PATH; 
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,horas,horas_cumplidas,comentario
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

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,horas,horas_cumplidas,comentario
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
/*---------------------------------------------Para Administración-----------------------------------------------*/

CREATE PROCEDURE Select_SolicitudesEspecial_Historial_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,horas_solicitadas,horas_asignadas,horas_cumplidas,comentario
FROM ((solicitud_general FULL OUTER JOIN solicitud_especial ON solicitud_general.id_sol_gen = solicitud_especial.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera)
WHERE solicitud_general.activo = '1' AND solicitud_especial.activo = '1' AND solicitud_general.estado != '0'
ORDER BY id_carrera ASC
FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO


CREATE PROCEDURE Select_SolicitudesTuroria_Historial_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,id_curso,nombre_curso,nota_curso_tut,nota_curso_tut_img,horas, nota_curso_tut,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_tutoria ON solicitud_general.id_sol_gen = solicitud_tutoria.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_tutoria.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_tutoria.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_tutoria.activo = '1' AND solicitud_general.estado != '0'
ORDER BY id_carrera ASC
FOR JSON PATH; 
COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO


CREATE PROCEDURE Select_SolicitudesAsistente_Historial_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,id_curso,nombre_curso,nota_curso_asist,nota_curso_asist_img,horas,id_prof_asistir,primer_apellido,segundo_apellido,primer_nombre,correo_electronico,cedula,horas_cumplidas,comentario
FROM ((((solicitud_general FULL OUTER JOIN solicitud_asistente ON solicitud_general.id_sol_gen = solicitud_asistente.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera) FULL OUTER JOIN curso ON solicitud_asistente.id_curso = curso.codigo_curso) FULL OUTER JOIN ((usuario FULL OUTER JOIN roles_por_usuario ON usuario.id = roles_por_usuario.usuario) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol) ON usuario.id = solicitud_asistente.id_prof_asistir)
WHERE solicitud_general.activo = '1' AND solicitud_asistente.activo = '1' AND solicitud_general.estado != '0'
ORDER BY id_carrera ASC
FOR JSON PATH; 
COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO



CREATE PROCEDURE Select_SolicitudesEstudiante_Historial_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,solicitud_general.id_carrera,carrera.nombre,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,cedula_img,carne_img,horas,horas_cumplidas,comentario
FROM ((solicitud_general FULL OUTER JOIN solicitud_estudiante ON solicitud_general.id_sol_gen = solicitud_estudiante.id_sol_general) FULL OUTER JOIN carrera ON solicitud_general.id_carrera = carrera.id_carrera)
WHERE solicitud_general.activo = '1' AND solicitud_estudiante.activo = '1' AND solicitud_general.estado != '0'
ORDER BY id_carrera ASC
FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------Periodo--------------------------------------------------------------*/
CREATE PROCEDURE Select_Periodo_Activo_UDP


AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT fecha_apertura,fecha_cierre,fecha_envio,num_max_horas,fecha_inicio_eval,fecha_cierre_eval
FROM config
WHERE config.activo = '1'

FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------Select todos los Periodos--------------------------------------------------------------*/

CREATE PROCEDURE Select_Periodos_UDP


AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT fecha_apertura,fecha_cierre,fecha_envio,num_max_horas,fecha_inicio_eval,fecha_cierre_eval
FROM config


FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO


CREATE PROCEDURE Insert_Periodo_Activo_UDP
@Fecha_inicio datetime,
@Fecha_cierre datetime,
@Fecha_envio datetime,
@Num_max_horas int,
@Fecha_inicio_EVAL datetime,
@Fecha_cierre_EVAL datetime
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

INSERT INTO config(fecha_apertura,fecha_cierre,fecha_envio,num_max_horas,fecha_inicio_eval,fecha_cierre_eval,activo) values (@Fecha_inicio,@Fecha_cierre,@Fecha_envio, @Num_max_horas, @Fecha_inicio_EVAL, @Fecha_cierre_EVAL,'1')


COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO
/*--------------------------------------------------Update Solicitud-----------------------------------------------------------------*/

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


/*-------------------------------------------------Delete Solicitud------------------------------------------------------------------*/

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

/*-------------------------------------------------Delete Periodo------------------------------------------------------------------*/

CREATE PROCEDURE Delete_Periodo_UDP


AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE config SET activo = '0' WHERE config.activo = '1'


COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------Extender Periodo------------------------------------------------------------------*/


CREATE PROCEDURE Update_Periodo_UDP
@ID_periodo int,
@Fecha_cierre datetime

AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE config SET fecha_cierre = @Fecha_cierre WHERE id_periodo = @ID_periodo


COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO
/*-------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE Update_Sol_Horas_Tutoria_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY,
	@ID_SOL_GEN int,
	@ID_OTRAS_ASISTENCIAS int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_tutoria
SET id_curso = j.idCurso,
horas = j.horas,
id_prof_asistir = j.idProfesor,
nota_curso_tut = j.notaCurso,
nota_curso_tut_img = j.imgNotaCurso


FROM (
    SELECT idcurso, horas, idProfesor, notaCurso,imgnotaCurso
	FROM  @solicitudWrapper) j
WHERE solicitud_tutoria.id_sol_general = @ID_SOL_GEN	

update otras_asistencias
SET horas = k.horas,
	descripcion = k.descripcion
	
FROM(
    SELECT horas,descripcion	
	FROM  @AsistenciasWrapper) K
WHERE 	otras_asistencias.id_otras_asistencia = @ID_OTRAS_ASISTENCIAS	
    
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

CREATE PROCEDURE Update_Sol_Horas_Tutoria_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@ID_SOL_GEN int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_tutoria
SET id_curso = j.idCurso,
horas = j.horas,
id_prof_asistir = j.idProfesor,
nota_curso_tut = j.notaCurso,
nota_curso_tut_img = j.imgNotaCurso


FROM (
    SELECT idcurso, horas, idProfesor, notaCurso,imgnotaCurso
	FROM  @solicitudWrapper) j
WHERE solicitud_tutoria.id_sol_general = @ID_SOL_GEN	


	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

/*----------------------------------------------------------------*/
CREATE PROCEDURE Update_Sol_Horas_Estudiante_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY,
	@ID_SOL_GEN int,
	@ID_OTRAS_ASISTENCIAS int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_estudiante
SET horas = j.horas

FROM (
    SELECT horas
	FROM  @solicitudWrapper) j
WHERE solicitud_estudiante.id_sol_general = @ID_SOL_GEN	

update otras_asistencias
SET horas = k.horas,
	descripcion = k.descripcion
	
FROM(
    SELECT horas,descripcion	
	FROM  @AsistenciasWrapper) K
WHERE 	otras_asistencias.id_otras_asistencia = @ID_OTRAS_ASISTENCIAS	
    
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

CREATE PROCEDURE Update_Sol_Horas_Estudiante_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@ID_SOL_GEN int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_estudiante
SET horas = j.horas

FROM (
    SELECT horas
	FROM  @solicitudWrapper) j
WHERE solicitud_estudiante.id_sol_general = @ID_SOL_GEN	

    
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

/*----------------------------------------------------------------*/
CREATE PROCEDURE Update_Sol_Horas_Asistente_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY,
	@ID_SOL_GEN int,
	@ID_OTRAS_ASISTENCIAS int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_asistente
SET id_curso = j.idCurso,
horas = j.horas,
id_prof_asistir = j.idProfesor,
nota_curso_asist = j.notaCurso,
nota_curso_asist_img = j.imgNotaCurso


FROM (
    SELECT idCurso, horas, idProfesor, notaCurso,imgNotaCurso
	FROM  @solicitudWrapper) j
WHERE solicitud_asistente.id_sol_general = @ID_SOL_GEN	

update otras_asistencias
SET horas = k.horas,
	descripcion = k.descripcion
	
FROM(
    SELECT horas,descripcion	
	FROM  @AsistenciasWrapper) K
WHERE 	otras_asistencias.id_otras_asistencia = @ID_OTRAS_ASISTENCIAS	
    
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

CREATE PROCEDURE Update_Sol_Horas_Asistente_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@ID_SOL_GEN int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_asistente
SET id_curso = j.idCurso,
horas = j.horas,
id_prof_asistir = j.idProfesor,
nota_curso_asist = j.notaCurso,
nota_curso_asist_img = j.imgNotaCurso


FROM (
    SELECT idCurso, horas, idProfesor, notaCurso,imgNotaCurso
	FROM  @solicitudWrapper) j
WHERE solicitud_asistente.id_sol_general = @ID_SOL_GEN	

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

CREATE PROCEDURE Update_Sol_Horas_Especial_UDP_1
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY,
	@ID_SOL_GEN int,
	@ID_OTRAS_ASISTENCIAS int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_especial
SET horas_solicitadas = j.horas

FROM (
    SELECT horas	
	FROM  @solicitudWrapper) j
WHERE solicitud_especial.id_sol_general = @ID_SOL_GEN	


update otras_asistencias
SET horas = k.horas,
	descripcion = k.descripcion
	
FROM(
    SELECT horas,descripcion	
	FROM  @AsistenciasWrapper) K
WHERE 	otras_asistencias.id_otras_asistencia = @ID_OTRAS_ASISTENCIAS	
    
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO


CREATE PROCEDURE Update_Sol_Horas_Especial_UDP_2
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@ID_SOL_GEN int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

UPDATE solicitud_general
SET cedula_est = i.cedula,
id_carrera = i.carrera, 
prom_pond_gen = i.proPonGeneral, 
prom_pond_sem = i.proPonSemestral,
creds_gen = i.creditosGeneral, 
creds_sem = i.creditosSemestre,
cuenta_banco = i.cuentaBanco, 
banco = i.banco, 
fecha_solicitud = i.fecha, 
prom_pond_gen_img = i.imgPpg, 
prom_pond_sem_img = i.imgPps,
creds_gen_img = i.imgCg, 
creds_sem_img = i.imgCs, 
cuenta_banco_img = i.imgCBanco, 
cedula_img = i.imgCed,
carne_img = i.imgCar,
anios_TEC = i.anosTEC,
telefono = i.telefono, 
estado = i.estado

FROM (
    SELECT cedula,carrera, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco, imgCed,imgCar,anosTEC,telefono, estado
	FROM  @solicitudWrapper) i
WHERE solicitud_general.id_sol_gen = @ID_SOL_GEN


UPDATE solicitud_especial
SET horas_solicitadas = j.horas

FROM (
    SELECT horas
	FROM  @solicitudWrapper) j
WHERE solicitud_especial.id_sol_general = @ID_SOL_GEN	


    COMMIT TRANSACTION;
END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;


END
GO

/*--------------------------------------------------------------------------------------*/


CREATE PROCEDURE Select_Profesores_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id, cedula, primer_nombre, primer_apellido, segundo_apellido
FROM ((usuario FULL OUTER JOIN roles_por_usuario ON roles_por_usuario.usuario = usuario.id) FULL OUTER JOIN rol ON rol.id_rol = roles_por_usuario.rol)
WHERE rol.id_rol = '4'

FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

CREATE PROCEDURE Select_Cursos_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
SELECT codigo_curso, nombre_curso
FROM curso
where curso.activo = '1'

FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

CREATE PROCEDURE Select_Carreras_UDP
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
SELECT id_carrera, nombre
FROM carrera
where carrera.activo = '1'

FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO
/*-------------------------------------------------------------------------*/

CREATE PROCEDURE Insert_Control_Estudiante_UDP
@ID_Estudiante varchar(11),
@ID_Profesor int,
@ID_Asistencia int,
@Comentario varchar(max),
@Horas int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

INSERT INTO control_estudiante(id_estudiante,id_profesor,id_asistencia, comentario, horas_cumplidas, activo) VALUES (@ID_Asistencia,@ID_Profesor,@ID_Asistencia,@Comentario,@Horas,'1')


COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO

/*-------------------------------------------------------------------------------------*/

CREATE PROCEDURE Select_Estudiantes_x_Responsable_UDP
@ID_Responsable int
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY


SELECT id_estudiante
FROM control_estudiante
where activo = '1' AND control_estudiante.id_profesor = @ID_Responsable

FOR JSON PATH; 

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO