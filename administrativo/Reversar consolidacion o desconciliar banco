use basedatos
declare @Codbanc varchar (30)
declare @Nroconc VARCHAR (4)
DECLARE @ESTADO VARCHAR (1)
DECLARE @PROXCBAN VARCHAR (4)

SET @Codbanc ='110102010'
SET @Nroconc='10'
SET @ESTADO='1'
SET @PROXCBAN =(SELECT @Nroconc-1)

--selecciona la conciliacion a eliminar
select * from SBCONC where CodBanc=@Codbanc  and NoConc=@Nroconc--and day(FechaF)='30' and MONTH(FechaF)='11' and YEAR(FechaF)='2012'

--elimina la conciliacion  

delete SBCONC where CodBanc=@Codbanc  and NoConc=@Nroconc--and day(FechaF)='30' and MONTH(FechaF)='11' and YEAR(FechaF)='2012'

--seleccionamos el banco y en el campo PrxConc le retamos 1

select * from SBBANC where codbanc=@Codbanc

--Actualizar el campo PrxConc y le retamos 1

update SBBANC set PrxConc=@PROXCBAN where codbanc=@Codbanc
 
---seleccionamos la concialiaciones a desconciliar

select * from SBTRAN where NoConc=@Nroconc and CodBanc=@Codbanc

--Actualizamos  la concialiaciones a desconciliar

Update SBTRAN set Estado=@ESTADO where NoConc=@Nroconc and CodBanc=@Codbanc

--seleccionamos las transacciones entrancito 

select * from SBTRTR where NoConc=@Nroconc and CodBanc=@Codbanc

--Borramos las transacciones entransito 

delete SBTRTR where NoConc=@Nroconc and CodBanc=@Codbanc
