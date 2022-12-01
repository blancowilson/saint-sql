declare @numeroErrado varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@NumeroCorrecto varchar (15),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)

set @numeroErrado='001166'
set @codprov='J408599341'
set @Tipocom='h'
set @TIPOCXP='21'
set @tipopago = '41'
set @tipoRetencion='81'
set @nrolote='00001'


--select * from sacomp where  NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

--select * from SAACxp where  CodProv=@codprov
--
--update SAEXIS
--set Existen=existen-(select a.cantidad from SAITEMCOM a where a.NumeroD=@numeroErrado and TipoCom=@Tipocom  and a.CodItem=SAEXIS.CodProd)
--where CodProd in (select Coditem from SAITEMCOM where NumeroD=@numeroErrado and TipoCom=@Tipocom)

---si maneja lote se ejecuta este habilite este query
/*
update SALOTE
set Cantidad=Cantidad-(select a.cantidad from SAITEMCOM a where a.NumeroD=@numeroErrado and a.CodItem=SALOTE.CodProd and a.NroLote=salote.NroLote)
where NroLote=@nrolote and CodProd in (select CodItem from SAITEMCOM where NumeroD=@numeroErrado)*/

--cambiar compra a documentos en espera
select  *   From    SACOMP where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov
-- items de compra
select  *   From   SAITEMCOM  where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

select  *   From   SASEPRCOM  where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

select  *   From   SATAXITC where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

select  *   From   SATAXCOM where NumeroD=@numeroErrado and TipoCom=@Tipocom and CodProv=@codprov

select  *   From   SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroErrado  and CodProv=@codprov) and NumeroD=@numeroErrado

select  *   From    SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroErrado  and CodProv=@codprov) and NumeroD=@numeroErrado

select  *   From   SAACXP where NumeroD=@numeroErrado and CodProv=@codprov

select  *   From   SAACXP where NumeroN=@numeroErrado and CodProv=@codprov
