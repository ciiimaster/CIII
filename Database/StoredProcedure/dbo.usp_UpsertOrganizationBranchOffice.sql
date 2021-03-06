SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ----------------------------------------------------------------------------
-- INSERT, UPDATE a row for the [OrganizationBranchOffice] table
-- NOTE : DO NOT UPDATE this stored procedure, 
--        the code was autogenerated by usp_GenerateUpsertStodedProcedure
-- ----------------------------------------------------------------------------
--  How to call this stored procedure ....
-- 
-- 	EXEC	@return_value = [dbo].[usp_UpsertCity]
-- 		@PK_City = -1,
-- 		@Code = N'LAV', 
-- 		@Name = N'Laval' 
-- 
-- 
CREATE PROCEDURE [dbo].[usp_UpsertOrganizationBranchOffice]
	
	@PK_OrganizationBranchOffice AS INT = -1 ,
	@FK_Organization AS INT = NULL,
	@FK_BranchOffice AS INT = NULL,
	@MarkAsShow AS BIT = NULL,
	@ForceOverride BIT = 1
AS
BEGIN

	-- ------------------------------------------------------------
	IF @ForceOverride = 1
	BEGIN
	    SET @ForceOverride=@ForceOverride
	END

	DECLARE @Result  TABLE ( FK int);
	IF @PK_OrganizationBranchOffice = -1
	BEGIN
		-- ------------------------------------------------------------
		-- Insert a row in table  [OrganizationBranchOffice] 
		-- ------------------------------------------------------------
		INSERT INTO [prj].[OrganizationBranchOffice]
		(
		[FK_Organization] ,
		[FK_BranchOffice] ,
		[MarkAsShow] )
		OUTPUT Inserted.PK_OrganizationBranchOffice INTO @Result 
		SELECT 
		@FK_Organization,
		@FK_BranchOffice,
		@MarkAsShow
	END ELSE
	BEGIN
		-- ------------------------------------------------------------
		-- Update a row in table  [OrganizationBranchOffice] 
		-- ------------------------------------------------------------
		UPDATE [ur]
		SET 
		[ur].[FK_Organization] = COALESCE(@FK_Organization,[ur].[FK_Organization]),
		[ur].[FK_BranchOffice] = COALESCE(@FK_BranchOffice,[ur].[FK_BranchOffice]),
		[ur].[MarkAsShow] = COALESCE(@MarkAsShow,[ur].[MarkAsShow])
		FROM [prj].[OrganizationBranchOffice] AS [ur]
		WHERE [PK_OrganizationBranchOffice] = @PK_OrganizationBranchOffice
	END;
	-- ------------------------------------------------------------
	IF (SELECT COUNT(*) FROM [prj].[OrganizationBranchOffice] WHERE PK_OrganizationBranchOffice = @PK_OrganizationBranchOffice) = 0
	    SET @PK_OrganizationBranchOffice = -1 ; 
	-- ------------------------------------------------------------
	SELECT COALESCE((SELECT MAX(FK) FROM @Result),@PK_OrganizationBranchOffice) AS [PK] 
	-- ------------------------------------------------------------
END
GO
