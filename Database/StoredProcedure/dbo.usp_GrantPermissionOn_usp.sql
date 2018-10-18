SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- --------------------------------------------------------------------------------------------
-- EXEC [dbo].[usp_GrantPermissionOn_usp]
CREATE PROCEDURE [dbo].[usp_GrantPermissionOn_usp]
AS
 Declare @usp_name  varchar (100);
 Declare @column_name varchar (100);
 Declare @pos int;
 Declare @ref_table_name varchar (100);
 Declare @ref_key_name varchar (100);
 Declare @constraint_name varchar (100) ;
 Declare @SQL varchar (500);
 Declare @exclusions varchar (1000);

 Declare pk_cursor CURSOR FAST_FORWARD for 
	 SELECT NAME
	 FROM   dbo.sysobjects
	 WHERE (type = 'P')
	 AND NAME like 'usp_%'

BEGIN TRANSACTION
	OPEN pk_cursor
	FETCH NEXT FROM pk_cursor INTO @usp_name
	WHILE @@FETCH_STATUS = 0
	BEGIN
	   --SET @SQL = 'GRANT EXECUTE ON [dbo].['+@usp_name+'] to [REG_NET\addinconception]'
	   --SET @SQL = 'GRANT EXECUTE ON [dbo].['+@usp_name+'] to [REG_NET\gverreault]'
	   --EXEC(@SQL);
	   SET @SQL = 'GRANT EXECUTE ON [dbo].['+@usp_name+'] to [AppUser]'
	   EXEC(@SQL);
	   FETCH NEXT FROM pk_cursor INTO @usp_name
	END
	CLOSE pk_cursor
DEALLOCATE pk_cursor
COMMIT
GO
