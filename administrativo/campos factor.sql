USE EASainsycaDb
GO

/****** Object:  Table [dbo].[Adcc_Variacion]    Script Date: 04-09-2019 08:32:41 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Adcc_Var_Factor](
	[tasa] [float] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[usuario] [nchar](20) NULL
) ON [PRIMARY]

GO


IF NOT EXISTS(select so.name from sysobjects so, syscolumns si where si.name = 'tasa' And so.id = si.id And so.name = 'safact') 
ALTER TABLE [dbo].safact WITH NOCHECK ADD tasa	decimal(28,4)	NULL;
IF NOT EXISTS(select so.name from sysobjects so, syscolumns si where si.name = 'TotalMoneda' And so.id = si.id And so.name = 'safact') 
ALTER TABLE [dbo].safact WITH NOCHECK ADD TotalMoneda	decimal(28,4)	NULL;

IF NOT EXISTS(select so.name from sysobjects so, syscolumns si where si.name = 'tasa' And so.id = si.id And so.name = 'saitemfac') 
ALTER TABLE [dbo].saitemfac WITH NOCHECK ADD tasa	decimal(28,4)	NULL;
IF NOT EXISTS(select so.name from sysobjects so, syscolumns si where si.name = 'TotalMoneda' And so.id = si.id And so.name = 'saitemfac') 
ALTER TABLE [dbo].saitemfac WITH NOCHECK ADD TotalMoneda	decimal(28,4)	NULL;
IF NOT EXISTS(select so.name from sysobjects so, syscolumns si where si.name = 'PrecioMoneda' And so.id = si.id And so.name = 'saitemfac') 
ALTER TABLE [dbo].saitemfac WITH NOCHECK ADD PrecioMoneda	decimal(28,4)	NULL;


USE EASainsycaDb
GO
/****** Object:  Trigger [dbo].[TR_TotalBs]    Script Date: 04-09-2019 08:06:58 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create TRIGGER [dbo].[TR_FactorItem]
   ON  [dbo].[SAITEMFAC] 
   AFTER  INSERT
AS 

DECLARE @NUMEROD VARCHAR (20)
DECLARE @CODPROD VARCHAR (20)
DECLARE @TIPOFACT VARCHAR (20)
DECLARE @FACTOR VARCHAR (20)


SET @FACTOR = (SELECT Factor FROM SACONF)
SELECT @NUMEROD=NumeroD,@TIPOFACT=TipoFac,@CODPROD=CodItem FROM inserted

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE SAITEMFAC SET PrecioMoneda=PRECIO/@FACTOR,TotalMoneda=(PRECIO/@FACTOR)*Cantidad,Tasa=@FACTOR 
	FROM SAITEMFAC 
	WHERE NumeroD=@NUMEROD AND TipoFac=@TIPOFACT AND CodItem=@CODPROD
    -- Insert statements for trigger here

END

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[TR_factorFact]
   ON  [dbo].[SAFACT] 
   AFTER  INSERT
AS 

DECLARE @NUMEROD VARCHAR (20)
DECLARE @TIPOFACT VARCHAR (20)
DECLARE @FACTOR VARCHAR (20)


SET @FACTOR = (SELECT Factor FROM SACONF)
SELECT @NUMEROD=NumeroD,@TIPOFACT=TipoFac FROM inserted

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE SAFACT SET TotalMoneda=round(Monto/@FACTOR,2),Tasa=@FACTOR WHERE NumeroD=@NUMEROD AND TipoFac=@TIPOFACT 

END
