SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- --------------------------------------------------------------------
-- Get Table Data
-- --------------------------------------------------------------------
-- EXEC [dbo].[usp_GetTableData] @TableName = 'Client', @ForceOverride = 1
-- EXEC [dbo].[usp_GetTableData] @TableName = 'Project'
-- EXEC [dbo].[usp_GetTableData] @TableName = 'Project', @WhereClause = 'CLIENTCODE = ''POM24''';
-- EXEC [dbo].[usp_GetTableData] @TableName = 'Project', @PK_Value = 3075 ;
-- EXEC [dbo].[usp_GetTableData] @TableName = 'AI', @WhereClause = 'MarkAsDeleted=0', @PartitionBy = 'DeviceInstance';

CREATE PROCEDURE [dbo].[usp_GetTableData] 
      @TableName    NVARCHAR(50) 
     ,@PK_Value     INT = NULL 
     ,@WhereClause  NVARCHAR(4000) = NULL
     ,@OrderClause  NVARCHAR(4000) = NULL
     ,@PartitionBy   NVARCHAR(4000) = NULL
     ,@ForceOverride BIT = 1
AS
BEGIN     

	DECLARE @CR NVARCHAR(2) = Char(13)+Char(10) 
	DECLARE @SQL                   NVARCHAR(MAX) = NULL
	DECLARE @OVERRIDEFIELD         NVARCHAR(MAX) = NULL
	DECLARE @PartitionWhereClause  NVARCHAR(MAX) = NULL
	DECLARE @Schema                NVARCHAR(50)
	

	SET  @Schema = (SELECT  SCHEMA_NAME(schema_id) As SchemaName from sys.tables WHERE [name] = @tableName );

	IF @PK_Value > 0
	  SET @WhereClause = 'PK_'+@TableName+ ' = ' + CONVERT(NVARCHAR, @PK_Value);

    -- ----------------------------------------------------------------
	-- Get Override field Table Data 
	SELECT 
		  @OVERRIDEFIELD = COALESCE(@OVERRIDEFIELD +' ','') + 
		                   '['+COLUMN_NAME+'] '
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @TableName 
	  AND COLUMN_NAME LIKE '%_Override'
	  
	  
   IF @PartitionBy IS NOT NULL 
   BEGIN
   
      SET @PartitionWhereClause =
   	  
	   ' PK_' +@TableName +' in
	  (
		  SELECT PK_'+@TableName + '
		  FROM (
				SELECT
				  PK_'+@TableName + ',
				  row_number() over (PARTITION BY '+ @PartitionBy +'
										 ORDER BY HistoricalDateTime DESC) AS [Row]
				 ['+@Schema+'].['+@TableName + ']
				) AS PK
		  WHERE [Row] = 1
	  ) '
	  Print @PartitionWhereClause
	END  

		  

	-- ----------------------------------------------------------------
	-- Get Table Data 
	SELECT 
		  @SQL = COALESCE(@SQL +',','SELECT ') + 
		               
		               CASE WHEN @ForceOverride = 1 THEN 		               
						   CASE WHEN CHARINDEX(COLUMN_NAME+'_Override', @OVERRIDEFIELD) > 0 
						   THEN 'COALESCE('+'['+COLUMN_NAME +'_Override'+']'+','+ COLUMN_NAME+')'
						   ELSE  '['+COLUMN_NAME +']' END
					   ELSE
					       '['+COLUMN_NAME +']'
					   END 	   
			             
		              +'AS ['+COLUMN_NAME+']'
		              
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @TableName
	  AND COLUMN_NAME NOT LIKE '%_Override'
 
 	-- ----------------------------------------------------------------
 	-- Final result
 	IF @PartitionBy IS NULL
 	
		SET @SQL = @SQL + ' FROM ['+@Schema+'].['+@TableName +']' + COALESCE( ' WHERE (1=1) AND ( '+ @WhereClause +' )' , ' WHERE (1=1) ') +
							COALESCE( ' ORDER BY '+ @OrderClause +';' , ' ;')
	ELSE
		SET @SQL = @SQL + ' FROM ['+@Schema+'].['+@TableName +']' + COALESCE( ' WHERE (1=1) AND ( '+ @PartitionWhereClause +' ) AND ( '+ @WhereClause +' )',  ' WHERE (1=1) AND ( '+ @PartitionWhereClause +' ) ' , ' WHERE (1=1) ') +
							COALESCE( ' ORDER BY '+ @OrderClause +';' , ' ;')					
							
	PRINT @SQL
	EXEC( @SQL )
	
	
	
END;
GO
