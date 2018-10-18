SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC [dbo].[usp_MergeProject]
-- TRUNCATE TABLE dbo.Project
-- UPDATE [prj].Project set Description = ''
CREATE PROCEDURE [dbo].[usp_MergeProject]
AS
BEGIN
    
      
	DECLARE @FK TABLE ( FK int)

	BEGIN TRY
          
	    -- ------------------------------------------------------------
        -- Step 1 
		-- Updating project list from MAESTRO
		MERGE [prj].[Project] AS [pr]
		USING (
			SELECT  [pr].NUM               AS [ProjectNumber]
			       ,[dbo].[ufc_FormatProjectManager]([pm].[PROJECTMANAGER])   AS [ProjectManager]	
				   ,[pr].DESCR             AS [Description]
				   ,[pr].[Status]          AS [Status]
				   ,Upper([pr].[CUSTCODE]) AS [ClientCode]
				   ,[pr].SITESPHONENO      AS [PrimaryPhoneNumber]
				   ,[pr].SITE
				   ,[pr].ADDR			   AS [AddressLine1]	
				   ,[pr].CITY              AS [City]
				   ,[pr].POSTALCODE        AS [ZipCode]
				   ,[pr].PROVINCE          AS [State]
				   ,[pr].COUNTRY           AS [Country]
				   ,[pr].[FAX]             AS [Fax]
				   , [cl].[PK_Client] AS [FK_Client]
				   ,CASE WHEN [pr].[OpeningDate] = '1753-01-01' THEN NULL ELSE [pr].[OpeningDate] END AS [OpeningDate]
				   ,CASE WHEN [pr].[ClosingDate] = '1753-01-01' THEN NULL ELSE [pr].[ClosingDate] END AS [ClosingDate]
			FROM      [regulvar].[dbo].[projet] AS [pr] WITH (NOLOCK)
			LEFT JOIN [regulvar].[dbo].[Projet] AS [pm] WITH(NOLOCK)  ON [pr].[MASTERPROJECT] = [pm].[NUM]
			LEFT JOIN            [prj].[Client] AS [cl] WITH (NOLOCK) ON [cl].[Code] = Upper([pr].[CUSTCODE])
 			) as [so]
		ON UPPER([pr].[ProjectNumber]) = UPPER([so].[ProjectNumber])
		WHEN NOT MATCHED THEN  
		INSERT (      [ProjectNumber],      [Status],     [Description])
		VALUES ( [so].[ProjectNumber], [so].[Status],[so].[Description])
		WHEN MATCHED AND (        [so].[Description]        !=          [pr].[Description] 
		              OR COALESCE([so].[Status],'')         != COALESCE([pr].[Status],'')
		              OR COALESCE([so].[ProjectManager],'') != COALESCE([pr].[ProjectManager],'')
		              OR COALESCE([so].[OpeningDate],'')    != COALESCE([pr].[OpeningDate],'')
		              OR COALESCE([so].[ClosingDate],'')    != COALESCE([pr].[ClosingDate],'')
		              OR COALESCE([so].[FK_Client],-1)      != COALESCE([pr].[FK_Client] ,-1)
		              )
        THEN 
		UPDATE SET [pr].[Description]       = [so].[Description]
		         , [pr].[Status]            = [so].[Status]
				 , [pr].[ProjectManager]    = [so].[ProjectManager]
		         , [pr].[OpeningDate]       = [so].[OpeningDate]
		         , [pr].[ClosingDate]       = [so].[ClosingDate]
		         , [pr].[FK_Client]         = [so].[FK_Client]
				 , [pr].[AddressLine1]      = [so].[AddressLine1]
		         , [pr].[City]              = [so].[City]
				 , [pr].[State]             = [so].[State]
				 , [pr].[Zipcode]           = [so].[Zipcode]
		         , [pr].[Country]           = [so].[Country]
				 , [pr].[PrimaryPhoneNumber]= [so].[PrimaryPhoneNumber]
				 , [pr].[Fax]               = [so].[Fax]
				 		
		-------------------------------------
         OUTPUT inserted.[PK_Project] INTO @FK ;
        -------------------------------------
	  
	  	-- Return the last modified key
		Return Coalesce((SELECT MAX(FK) From @FK),-1)
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   


	UPDATE [prj].[Project] SET [ApplyProjectManagement] = 1 WHERE LEN([ProjectNumber]) = 9
	UPDATE [prj].[Project] SET [Active] = 1 WHERE [Status] = 'A'
	UPDATE [prj].[Project] SET [Active] = 0 WHERE [Status] = 'F'

     
END
GO
