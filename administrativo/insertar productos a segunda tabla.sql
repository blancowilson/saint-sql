USE [EnterpriseAdminDB]
GO
/****** Object:  Trigger [dbo].[disparador_insert_produc]    Script Date: 03/07/2018 16:24:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Antonio gonzalez -  Wilson Blanco Saif Integral Systems>
-- Create date: <16-01-2015>
-- Description:	<INSERTA LOS ITEMS CREADOS EN LA EMPRESA BYD A LA EMPRESA TOYOTEX>
-- =============================================
Alter TRIGGER [dbo].[disparador_insert_produc]
   ON  [dbo].[SAPROD]
   AFTER  INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	insert into EAdminToyoTexDb.dbo.SAPROD
	select * from SAPROD where CodProd not in (select CodProd from EAdminToyoTexDb.dbo.SAPROD)


	insert into EAdminToyoTexDb.dbo.SACODBAR
	select * from SACODBAR where CodProd not in (select CodProd from EAdminToyoTexDb.dbo.SACODBAR)
    
	
	insert into EAdminToyoTexDb.dbo.SATAXPRD
	select * from SATAXPRD where CodProd not in (select CodProd from EAdminToyoTexDb.dbo.SATAXPRD)
	   

END
