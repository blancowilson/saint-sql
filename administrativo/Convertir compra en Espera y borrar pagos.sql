declare @numeroErrado varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@tipocompracxp VARCHAR(2),
		@NumeroCorrecto varchar (15),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)

set @numeroErrado='101940'
set @codprov='J002137789'
set @Tipocom='H'
set @TIPOCXP='10'
set @tipopago = '41'
set @tipoRetencion='81'
set @nrolote='00001'
set @tipocompracxp='10'


--
update SAEXIS
set Existen=existen-(select a.cantidad from SAITEMCOM a where a.NumeroD=@numeroErrado and TipoCom=@Tipocom  and a.CodItem=SAEXIS.CodProd)
where CodProd in (select Coditem from SAITEMCOM where NumeroD=@numeroErrado and TipoCom=@Tipocom)

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

delete from SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroErrado  and CodProv=@codprov and TipoCxP=@tipocompracxp) and NumeroD=@numeroErrado

delete SAACXP where NumeroD=@numeroErrado and CodProv=@codprov and TipoCxP=@tipocompracxp

delete SAACXP where NumeroN=@numeroErrado and TipoCxP=@tipoRetencion and CodProv=@codprov


