-- ================================
-- Create User-defined Table Type
-- ================================
USE [BecasCE]
GO

-- Create the data type
CREATE TYPE [dbo].[SolicitudWrapper] AS TABLE (
			cedula int null,
			carrera int null,
			proPonGeneral float null,
			proPonSemestral float null,
			creditosGeneral int null,
			creditosSemestre int null,
			cuentaBanco int null,
			banco varchar(max) null,
			carne varchar(11) null,
			horas int null,
			imgPpg varbinary(max) null,
			imgPps varbinary(max) null,
			imgCg varbinary(max) null,
			imgCs varbinary(max) null,
			imgCBanco varbinary(max) null,
			imgCed varbinary(max) null,
			imgCar varbinary(max) null,
			idCurso varchar(10) null,
			idProfesor int null,
			notaCurso float null,
			imgNotaCurso varbinary(max) null,
			fecha datetime null,
			telefono int null,
			anosTEC float null,
			estado int null
)
GO

CREATE TYPE [dbo].[OtrasAsistenciasWrapper] AS TABLE (
			/*contador int null,*/
			/*id_estudiante varchar(11) null,*/
			horas int null,
			descripcion varchar(max)
)
GO

CREATE TYPE [dbo].[AsistenciasResponsableWrapper] AS TABLE (
			/*contador int null,*/
			/*id_estudiante varchar(11) null,*/
			ID_sol_gen int null,
			ID_estudiante int null,
			Nombre_asistencia varchar(max)
)
GO