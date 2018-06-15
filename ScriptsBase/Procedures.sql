-- =============================================
-- Author:		<Diego Solís Jiménez>
-- Create date: <15/6/2018>
-- Description:	<Recibe e inserta una solicitud>
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Solicitud_Test 
	-- Add the parameters for the stored procedure here
	@solicitudWrapper SolicitudWrapper READONLY
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO test (carne,nota)
		SELECT carne, notaCurso
		FROM @solicitudWrapper

END
GO
