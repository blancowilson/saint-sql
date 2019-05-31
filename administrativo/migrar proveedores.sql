insert into SAPROV (CodProv, Descrip, TipoPrv, TipoID3, TipoID, ID3, DescOrder, Clase, Activo, Represent, Direc1, Direc2, Pais, Estado, Ciudad, Municipio, ZipCode, Telef, Movil, Fax, Email, FechaE, EsReten, RetenISLR, 
                         DiasCred, Observa, EsMoneda, Saldo, MontoMax, PagosA, PromPago, RetenIVA, FechaUC, MontoUC, NumeroUC, FechaUP, MontoUP, NumeroUP )
SELECT       CodProv, Descrip, TipoPrv, TipoID3, TipoID, ID3, DescOrder, Clase, Activo, Represent, Direc1, Direc2, Pais, Estado, Ciudad, Municipio, ZipCode, Telef, Movil, Fax, Email, FechaE, EsReten, RetenISLR, 
                         DiasCred, Observa, EsMoneda, Saldo, MontoMax, PagosA, PromPago, RetenIVA, FechaUC, MontoUC, NumeroUC, FechaUP, MontoUP, NumeroUP
FROM    EnterpriseMTAdminDb.dbo.SAPROV

