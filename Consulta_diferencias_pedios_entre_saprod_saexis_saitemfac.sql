
--consultar diferencias
with pedidos (coditem,codubic,cantcom_ped) as
-- Define La Transaccion tempora y la lista de columnas
(
select coditem,codubic, sum(cantidad) as cantcom
 from saitemfac
where tipofac = 'E'
group by coditem, codubic
) select coditem, p.cantcom_ped, e.CantCom
from pedidos p inner join SAEXIS E on p.coditem = e.CodProd
where p.cantcom_ped <> e.CantCom and e.CodUbic='001'


with pedidos (coditem,codubic,cantcom_ped) as
-- Define La Transaccion tempora y la lista de columnas
(
select coditem,codubic, sum(cantidad) as cantcom
 from saitemfac
where tipofac = 'E'
group by coditem, codubic
) 
update e
set e.cantcom = p.cantcom_ped
from pedidos p inner join SAEXIS E on p.coditem = e.CodProd
where p.cantcom_ped <> e.CantCom and e.CodUbic='001'--se debe mejorar en 


update SAEXIS
set CantCom =0
where CodProd not in (select coditem from SAITEMFAC where TipoFac ='E' and Cantidad >0) and CodUbic ='001' and CantCom >0

update P 
set p.compro = e.cantcom
from SAPROD p inner join SAEXIS E on p.CodProd = e.CodProd
where e.CodUbic ='001' and p.Compro <>e.CantCom
