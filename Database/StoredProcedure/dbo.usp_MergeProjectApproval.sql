SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC [dbo].[usp_MergeProjectApproval]
-- TRUNCATE TABLE dbo.ProjectApproval
CREATE PROCEDURE [dbo].[usp_MergeProjectApproval]
AS
BEGIN
      
	DECLARE @FK TABLE ( FK int)

	BEGIN TRY
      
	    -- ------------------------------------------------------------
	    -- Step 1
	    -- Updating project list from CRM   
	   	MERGE [prj].[ProjectApproval] AS [pr]
		USING (
			   SELECT  
					   gfi_projectNUMBER                        COLLATE French_CI_AS   AS [ProjectNumber]
					  ,MAX([bu].[PK_Building])                                         AS [FK_Building]
					  ,MAX(gfi_OrderDate)                                              AS [OrderDate]
					  ,MAX(OrderNumber)                                                AS [OrderNumber]  
					  ,MAX(sob.Name)                                                   AS [Description]
					  ,MAX(UPPER(sob.gfi_Customer_axclientid))  COLLATE French_CI_AS   AS [ClientCode] 
					  ,MAX(sob.CustomerIdName)                  COLLATE French_CI_AS   AS [ClientName]
					  ,MAX(gfi_customer_Division)                                      AS [Division]
					  ,MAX(gfi_PurchaseOrder)                                          AS [PurchaseOrderNumber]
					  ,MAX(coalesce(sgb.gfi_name,''))                                  AS [Estimator]
					  ,MAX(gfi_NominalPrice)                                           AS [NominalPrice]
					  ,MAX(gfi_SellingPrice)                                           AS [SellingPrice]
				FROM      [CRM_Regulvar].[dbo].SalesOrderBase     AS [sob]
				LEFT JOIN [CRM_Regulvar].[dbo].gfi_salesgroupBase AS [sgb] ON [sgb].gfi_salesgroupid = [sob].gfi_EstimatorSGId
				LEFT JOIN                [prj].[Building]         AS [bu]  ON [bu].[ID_Building]     =  [gfi_Building]  
				WHERE    gfi_projectNUMBER IS NOT NULL
				GROUP BY  gfi_projectNUMBER  COLLATE French_CI_AS
				        
              ) as [so]
		ON UPPER([pr].[ProjectNumber]) = UPPER([so].[ProjectNumber])
		WHEN NOT MATCHED THEN  
		INSERT (       [ProjectNumber]
		              ,[NominalPrice]
					  ,[SellingPrice]
					  ,[Estimator]
					  ,[OrderNumber]
					  ,[OrderDate]
					  ,[Description]
					  ,[FK_Building]
			   )
		VALUES ( [so].[ProjectNumber]
		       , Coalesce([so].[NominalPrice],0.00)
			   , Coalesce([so].[SellingPrice],0.00)
			   , [so].[Estimator]
			   , [so].[OrderNumber]
			   , [so].[OrderDate]
			   , [so].[Description]
			   , [so].[FK_Building]
			   )
		WHEN MATCHED AND 
		         (          [pr].[OrderDate]      != [so].[OrderDate]
		        OR COALESCE([pr].[ClientCode],'') IS NULL 
		        OR COALESCE([pr].[ClientName],'')  != COALESCE([so].[ClientName],'') 
				OR COALESCE([pr].[FK_Building],-1) != COALESCE([so].[FK_Building],-1) 
		         )
	    THEN 
		UPDATE SET [pr].[OrderDate]    =        [so].[OrderDate]
		         , [pr].[ClientCode]   = UPPER( [so].[ClientCode])
		         , [pr].[ClientName]   = [so].[ClientName]
				 , [pr].[FK_Building]  = [so].[FK_Building]
		---------------------------------------
		OUTPUT inserted.[PK_ProjectApproval] INTO @FK ;
		-------------------------------------

		-- Return the last modified key
		Return Coalesce((SELECT MAX(FK) From @FK),-1)
	END TRY
	BEGIN CATCH
	   Return -1
	END CATCH   
	
    -- -----------------------------------------------------------------------
	-- Import ProjectOpproval Organization (Architect, Consultant, ...)
	MERGE [prj].[ProjectApprovalOrganization] as [ds]
	USING (
			SELECT [pr].[PK_ProjectApproval], [or].PK_Organization, [po].FK_OrganizationType FROM (
			SELECT gfi_projectNUMBER COLLATE French_CI_AS AS [ProjectNumber] , [gfi_GeneralContractorId] AS [ID_Organization], 2 AS [FK_OrganizationType]  FROM  [CRM_Regulvar].[dbo].SalesOrderBase WHERE NOT [gfi_GeneralContractorId] IS NULL
			UNION
			SELECT gfi_projectNUMBER COLLATE French_CI_AS AS [ProjectNumber] , [gfi_ArchitechId]           , 4 AS [FK_OrganazationType]  FROM  [CRM_Regulvar].[dbo].SalesOrderBase WHERE NOT [gfi_ArchitechId] IS NULL
			UNION ALL
			SELECT gfi_projectNUMBER COLLATE French_CI_AS AS [ProjectNumber] , [gfi_ConsultantId]          , 5 AS [FK_OrganazationType]  FROM  [CRM_Regulvar].[dbo].SalesOrderBase WHERE NOT [gfi_ConsultantId] IS NULL
			UNION ALL
			SELECT gfi_projectNUMBER COLLATE French_CI_AS AS [ProjectNumber] , [gfi_ElectricalContractorId], 7 AS [FK_OrganazationType]  FROM  [CRM_Regulvar].[dbo].SalesOrderBase WHERE NOT [gfi_ElectricalContractorId] IS NULL
			UNION ALL
			SELECT gfi_projectNUMBER COLLATE French_CI_AS AS [ProjectNumber] , [gfi_PlumbingContractorId]  , 9 AS [FK_OrganazationType]  FROM  [CRM_Regulvar].[dbo].SalesOrderBase WHERE NOT [gfi_PlumbingContractorId] IS NULL
			) AS [po] 
			INNER JOIN [prj].[ProjectApproval]  AS [pr] ON [pr].[ProjectNumber]   = [po].[ProjectNumber] 
			INNER JOIN [prj].[Organization]     AS [or] ON [or].[ID_Organization] = [po].[ID_Organization]
	      ) AS [sr]
	ON   [ds].[FK_ProjectApproval]  = [sr].[PK_ProjectApproval]
	AND  [ds].[FK_Organization]     = [sr].[PK_Organization]
	AND  [ds].[FK_OrganizationTYpe] = [sr].[FK_OrganizationType]
	WHEN NOT MATCHED THEN
	INSERT ([FK_ProjectApproval],[FK_Organization],[FK_OrganizationType])
	VALUES  ([sr].[PK_ProjectApproval],[sr].[PK_Organization], [sr].[FK_OrganizationType]);
     
END
GO
