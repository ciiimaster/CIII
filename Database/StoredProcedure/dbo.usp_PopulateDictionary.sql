SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- -----------------------------------------------------------
-- EXEC usp_PopulateDictionary
CREATE PROCEDURE [dbo].[usp_PopulateDictionary]
AS
BEGIN

	MERGE  [app].[Dictionary] AS [dc]
	USING (
			SELECT
				  'View'				AS [ParentObjectType] 
				, 'Column'				AS [ObjectType]
				,  o.name				AS [ParentObject]
				,  c.name				AS [Object]

				-- Get Table name
				,  CASE WHEN CHARINDEX ('.',c.name ) > 0 THEN
				       SUBSTRING ( c.name ,1 , CHARINDEX ('.',c.name )-1 ) 
				   ELSE ''  END			AS [TableName]

                -- Get Column name
				,  CASE WHEN CHARINDEX ('.',c.name ) > 0 THEN
				       SUBSTRING ( c.name , CHARINDEX ('.',c.name )+1, 200 ) 
				   ELSE c.name  END		AS [ColumnName]
				, 1						AS [FK_Language]
				,  CASE WHEN CHARINDEX ('.',c.name ) > 0 THEN
				       SUBSTRING ( c.name , CHARINDEX ('.',c.name )+1, 200 ) 
				   ELSE c.name  END		AS [Caption]
				, ''					AS [Hint]
			FROM sys.objects o
			JOIN sys.schemas s ON o.[schema_id] = s.[schema_id]
			JOIN sys.columns c ON o.[object_id] = c.[object_id]
			WHERE o.[type] IN ( 'V')
		 ) AS [sr]
	ON  [sr].[ParentObjectType] = [dc].[ParentObjectType]
	AND [sr].[ObjectType]       = [dc].[ObjectType]
	AND [sr].[ParentObject]     = [dc].[ParentObject]
	AND [sr].[Object]           = [dc].[Object]
	AND [sr].[FK_Language]      = [dc].[FK_Language]

	WHEN NOT MATCHED THEN
	INSERT ( [ParentObjectType]
	        ,[ObjectType]
			,[ParentObject]
			,[Object]
			,[TableName]
			,[ColumnName]
			,[FK_Language]
			,[Caption]
			,[Hint]
			)
   VALUES (  [sr].[ParentObjectType]
	        ,[sr].[ObjectType]
			,[sr].[ParentObject]
			,[sr].[Object]
			,[sr].[TableName]
			,[sr].[ColumnName]
			,[sr].[FK_Language]
			,[sr].[Caption]
			,[sr].[Hint]
          )
   WHEN MATCHED AND [dc].[Caption]     != [sr].[Caption] 
                OR  [dc].[Hint]        != [sr].[Hint] 
				OR  [dc].[TableName]   != [sr].[TableName] 
				OR  [dc].[ColumnName]  != [sr].[ColumnName] THEN
   UPDATE SET  [dc].[Caption]     = [sr].[Caption]
            ,  [dc].[Hint]        = [sr].[Hint]
			,  [dc].[TableName]   = [sr].[TableName]
			,  [dc].[ColumnName]  = [sr].[ColumnName]
    ;

END;



GO
