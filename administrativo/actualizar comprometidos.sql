UPDATE SAEXIS
SET CantCom =0
where CodProd not in (select coditem 
						from SAITEMFAC
						where TipoFac ='E' and Cantidad>0
						group by CodItem) and CantCom<>0


WITH It (Codprod,CodUbic, Pedidos) AS
(
   SELECT It.CodItem,It.CodUbic, SUM(It.cantidad) as Pedidos
     -- FROM SAEXIS Ex
       --  JOIN SAITEMFAC It ON Ex.CodProd = It.CodItem and Ex.CodUbic = It.CodUbic
	from SAITEMFAC IT 	
		where It.TipoFac ='E'
      GROUP BY It.CodItem,It.CodUbic
)
UPDATE Ex SET Ex.CantCom = It.Pedidos
   FROM SAEXIS Ex
      INNER JOIN It ON It.Codprod = Ex.CodProd and Ex.CodUbic=It.CodUbic
where It.Pedidos<>ex.CantCom


WITH Exis (Codprod, Pedidos) AS
(
   SELECT Ex.CodProd, SUM(Ex.cantcom) as Pedidos
      FROM SAEXIS Ex
      GROUP BY Ex.CodProd
)
UPDATE Pr SET Pr.Compro = Exis.Pedidos
   FROM SAPROD pr
      INNER JOIN Exis ON Exis.Codprod = Pr.CodProd 
where Exis.Pedidos<>Pr.Compro

WITH Exis (Codprod, Pedidos) AS
(
   SELECT Ex.CodProd, SUM(Ex.cantcom) as Pedidos
      FROM SAEXIS Ex
      GROUP BY Ex.CodProd
)
select pr.CodProd,pr.Existen,pr.Compro,exis.Pedidos
   FROM SAPROD pr
      INNER JOIN Exis ON Exis.Codprod = Pr.CodProd 
where Exis.Pedidos<>Pr.Compro







with Exis (CodProd,Pedidos) as
(
   SELECT Ex.CodProd, SUM(Ex.CantCom) as Pedidos
      FROM SAPROD Pro
         JOIN SAEXIS Ex ON Ex.CodProd = Pro.CodProd 
      GROUP BY Ex.CodProd
	  having SUM(Ex.CantCom)<>0
)
Select * --SET P.compro = Exis.Pedidos
   FROM SAPROD P
      INNER JOIN Exis ON P.Codprod = Exis.CodProd 
where Exis.Pedidos<>P.Compro







select p.CodProd, sum(p.Existen) Exist_produc,sum(e.Existen) Exist_E, sum(e.CantCom) Cant_comp_exi,sum(p.Compro) Cant_comp_pro
 from SAPROD P  right join SAEXIS e on  (p.CodProd = e.codprod)
group by p.CodProd
having sum(p.Compro)<>sum(e.CantCom)

select DISTINCT codubic
from SAITEMFAC i 
where  TipoFac='E' 
group by i.CodItem, i.CodUbic
having sum(i.cantidad) <> 0

select p.Existen,e.Existen,p.Compro,e.CantCom, * from SAPROD p inner join SAEXIS e 
on p.CodProd =e.CodProd
where p.CodProd ='04111-0D152'

select sum(cantidad)
from SAITEMFAC
where TipoFac ='E' and coditem ='04111-0D152'