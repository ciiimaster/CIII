SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[usp_MergeEmployee]
AS
BEGIN

    DECLARE @FK TABLE ( FK int)

	BEGIN TRY
	             
	    -- ------------------------------------------------------------
		-- Updating Employee List
		MERGE [app].[Employee] AS [pr]
		USING (
			    SELECT [EmployeeNumber]            AS [PK_Employee]
					  ,[EmployeeNumber]            AS [EmployeeNumber] 
					  ,[Active]                    AS [Active]
					  ,[FirstName]                 AS [FirstName]
					  ,[LastName]                  AS [LastName]
					  ,[FullName]                  AS [FullName]
					  ,[JobTitle]                  AS [JobTitle]
					  ,[BranchOfficeName]          AS [BranchOfficeName]
					  ,[GenericTitle]              AS [GenericTitle]
					  ,[PhoneNumber]               AS [OfficePhoneNumber]
					  ,[CellPhoneNumber]           AS [MobilePhone]
					  ,[IPPhone]                   AS [Extension]   
					  ,[EmailAddress]              AS [Email]
				FROM [GreyGoo].[dbo].[uvw_EmployeeList]
              ) as [so]
		ON UPPER([pr].[PK_Employee]) = UPPER([so].[PK_Employee])
		WHEN NOT MATCHED THEN  
		INSERT (       [PK_Employee]           
					  ,[EmployeeNumber]  
					  ,[Active]        
					  ,[FirstName]                 
					  ,[LastName]                 
					  ,[FullName] 
					  ,[JobTitle]
					  ,[BranchOfficeName]                
					  ,[GenericTitle]              
					  ,[OfficePhoneNumber]              
					  ,[MobilePhone]          
			      	  ,[Extension]                   
					  ,[Email]              
			   )
		VALUES (       [PK_Employee]           
					  ,[EmployeeNumber]
					  ,[Active]          
					  ,[FirstName]                 
					  ,[LastName]                 
					  ,[FullName] 
					  ,[JobTitle]
					  ,[BranchOfficeName]                                 
					  ,[GenericTitle]              
					  ,[OfficePhoneNumber]              
					  ,[MobilePhone]          
			     	  ,[Extension]                   
					  ,[Email] 
				)
		WHEN MATCHED THEN 
		UPDATE SET [pr].[PK_Employee] = [so].[PK_Employee]
		         , [pr].[Active] = [so].[Active]
		         , [pr].[FirstName] = [so].[FirstName]
		         , [pr].[LastName] = [so].[LastName]
		         , [pr].[FullName] = [so].[FullName]
		         , [pr].[GenericTitle] = [so].[GenericTitle]	
				 , [pr].[JobTitle] = [so].[JobTitle]	
				 , [pr].[BranchOfficeName] = [so].[BranchOfficeName]		         
				 , [pr].[OfficePhoneNumber] = [so].[OfficePhoneNumber]
		         , [pr].[MobilePhone] = [so].[MobilePhone]
				 , [pr].[Extension] = [so].[Extension]	
		         , [pr].[Email] = [so].[Email]	
		;
	
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   

END
GO
