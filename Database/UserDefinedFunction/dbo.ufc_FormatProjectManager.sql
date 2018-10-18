SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create Function [dbo].[ufc_FormatProjectManager] ( @ProjectManager varchar(50) = '' )
RETURNS VARCHAR(100)
BEGIN
 
   RETURN CASE WHEN CASE WHEN COAlESCE(@ProjectManager,'') = '' THEN  COAlESCE(@ProjectManager,'') 
	                     ELSE @ProjectManager 
	                END = '' THEN ' Non assigné' 
	           ELSE CASE WHEN COAlESCE(@ProjectManager,'') = '' THEN  COAlESCE(@ProjectManager,'') 
	                     ELSE @ProjectManager 
	                END 
	      END 	
END

GO
