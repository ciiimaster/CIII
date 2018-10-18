SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- EXEC [dbo].[usp_MergeContact]

CREATE PROCEDURE [dbo].[usp_MergeContact]
AS
BEGIN

    DECLARE @FK TABLE ( FK int)

	BEGIN TRY
	             
	    -- ------------------------------------------------------------
        -- Step 1 
		-- Updating Contact list from CRM
		MERGE [prj].[Contact] AS [ds]
		USING (
			   SELECT  
					   [co].[ContactId]                    AS [ID_Contact]
					  ,[co].[JobTitle]                     AS [Title] 
					  ,Coalesce([co].[FirstName],'')       AS [FirstName]
					  ,Coalesce([co].[LastName],'')        AS [LastName]
					  ,[co].[FullName]                     AS [FullName]

					  ,Coalesce([co].[gfi_FullAddress],'') AS [FullAddress]
					  ,[ad].[Line1]                        AS [AddressLine1]
					  ,[ad].[Line2]                        AS [AddressLine2]
					  ,[ad].[City]                         AS [City]
					  ,[ad].[StateOrProvince]              AS [State]   
					  ,[ad].[Country]                      AS [Country]   
					  ,[ad].[PostalCode]                   AS [ZipCode]  

					  ,[co].[WebSiteUrl]                   AS [Website]
					  ,[co].[EMailAddress1]                AS [Email]
					  ,[co].[Telephone1]                   AS [PrimaryPhoneNumber]
					  ,[co].[Telephone2]                   AS [SecondaryPhoneNumber]
					  ,[co].[MobilePhone]                  AS [MobilePhone]
					  ,[co].[Fax]                          AS [Fax]   
					

					FROM        [CRM_Regulvar].[dbo].[ContactBase]         AS [co]
					inner join  [CRM_Regulvar].[dbo].[CustomerAddressBase] AS [ad] ON [ad].ParentId = [co].ContactId
					WHERE (1=1)
					  AND [ad].AddressNumber = 1
              ) as [so]
		ON UPPER([ds].[ID_Contact]) = UPPER([so].[ID_Contact])
		WHEN NOT MATCHED THEN  
		INSERT ( [ID_Contact]
		        ,[Title]
			    ,[FirstName]
			    ,[LastName]
				,[FullName]
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
				,[FK_Language]
			   )
		VALUES ( [so].[ID_Contact]
		        ,[so].[Title]
			    ,[so].[FirstName]
			    ,[so].[LastName]
				,[so].[FullName]
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
				,1
				)
		WHEN MATCHED THEN 
		UPDATE SET [ds].[Title] = [so].[Title]
		         , [ds].[FirstName] =[so].[FirstName]
			     , [ds].[LastName] = [so].[LastName]
				 , [ds].[FullName] = [so].[FullName]
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
		;
	
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   

END
GO
