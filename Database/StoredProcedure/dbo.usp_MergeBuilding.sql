SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ----------------------------------------------------------------------------
-- EXEC  [dbo].[usp_MergeBuilding]
CREATE PROCEDURE [dbo].[usp_MergeBuilding]
AS
BEGIN

    DECLARE @FK TABLE ( FK int)
	BEGIN TRY
	             
	    -- ------------------------------------------------------------
        -- Step 1 
		-- Updating Building list from CRM
		MERGE [prj].[Building] AS [ds]
		USING (
			   SELECT 
			          [bu].[gfi_buildingId]        AS [ID_Building]
                     ,[bu].[gfi_Name]              AS [Title] 
					 ,Null                         AS [FirstName]
					 ,Null                         AS [LastName]
					 ,[bu].[gfi_Name]              AS [FullName]
					 
					 ,[bu].[gfi_FullAddress]       AS [FullAddress]
				     ,[bu].[gfi_BuildingAddress]   AS [AddressLine1]
					 ,Null                         AS [AddressLine2]
					 ,[bu].[gfi_BuildingCity]      AS [City]
					 ,[sb].[Value]                 AS [State]   
					 ,'Canada'                     AS [Country]   
					 ,[bu].[gfi_BuildingPostalCode]AS [ZipCode]  

					 ,Null                         AS [Website]
                     ,[bu].[gfi_BuildingEmail]     AS [Email]
				     ,[bu].[gfi_BuildingMainPhone] AS [PrimaryPhoneNumber]
					 ,[bu].[gfi_BuildingOtherPhone]AS [SecondaryPhoneNumber]
					 ,Null                         AS [MobilePhone]
					 ,[bu].[gfi_BuildingFax]       AS [Fax]
					 ,[ow].[PK_Organization]       AS [FK_Organization__Owner]
					 ,[ma].[PK_Organization]       AS [FK_Organization__Manager]
               FROM      [CRM_Regulvar].[dbo].[gfi_buildingBase]    AS [bu]
			   LEFT JOIN                [prj].[Organization]        AS [ow] ON [ow].[ID_Organization] = [bu].[gfi_BuildingCompanyOwnerId] 
			   LEFT JOIN                [prj].[Organization]        AS [ma] ON [ma].[ID_Organization] = [bu].[gfi_BuildingCompanyManager] 


			   LEFT JOIN [CRM_Regulvar].[dbo].[StringMapBase]       AS [sb] ON [sb].AttributeValue = [bu].gfi_BuildingProvinceState
			   	                                                           AND [sb].[LangId] = 1036
																           AND [sb].[attributeName] = 'gfi_BuildingProvinceState'
               WHERE (1=1)
		    	
              ) as [so]
		ON UPPER([ds].[ID_Building]) = UPPER([so].[ID_Building])
	WHEN NOT MATCHED THEN  
		INSERT ( [ID_Building]
		        ,[Name]
			    ,[FullAddress]
				,[AddressLine1]
				,[AddressLine2]
				,[City]
				,[State]   
				,[Country]   
				,[ZipCode]
				,[Email]
				,[Website]
				,[PrimaryPhoneNumber]
				,[SecondaryPhoneNumber]
				,[MobilePhone]
				,[Fax]   
				,[Comment]
				
			   )
		VALUES ( [so].[ID_Building]
		        ,[so].[Title]
		        ,[so].[FullAddress]
				,[so].[AddressLine1]
				,[so].[AddressLine2]
				,[so].[City]
				,[so].[State]   
				,[so].[Country]   
				,[so].[ZipCode]
				,[so].[Email]
				,[so].[Website]
				,[so].[PrimaryPhoneNumber]
				,[so].[SecondaryPhoneNumber]
				,[so].[MobilePhone]
				,[so].[Fax]   
				,[so].[FullAddress]
				)
		WHEN MATCHED THEN 
		UPDATE SET [ds].[Name] = [so].[Title]
		         , [ds].[FullAddress] =[so].[FullAddress]
				 , [ds].[AddressLine1] =[so].[AddressLine1]
				 , [ds].[AddressLine2] = [so].[AddressLine2]
				 , [ds].[City] = [so].[City]
				 , [ds].[State]  =[so].[State]   
				 , [ds].[Country] = [so].[Country]   
				 , [ds].[ZipCode] =[so].[ZipCode]
		         , [ds].[Email] = [so].[Email]
		         , [ds].[Website] = [so].[Website]	
				 , [ds].[PrimaryPhoneNumber] = [so].[PrimaryPhoneNumber]		         
				 , [ds].[SecondaryPhoneNumber] = [so].[SecondaryPhoneNumber]
		         , [ds].[MobilePhone] = [so].[MobilePhone]
				 , [ds].[Fax] = [so].[Fax]	
				 , [ds].[Comment] = [so].[FullAddress]	
				 , [ds].[FK_Organization__Owner] =[so].[FK_Organization__Owner]		
				 , [ds].[FK_Organization__Manager] =[so].[FK_Organization__Manager]		 		
		;

		-- Link Building with the project
		Merge [prj].[ProjectBuilding] as [pb]
		USING (
				 SELECT [pr].[PK_Project]    AS [FK_Project]
					   ,[bu].[PK_Building]   AS [FK_Building]
					   , 1                   AS [Choosen] 
				 FROM       [CRM_Regulvar].[dbo].[SalesOrderBase] AS [so]
				 INNER JOIN                [prj].[Project]        AS [pr] on [pr].[ProjectNumber] collate French_CI_AS = [so].[gfi_ProjectNumber]
				 INNER JOIN                [prj].[Building]       AS [bu] on [bu].[ID_Building] = [so].[gfi_Building]
			   ) as [so]
		ON   [so].[FK_Project] = [pb].[FK_Project]
		AND  [so].[FK_Building] = [pb].[FK_Building]
		WHEN NOT MATCHED THEN
		INSERT ([FK_Project],[FK_Building], [Choosen])
		VALUES ( [so].[FK_Project],[so].[FK_Building], 1);

	
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   

END
GO
