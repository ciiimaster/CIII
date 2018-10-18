SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC [dbo].[usp_MergeOrganization]
CREATE PROCEDURE [dbo].[usp_MergeOrganization]
AS
BEGIN

    DECLARE @FK TABLE ( FK int)

	BEGIN TRY
	             
	    -- ------------------------------------------------------------
        -- Step 1 
		-- Updating Owner list from CRM
		MERGE [prj].[Organization] AS [ds]
		USING (

			     SELECT  DISTINCT
			           [ac].[AccountId]       AS [ID_Organization]
                      ,3                      AS [FK_OrganizationType] -- 1 = Propriétaire
					  ,[ac].[Name]            AS [Name]
					  ,[ac].[gfi_LegalName]   AS [LegalName]
					  ,[ac].[gfi_FullAddress] AS [FullAddress]

                      ,[ad].[Line1]           AS [AddressLine1]
					  ,[ad].[Line2]           AS [AddressLine2]
					  ,[ad].[City]            AS [City]
					  ,[ad].[StateOrProvince] AS [State]   
					  ,[ad].[Country]         AS [Country]   
					  ,[ad].[PostalCode]      AS [ZipCode]  
					  
					  ,[ac].[WebSiteURL]      AS [WebSite]
					  ,[ac].[EMailAddress1]   AS [Email]
					  ,[ac].[Telephone1]      AS [PrimaryPhoneNumber]
					  ,[ac].[Fax]             AS [Fax]

				  FROM       [CRM_Regulvar].[dbo].[AccountBase]         AS [ac]
				  --INNER JOIN [CRM_Regulvar].[dbo].[gfi_buildingBase]    AS [bu] ON [bu].[gfi_BuildingCompanyOwnerId] =[ac].[AccountId]
				  LEFT join  [CRM_Regulvar].[dbo].[CustomerAddressBase] AS [ad] ON [ad].ParentId = [ac].AccountId AND [ad].AddressNumber = 1
				  WHERE (1=1)
					  
              ) AS [so]
				ON UPPER([ds].[ID_Organization]) = UPPER([so].[ID_Organization])
		WHEN NOT MATCHED THEN  
		INSERT ( [ID_Organization]
		        ,[FK_OrganizationType]
		        ,[Name]
				,[LegalName]
				,[FullAddress]
				,[AddressLine1]
				,[AddressLine2]
				,[City]
				,[State]   
				,[Country]   
				,[ZipCode]
				,[WebSite]
			    ,[Email]
				,[PrimaryPhoneNumber]
				,[Fax]   
			   )
		VALUES ( [so].[ID_Organization]
		       , [so].[FK_OrganizationType]
		       , [so].[Name]
			   , [so].[LegalName]
			   , [so].[FullAddress]
			    ,[so].[AddressLine1]
				,[so].[AddressLine2]
				,[so].[City]
				,[so].[State]   
				,[so].[Country]   
				,[so].[ZipCode]
			   , [so].[WebSite]
			   , [so].[Email]
			   , [so].[PrimaryPhoneNumber]
				,[so].[Fax]
				)
		WHEN MATCHED THEN 
		UPDATE SET [ds].[Name]               = [so].[Name]
		         , [ds].[LegalName]          = [so].[LegalName]
		         , [ds].[FullAddress]        = [so].[FullAddress]
				 , [ds].[AddressLine1]       = [so].[AddressLine1]
				 , [ds].[AddressLine2]       = [so].[AddressLine2]
				 , [ds].[City]               = [so].[City]  
				 , [ds].[State]              = [so].[State]    
				 , [ds].[Country]            = [so].[Country]    
				 , [ds].[ZipCode]            = [so].[ZipCode] 
				 , [ds].[WebSite]            = [so].[WebSite]
		         , [ds].[Email]              = [so].[Email]
		         , [ds].[PrimaryPhoneNumber] = [so].[PrimaryPhoneNumber]
		         , [ds].[Fax]                = [so].[Fax]		         
		;

       -- -----------------------------------------------------------------------------
	   -- Link organisation to contact
       -- 	   
	   MERGE [prj].[OrganizationContact] AS [ds]
	   USING (
			   SELECT 
					 [pac].PK_Organization AS [FK_Organization]
					,[pco].PK_Contact      AS [FK_Contact]
			   FROM       [CRM_Regulvar].[dbo].[AccountBase]  AS [ac]
			   INNER JOIN [CRM_Regulvar].[dbo].[ContactBase]  AS [co]  ON [co].ParentCustomerId = [ac].[AccountId]
			   INNER JOIN                [prj].[Contact]      AS [pco] ON [pco].ID_Contact      = [co].[ContactId] 
			   INNER JOIN                [prj].[Organization] AS [pac] ON [pac].ID_Organization = [ac].[AccountId]  
             ) AS [sr]
	   ON  [sr].[FK_Organization] =  [ds].[FK_Organization] 
	   AND [sr].[FK_Contact]      =  [ds].[FK_Contact] 
	   WHEN NOT MATCHED THEN
	   INSERT ( [FK_Organization] ,[FK_Contact])
	   VALUES ( [sr].[FK_Organization] ,[sr].[FK_Contact]);
	
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   

END
GO
