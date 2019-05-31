update SAPROD
set Compro=0
where CodProd='11193-15010'

update SAEXIS 
set cantcom=0
where CodProd='11193-15010'


select sum(cantidad)
from SAITEMFAC
where CodItem ='11193-15010' and TipoFac='E'
group by CodItem,CodUbic

select compro from SAPROD
where CodProd='11193-15010'

select CantCom from SAEXIS
where codprod ='11193-15010'




update SAEXIS 
set cantcom=0
where CodProd='23220-21132'