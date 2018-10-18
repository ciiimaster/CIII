SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [dbo].[usp_CreateMissingConstraints]

-- --------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_CreateMissingConstraints]
AS
 Declare @table_name  varchar (100);
 Declare @column_name varchar (100);
 Declare @pos int;
 Declare @ref_table_name varchar (100);
 Declare @ref_key_name varchar (100);
 Declare @constraint_name varchar (100) ;
 Declare @SQL varchar (500);
 Declare @exclusions varchar (1000);
 Declare pk_cursor CURSOR FAST_FORWARD for 
   SELECT COLUMNS.TABLE_NAME, COLUMNS.COLUMN_NAME  FROM INFORMATION_SCHEMA.COLUMNS COLUMNS, INFORMATION_SCHEMA.TABLES TABLES
   WHERE COLUMNS.COLUMN_NAME LIKE 'FK[_]%' AND COLUMNS.TABLE_NAME=TABLES.TABLE_NAME AND
         TABLES.TABLE_TYPE='BASE TABLE' AND  
         --COLUMNS.TABLE_NAME LIKE 'dx%' AND
         NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CONSTRAINTS
	             WHERE CONSTRAINTS.TABLE_NAME = COLUMNS.TABLE_NAME AND
                       CONSTRAINTS.COLUMN_NAME = COLUMNS.COLUMN_NAME);

 select @exclusions = ' ';
 BEGIN TRANSACTION
 OPEN pk_cursor
 FETCH NEXT FROM pk_cursor INTO @table_name, @column_name
 WHILE @@FETCH_STATUS = 0
 BEGIN
   PRINT @table_name
   IF (PATINDEX('%'+@table_name+@column_name+'%', @exclusions) = 0)
   -- BEGIN
   --   FETCH NEXT FROM pk_cursor INTO @table_name, @column_name;
   --   CONTINUE;
   --END ELSE
   BEGIN
     
     select @ref_table_name = REPLACE(@column_name, 'FK_', '');
     select @pos = PATINDEX('%[_][_]%', @ref_table_name);
     IF @pos > 0
     BEGIN
        select @ref_table_name = SUBSTRING(@ref_table_name, 1, @pos - 1)
     END
     select @ref_key_name = 'PK_' + @ref_table_name;
     select @constraint_name = 'Constraint_' + @column_name + '_' + @table_name;
     select @SQL = 'ALTER TABLE ['+
	              (SELECT  SCHEMA_NAME(schema_id) As SchemaName from sys.tables WHERE [name] = @table_name ) +
				 '].[' + @table_name + ']  ADD CONSTRAINT ' + @constraint_name +
                 ' FOREIGN KEY (' + @column_name + ') REFERENCES ['+
				 (SELECT  SCHEMA_NAME(schema_id) As SchemaName from sys.tables WHERE [name] = @ref_table_name ) +
				 '].[' + @ref_table_name + '](' + @ref_key_name + ')';
     PRINT @SQL 
     EXEC(@SQL);
   END
   FETCH NEXT FROM pk_cursor INTO @table_name, @column_name
 END

 CLOSE pk_cursor
 DEALLOCATE pk_cursor
 COMMIT
GO
