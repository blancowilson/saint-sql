declare @numeroErrado varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@NumeroCorrecto varchar (15),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)

set @numeroErrado='SERIEAB11128740'
set @codprov='J002206080'
set @Tipocom='H'
set @TIPOCXP='10'
set @tipopago = '41'
set @tipoRetencion='81'
set @nrolote='00001'

--select * from sacomp where  NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
--select * from SAACxp where  CodProv=@codprov
select NroUnico from SAACXP where NumeroN=@numeroErrado  and CodProv=@codprov and TipoCxP = @TIPOCXP
select NroUnico from SAACXP where Numerod=@numeroErrado  and CodProv=@codprov and TipoCxP = @TIPOCXP
update EXIS
set EXIS.Existen=EXIS.existen- comp.cantidad 
from saexis Exis INNER JOIN SAITEMCOM COMP ON  COMP.CodItem=EXIS.CodProd
where COMP.NumeroD=@numeroErrado and COMP.TipoCom=@Tipocom  and COMP.CodProv= @codprov AND COMP.CodUbic = Exis.CodUbic

--si maneja lote se ejecuta este habilite este query
/*
update SALOTE
set Cantidad=Cantidad-(select a.cantidad from SAITEMCOM a where a.NumeroD=@numeroErrado and a.CodItem=SALOTE.CodProd and a.NroLote=salote.NroLote)
where NroLote=@nrolote and CodProd in (select CodItem from SAITEMCOM where NumeroD=@numeroErrado)*/

select * from SAACXP where NumeroN=@numeroErrado  and CodProv=@codprov and TipoCxP = @TIPOCXP

--cambiar compra a documentos en espera
delete   From    SACOMP where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
-- items de compra
delete from  SAITEMCOM  where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
delete from  SASEPRCOM  where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
delete from  SATAXITC where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
delete from  SATAXCOM where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

delete from  SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroD=@numeroErrado  and CodProv=@codprov and TipoCxP = @TIPOCXP) and NumeroD=@numeroErrado
delete from   SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroErrado  and CodProv=@codprov and TipoCxP = @TIPOCXP) and NumeroD=@numeroErrado

delete from  SAACXP where NumeroD=@numeroErrado and CodProv=@codprov  and TipoCxP = @TIPOCXP
delete from  SAACXP where NumeroN=@numeroErrado and CodProv=@codprov 


