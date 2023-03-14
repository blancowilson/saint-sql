declare @numeroAnterior varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@tipocompracxp VARCHAR(2),
		@NumeroCorrecto varchar (15),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)

set @numeroAnterior='22-18721'
set @codprov='J300180174'
set @Tipocom='H'
set @TIPOCXP='10'
set @tipopago = '41'
set @tipoRetencion='81'
set @nrolote='00001'
set @tipocompracxp='10'


select *	From	SACOMP		where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
select *	From    SACOMP		where NumeroN=@numeroAnterior and CodProv=@codprov
select *	From	SAITEMCOM	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
select *	From	SASEPRCOM	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
select *	From	SATAXITC	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
select *	From	SATAXCOM	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
select *	From	SAPAGCXP	where NroRegi=(select NroUnico from SAACXP where NumeroD=@numeroAnterior  and CodProv=@codprov) and NumeroD=@numeroAnterior
--select *	From    SAPAGCXP	where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroAnterior  and CodProv=@codprov) and NumeroD=@numeroAnterior
select *	From	SAACXP		where NumeroD=@numeroAnterior and CodProv=@codprov
select *	From	SAACXP		where NumeroN=@numeroAnterior and CodProv=@codprov

--compra
update SACOMP set Numerod = @NumeroCorrecto where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
-- items de compra
update     SACOMP		set numerod=@NumeroCorrecto	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
Update     SACOMP		set numeroN=@NumeroCorrecto	where NumeroN=@numeroAnterior and CodProv=@codprov
update    SAITEMCOM		set numerod=@NumeroCorrecto	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
update	  SASEPRCOM		set numerod=@NumeroCorrecto	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
update	  SATAXITC		set numerod=@NumeroCorrecto	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
update	  SATAXCOM		set numerod=@NumeroCorrecto	where NumeroD=@numeroAnterior and TipoCom=@Tipocom and CodProv=@codprov
update	  SAPAGCXP		set numerod=@NumeroCorrecto	where NroRegi=(select NroUnico from SAACXP where NumeroD=@numeroAnterior  and CodProv=@codprov) and NumeroD=@numeroAnterior
--update	   SAPAGCXP		set numerod=@NumeroCorrecto	where NroPpal=(select NroUnico from SAACXP where NumeroN=@numeroAnterior  and CodProv=@codprov) and NumeroD=@numeroAnterior
update	  SAACXP		set numerod=@NumeroCorrecto	where NumeroD=@numeroAnterior and CodProv=@codprov
update 	  SAACXP		set numeroN=@NumeroCorrecto	where NumeroN=@numeroAnterior and CodProv=@codprov
