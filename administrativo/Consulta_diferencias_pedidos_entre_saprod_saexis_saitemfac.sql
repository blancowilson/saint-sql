
--consultar diferencias
WITH Pedidos (coditem,codubic,cantcom_ped) as
-- Define La Transaccion tempora y la lista de columnas
(
SELECT coditem,codubic, sum(cantidad) as cantcom
 FROM saitemfac
WHERE tipofac = 'E'
group by coditem, codubic
) select coditem, Ped.codubic, ISNULL(Ped.cantcom_ped,0), e.CantCom
from Pedidos Ped RIGHT join SAEXIS E on Ped.coditem = e.CodProd
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
from Pedidos Ped RIGHT join SAEXIS E on Ped.coditem = e.CodProd
where ISNULL(Ped.cantcom_ped,0) <> e.CantCom and (e.CodUbic=Ped.codubic OR Ped.codubic IS NULL) 


--UPDATE EXS
--SET EXS.CantCom =0
--SELECT *
--FROM SAEXIS EXS 
--WHERE NOT EXISTS (select * from SAITEMFAC ITF
--				where TipoFac ='E' and Cantidad >0 
--				AND EXS.CodUbic= ITF.CodUbic) and EXS.CantCom >0

SELECT *
FROM SAPROD PRD INNER JOIN (SELECT CODPROD, SUM(CANTCOM) CANTCOM 
					FROM SAEXIS GROUP BY CodProd) EXS  ON PRD.CodProd = EXS.CODPROD
WHERE EXS.CANTCOM <> PRD.Compro 


update PRD 
set PRD.compro = EXS.cantcom
FROM SAPROD PRD INNER JOIN (SELECT CODPROD, SUM(CANTCOM) CANTCOM 
					FROM SAEXIS GROUP BY CodProd) EXS  ON PRD.CodProd = EXS.CODPROD
WHERE EXS.CANTCOM <> PRD.Compro 