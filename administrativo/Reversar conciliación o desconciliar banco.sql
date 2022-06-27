use EnterpriseAdminDB
declare @Codbanc varchar (30)
declare @Nroconc VARCHAR (4)
DECLARE @ESTADO VARCHAR (1)
DECLARE @PROXCBAN VARCHAR (4)

select *
from SBBANC
SET @Codbanc ='1101020003'
SET @Nroconc='69'
SET @ESTADO='1'
SET @PROXCBAN =(SELECT @Nroconc-1)


--selecciona la conciliacion a eliminar
select * from SBCONC where CodBanc=@Codbanc  and NoConc=@Nroconc--and day(FechaF)='30' and MONTH(FechaF)='11' and YEAR(FechaF)='2012'
--seleccionamos las transacciones entrancito 
select * from SBTRTR where NoConc=@Nroconc and CodBanc=@Codbanc
--seleccionamos el banco y en el campo PrxConc le restamos 1
select * from SBBANC where codbanc=@Codbanc
---seleccionamos la concialiaciones a desconciliar
select * from SBTRAN where NoConc=@Nroconc and CodBanc=@Codbanc


--elimina la conciliacion  
delete SBCONC where CodBanc=@Codbanc  and NoConc=@Nroconc--and day(FechaF)='30' and MONTH(FechaF)='11' and YEAR(FechaF)='2012'

--Actualizar el campo PrxConc y le retamos 1
update SBBANC set PrxConc=@PROXCBAN where codbanc=@Codbanc
 
--Actualizamos  la concialiaciones a desconciliar
Update SBTRAN set Estado=@ESTADO where NoConc=@Nroconc and CodBanc=@Codbanc

--seleccionamos las transacciones entrancito 
select * from SBTRTR where NoConc=@Nroconc and CodBanc=@Codbanc

--Borramos las transacciones entransito 
delete SBTRTR where NoConc=@Nroconc and CodBanc=@Codbanc
