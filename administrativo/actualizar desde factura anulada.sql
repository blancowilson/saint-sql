UPDATE  Dest
                  SET Dest.TipoFac = Ori.TipoFac, Dest.NumeroD = Ori.NumeroD,  Dest.NroCtrol = Ori.NroCtrol, Dest.Status = Ori.Status, Dest.CodSucu = Ori.CodSucu, Dest.CodEsta = Ori.CodEsta, Dest.CodUsua = Ori.CodUsua, Dest.EsCorrel = Ori.EsCorrel, Dest.CodConv = Ori.CodConv, Dest.Signo = Ori.Signo, Dest.FechaT = Ori.FechaT, Dest.OTipo = Ori.OTipo, Dest.ONumero = Ori.ONumero, Dest.TipoTra = Ori.TipoTra, Dest.NumeroC = Ori.NumeroC, Dest.NumeroT = Ori.NumeroT, Dest.NumeroR = Ori.NumeroR, Dest.FechaD1 = Ori.FechaD1, Dest.NumeroD1 = Ori.NumeroD1, Dest.NumeroK = Ori.NumeroK, Dest.NumeroF = Ori.NumeroF, Dest.NumeroP = Ori.NumeroP, Dest.NumeroE = Ori.NumeroE, Dest.NumeroZ = Ori.NumeroZ, Dest.EsExPickup = Ori.EsExPickup, Dest.Moneda = Ori.Moneda, Dest.Factor = Ori.Factor, Dest.MontoMEx = Ori.MontoMEx, Dest.CodClie = Ori.CodClie, Dest.CodVend = Ori.CodVend, Dest.CodUbic = Ori.CodUbic, Dest.Descrip = Ori.Descrip, Dest.Direc1 = Ori.Direc1, Dest.Direc2 = Ori.Direc2, Dest.Direc3 = Ori.Direc3, Dest.Pais = Ori.Pais, Dest.Estado = Ori.Estado, Dest.Ciudad = Ori.Ciudad, Dest.Municipio = Ori.Municipio, Dest.ZipCode = Ori.ZipCode, Dest.Telef = Ori.Telef, Dest.ID3 = Ori.ID3, Dest.Monto = Ori.Monto, Dest.MtoTax = Ori.MtoTax, Dest.Fletes = Ori.Fletes, Dest.TGravable = Ori.TGravable, Dest.TExento = Ori.TExento, Dest.CostoPrd = Ori.CostoPrd, Dest.CostoSrv = Ori.CostoSrv, Dest.DesctoP = Ori.DesctoP, Dest.RetenIVA = Ori.RetenIVA, Dest.FechaR = Ori.FechaR, Dest.FechaI = Ori.FechaI, Dest.FechaE = Ori.FechaE, Dest.FechaV = Ori.FechaV, Dest.MtoTotal = Ori.MtoTotal, Dest.Contado = Ori.Contado, Dest.Credito = Ori.Credito, Dest.CancelI = Ori.CancelI, Dest.CancelA = Ori.CancelA, Dest.CancelE = Ori.CancelE, Dest.CancelC = Ori.CancelC, Dest.CancelT = Ori.CancelT, Dest.CancelG = Ori.CancelG, Dest.CancelP = Ori.CancelP, Dest.Cambio = Ori.Cambio, Dest.EsConsig = Ori.EsConsig, Dest.MtoExtra = Ori.MtoExtra, Dest.ValorPtos = Ori.ValorPtos, Dest.Descto1 = Ori.Descto1, Dest.PctAnual = Ori.PctAnual, Dest.MtoInt1 = Ori.MtoInt1, Dest.Descto2 = Ori.Descto2, Dest.PctManejo = Ori.PctManejo, Dest.MtoInt2 = Ori.MtoInt2, Dest.SaldoAct = Ori.SaldoAct, Dest.MtoPagos = Ori.MtoPagos, Dest.MtoNCredito = Ori.MtoNCredito, Dest.MtoNDebito = Ori.MtoNDebito, Dest.MtoFinanc = Ori.MtoFinanc, Dest.DetalChq = Ori.DetalChq, Dest.TotalPrd = Ori.TotalPrd, Dest.TotalSrv = Ori.TotalSrv, Dest.OrdenC = Ori.OrdenC, Dest.CodOper = Ori.CodOper, Dest.NGiros = Ori.NGiros, Dest.NMeses = Ori.NMeses, Dest.MtoComiVta = Ori.MtoComiVta, Dest.MtoComiCob = Ori.MtoComiCob, Dest.MtoComiVtaD = Ori.MtoComiVtaD, Dest.MtoComiCobD = Ori.MtoComiCobD, Dest.Notas1 = Ori.Notas1, Dest.Notas2 = Ori.Notas2, Dest.Notas3 = Ori.Notas3, Dest.Notas4 = Ori.Notas4, Dest.Notas5 = Ori.Notas5, Dest.Notas6 = Ori.Notas6, Dest.Notas7 = Ori.Notas7, Dest.Notas8 = Ori.Notas8, Dest.Notas9 = Ori.Notas9, Dest.Notas10 = Ori.Notas10, Dest.TipoTraE = Ori.TipoTraE, Dest.NumeroNCF = Ori.NumeroNCF, Dest.TGravable0 = Ori.TGravable0, Dest.AutSRI = Ori.AutSRI, Dest.AutSRIReten = Ori.AutSRIReten, Dest.FecCadReten = Ori.FecCadReten, Dest.EstablReten = Ori.EstablReten, Dest.PtoEmiReten = Ori.PtoEmiReten, Dest.FechaSRI = Ori.FechaSRI, Dest.NroEstable = Ori.NroEstable, Dest.PtoEmision = Ori.PtoEmision, Dest.EstadoFE = Ori.EstadoFE, Dest.CodTran = Ori.CodTran, Dest.FromTran = Ori.FromTran, Dest.TipoDev = Ori.TipoDev, Dest.CodTarj = Ori.CodTarj, Dest.NroTurno = Ori.NroTurno, Dest.NIT = Ori.NIT
                  FROM EnterpriseAdminDb150824.dbo.safact ORI
                  INNER JOIN EnterpriseAdminDb.dbo.safact Dest
                  ON DEST.NumeroD = ORI.NumeroD  AND DEST.NroUnico = ORI.NroUnico
where DEST.NumeroD ='077008'


UPDATE  Dest
                  SET Dest.CodClie = Ori.CodClie, Dest.NroRegi = Ori.NroRegi, Dest.FechaI = Ori.FechaI, Dest.FechaE = Ori.FechaE, Dest.FechaV = Ori.FechaV, Dest.FechaT = Ori.FechaT, Dest.FechaR = Ori.FechaR, Dest.CodSucu = Ori.CodSucu, Dest.CodEsta = Ori.CodEsta, Dest.CodUsua = Ori.CodUsua, Dest.CodOper = Ori.CodOper, Dest.CodVend = Ori.CodVend, Dest.NumeroT = Ori.NumeroT, Dest.NumeroN = Ori.NumeroN, Dest.FechaD1 = Ori.FechaD1, Dest.NumeroD1 = Ori.NumeroD1, Dest.NroCtrol = Ori.NroCtrol, Dest.FromTran = Ori.FromTran, Dest.TipoCxc = Ori.TipoCxc, Dest.Moneda = Ori.Moneda, Dest.Factor = Ori.Factor, Dest.MontoMEx = Ori.MontoMEx, Dest.SaldoMEx = Ori.SaldoMEx, Dest.Document = Ori.Document, Dest.Notas1 = Ori.Notas1, Dest.Notas2 = Ori.Notas2, Dest.Notas3 = Ori.Notas3, Dest.Notas4 = Ori.Notas4, Dest.Notas5 = Ori.Notas5, Dest.Notas6 = Ori.Notas6, Dest.Notas7 = Ori.Notas7, Dest.Notas8 = Ori.Notas8, Dest.Notas9 = Ori.Notas9, Dest.Notas10 = Ori.Notas10, Dest.Monto = Ori.Monto, Dest.MontoNeto = Ori.MontoNeto, Dest.MtoTax = Ori.MtoTax, Dest.RetenIVA = Ori.RetenIVA, Dest.OrgTax = Ori.OrgTax, Dest.Saldo = Ori.Saldo, Dest.SaldoOrg = Ori.SaldoOrg, Dest.SaldoAct = Ori.SaldoAct, Dest.EsLibroI = Ori.EsLibroI, Dest.BaseImpo = Ori.BaseImpo, Dest.TExento = Ori.TExento, Dest.CancelI = Ori.CancelI, Dest.CancelA = Ori.CancelA, Dest.CancelE = Ori.CancelE, Dest.CancelC = Ori.CancelC, Dest.CancelT = Ori.CancelT, Dest.CancelG = Ori.CancelG, Dest.CancelP = Ori.CancelP, Dest.CancelD = Ori.CancelD, Dest.Comision = Ori.Comision, Dest.DetalChq = Ori.DetalChq, Dest.EsUnPago = Ori.EsUnPago, Dest.AfectaVta = Ori.AfectaVta, Dest.AfectaComi = Ori.AfectaComi, Dest.EsChqDev = Ori.EsChqDev, Dest.EsReten = Ori.EsReten, Dest.UltIntMora = Ori.UltIntMora, Dest.PrxVisita = Ori.PrxVisita, Dest.Debitos = Ori.Debitos, Dest.Creditos = Ori.Creditos, Dest.TipoTraE = Ori.TipoTraE, Dest.AutSRI = Ori.AutSRI, Dest.NroEstable = Ori.NroEstable, Dest.PtoEmision = Ori.PtoEmision, Dest.NumeroF = Ori.NumeroF, Dest.NumeroP = Ori.NumeroP, Dest.NumeroD = Ori.NumeroD, Dest.TipoReg = Ori.TipoReg, Dest.CodTarj = Ori.CodTarj, Dest.NroTurno = Ori.NroTurno
                  FROM EnterpriseAdminDb150824.dbo.SAACXC ORI
                  INNER JOIN EnterpriseAdminDb.dbo.SAACXC Dest
                  ON DEST.NumeroD = ORI.NumeroD  AND DEST.NroUnico = ORI.NroUnico
where DEST.NumeroD ='077008'

UPDATE  Dest
                  SET Dest.TipoFac = Ori.TipoFac, Dest.NumeroD = Ori.NumeroD, Dest.CodTaxs = Ori.CodTaxs, Dest.Monto = Ori.Monto, Dest.MtoTax = Ori.MtoTax, Dest.TGravable = Ori.TGravable, Dest.CodSucu = Ori.CodSucu, Dest.EsReten = Ori.EsReten
                  FROM EnterpriseAdminDb150824.dbo.sataxvta ORI
                  INNER JOIN EnterpriseAdminDb.dbo.sataxvta Dest
                  ON DEST.NumeroD = ORI.NumeroD  AND DEST.TipoFac = ORI.TipoFac
where DEST.NumeroD ='077008'

UPDATE  Dest
                  SET Dest.TipoFac = Ori.TipoFac, Dest.NumeroD = Ori.NumeroD, Dest.NroLinea = Ori.NroLinea, Dest.NroLineaC = Ori.NroLineaC, Dest.CodTaxs = Ori.CodTaxs, Dest.CodItem = Ori.CodItem, Dest.Monto = Ori.Monto, Dest.TGravable = Ori.TGravable, Dest.MtoTax = Ori.MtoTax, Dest.CodSucu = Ori.CodSucu
                  FROM EnterpriseAdminDb150824.dbo.sataxitf ORI
                  INNER JOIN EnterpriseAdminDb.dbo.sataxitf Dest
                  ON DEST.NumeroD = ORI.NumeroD  AND DEST.TipoFac = ORI.TipoFac
where DEST.NumeroD ='077008'


UPDATE  Dest
                  SET Dest.TipoFac = Ori.TipoFac, Dest.NumeroD = Ori.NumeroD, Dest.OTipo = Ori.OTipo, Dest.ONumero = Ori.ONumero, Dest.NumeroE = Ori.NumeroE, Dest.Status = Ori.Status, Dest.NroLinea = Ori.NroLinea, Dest.NroLineaC = Ori.NroLineaC, Dest.CodItem = Ori.CodItem, Dest.CodUbic = Ori.CodUbic, Dest.CodMeca = Ori.CodMeca, Dest.CodVend = Ori.CodVend, Dest.Descrip1 = Ori.Descrip1, Dest.Descrip2 = Ori.Descrip2, Dest.Descrip3 = Ori.Descrip3, Dest.Descrip4 = Ori.Descrip4, Dest.Descrip5 = Ori.Descrip5, Dest.Descrip6 = Ori.Descrip6, Dest.Descrip7 = Ori.Descrip7, Dest.Descrip8 = Ori.Descrip8, Dest.Descrip9 = Ori.Descrip9, Dest.Descrip10 = Ori.Descrip10, Dest.Refere = Ori.Refere, Dest.Signo = Ori.Signo, Dest.CantMayor = Ori.CantMayor, Dest.Cantidad = Ori.Cantidad, Dest.CantidadO = Ori.CantidadO, Dest.Tara = Ori.Tara, Dest.ExistAntU = Ori.ExistAntU, Dest.ExistAnt = Ori.ExistAnt, Dest.CantidadU = Ori.CantidadU, Dest.CantidadC = Ori.CantidadC, Dest.CantidadA = Ori.CantidadA, Dest.CantidadUA = Ori.CantidadUA, Dest.TotalItem = Ori.TotalItem, Dest.Costo = Ori.Costo, Dest.Precio = Ori.Precio, Dest.Descto = Ori.Descto, Dest.NroUnicoL = Ori.NroUnicoL, Dest.NroLote = Ori.NroLote, Dest.FechaE = Ori.FechaE, Dest.FechaL = Ori.FechaL, Dest.FechaV = Ori.FechaV, Dest.EsServ = Ori.EsServ, Dest.EsUnid = Ori.EsUnid, Dest.EsFreeP = Ori.EsFreeP, Dest.EsPesa = Ori.EsPesa, Dest.EsExento = Ori.EsExento, Dest.UsaServ = Ori.UsaServ, Dest.DEsLote = Ori.DEsLote, Dest.DEsSeri = Ori.DEsSeri, Dest.DEsComp = Ori.DEsComp, Dest.CodSucu = Ori.CodSucu, Dest.MtoTax = Ori.MtoTax, Dest.PriceO = Ori.PriceO, Dest.MtoTaxO = Ori.MtoTaxO, Dest.TipoPVP = Ori.TipoPVP, Dest.Factor = Ori.Factor, Dest.ONroLinea = Ori.ONroLinea, Dest.ONroLineaC = Ori.ONroLineaC, Dest.CantidadT = Ori.CantidadT, Dest.CodUsua = Ori.CodUsua
                  FROM EnterpriseAdminDb150824.dbo.Saitemfac ORI
                  INNER JOIN EnterpriseAdminDb.dbo.Saitemfac Dest
                  ON DEST.NumeroD = ORI.NumeroD  AND DEST.TipoFac = ORI.TipoFac
where DEST.NumeroD ='077008'

update dest
set dest.Existen = dest.Existen + ori.Cantidad
from EnterpriseAdminDb.DBO.SAEXIS DEST 
	INNER JOIN SAITEMFAC Ori 
	ON Ori.CodItem = DEST.CodProd
WHERE DEST.CodProd = ORI.CODITEM AND Ori.NumeroD ='077008' ;

WITH EXISTENCIA (CODPROD, CANT) AS
(SELECT CODPROD, SUM(Existen) CANT 
					FROM SAEXIS GROUP BY CodProd)
UPDATE PRD
SET PRD.Existen = EX.CANT
FROM EXISTENCIA EX INNER JOIN SAPROD PRD 
	ON PRD.CodProd = EX.CODPROD
WHERE EX.CANT <> PRD.Existen 