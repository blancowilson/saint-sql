DECLARE @CodClie  VARCHAR(12)
DECLARE @TipoFac  VARCHAR(2)
DECLARE @NumeroD  VARCHAR(20)
DECLARE @TIPO     VARCHAR(2)
DECLARE @CodItem  VARCHAR(15)
DECLARE @CodUbic  VARCHAR(10)
DECLARE @Cantidad  DECIMAL(28,3)
DECLARE @EsUnid   SMALLINT
DECLARE @ExUnidad int
DECLARE @Variable1 decimal(28,2)
DECLARE @Variable2 int 
DECLARE @Variable3 decimal(28,2)
DECLARE @CantEmpaq int
DECLARE @Existen  DECIMAL(28,3)
DECLARE @FechaE   datetime
DECLARE @FechaT   datetime
declare @CantDoc int
Declare @TipoCxc varchar (5),
@NroRegi varchar (10)

SET DATEFORMAT YMD

set @numerod='003028' 
set @codclie='J410318350'
set @TipoFac ='B'
set @tipocxc = '31'


/*  Mejoras pendientes 
*************************************************
---------  eliminar el pago en Sapagcxc
---------
*****************************************************
*/
-- reversar los pagos que correspondia a la N/C 
set @NroRegi = (select nrounico 
					from SAACXC 
					where NumeroD = @numerod and CodClie = @codclie and TipoCxc = @tipocxc)
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
			update saacxc set Saldo=saldo+@MontoPagado where NumeroD = @NumeroFact and TipoCxc = '10'
	    FETCH MontosP INTO @NumeroFact,@MontoPagado

	END 
	CLOSE MontosP
	DEALLOCATE MontosP

--select * from SAFACT where NumeroD =@NumeroD and TipoFac =@TipoFac

--SELECT CodClie,Descrip,NumeroD,*  FROM SAFACT WHERE NumeroD=@numerod AND TipoFac=@TipoFac
--SELECT * FROM SAITEMFAC WHERE NumeroD=@numerod AND TipoFac=@TipoFac
--select * from SATAXVTA WHERE NumeroD=@numerod AND TipoFac=@TipoFac
--select * from sataxitf WHERE NumeroD=@numerod AND TipoFac=@TipoFac
--SELECT * FROM SAACXC WHERE NumeroD=@numerod AND TipoCxc='31' AND CodClie='J-08009419-0'
/*
	actualizar numerounico
	set @NroRegi = (select nrounico 
					from SAACXC 
					where NumeroD = @numerod and CodClie = @codclie and TipoCxc = @tipocxc)
*/

	 DECLARE MCURSOR CURSOR FOR
	 SELECT A.CodItem, A.Cantidad, A.CodUbic, A.EsUnid
	 FROM SAitemfac as A
	 WHERE A.tipofac = @TipoFac And A.Numerod=@NumeroD AND EsServ = 0
	 ORDER BY A.NroLinea
	 OPEN Mcursor
	 FETCH NEXT FROM Mcursor INTO @CodItem, @Cantidad, @CodUbic, @EsUnid
	 WHILE (@@FETCH_STATUS<>-1)
	  BEGIN
		IF (@@FETCH_STATUS<>-2)
		   BEGIN
			   -- SET @Existen=@Cantidad*@Signo
				IF @EsUnid=0
					 begin			 
						UPDATE SAEXIS
						SET EXISTEN = existen- @Cantidad
						WHERE codprod = @CodItem and CodUbic=@CodUbic
						UPDATE SAPROD
						SET EXISTEN = existen- @Cantidad
						WHERE codprod = @CodItem 
					end
				else if @EsUnid=1 
					 begin
						 SELECT @CantEmpaq = CantEmpaq, @ExUnidad= ExUnidad, @Existen=Existen  from saprod where codprod=@CodItem  
						 set @variable1=(@Existen*@CantEmpaq+@ExUnidad+@Cantidad)
						 set @variable2=@variable1/@CantEmpaq
						 set @variable3=@variable1-@variable2*@CantEmpaq
						 UPDATE SAPROD
						 SET EXISTEN = @variable2, ExUnidad= @Variable3
						 WHERE codprod = @CodItem  
						 SELECT @ExUnidad= ExUnidad, @Existen=Existen  from saexis where codprod=@CodItem  and CodUbic=@CodUbic
						 set @variable1=(@Existen*@CantEmpaq+@ExUnidad+@Cantidad)
						 set @variable2=@variable1/@CantEmpaq
						 set @variable3=@variable1-@variable2*@CantEmpaq
						 UPDATE SAEXIS
						 SET EXISTEN = @variable2, ExUnidad= @Variable3
						 WHERE codprod = @CodItem and CodUbic=@CodUbic
					 end
			End
		FETCH NEXT
		FROM Mcursor
		INTO @CodItem, @Cantidad, @CodUbic, @EsUnid
	  END
	 CLOSE Mcursor
	 DEALLOCATE Mcursor 




--colocar en 0 la nota de credito en 0
update safact set descrip='ANULADO', monto=0, mtotax=0, tgravable=0, costoprd=0, TExento=0,
Credito=0, TotalPrd=0, MtoTotal=0, CancelC=0, Descto1=0, Contado=0, CancelE=0, TotalSrv=0, CostoSrv=0,numeror=NULL
WHERE NumeroD=@numerod AND TipoFac=@TipoFac

update saitemfac set cantidad=0 WHERE NumeroD=@numerod AND TipoFac=@TipoFac

update sataxvta set monto=0, mtotax=0, tgravable=0 WHERE NumeroD=@numerod AND TipoFac=@TipoFac

update sataxitf set monto=0, tgravable=0, mtotax=0 
WHERE NumeroD=@numerod AND TipoFac=@TipoFac

update saacxc set orgtax=0, saldoorg=0, monto=0, montoneto=0, mtotax=0, saldo=0,
saldoact=saldoact+monto, baseimpo=0, TExento=0,Document ='Anulado'
WHERE NumeroD=@numerod AND TipoCxc=@tipocxc AND CodClie=@codclie

--Liberar factura
---
       DECLARE @CodClien    varchar(15)
       DECLARE @ActClie    varchar(15)
       DECLARE @Monto      decimal(13,2)
       DECLARE @NroUnico   INT
       DECLARE @Saldo      decimal(13,2)
       DECLARE @Saldoact   decimal(13,2)
       DECLARE @FACTOR     SMALLINT
       DECLARE @Saldoant   DECIMAL(13,2)
       DECLARE MCLIE CURSOR FOR
       SELECT DISTINCT A.CodClie 
       FROM SAClie A, SAACxC as B
       Where A.CodClie = @codclie
       Order By A.CodClie
       OPEN MCLIE
       FETCH NEXT FROM MCLIE INTO @ACTClie
       	WHILE @@FETCH_STATUS=0 BEGIN
       	   SET @SALDOANT=0
                  DECLARE MCURSOR CURSOR FOR
                  SELECT A.CodClie, A.FechaE, A.NroUnico, A.NumeroD,
                         A.TipoCxC, A.Monto,  A.Saldo,    A.Saldoact
                  FROM SAACxC as A
       	   Where A.CodClie = @ACTClie
                  ORDER BY CodClie, A.FechaE, A.NroUnico
                  OPEN Mcursor
                  FETCH NEXT FROM Mcursor INTO @CodClie, @FECHAE, @NroUnico, @NumeroD,
                                            @TipoCxC, @Monto,  @Saldo,    @Saldoact
                  WHILE (@@FETCH_STATUS<>-1)
                   BEGIN
                     IF (@@FETCH_STATUS<>-2)
                        BEGIN
                          SET @FACTOR=CASE SUBSTRING(@TIPOCxC,1,1)
                                       WHEN '1' THEN 1
                                       WHEN '2' THEN 1
                                       WHEN '3' THEN -1
                                       WHEN '4' THEN -1
                                       WHEN '5' THEN -1
                                       WHEN '6' THEN 1
                                       WHEN '7' THEN 1
                                       WHEN '8' THEN -1  
                                      END
                          IF (@TIPOCxC<>'50')
                             SET @SALDOANT=@SALDOANT+@FACTOR*@MONTO
                          UPDATE SAACxC
                          SET SALDOACT = @saldoant
                          WHERE NroUnico = @NroUnico
                        END
                     FETCH NEXT
                     FROM Mcursor
                     INTO @CodClie, @FECHAE, @NroUnico, @NumeroD,
                          @TipoCxC, @Monto,  @Saldo, @Saldoact
                   END
                  CLOSE MCursor
                  DEALLOCATE MCursor
       	   FETCH NEXT FROM MCLIE INTO @ACTClie
       END
       CLOSE MCLIE
       DEALLOCATE MCLIE

