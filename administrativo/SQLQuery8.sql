delete from cargos
where cantidad <=0

select * from cargos
order by codigo

select * from eadmintoyotexdb.dbo.SAITEMOPI
where NumeroD ='0000001' and CodItem like '04371%'


select * from cargos
where codigo not in (select codprod from eadmintoyotexdb.dbo.SAPROD)

select * from
EAdminRYLDB.dbo.SAPROD
where CodProd ='BP4K-34170CMTR'

SELECT * FROM SAPROD
WHERE CodProd LIKE '%GUMZ-1TY%'

UPDATE cargos set codigo ='12371-11240MTR'
where codigo ='12372-11240MTR'

SELECT * FROM SAPROD
WHERE CodProd like 'BP4K-34170CMTR'

SELECT * FROM SAPROD
WHERE CodProd like '04371-35031ty'

select * from SAPROD where Descrip like '%ROTULA DE DIRECCION DE CHEVROLET%'

select * from SAINSTA 
where CodInst ='5'

update SACORRELSIS set ValueInt =1
where FieldName ='PrxCargo'


update c
set c.Nombre = p.Descrip
from cargos c inner join SAPROD p on c.codigo = p.CodProd

select * from SAITEMOPI 
where NumeroD ='0000008'