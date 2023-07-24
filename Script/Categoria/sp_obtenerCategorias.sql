IF EXISTS (SELECT * FROM SYSOBJECTS WHERE name = 'sp_ObtenerCategorias')
BEGIN
	DROP PROCEDURE sp_ObtenerCategorias;
END

GO

CREATE PROCEDURE sp_ObtenerCategorias
	@pCodigo VARCHAR(10) = NULL,
	@pNombre VARCHAR(1000) = NULL,
	@ppage INT,
	@pcount INT
AS
DECLARE 
	 @consulta VARCHAR(MAX) = NULL
BEGIN
	SET @pCodigo = REPLACE(@pCodigo, '''', '''''');
	SET @pNombre = REPLACE(@pNombre, '''', '''''');
	SET @consulta = 'SELECT id_Categoria, codigo, nombre FROM CATEGORIA WHERE estado = ''A''';

	IF(@pCodigo IS NOT NULL AND @pCodigo <> '')
	BEGIN
		SET @consulta = @consulta + ' AND codigo LIKE ''%' + @pCodigo + '%''';
	END
	
	IF(@pNombre IS NOT NULL AND @pNombre <> '')
	BEGIN
		SET @consulta = @consulta + ' AND nombre LIKE ''%' + @pNombre + '%''';
	END

	SET @consulta = @consulta + ' ORDER BY nombre';

	IF(@ppage IS NOT NULL AND @pcount IS NOT NULL)
	BEGIN
		SET @consulta = @consulta + ' OFFSET ' + CONVERT(VARCHAR, (@ppage - 1) * @pcount)
			+ ' ROWS FETCH NEXT ' + CONVERT(VARCHAR, @pcount) + ' ROWS ONLY';
	END

	SET @consulta = @consulta + ';'
	EXECUTE SP_SQLEXEC @consulta;
END