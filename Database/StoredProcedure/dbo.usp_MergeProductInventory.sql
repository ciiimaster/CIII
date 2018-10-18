SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- -----------------------------------------------
-- EXEC [usp_MergeProductInventory]
CREATE PROCEDURE [dbo].[usp_MergeProductInventory]
AS 
BEGIN 

  -- ----------------------------------------------------
  -- Sync Product Type
  MERGE [inv].[ProductType] [tr] 
  USING (SELECT DISTINCT
		     [NAME]        AS [Code]
            ,[DESCRIPTION] AS [Description]
         FROM [regulvar].[dbo].[intype]) as [sr]
	  ON Upper([tr].[Code]) = Upper([sr].[Code])
   WHEN NOT MATCHED THEN
	  INSERT ([Code], [Description] )
	  VALUES ([sr].[Code], [sr].[Description] )            
  ;	 

  -- ----------------------------------------------------
  -- Sync Product
  -- Merge product from ERP (Maestro)
  MERGE [inv].Product [tr] 
  USING (
		  SELECT DISTINCT
			   Upper([in].[CODE])                    AS [ItemCode]
			  ,[in].[TYPEITEM]                       AS [ItemType]
			  ,[lo].[PK_ProductType]                 AS [FK_ProductType]
			  ,[in].[FRENCHDESCRIPTION1]             AS [Name]
			  ,[in].[FRENCHDESCRIPTION1]             AS [Description]
			  ,[in].[ENGLISHDESCR1] + CHAR(13)+[in].[FRENCHDESCRIPTION2] + CHAR(13)+[in].[FRENCHDESCRIPTION3] AS [Note]
		  FROM        [regulvar].[dbo].[incat]       AS [in] WITH(NOLOCK)
		  LEFT JOIN              [inv].[ProductType] AS [lo] WITH(NOLOCK) on   
				                    Upper([lo].[Code]) = Upper([in].TYPEITEM)
        ) as [sr]
  ON Upper([tr].[COde]) = Upper([sr].[ItemCode])
  WHEN MATCHED 
   AND (COALESCE([sr].[Name],'')           != COALESCE([tr].[Description],'') 
   OR   COALESCE([sr].[Description],'')    != COALESCE([tr].[Description],'') 
   OR   COALESCE([sr].[Note],'')           != COALESCE([tr].[Note],'')
   OR   COALESCE([sr].[FK_ProductType],-1) != COALESCE([tr].[FK_ProductType],-1)
   ) THEN
      UPDATE SET tr.[Name]        = sr.[Name]
	           , tr.[Description] = sr.[Description]
               , tr.[FK_ProductType] = sr.[FK_ProductType]
               , tr.[Note] = sr.[Note]
			   , tr.[IsERPProduct] = 1
  WHEN NOT MATCHED THEN
	  INSERT ([CODE], [Name], [Description] )
	  VALUES ([sr].[ItemCode], [sr].[Name], [sr].[Description])            
  ;
 
  -- ----------------------------------------------------
  -- Sync Location 
  MERGE [inv].ProductLocation [tr] 
  USING (SELECT DISTINCT
		     [hs].[PREFIX]   AS [Warehouse]
			,[hs].[SITE]     AS [Site]
			,[hs].[LOCATION] AS [Emplacement] 
		 FROM [regulvar].[dbo].[incathis] as [hs] WITH (NOLOCK) ) as [sr]
	  ON  Upper([tr].[Warehouse])   = Upper([sr].[Warehouse])
	  AND Upper([tr].[Site])        = Upper([sr].[Site])
	  AND Upper([tr].[Emplacement]) = Upper([sr].[Emplacement])
  WHEN NOT MATCHED THEN
	  INSERT ([Warehouse], [Site], [Emplacement] )
	  VALUES ([sr].[Warehouse], [sr].[Site], [sr].[Emplacement] )            
  ;	 

  -- ----------------------------------------------------
  -- Sync Product Inventory  
   MERGE [inv].ProductInventory [tr] 
   USING (
		  SELECT
			   [pr].[PK_Product]           AS [FK_Product]
			  ,[lo].[PK_ProductLocation]   AS [FK_ProductLocation]
			  -- -------------------------------------------------------------------
			  -- Stock
			  ,SUM( 
				CASE 
					 WHEN Transactiontype = '2' then  1.0*[QUANTITY]  --50 Réception
					 WHEN Transactiontype = '4' then  1.0*[QUANTITY]  --53 Ajustement 
					 WHEN Transactiontype = '6' then -1.0*[QUANTITY]  --54 Livraison
					 WHEN Transactiontype = '?' then -1.0*[QUANTITY]  --63 Livraison direct
					 WHEN Transactiontype = ';' then -1.0*[QUANTITY]  --59 Transfer projet 
					 WHEN Transactiontype = 'è' then -1.0*[QUANTITY]  --232 Prise d''inventaire
				ELSE 0.0 END 
				 ) AS [InStock]
			  -- --------------------------------------------------------------------
			  -- Reserved Stock   
			  ,SUM( 
				CASE 
					 WHEN Transactiontype = '2' AND [RESERVATIONNO] != '' then  1.0*[QUANTITY]  --50 Réception
					 WHEN Transactiontype = '4' AND [RESERVATIONNO] != '' then  1.0*[QUANTITY]  --53 Ajustement 
					 WHEN Transactiontype = '6' AND [RESERVATIONNO] != '' then -1.0*[QUANTITY]  --54 Livraison
					 WHEN Transactiontype = '?' AND [RESERVATIONNO] != '' then -1.0*[QUANTITY]  --63 Livraison direct
					 WHEN Transactiontype = ';' AND [RESERVATIONNO] != '' then -1.0*[QUANTITY]  --59 Transfer projet 
					 WHEN Transactiontype = 'è' AND [RESERVATIONNO] != '' then -1.0*[QUANTITY]  --232 Prise d''inventaire
				ELSE 0.0 END 
				 ) AS [ReservedStock] 

		  FROM      [regulvar].[dbo].[incathis]   as [hs] WITH(NOLOCK)
		  LEFT JOIN [regulvar].[dbo].[incat]      as [in] WITH(NOLOCK) on [in].CODE = [hs].CODE
		  LEFT JOIN            [inv].[Product]    as [pr] WITH(NOLOCK) on 
		  				  Upper([pr].[Code])        = Upper([hs].[Code])
		  LEFT JOIN            [inv].[ProductLocation]   as [lo] WITH(NOLOCK) on   
						  Upper([lo].[Warehouse])   = Upper([hs].[PREFIX])
        			  AND Upper([lo].[Site])        = Upper([hs].[Site])
					  AND Upper([lo].[Emplacement]) = Upper([hs].[Location])
		  WHERE 1=1
		  AND [hs].[DATE] <= GetDate()
		  GROUP BY 
			   [pr].[PK_Product]
			  ,[lo].[PK_ProductLocation]
		 ) as [sr]
	  ON  Upper([tr].[FK_Product])         = Upper([sr].[FK_Product])
	  AND Upper([tr].[FK_ProductLocation]) = Upper([sr].[FK_ProductLocation])
	
  WHEN NOT MATCHED THEN
	  INSERT (     [FK_Product],      [FK_ProductLocation],      [InStock],     [ReservedStock] )
	  VALUES ([sr].[FK_Product], [sr].[FK_ProductLocation], [sr].[InStock],[sr].[ReservedStock] ) 
  WHEN MATCHED AND [tr].[InStock]      != [sr].[InStock]
                OR [tr].[ReservedStock]!= [sr].[ReservedStock]  THEN
  UPDATE SET [tr].[InStock]       = [sr].[InStock] 
            ,[tr].[ReservedStock] = [sr].[ReservedStock] 
  
    	; 
  
  
  -- Update the UnitCost based on fifo
   MERGE [inv].ProductInventory [tr] 
   USING (
		   SELECT 
				 [tr].[PK_ProductInventory]
			   , [GreyGoo].[dbo].[ufc_GetFIFOLastAverageCost] (
				 [pl].[Warehouse]
			   , [pr].[Code]
			   , [tr].[InStock] 
			   , GetDate()  ) AS [UnitCost]
		   FROM       [inv].ProductInventory [tr] WITH (NOLOCK)
		   INNER JOIN [inv].Product          [pr] WITH (NOLOCK) on pr.PK_Product = tr.FK_Product
		   INNER JOIN [inv].ProductLocation  [pl] WITH (NOLOCK) on pl.PK_ProductLocation = tr.FK_ProductLocation               
        ) AS [up]
   ON [tr].PK_ProductInventory = [up].[PK_ProductInventory]
   WHEN MATCHED AND [tr].[UnitCost]  != [up].[UnitCost]
                 THEN
  UPDATE SET [tr].[UnitCost]       = [up].[UnitCost] 
           
  
    	; 

END  
GO
