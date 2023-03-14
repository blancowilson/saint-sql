declare @TipoTrans varchar(3), @numeroErrado varchar(15), @Tipocom varchar(1),
		@codprov varchar(15),  @TIPOCXP VARCHAR(2), @tipocompracxp VARCHAR(2),
		@NumeroCorrecto varchar (15), @tipoRetencion varchar(2), @tipopago varchar(2),
		@nrolote varchar (15), @signo int

set @numeroErrado='616'
set @codprov='ADI007'
set @nrolote='00001' -- si maneja lote

Select codprov from SACOMP where NumeroD= @numeroErrado

set	@tipotrans='dvc' --co para compra y dvc para deoluion 
	if (@tipotrans ='co' )
		begin
			set @Tipocom='H'
			set @TIPOCXP='10'
			set @tipopago = '41'
			set @tipoRetencion='81'
			set @tipocompracxp='10'
			set @signo = -1
		end 
	else
	if (@tipotrans ='dvc' )
		begin 
			set @Tipocom='I'
			set @TIPOCXP='21'
			set @tipopago = '41'
			set @tipoRetencion='82'
			set @tipocompracxp='10'
			set @signo = 1
		end 

--select  Existen=existen+(Isnull(c.Cantidad,0) * @Signo)
--from SAEXIS E inner join SAITEMCOM c on C.NumeroD = @numeroErrado and c.TipoCom = @Tipocom and c.CodItem = E.codprod
--where c.EsServ =0

update E
set Existen=existen+(Isnull(c.Cantidad,0) * @Signo)
from SAEXIS E inner join SAITEMCOM c on C.NumeroD = @numeroErrado and c.TipoCom = @Tipocom and c.CodItem = E.codprod
			and e.CodUbic = c.CodUbic

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


--- mejora actualizar el saldo del proveedor
--SET DATEFORMAT YMD 

--- recalcular el saldo del estado de cuentas

       DECLARE MProv CURSOR FOR
       SELECT DISTINCT A.CodProv 
       FROM SAPROV A, SAACXP as B
       Where A.CodProv = @codprov
       Order By A.CodProv
       OPEN MProv
       FETCH NEXT FROM MProv INTO @ACTProv
       	WHILE @@FETCH_STATUS=0 BEGIN
       	   SET @SALDOANT=0
                  DECLARE MCURSOR CURSOR FOR
                  SELECT A.CodProv, A.FechaE, A.NroUnico, A.NumeroD,
                         A.TipoCxP, A.Monto,  A.Saldo,    A.Saldoact
                  FROM SAACXP as A
       	   Where A.CodProv = @ACTPROV
                  ORDER BY CodProv, A.FechaE, A.NroUnico
                  OPEN Mcursor
                  FETCH NEXT FROM Mcursor INTO @CodProv, @FECHAE, @NroUnico, @NumeroD,
                                            @TipoCxP, @Monto,  @Saldo,    @Saldoact
                  WHILE (@@FETCH_STATUS<>-1)
                   BEGIN
                     IF (@@FETCH_STATUS<>-2)
                        BEGIN
                          SET @FACTOR=CASE SUBSTRING(@TIPOCXP,1,1)
                                       WHEN '1' THEN 1
                                       WHEN '3' THEN 1
                                       WHEN '2' THEN -1
                                       WHEN '4' THEN -1
                                       WHEN '5' THEN -1
                                       WHEN '6' THEN 1
                                       WHEN '7' THEN 1
                                       WHEN '8' THEN -1  
                                      END
                          IF (SUBSTRING(@TIPOCXP,1,1) <>'5')
                             SET @SALDOANT=@SALDOANT+@FACTOR*@MONTO
                          UPDATE SAACXP
                          SET SALDOACT = @saldoant
                          WHERE NroUnico = @NroUnico
                        END
                     FETCH NEXT
                     FROM Mcursor
                     INTO @Codprov, @FECHAE, @NroUnico, @NumeroD,
                          @TipoCxP, @Monto,  @Saldo, @Saldoact
                   END
                  CLOSE MCursor
                  DEALLOCATE MCursor
       	   FETCH NEXT FROM MProv INTO @ACTPROV
       END
       CLOSE MProv
       DEALLOCATE MProv

