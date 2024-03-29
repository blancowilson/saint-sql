USE [EnterpriseAdminDB]
GO
/****** Object:  Trigger [dbo].[cambio_factor]    Script Date: 30/11/2022 23:09:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		< Wilson Blanco Saif Integral Systems>
-- Create date: <16-01-2015>
-- Description:	<ACTUALIZAR PRECIO DE PRODUCTOS Y SERVICIOS EN DIVISA>
-- =============================================
ALTER TRIGGER [dbo].[cambio_factor]
   ON  [dbo].[SACONF]
   AFTER  update
AS 

--declarecion de variables

declare @precio1 decimal(28, 4)
declare @precio2 decimal(28, 4)
declare @precio3 decimal(28, 4)
DECLARE @Factor decimal(28, 4)
DECLARE @ULT_TASA decimal(28, 4)
declare @vIVA decimal(28,4)
declare @MANTENER_PRECIO smallint
declare @TipoPrecio smallint
sELECT TOP 1 @ULT_TASA = TASA FROM QSHistoricoFactor ORDER BY FECHA DESC
SELECT @Factor=Factor FROM inserted


BEGIN

	SET NOCOUNT ON;
	select @vIVA= MtoTax from SATAXES	where CodTaxs ='IVA'
	
	if (@factor<>@ULT_TASA) OR (@ULT_TASA IS NULL)
	begin 
		insert into QSHistoricoFactor values (@Factor,GETDATE(),null)
		--UPDATE TaSpMultiCurrency SET Factor =@Factor WHERE IdCurrency =7

		SET NOCOUNT ON;
		select @vIVA= MtoTax from SATAXES	where CodTaxs ='IVA'
		update SAPROD   
		set Precio1 = round(((convert(float,precioI1)/(1+(@vIva/100)))*@factor),4)
		where (precioI1 is not NULL )and precioI1 >=0.01
		update SAPROD   
		set Precio2 = round(((convert(float,precioI2)/(1+(@vIva/100)))*@factor),4)
		where (precioI2 is not NULL )and precioI2 >=0.01
		update SAPROD   
		set Precio3 = round(((convert(float,precioI3)/(1+(@vIva/100)))*@factor),4)
		where (precioI3 is not NULL )and precioI1 >=0.01
	END

END