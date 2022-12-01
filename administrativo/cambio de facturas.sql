-- cambiar fecha a factura

--fecha de compra
update sacomp
set FechaE =convert(datetime,'2021-11-15 11:59:11.080',120)
where codprov='J310983496' and Numerod='00000560'

--- fehca de registro
update sacomp
set Fechai =convert(datetime,'2021-11-15 11:59:11.080',120)
where codprov='J310983496' and Numerod='00000560'


--si se cambia la fecha de la retencion tambien hay que cambiar en saacxp tipo 81 fechae
update SAACXP
set Fechae =convert(datetime,'2021-11-15 08:59:11.080',120)
where codprov='J310983496' and Numerod='20211100002679'

select * from sacomp
where Descrip like '%medicos%'

