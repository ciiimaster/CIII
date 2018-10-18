SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC [dbo].[usp_MergeClient]
-- TRUNCATE TABLE dbo.Client

CREATE PROCEDURE [dbo].[usp_MergeClient]
AS
BEGIN

DECLARE @FK TABLE ( FK int)

	BEGIN TRY
          
	    -- ------------------------------------------------------------
        -- Step 1 
		-- Updating Client list from MAESTRO
		MERGE [prj].[Client] AS [pr]
		USING (
			SELECT  DISTINCT
				    Upper(CUSTCODE) AS [Code]
				   ,[cl].[Name]     AS [Name]
			FROM       [regulvar].[dbo].[projet] AS [pr] WITH (NOLOCK)
			INNER JOIN [regulvar].[dbo].[client] AS [cl] ON [cl].[CODE] =   Upper(CUSTCODE)
			) as [so]
		ON UPPER([pr].[Code]) = UPPER([so].[Code])
		WHEN NOT MATCHED THEN  
		INSERT (      [Code],      [Name])
		VALUES ( [so].[Code], [so].[Name])
		WHEN MATCHED AND [so].[Name] != [pr].[Name] 
		THEN 
		UPDATE SET [pr].[Name] = [so].[Name];
		
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   

END
GO
