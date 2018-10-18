SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [app].[VersionInfo](
	[PK_VersionInfo] [tinyint] IDENTITY(1,1) NOT NULL,
	[Major] [int] NOT NULL,
	[Minor] [int] NOT NULL,
	[Revision] [int] NOT NULL,
	[Build] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [app].[VersionInfo] ADD  CONSTRAINT [DF_VersionInfo_Major]  DEFAULT ((1)) FOR [Major]
GO
ALTER TABLE [app].[VersionInfo] ADD  CONSTRAINT [DF_VersionInfo_Minor]  DEFAULT ((0)) FOR [Minor]
GO
ALTER TABLE [app].[VersionInfo] ADD  CONSTRAINT [DF_VersionInfo_Revision]  DEFAULT ((0)) FOR [Revision]
GO
ALTER TABLE [app].[VersionInfo] ADD  CONSTRAINT [DF_VersionInfo_Build]  DEFAULT ((0)) FOR [Build]
GO
