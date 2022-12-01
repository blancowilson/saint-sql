--Insertar a un documento en espera de Operaciones de inventario de otra tabla donde se migra la informacion
-- se debe  omitir el primer item del cargo generado
/* Mejoras pendientes 
-- * Crear la cabecera en SaOpei tomando el proximo numero de documento en espera
-- verificar los calculos de saitemopi
-- crear una plantilla para migrar la informacion
*/

--insert into SAITEMOPI(TipoOpI, NumeroD, NroLinea, CodItem, Descrip1, CodUbic, Cantidad, Costo,Precio, FechaE, DEsSeri,CodSucu)
SELECT 'R','000003', (ROW_NUMBER() OVER (ORDER BY codigo))+1 as Num,codigo, p.descrip, '001',([Existencia_S] -P.Existen),([Existencia_S] -P.Existen)*p.Peso,Precio*4.8,getdate(),0,'00000'
from inventario$ I inner join SAPROD p  ON I.codigo = P.CodProd
where [Existencia_S] -P.Existen >0 and codigo not in('BIB-03')


--insert into SAITEMOPI(TipoOpI, NumeroD, NroLinea, CodItem, Descrip1, CodUbic, Cantidad, Costo,Precio, FechaE, DEsSeri,CodSucu)
--SELECT 'R','000003', (ROW_NUMBER() OVER (ORDER BY i.codprod))+1 as Num,I.CodProd, I.descrip, '001',1,1*I.Precio1,PrecioI1*4.8,getdate(),0,'00000'
--from SEASecundariaDB.dbo.SAPROD I 
--where I.Existen >0 and i.CodProd not in('ALM-01')



