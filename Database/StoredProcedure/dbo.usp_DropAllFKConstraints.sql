SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DropAllFKConstraints]
AS
 Declare @table_name  varchar (100);
 Declare @constraint_name varchar (100) ;
 Declare @SQL varchar (500);
 Declare pk_cursor CURSOR FAST_FORWARD for 
    SELECT CONSTRAINTS.TABLE_NAME, CONSTRAINTS.CONSTRAINT_NAME 
    FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CONSTRAINTS
	WHERE CONSTRAINTS.COLUMN_NAME LIKE 'FK[_]%' AND CONSTRAINTS.CONSTRAINT_NAME LIKE 'Constraint_%';

 BEGIN TRANSACTION
 OPEN pk_cursor
 FETCH NEXT FROM pk_cursor INTO @table_name, @constraint_name
 WHILE @@FETCH_STATUS = 0
 BEGIN
   select @SQL = 'ALTER TABLE ' + 
    (SELECT  SCHEMA_NAME(schema_id) As SchemaName from sys.tables WHERE [name] = @table_name ) +
   '.['+@table_name + '] DROP CONSTRAINT ' + @constraint_name;
   EXEC(@SQL);
   FETCH NEXT FROM pk_cursor INTO @table_name, @constraint_name
 END

 CLOSE pk_cursor 
 DEALLOCATE pk_cursor
 COMMIT
GO
