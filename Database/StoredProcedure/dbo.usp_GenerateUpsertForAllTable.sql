SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- -------------------------------------------------------------
-- EXEC [dbo].[usp_GenerateUpsertForAllTable]
CREATE PROCEDURE [dbo].[usp_GenerateUpsertForAllTable]
AS
BEGIN
 Declare @table_name  varchar (100);
  Declare @SQL NVARCHAR (MAX);
 Declare pk_cursor CURSOR FAST_FORWARD for 
    SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' and TABLE_NAME!= 'sysdiagrams';

 BEGIN TRANSACTION
 OPEN pk_cursor
 FETCH NEXT FROM pk_cursor INTO @table_name
 WHILE @@FETCH_STATUS = 0
 BEGIN
   EXEC [dbo].[usp_GenerateUpsertStodedProcedure] @TableName = @table_name
   FETCH NEXT FROM pk_cursor INTO @table_name
 END

 CLOSE pk_cursor 
 DEALLOCATE pk_cursor
 COMMIT

END; 
GO
