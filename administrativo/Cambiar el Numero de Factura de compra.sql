declare @numeroAnterior varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@tipocompracxp VARCHAR(2),
		@NumeroCorrecto varchar (15),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)

set @numeroAnterior='101940'
set @codprov='J002137789'
set @Tipocom='H'
set @TIPOCXP='10'
set @tipopago = '41'
set @tipoRetencion='81'
set @nrolote='00001'
set @tipocompracxp='10'

--cambiar compra a documentos en espera
update SACOMP set Numerod = @NumeroCorrecto where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
-- items de compra
update SAITEMCOM set Numerod = @NumeroCorrecto where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov

Update SASEPRCOM set Numerod = @NumeroCorrecto where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov

update SATAXITC set Numerod = @NumeroCorrecto where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov

update SATAXCOM set Numerod = @NumeroCorrecto where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov

delete SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroAnterior and TipoCxP=@tipoRetencion and CodProv=@codprov) and NumeroD=@numeroAnterior

delete from SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroAnterior  and CodProv=@codprov and TipoCxP=@tipocompracxp) and NumeroD=@numeroAnterior

delete SAACXP where NumeroD=@numeroAnterior and CodProv=@codprov and TipoCxP=@tipocompracxp

delete SAACXP where NumeroN=@numeroAnterior and TipoCxP=@tipoRetencion and CodProv=@codprov


