--VERIFICAR NRO CONCILIACION 

--SELECT CodBanc,NoConc,Descripcion,FechaI,FechaF FROM SBCONC WHERE CodBanc='110102010' order by NoConc desc


declare @Codbanc varchar (30)
declare @Nroconc VARCHAR (4)
DECLARE @ESTADO VARCHAR (1)
DECLARE @PROXCBAN VARCHAR (4)
--
SET @Codbanc ='110102002'
--para saber el numero de conciliacion que vas a eliminar ejecuta la consulta que esta comentada y coloca el codigo de la cuenta contable en la codicion 
SET @Nroconc='65'
SET @ESTADO='1'
SET @PROXCBAN =(SELECT @Nroconc-1)



delete SBCONC where CodBanc=@Codbanc  and NoConc=@Nroconc
update SBBANC set PrxConc=@PROXCBAN where codbanc=@Codbanc
Update SBTRAN set Estado=@ESTADO where NoConc=@Nroconc and CodBanc=@Codbanc
delete SBTRTR where NoConc=@Nroconc and CodBanc=@Codbanc