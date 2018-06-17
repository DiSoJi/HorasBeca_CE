-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas estudiante>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Estudiante_UDP
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY,
	@AsistenciasWrapper OtrasAsistenciasWrapper READONLY
	
AS
BEGIN

BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @sol_gen_ID int
	DECLARE @ID_estudiante varchar(11)
	SET NOCOUNT ON;
	SELECT @ID_estudiante = carne FROM @solicitudWrapper

	INSERT INTO solicitud_general (	cedula_est, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img, estado,anios_TEC, activo)
	SELECT cedula, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco,anosTEC, estado, 1
	FROM @solicitudWrapper

	set @sol_gen_ID = SCOPE_IDENTITY()

	INSERT INTO solicitud_estudiante( id_estudiante, id_sol_general, horas, activo )
	SELECT carne, @sol_gen_ID, horas, 1
	FROM @solicitudWrapper


	INSERT INTO otras_asistencias(id_estudiante,horas, descripcion,activo)
	SELECT @ID_estudiante, horas, descripcion, 1
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

CREATE PROCEDURE Insert_Sol_Horas_Asistente_UDP
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
   	DECLARE @sol_gen_ID int
	SET NOCOUNT ON;

	INSERT INTO solicitud_general (	cedula_est, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img, estado,anios_TEC, activo)
	SELECT cedula, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco,anosTEC, estado, 1
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

-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Tutor_UDP
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN

	BEGIN TRANSACTION;

BEGIN TRY
   	DECLARE @sol_gen_ID int
	SET NOCOUNT ON;

	INSERT INTO solicitud_general (	cedula_est, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img, estado,anios_TEC, activo)
	SELECT cedula, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco,anosTEC, estado, 1
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

-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud de beca horas asistente>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Insert_Sol_Horas_Especial_UDP
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @sol_gen_ID int
	SET NOCOUNT ON;

	INSERT INTO solicitud_general (	cedula_est, prom_pond_gen, prom_pond_sem, creds_gen, creds_sem, cuenta_banco, banco, fecha_solicitud, prom_pond_gen_img, prom_pond_sem_img, creds_gen_img, creds_sem_img, cuenta_banco_img, estado,anios_TEC, activo)
	SELECT cedula, proPonGeneral, proPonSemestral, creditosGeneral, creditosSemestre, cuentaBanco, banco, fecha, imgPpg, imgPps,imgCg, imgCs, imgCBanco,anosTEC, estado, 1
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

CREATE PROCEDURE Select_SolicitudesEspecialxCarne_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,horas_solicitadas,horas_asignadas
FROM (solicitud_general FULL OUTER JOIN solicitud_especial ON solicitud_general.id_sol_gen = solicitud_especial.id_sol_general)
WHERE solicitud_general.activo = '1' AND solicitud_especial.activo = '1' AND solicitud_especial.id_estudiante = @carne

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO
/*
CREATE PROCEDURE Select_SolicitudesTuroriaxCarne_UDP
	-- Add the parameters for the stored procedure here
	@carne varchar(11)
	
AS
BEGIN
BEGIN TRANSACTION;

BEGIN TRY

SELECT id_sol_gen,cedula_est,prom_pond_gen,prom_pond_sem, creds_gen,creds_sem,cuenta_banco,banco,fecha_solicitud,prom_pond_gen_img,prom_pond_sem_img,creds_gen_img,creds_sem_img,cuenta_banco_img,anios_TEC,estado,id_sol,id_estudiante,horas_solicitadas,horas_asignadas
FROM (solicitud_general FULL OUTER JOIN solicitud_tutoria ON solicitud_general.id_sol_gen = solicitud_tutoria.id_sol_general) FULL OUTER JOIN curso ON solicitud_tutoria
WHERE solicitud_general.activo = '1' AND solicitud_tutoria.activo = '1' AND solicitud_tutoria.id_estudiante = @carne

COMMIT TRANSACTION;
END TRY

BEGIN CATCH

    ROLLBACK TRANSACTION;
END CATCH;

END
GO*/