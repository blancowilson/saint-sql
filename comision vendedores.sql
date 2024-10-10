
select  fapag.codclie, fapag.Descrip, fapag.NumeroD, fapag.CodVend, FechaP.ultimopago, fapag.FechaV, 
    datediff (DAY, fapag.FechaV,FechaP.ultimopago) Vencido
		, sum((CASE WHEN pagos.TIPOCXC LIKE '3%' THEN -1 ELSE 1 END)*(pagos.MONTO-pagos.MTOTAX)) AS MONTO 
		, sum((CASE WHEN pagos.TIPOCXC LIKE '3%' THEN -1 ELSE 1 END)*(pagos.Comision)) AS COMISION
from	
	(SELECT
		fac.TipoCxc
		, cl.CodVend
		,cl.Descrip
		, pg.NroRegi
		, CC.codclie
		, fac.NroUnico
		, fac.FechaE
		, fac.FechaV
		, pg.NumeroD
		FROM SAACXC CC WITH (NOLOCK)
			INNER JOIN SACLIE CL 
					ON (CL.CodClie=CC.CodClie)
			LEFT JOIN SAPAGCXC PG 
				ON (PG.NROPPAL=CC.NROUNICO)
			inner join SAACXC fac on fac.NumeroD = pg.NumeroD and fac.TipoCxc = pg.tipocxc and fac.NroUnico = pg.NroRegi
		WHERE ((CC.TipoCxc Like '4%') Or (CC.Tipocxc Like '3%')) 
			And (CC.EsReten=0) 
			AND (CC.FromTran=1) AND CC.TipoCxc IN ('31','41')
			--AND	 (CONVERT(DATETIME,:FECHAINI+' 00:00:00',120)<=PG.FECHAE) 
			--AND (PG.FECHAE<=CONVERT(DATETIME,:FECHAFIN+' 23:59:59',120))
			AND FAC.Saldo <=0
		group by pg.NroRegi, cc.CodClie,fac.FechaE, fac.TipoCxc, pg.NumeroD, fac.FechaV, cl.CodVend, cl.Descrip, fac.NroUnico) fapag 
	inner join SAPAGCXC 
		pagos on pagos.NumeroD = fapag.NumeroD  and pagos.NroRegi = fapag.NroRegi 
	inner join ( SELECT max (fechae)  AS ultimopago, nroregi, NumeroD,TipoCxc
				FROM SAPAGCXC
				where TipoCxc in (10,20)
				group by NroRegi,NumeroD,TipoCxc) fechap 
			on pagos.NumeroD = fechap.NumeroD and pagos.NroRegi = fechap.NroRegi
	group by fapag.CodClie,fapag.Descrip, fapag.NumeroD, fapag.CodVend,fechap.ultimopago,  fapag.FechaV 