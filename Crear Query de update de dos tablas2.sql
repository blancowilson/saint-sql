DECLARE @db1 NVARCHAR(100) = 'SEA_InversionesHJDB';
DECLARE @db2 NVARCHAR(100) = 'bd2';
DECLARE @tableName NVARCHAR(100) = 'tabla1';
DECLARE @sql NVARCHAR(MAX);
DECLARE @columnName NVARCHAR(100);
DECLARE @updateSql NVARCHAR(MAX);

-- Crear una tabla temporal para almacenar las columnas
CREATE TABLE #Columns (
    ColumnName NVARCHAR(100)
);

-- Insertar las columnas de la tabla en la tabla temporal
SET @sql = 'INSERT INTO #Columns (ColumnName)
            SELECT COLUMN_NAME
            FROM ' + @db1 + '.INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = ''' + @tableName + '''';

EXEC sp_executesql @sql;

-- Inicializar la consulta de actualización
SET @updateSql = 'UPDATE ' + @db1 + '.dbo.' + @tableName + '
                  SET ';

-- Declarar un cursor para iterar sobre las columnas
DECLARE columnCursor CURSOR FOR
SELECT ColumnName FROM #Columns;

OPEN columnCursor;
FETCH NEXT FROM columnCursor INTO @columnName;

-- Construir la consulta de actualización
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @updateSql = @updateSql + @db1 + '.dbo.' + @tableName + '.' + @columnName + ' = ' + @db2 + '.dbo.' + @tableName + '.' + @columnName + ', ';
    FETCH NEXT FROM columnCursor INTO @columnName;
END

-- Eliminar la última coma y espacio
SET @updateSql = LEFT(@updateSql, LEN(@updateSql) - 2);

-- Añadir la cláusula FROM y la condición de unión
SET @updateSql = @updateSql + '
                  FROM ' + @db1 + '.dbo.' + @tableName + '
                  INNER JOIN ' + @db2 + '.dbo.' + @tableName + '
                  ON ' + @db1 + '.dbo.' + @tableName + '.PrimaryKeyColumn = ' + @db2 + '.dbo.' + @tableName + '.PrimaryKeyColumn';

-- Ejecutar la consulta de actualización


print @updateSql

--EXEC sp_executesql @updateSql;



-- Cerrar y desechar el cursor
CLOSE columnCursor;
DEALLOCATE columnCursor;

-- Eliminar la tabla temporal
DROP TABLE #Columns;
