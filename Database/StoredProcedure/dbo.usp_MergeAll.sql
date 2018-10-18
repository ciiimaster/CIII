SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ----------------------------------------------------------------------------
-- Merge all table from CRM, ERP and Active Directory
-- EXEC [dbo].[usp_MergeAll]
CREATE PROCEDURE [dbo].[usp_MergeAll]
AS
BEGIN

    -- Populate reference tables used by other tables ... language, application, Type etc ... 
    EXEC [dbo].[usp_PopulateReferenceTable]

    -- Merge data with no dependencies

    EXEC [dbo].[usp_MergeEmployee];

	EXEC [dbo].[usp_MergeClient];

	
	-- Merge project data by priority

	EXEC [dbo].[usp_MergeBuilding] ;
  
    EXEC [dbo].[usp_MergeContact];

	EXEC [dbo].[usp_MergeOrganization];
		
	EXEC [dbo].[usp_MergeProject];

    EXEC [dbo].[usp_MergeProjectApproval];

	-- Merge inventory data

	EXEC [dbo].[usp_MergeProductInventory];

END
GO
