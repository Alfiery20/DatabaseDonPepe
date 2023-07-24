IF EXISTS (SELECT * FROM SYSOBJECTS WHERE name = 'sp_VerCategoria')
BEGIN
	DROP PROCEDURE sp_VerCategoria;
END

GO

CREATE PROCEDURE sp_VerCategoria
	@pId SMALLINT = NULL
AS
DECLARE 
	 @consulta VARCHAR(MAX) = NULL
BEGIN
	SET @consulta = 'SELECT id_Categoria, codigo, nombre FROM CATEGORIA WHERE 1 = 1';

	IF(@pId IS NOT NULL AND @pId <> '')
	BEGIN
		SET @consulta = @consulta + ' AND id_Categoria = ' + CONVERT(VARCHAR, @pId) + ';';
	END

	SET @consulta = @consulta + ';'
	EXECUTE SP_SQLEXEC @consulta;
END