select Existen, Cantidad, Existen+Cantidad,*
from Inv_280222 c inner join SAPROD p
on Código = p.CodProd
where Existen+Cantidad=0

select * from Inv_280222

select '00000','P','000012',(row_number() over(order by E.Código))+1, 0, E.Código,
 e.deposito,P.Descrip, -1,E.Cantidad, p.CostAct,p.CostAct*e.Cantidad costo,
 CONVERT (datetime, '28-02-2022', 103), CONVERT (datetime, '28-02-2022', 103)
from SEAElMagoDb.dbo.Inv_280222 E INNER JOIN SAPROD P ON E.Código = P.CodProd 
where e.Cantidad>0

select '00000','P','000012',(row_number() over(order by E.Código))+1, 0, E.Código,
 e.deposito,P.Descrip, -1,E.Cantidad, p.CostAct,p.CostAct*e.Cantidad costo,
 CONVERT (datetime, '28-02-2022', 103), CONVERT (datetime, '28-02-2022', 103)
from SEAElMagoDb.dbo.Inv_280222 E INNER JOIN SAPROD P ON E.Código = P.CodProd 
where e.Cantidad<0