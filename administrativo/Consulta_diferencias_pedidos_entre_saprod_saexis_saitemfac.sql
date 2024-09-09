
--consultar diferencias
WITH Pedidos (coditem,codubic,cantcom_ped) as
-- Define La Transaccion tempora y la lista de columnas
(
SELECT coditem,codubic, sum(cantidad) as cantcom
 FROM saitemfac
WHERE tipofac = 'E'
group by coditem, codubic
) select coditem, E.CodProd, PRD.Descrip, Ped.codubic,e.CodUbic, ISNULL(Ped.cantcom_ped,0), e.CantCom
from Pedidos Ped RIGHT join SAEXIS E on Ped.coditem = e.CodProd and ped.codubic = e.CodUbic
INNER JOIN SAPROD PRD ON PRD.CodProd = E.CodProd
where ISNULL(Ped.cantcom_ped,0) <> e.CantCom and (e.CodUbic=Ped.codubic OR Ped.codubic IS NULL)


with pedidos (coditem,codubic,cantcom_ped) as
-- Define La Transaccion tempora y la lista de columnas
(
select coditem,codubic, sum(cantidad) as cantcom
 from saitemfac
where tipofac = 'E'
group by coditem, codubic
) 
update e
set e.cantcom = ISNULL(Ped.cantcom_ped,0)
from Pedidos Ped RIGHT join SAEXIS E on Ped.coditem = e.CodProd and ped.codubic = e.CodUbic
where ISNULL(Ped.cantcom_ped,0) <> e.CantCom and (e.CodUbic=Ped.codubic OR Ped.codubic IS NULL) 


SELECT EXS.CANTCOM, PRD.Compro, *
FROM SAPROD PRD INNER JOIN (SELECT CODPROD, SUM(CANTCOM) CANTCOM 
					FROM SAEXIS GROUP BY CodProd) EXS  ON PRD.CodProd = EXS.CODPROD
WHERE EXS.CANTCOM <> PRD.Compro 


update PRD 
set PRD.compro = EXS.cantcom
FROM SAPROD PRD INNER JOIN (SELECT CODPROD, SUM(CANTCOM) CANTCOM 
					FROM SAEXIS GROUP BY CodProd) EXS  ON PRD.CodProd = EXS.CODPROD
WHERE EXS.CANTCOM <> PRD.Compro 