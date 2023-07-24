IF EXISTS (SELECT * FROM SYSOBJECTS WHERE name = 'sp_IUDCategoria')
BEGIN
	DROP PROCEDURE sp_IUDCategoria;
END

GO

CREATE PROCEDURE sp_IUDCategoria
	@pId SMALLINT = NULL,
	@pCodigo VARCHAR(2) = NULL,
	@pNombre VARCHAR(1000) = NULL,
	@pAccion CHAR(1) --I, U, D
AS
DECLARE @countCodigo SMALLINT = 0,
		@countNombre SMALLINT = 0,
		@countId SMALLINT = 0
BEGIN
	IF(@pAccion = 'I')
		BEGIN
		SELECT @countCodigo = COUNT(codigo) FROM CATEGORIA WHERE codigo = @pCodigo
		SELECT @countNombre = COUNT(nombre) FROM CATEGORIA WHERE nombre = @pNombre
			IF(@pCodigo IS NULL OR @pCodigo = '')
				BEGIN
					SELECT 'E1' AS [CODIGO], 'CODIGO VACIO' AS [MENSAJE]
				END
			ELSE IF(@pNombre IS NULL OR @pNombre = '')
				BEGIN
					SELECT 'E2' AS [CODIGO], 'NOMBRE VACIO' AS [MENSAJE]
				END
			ELSE IF(@countCodigo <> 0)
				BEGIN
					SELECT 'E3' AS [CODIGO], 'CODIGO REPETIDO' AS [MENSAJE]
				END
			ELSE IF(@countNombre <> 0)
				BEGIN
					SELECT 'E4' AS [CODIGO], 'NOMBRE REPETIDO' AS [MENSAJE]
				END
			ELSE
				BEGIN
					INSERT INTO CATEGORIA(codigo, nombre, estado) VALUES (@pCodigo, @pNombre, 'A');
					IF(@@ROWCOUNT > 0)
						BEGIN
							SELECT 'OK' AS [CODIGO], 'CATEGORIA AGREGADA CON EXITO' AS [MENSAJE]
						END
					ELSE
						BEGIN
							SELECT 'EX' AS [CODIGO], 'OPERACION FALLIDA' AS [MENSAJE]
						END
				END
		END
	ELSE IF(@pAccion = 'U')
		BEGIN
			SELECT @countNombre = COUNT(nombre) FROM CATEGORIA WHERE nombre = @pNombre
			SELECT @countId = COUNT(id_Categoria) FROM CATEGORIA WHERE id_Categoria = @pId
			IF(@pId IS NULL OR @pId = '')
				BEGIN
					SELECT 'E5' AS [CODIGO], 'NO SE HA SELECCIONADO CATEGORIA' AS [MENSAJE]
				END
			ELSE IF(@countId = 0)
				BEGIN
					SELECT 'E6' AS [CODIGO], 'CATEGORIA NO EXISTE' AS [MENSAJE]
				END
			ELSE IF(@pNombre IS NULL OR @pNombre = '')
				BEGIN
					SELECT 'E2' AS [CODIGO], 'NOMBRE VACIO' AS [MENSAJE]
				END
			ELSE IF(@countNombre <> 0)
				BEGIN
					SELECT 'E4' AS [CODIGO], 'NOMBRE REPETIDO' AS [MENSAJE]
				END
			ELSE
				BEGIN
					UPDATE CATEGORIA SET nombre = @pNombre WHERE id_Categoria = @pId
					IF(@@ROWCOUNT > 0)
						BEGIN
							SELECT 'OK' AS [CODIGO], 'CATEGORIA ACTUALIZADA CON EXITO' AS [MENSAJE]
						END
					ELSE
						BEGIN
							SELECT 'EX' AS [CODIGO], 'OPERACION FALLIDA' AS [MENSAJE]
						END
				END
		END
	ELSE IF(@pAccion = 'D')
		BEGIN
			SELECT @countId = COUNT(id_Categoria) FROM CATEGORIA WHERE id_Categoria = @pId
			IF(@pId IS NULL OR @pId = '')
				BEGIN
					SELECT 'E5' AS [CODIGO], 'NO SE HA SELECCIONADO CATEGORIA' AS [MENSAJE]
				END
			ELSE IF(@countId = 0)
				BEGIN
					SELECT 'E6' AS [CODIGO], 'CATEGORIA NO EXISTE' AS [MENSAJE]
				END
			ELSE 
				BEGIN
					UPDATE CATEGORIA SET estado = 'I' WHERE id_Categoria = @pId
					IF(@@ROWCOUNT > 0)
						BEGIN
							SELECT 'OK' AS [CODIGO], 'CATEGORIA ELIMINADA CON EXITO' AS [MENSAJE]
						END
					ELSE
						BEGIN
							SELECT 'EX' AS [CODIGO], 'OPERACION FALLIDA' AS [MENSAJE]
						END
				END
		END
END