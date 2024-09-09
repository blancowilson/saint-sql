-- corregir un documento
Declare @NumeroErrado as varchar(12) ='*000872';
Declare @NumeroD as varchar(12) ='003109';
Declare @Codclie as varchar(20) ='*000872';


SELECT CodOper, CodClie, *
FROM SAACXC
WHERE TipoCxc ='31' and NumeroD =@NumeroErrado and CodClie =@Codclie
order by fechae desc

SELECT CodOper, NumeroR, *
FROM SAFACT
WHERE TipoFac ='B' and NumeroD =@NumeroErrado and CodClie =@Codclie
order by fechae desc

SELECT  *
FROM SAITEMFAC
WHERE TipoFac ='B' and NumeroD =@NumeroErrado
order by fechae desc

--update safact
--set NumeroD = @NumeroD, CodOper = NULL
--WHERE TipoFac ='B' and NumeroD =@NumeroErrado and CodClie =@Codclie

--update SAACXC
--set NumeroD = @NumeroD, CodOper = NULL
--WHERE TipoCxc ='31' and NumeroD =@NumeroErrado and CodClie =@Codclie

---- colocar los correlativos correctos
--update SACORRELSIS
--set ValueInt = valueint + 1
--WHERE FieldName ='PrxNotaCr'

--update SACORRELSIS
--set ValueInt = Valueint - 1
--WHERE FieldName ='PrxNotaCrNoI'
