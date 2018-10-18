SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[uvw_GetProjectList]

AS

SELECT [pr].[PK_Project]				AS [Project.PK_Project]
      ,[pr].[FK_BranchOffice]			AS [Project.FK_BranchOffice]
      ,[pr].[FK_Client]					AS [Project.FK_Client]
      ,[pr].[Active]					AS [Project.Active]
      ,[pr].[ProjectNumber]				AS [Project.ProjectNumber]
      ,[pr].[Description]				AS [Project.Description]
      ,[pr].[OrderDate]					AS [Project.OrderDate]
      ,[pr].[OpeningDate]				AS [Project.OpeningDate]
      ,[pr].[ClosingDate]				AS [Project.ClosingDate]
      ,[pr].[ProjectManager]			AS [Project.ProjectManager]
	  ,[em].[PK_Employee]               AS [Employee.PK_Employee]
	  ,[em].[EmployeeNumber]			AS [Employee.EmployeeNumber]
	  ,[em].[MobilePhone]				AS [Employee.MobilePhone]
	  ,[em].[Extension]					AS [Employee.Extension]
	  ,[em].[Email]						AS [Employee.Email]
      ,[pr].[FullAddress]				AS [Project.FullAddress]
      ,[pr].[AddressLine1]				AS [Project.AddressLine1]
      ,[pr].[AddressLine2]				AS [Project.AddressLine2]
      ,[pr].[City]						AS [Project.City]
      ,[pr].[State]						AS [Project.State]
      ,[pr].[Country]					AS [Project.Country]
      ,[pr].[ZipCode]					AS [Project.ZipCode]
      ,[pr].[Email]						AS [Project.Email]
      ,[pr].[WebSite]					AS [Project.WebSite]
      ,[pr].[PrimaryPhoneNumber]		AS [Project.PrimaryPhoneNumber]
      ,[pr].[SecondaryPhoneNumber]  	AS [Project.SecondaryPhoneNumber]
      ,[pr].[MobilePhone]			    AS [Project.MobilePhone]
      ,[pr].[Fax]			            AS [Project.Fax]
      ,[pr].[Status]		        	AS [Project.Status]
      ,[pr].[ApplyProjectManagement]	AS [Project.ApplyProjectManagement]
      ,[pr].[Comment]					AS [Project.Comment]
      ,[pr].[MarkedAsDeleted]			AS [Project.MarkedAsDeleted]
  FROM       [prj].[Project]  AS [pr]
  LEFT JOIN  [app].[Employee] AS [em] on [em].[FullName] = [pr].[ProjectManager]

GO
