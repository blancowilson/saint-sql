USE [EnterpriseMTAdminDb]
GO
/****** Object:  Trigger [dbo].[Recal_compro]    Script Date: 30-05-2019 04:01:40 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,DF SISTEMAS C.A,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,Recalcula las cantidades comprometidas eya que saint lo esta haciendo mal,>
-- =============================================
ALTER TRIGGER [dbo].[Recal_compro]
   ON  [dbo].[SAITEMFAC]
   AFTER DELETE
AS 
DECLARE @TIPOFAC VARCHAR (1)
DECLARE @CANTIDAD DECIMAL (28,4)
DECLARE @CODUBIC VARCHAR (4)
DECLARE @CODPROD VARCHAR (20)

SELECT @TIPOFAC=TipoFac,@CANTIDAD=Cantidad,@CODUBIC=NumeroD,@CODPROD=CodItem FROM inserted

IF @TIPOFAC='E'

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
UPDATE SAEXIS
SET CantCom =0
where CodProd not in (select coditem 
						from SAITEMFAC
						where TipoFac ='E' and Cantidad>0
						group by CodItem) and CantCom<>0;


WITH It (Codprod,CodUbic, Pedidos) AS
(
   SELECT It.CodItem,It.CodUbic, SUM(It.cantidad) as Pedidos
     -- FROM SAEXIS Ex
       --  JOIN SAITEMFAC It ON Ex.CodProd = It.CodItem and Ex.CodUbic = It.CodUbic
	from SAITEMFAC IT 	
		where It.TipoFac ='E'
      GROUP BY It.CodItem,It.CodUbic
)
UPDATE Ex SET Ex.CantCom = It.Pedidos
   FROM SAEXIS Ex
      INNER JOIN It ON It.Codprod = Ex.CodProd and Ex.CodUbic=It.CodUbic
where It.Pedidos<>ex.CantCom;


WITH Exis (Codprod, Pedidos) AS
(
   SELECT Ex.CodProd, SUM(Ex.cantcom) as Pedidos
      FROM SAEXIS Ex
      GROUP BY Ex.CodProd
)
UPDATE Pr SET Pr.Compro = Exis.Pedidos
   FROM SAPROD pr
      INNER JOIN Exis ON Exis.Codprod = Pr.CodProd 
where Exis.Pedidos<>Pr.Compro;


END
