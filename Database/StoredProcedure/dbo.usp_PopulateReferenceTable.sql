SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_PopulateReferenceTable] 
AS
BEGIN


      -- ---------------------------------------------------------
	  -- Set DB version for this release
	  INSERT INTO [app].[VersionInfo] 
	  SELECT 1,0,0,0 WHERE NOT EXISTS ( SELECT * FROM  [app].[VersionInfo]);


	  UPDATE [app].[VersionInfo] 
	  SET [Major] = 1
	     ,[Minor] = 0
		 ,[Revision] = 0
		 ,[Build] = 0



	  -- ---------------------------------------------------------
	  -- Populate Language Table
	  MERGE [app].[Language] AS [ds]
	  USING (
			  SELECT 
				   [PK_Language]
				  ,[Code]
				  ,[Name]
			  FROM (
					  SELECT 1 AS [PK_Language], 'FR' AS [Code], 'Français' AS [Name]
					  UNION
					  SELECT 2 AS [PK_Language], 'EN' AS [Code], 'Anglais' AS [Name]
					  UNION
					  SELECT 3 AS [PK_Language], 'SP' AS [Code], 'Espagnol' AS [Name]
				   ) AS [la]
		   ) AS [sr]
	  ON [ds].[PK_Language] = [sr].[PK_Language]
	  WHEN NOT MATCHED THEN  
			INSERT (
					[PK_Language]
				   ,[Code]
				   ,[Name]
				   )
		   VALUES ( 
					[sr].[PK_Language]
				   ,[sr].[Code]
				   ,[sr].[Name]
				   );


	  -- ---------------------------------------------------------
	  -- Organization Type
	  MERGE [prj].[OrganizationType] AS [ds]
	  USING (
			  SELECT 
					[PK_OrganizationType]
				   ,[Name]
			  FROM (
					  SELECT 1 AS [PK_OrganizationType], 'Propriétaire' AS [Name]
					  UNION
					  SELECT 2 AS [PK_OrganizationType], 'Contracteur' AS [Name]
					  UNION
					  SELECT 3 AS [PK_OrganizationType], 'Ingénieur' AS [Name]
					  UNION
					  SELECT 4 AS [PK_OrganizationType], 'Architect' AS [Name]
					  UNION
					  SELECT 5 AS [PK_OrganizationType], 'Consultant' AS [Name]
                      UNION
					  SELECT 6 AS [PK_OrganizationType], 'Gestionnaire de projet' AS [Name]
					  UNION
					  SELECT 7 AS [PK_OrganizationType], 'Entrepreneur électrique' AS [Name]
					  UNION
					  SELECT 8 AS [PK_OrganizationType], 'Entrepreneur ventilation' AS [Name]
					  UNION
					  SELECT 9 AS [PK_OrganizationType], 'Entrepreneur plomberie' AS [Name]
					  UNION
					  SELECT 10 AS [PK_OrganizationType],'Fournisseur' AS [Name]
					  UNION
					  SELECT 11 AS [PK_OrganizationType],'Fabricant' AS [Name]

				   ) AS [la]
		   ) AS [sr]
	  ON [ds].[PK_OrganizationType] = [sr].[PK_OrganizationType]
	  WHEN NOT MATCHED THEN  
			INSERT (
					[PK_OrganizationType]
				   ,[Name]
				   )
		   VALUES ( 
					[sr].[PK_OrganizationType]
				   ,[sr].[Name]
				   );


	  -- ---------------------------------------------------------
	  -- Populate Historical Stage Table
	  MERGE [app].[HistoricalStage] AS [ds]
	  USING (
			  SELECT 
				   [PK_HistoricalStage]
				  ,[HistoricalStage]
				 
			  FROM (
					  SELECT 1 AS [PK_HistoricalStage], 'Conception' AS [HistoricalStage]
					  UNION
					  SELECT 2 AS [PK_HistoricalStage], 'Révision'   AS [HistoricalStage]
					  UNION
					  SELECT 3 AS [PK_HistoricalStage], 'Chantier'   AS [HistoricalStage]
				   ) AS [la]
		   ) AS [sr]
	  ON [ds].[PK_HistoricalStage] = [sr].[PK_HistoricalStage]
	  WHEN NOT MATCHED THEN  
			INSERT (
					[PK_HistoricalStage]
				   ,[HistoricalStage]
				    )
		   VALUES ( 
					[sr].[PK_HistoricalStage]
				   ,[sr].[HistoricalStage]
				  				   );

	  -- ---------------------------------------------------------
	  -- Application
	  MERGE [app].[Application] AS [ds]
	  USING (
			  SELECT 
					[PK_Application]
				   ,[Name]
				   ,[MarkedAsDeleted]
			  FROM (
					  SELECT 1 AS [PK_Application], 'CPM' AS [Name], 'False' as [MarkedAsDeleted]
				   ) AS [la]
		   ) AS [sr]
	  ON [ds].[PK_Application] = [sr].[PK_Application]
	  WHEN NOT MATCHED THEN  
			INSERT (
					[PK_Application]
				   ,[Name]
				   ,[MarkedAsDeleted]
				   )
		   VALUES ( 
					[sr].[PK_Application]
				   ,[sr].[Name]
				   ,[MarkedAsDeleted]
				   );


END;
GO
