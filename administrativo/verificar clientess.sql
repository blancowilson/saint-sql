-- Verificar los clientes que estan en otras tablas quitandole algun simbolo

select CodClie, Descrip, ID3, TipoID3, TipoID, Activo, DescOrder, Clase, Represent, Direc1, Direc2, Pais, 
		Estado, Ciudad, Municipio, ZipCode, Telef, Movil,Email, Fax, FechaE, CodZona, CodVend, CodConv, 
		CodAlte, TipoCli, TipoPVP, Observa, EsMoneda, EsCredito, LimiteCred, DiasCred, EsToleran, DiasTole, 
		IntMora, Descto, Saldo, PagosA, FechaUV, MontoUV, NumeroUV, FechaUP, MontoUP, NumeroUP, MontoMax,
		MtoMaxCred, PromPago, RetenIVA, SaldoPtos, DescripExt, EsReten, NIT 
	from SACLIE where replace (CodClie,'-','')  not in (select replace(CodClie,'-','') 
															from EnterpriseAdminDB.dbo.SACLIE )