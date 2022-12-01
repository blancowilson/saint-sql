Use [SNACSainsycaDb] --tabla de origen de los presupuestos

select [TipoFac], [NumeroD],  [NroCtrol], [Status], [CodSucu], [CodEsta], [CodUsua], [CodConv], [Signo], [FechaT], [OTipo], [ONumero], [TipoTra], [NumeroC], [NumeroT], [NumeroR], [FechaD1], [NumeroD1], [NumeroK], [NumeroF], [NumeroP], [NumeroE], [NumeroZ], [EsExPickup], [Moneda], [Factor], [MontoMEx], [CodClie], [CodVend], [CodUbic], [Descrip], [Direc1], [Direc2], [Direc3], [Pais], [Estado], [Ciudad], [Municipio], [ZipCode], [Telef], [ID3], [Monto], [MtoTax], [Fletes], [TGravable], [TExento], [CostoPrd], [CostoSrv], [DesctoP], [RetenIVA], [FechaR], [FechaI], [FechaE], [FechaV], [MtoTotal], [Contado], [Credito], [CancelI], [CancelA], [CancelE], [CancelC], [CancelT], [CancelG], [CancelP], [Cambio], [EsConsig], [MtoExtra], [ValorPtos], [Descto1], [PctAnual], [MtoInt1], [Descto2], [PctManejo], [MtoInt2], [SaldoAct], [MtoPagos], [MtoNCredito], [MtoNDebito], [MtoFinanc], [DetalChq], [TotalPrd], [TotalSrv], [OrdenC], [CodOper], [NGiros], [NMeses], [MtoComiVta], [MtoComiCob], [MtoComiVtaD], [MtoComiCobD], [Notas1], [Notas2], [Notas3], [Notas4], [Notas5], [Notas6], [Notas7], [Notas8], [Notas9], [Notas10], [nit], [ESCORREL], [tasa], [TMoneda]
from SAFACT 
where tipofac = 'F' and NumeroD not in ( select NumeroD from SNACWilsonDb.dbo.SAFACT 
										 where TipoFac ='F')


insert into SNACWilsonDb.dbo.SAFACT ([TipoFac], [NumeroD],  [NroCtrol], [Status], [CodSucu], [CodEsta], [CodUsua], [CodConv], [Signo], [FechaT], [OTipo], [ONumero], [TipoTra], [NumeroC], [NumeroT], [NumeroR], [FechaD1], [NumeroD1], [NumeroK], [NumeroF], [NumeroP], [NumeroE], [NumeroZ], [EsExPickup], [Moneda], [Factor], [MontoMEx], [CodClie], [CodVend], [CodUbic], [Descrip], [Direc1], [Direc2], [Direc3], [Pais], [Estado], [Ciudad], [Municipio], [ZipCode], [Telef], [ID3], [Monto], [MtoTax], [Fletes], [TGravable], [TExento], [CostoPrd], [CostoSrv], [DesctoP], [RetenIVA], [FechaR], [FechaI], [FechaE], [FechaV], [MtoTotal], [Contado], [Credito], [CancelI], [CancelA], [CancelE], [CancelC], [CancelT], [CancelG], [CancelP], [Cambio], [EsConsig], [MtoExtra], [ValorPtos], [Descto1], [PctAnual], [MtoInt1], [Descto2], [PctManejo], [MtoInt2], [SaldoAct], [MtoPagos], [MtoNCredito], [MtoNDebito], [MtoFinanc], [DetalChq], [TotalPrd], [TotalSrv], [OrdenC], [CodOper], [NGiros], [NMeses], [MtoComiVta], [MtoComiCob], [MtoComiVtaD], [MtoComiCobD], [Notas1], [Notas2], [Notas3], [Notas4], [Notas5], [Notas6], [Notas7], [Notas8], [Notas9], [Notas10], [nit], [ESCORREL], [tasa], [TMoneda] )
select [TipoFac], [NumeroD],  [NroCtrol], [Status], [CodSucu], [CodEsta], [CodUsua], [CodConv], [Signo], [FechaT], [OTipo], [ONumero], [TipoTra], [NumeroC], [NumeroT], [NumeroR], [FechaD1], [NumeroD1], [NumeroK], [NumeroF], [NumeroP], [NumeroE], [NumeroZ], [EsExPickup], [Moneda], [Factor], [MontoMEx], [CodClie], [CodVend], [CodUbic], [Descrip], [Direc1], [Direc2], [Direc3], [Pais], [Estado], [Ciudad], [Municipio], [ZipCode], [Telef], [ID3], [Monto], [MtoTax], [Fletes], [TGravable], [TExento], [CostoPrd], [CostoSrv], [DesctoP], [RetenIVA], [FechaR], [FechaI], [FechaE], [FechaV], [MtoTotal], [Contado], [Credito], [CancelI], [CancelA], [CancelE], [CancelC], [CancelT], [CancelG], [CancelP], [Cambio], [EsConsig], [MtoExtra], [ValorPtos], [Descto1], [PctAnual], [MtoInt1], [Descto2], [PctManejo], [MtoInt2], [SaldoAct], [MtoPagos], [MtoNCredito], [MtoNDebito], [MtoFinanc], [DetalChq], [TotalPrd], [TotalSrv], [OrdenC], [CodOper], [NGiros], [NMeses], [MtoComiVta], [MtoComiCob], [MtoComiVtaD], [MtoComiCobD], [Notas1], [Notas2], [Notas3], [Notas4], [Notas5], [Notas6], [Notas7], [Notas8], [Notas9], [Notas10], [nit], [ESCORREL], [tasa], [TMoneda]
from SAFACT 
where tipofac = 'F' and NumeroD not in ( select NumeroD from SNACWilsonDb.dbo.SAFACT 
										 where TipoFac ='F')
insert into SNACWilsonDb.dbo.SAITEMFAC 
select * from SAITEMFAC 
where tipofac = 'F' and NumeroD not in ( select NumeroD from SNACWilsonDb.dbo.SAITEMFAC 
										 where TipoFac ='F')

--
insert into SNACWilsonDb.dbo.SAITESERVFAC_01 
select * from SAITESERVFAC_01  
where tipofac = 'F' and NumeroD not in ( select NumeroD from SNACWilsonDb.dbo.SAITESERVFAC_01  
										 where TipoFac ='F')

insert into SNACSainsycaDb.dbo.SACLIE
select * from SNACWilsonDb.dbo.SACLIE
where CodClie not in (select  CodClie from SNACSainsycaDb.dbo.SACLIE)