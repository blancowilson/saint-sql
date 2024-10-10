
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
SET DATEFORMAT YMD
set @TipoFac = 'A'
set  @NumeroD = '*000448'
set  @CodClie = 'J312657219'
set  @FechaE = getdate()
set  @FechaT = Getdate() 

SELECT     @CantDoc=COUNT(*) 
FROM         SAPAGCXC
WHERE     (NumeroD =@NumeroD) AND (TipoCxc = '10');
print @cantdoc
-- verificar items de la factura
--select * from SAITEMFAC  where NumeroD =@NumeroD  and TipoFac = @TipoFac 

select @FechaE = Fechae from safact where tipofac='a' and Numerod=@NumeroD
--if @CantDoc=0 and LEFT (CONVERT (varchar, @FechaE, 112), 6)=(select mescurso from saconf) and @codclie=(select codclie from safact where tipofac='a' and Numerod=@NumeroD)
--begin
	SELECT @TIPO = tipofac from safact where numerod=@numerod and tipofac=@tipofac

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
				 SET EXISTEN = existen+ @Cantidad
				 WHERE codprod = @CodItem and CodUbic=@CodUbic
				 UPDATE SAPROD
				 SET EXISTEN = existen+ @Cantidad
				 WHERE codprod = @CodItem 
				 end
             else if @EsUnid=1 begin
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
		   end
		FETCH NEXT
		FROM Mcursor
		INTO @CodItem, @Cantidad, @CodUbic, @EsUnid
	  END
	 CLOSE Mcursor
	 DEALLOCATE Mcursor 



	IF @TIPO ='A' BEGIN
	update safact set descrip='ANULADO', monto=0, mtotax=0, tgravable=0, costoprd=0, TExento=0, 
	Credito=0, TotalPrd=0, MtoTotal=0, CancelC=0, Descto1=0, Contado=0, CancelE=0, TotalSrv=0, CostoSrv=0
	where numerod=@NumeroD and tipoFac=@TipoFac
	
	update saitemfac set cantidad=0 where numerod=@NumeroD and TipoFac=@TipoFac	

	update sataxvta set monto=0, mtotax=0, tgravable=0
	where numerod=@NumeroD and tipoFac=@TipoFac

	update sataxitf set monto=0, tgravable=0, mtotax=0
	where numerod=@NumeroD and tipoFac=@TipoFac

	update saacxc set orgtax=0, saldoorg=0, monto=0, montoneto=0, mtotax=0, saldo=0, saldoact=saldoact-monto, baseimpo=0, TExento=0 
	where numerod=@NumeroD and tipoCxC='10'
     -- si maneja seriales
	 --   INSERT INTO SASERI (CODPROD,CODUBIC,NROSERIAL)
		--(SELECT CODITEM,CODUBIC,NROSERIAL FROM SASEPRFAC WHERE NUMEROD=@NUMEROD AND TIPOFAC=@TIPOFAC)	
	
	DELETE SASEPRFAC WHERE NUMEROD=@NUMEROD AND TIPOFAC=@TIPOFAC


	--end
	--DELETE FROM SACLIE_01 WHERE CODCLIE=@CodClie and NroFactura not in(select NumeroD from Safact where TipoFac='A')
--end
--ELSE BEGIN
--DELETE FROM SACLIE_01 WHERE NROUNICO=(SELECT NROUNICO FROM INSERTED)
END


-- actualizar saldo de cliente 

       DECLARE @CodClien    varchar(15)
       DECLARE @ActClie    varchar(15)
       DECLARE @Monto      decimal(13,2)
       DECLARE @NroUnico   INT
       DECLARE @Saldo      decimal(13,2)

       DECLARE @TipoCxC    varchar(2)
       DECLARE @Saldoact   decimal(13,2)
       DECLARE @FACTOR     SMALLINT
       DECLARE @Saldoant   DECIMAL(13,2)
       --set @CodClien=(select codclie from inserted)
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


