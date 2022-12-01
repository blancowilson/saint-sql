


select codclie, sum (saldo)-isnull((select sum (saldo) from SAACXC where TipoCxc =31 and codclie = a.codclie group by CodClie),0) saldo 
	into ##Saldo_temp
from SAACXC a
where TipoCxc in (10,20) 
group by CodClie
 
--select c.saldo, t.saldo,*
--from SACLIE c inner join ##Saldo_temp t on c.CodClie = t.codclie
--where c.Saldo<0 

update c
set c.Saldo = t.saldo
from SACLIE c inner join  ##Saldo_temp t on c.CodClie = t.codclie
where c.Saldo<0 

drop table  ##Saldo_temp