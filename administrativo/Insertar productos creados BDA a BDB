USE [BaseDatosA]
GO
/****** Object:  Trigger [dbo].[disparador_insert_produc]    Script Date: 10/10/2019 11:49:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Antonio gonzalez antonio101085@gmail.com -  Wilson Blanco blancowilson83@gmail.com>
-- Create date: <16-01-2015>
-- Description:	<INSERTA LOS ITEMS CREADOS EN LA EMPRESA BaseDatosA A LA EMPRESA BaseDatosB>
-- =============================================
CREATE TRIGGER [dbo].[disparador_insert_produc]
   ON  [dbo].[SAPROD]
   AFTER  INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	insert into BaseDatosB.dbo.SAPROD
	select * from SAPROD where CodProd not in (select CodProd from BaseDatosB.dbo.SAPROD)


	insert into BaseDatosB.dbo.SACODBAR
	select * from SACODBAR where CodProd not in (select CodProd from BaseDatosB.dbo.SACODBAR)
    
	
	insert into BaseDatosB.dbo.SATAXPRD
	select * from SATAXPRD where CodProd not in (select CodProd from BaseDatosB.dbo.SATAXPRD)
	   

END
