SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetTableSchema] 
      @TableName    NVARCHAR(50) 
AS
BEGIN      
    SELECT
		 [COLUMN_NAME]					AS [ColumnName]
		,[ORDINAL_POSITION]				AS [OrdinalPosition] 
		,[IS_NULLABLE]					AS [IsNullable]
		,[DATA_TYPE]					AS [DataType]
		,[CHARACTER_MAXIMUM_LENGTH]		AS [Length]
		,[NUMERIC_PRECISION]     		AS [Precision]
	
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @TableName
	  AND COLUMN_NAME NOT LIKE '%_Override'
END	
GO
