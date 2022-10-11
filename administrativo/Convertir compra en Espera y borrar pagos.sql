declare @numeroErrado varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@NumeroCorrecto varchar (15),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)

set @numeroErrado='00990'
set @codprov='V-06176322-4'
set @Tipocom='H'
set @TIPOCXP='21'
set @tipopago = '41'
set @tipoRetencion='81'
set @nrolote='00001'

--select * from sacomp where    CodProv=@codprov and TipoCom=@Tipocom and NumeroD=@numeroErrado 
--select * from SAITEMCOM where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

--
Update Exis
set Exis.Existen= Exis.Existen - ITEM.Cantidad
from SAEXIS Exis inner join SAITEMCOM ITEM on  ITEM.CodItem = Exis.CodProd and ITEM.CodUbic = Exis.CodUbic
where item.NumeroD=@numeroErrado and item.TipoCom=@Tipocom and item.CodProv=@codprov and item.EsServ =0

---si maneja lote se ejecuta este habilite este query
/*
update SALOTE
set Cantidad=Cantidad-(select a.cantidad from SAITEMCOM a where a.NumeroD=@numeroErrado and a.CodItem=SALOTE.CodProd and a.NroLote=salote.NroLote)
where NroLote=@nrolote and CodProd in (select CodItem from SAITEMCOM where NumeroD=@numeroErrado)*/

--cambiar compra a documentos en espera
update SACOMP set TipoCom = 'M' where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
-- items de compra
update SAITEMCOM set tipocom = 'M' where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

delete SASEPRCOM  where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

delete SATAXITC where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

delete SATAXCOM where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

delete SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroErrado and TipoCxP=@tipoRetencion and CodProv=@codprov) and NumeroD=@numeroErrado

delete from SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroErrado and TipoCxP=@tipopago and CodProv=@codprov) and NumeroD=@numeroErrado

delete SAACXP where NumeroD=@numeroErrado and CodProv=@codprov

delete SAACXP where NumeroN=@numeroErrado and TipoCxP=@tipoRetencion and CodProv=@codprov


