-- error en registro de Nota de credito 
declare @NumeroErrado as varchar(20),
		@Codclie as varchar(20),
		@NumeroDCorrecto as varchar(20),
		@CodOper as varchar(14)

set @NumeroErrado = '*000578'
set @NumeroDCorrecto = '003079'
set @Codclie = 'V-12634092-6'

--select numeror,codoper,* 
--from safact 
--where tipofac = 'b'  and NumeroD = @NumeroErrado and CodClie =@Codclie
--order by FechaE desc

--select numeror,codoper,* 
--from safact 
--where tipofac = 'A'  and NumeroD = '007119'

--select *
--from SATAXVTA
--where TipoFac = 'B'
--order by NumeroD desc

--select numerod,*
--from SAACXC
--where TipoCxc = 31 and CodClie = @Codclie and NumeroD= @NumeroErrado
--order by fechae desc

--select *
--from SAITEMFAC
--where TipoFac ='B'
--order by FechaE desc

--select *
--from SATAXVTA
--where TipoFac = 'B'
--order by NumeroD desc

--select *
--from SACORRELSIS
--where FieldName in ('PrxNotaCrNoI','PrxNotaCr')


Update SACORRELSIS
set valueint = 578
where FieldName in ('PrxNotaCrNoI')

Update SACORRELSIS
set valueint = 3080
where FieldName in ('PrxNotaCr')

Update safact 
set NumeroD = @NumeroDCorrecto
where tipofac = 'b'  and NumeroD = @NumeroErrado and CodClie =@Codclie

update SAACXC
set NumeroD = @NumeroDCorrecto
where TipoCxc = 31 and CodClie = @Codclie and NumeroD= @NumeroErrado

