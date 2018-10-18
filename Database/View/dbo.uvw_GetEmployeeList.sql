SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[uvw_GetEmployeeList]
AS

SELECT [PK_Employee]		AS [Employee.PK_Employee]
      ,[Active]				AS [Employee.Active]
      ,[EmployeeNumber]		AS [Employee.EmployeeNumber]
      ,[FirstName]			AS [Employee.FirstName]
      ,[LastName]			AS [Employee.LastName]
      ,[FullName]			AS [Employee.FullName]
      ,[JobTitle]			AS [Employee.JobTitle]
      ,[BranchOfficeName]	AS [Employee.BranchOfficeName]
      ,[GenericTitle]		AS [Employee.GenericTitle]
      ,[OfficePhoneNumber]	AS [Employee.OfficePhoneNumber]
      ,[MobilePhone]		AS [Employee.MobilePhone]
      ,[Extension] 			AS [Employee.Extension]
      ,[Email]				AS [Employee.Email]
  FROM [app].[Employee]
 
GO
