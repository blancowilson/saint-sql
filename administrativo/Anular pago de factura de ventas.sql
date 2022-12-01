
declare @numerod varchar (10),
		@codclie varchar (15),	
		@tiponc varchar(10),
		@tipocxc varchar (10), 
		@NroRegi varchar (10),
		@ClienteAnulado Varchar (10),
		@MostarT Smallint
set @numerod='029911' 
set @codclie='J000025479'
set @tiponc ='B'
set @tipocxc = '41'
--set @clienteAnulado ='A0001'


--select * from  SAACXC where NumeroD = @numerod and CodClie = @codclie and TipoCxc = @tipocxc

	-- busca el numero unico de la nota de credito para verificar el pago en sapag
	set @NroRegi = (select nrounico 
					from  SAACXC 
					where NumeroD = @numerod and CodClie = @codclie and TipoCxc = @tipocxc)
	--print @nroregi
	Declare @NumeroFact as Varchar(10),
			@MontoPagado as float
	--Devolver el saldo a la factura
	DECLARE MontosP CURSOR 
	FOR Select Numerod, monto
	From SAPAGCXC
	where NroPpal = @NroRegi
	OPEN MontosP
	FETCH MontosP INTO @NumeroFact,@MontoPagado
		WHILE (@@FETCH_STATUS = 0)
		BEGIN	
			--select saldo+@MontoPagado,* from SAACXC  where NumeroD = @NumeroFact and TipoCxc = '10'
			update saacxc set Saldo=saldo+@MontoPagado  where NumeroD = @NumeroFact and TipoCxc = '10'
	    FETCH MontosP INTO @NumeroFact,@MontoPagado

	END 
	CLOSE MontosP
	DEALLOCATE MontosP
	
	
	delete from SAACXC
	Where NumeroD = @numerod and CodClie = @codclie and TipoCxc = @tipocxc
	
	-- Borrar Pgos
	delete from SAPAGCXC where nroppal = @NroRegi
	

	

