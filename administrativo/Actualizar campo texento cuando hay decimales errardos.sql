-- Un error que debe corregirse en el program no ejecutar sin un analisis previo
update SACOMP
set TExento= 0, TGravable= TGravable+TExento
from sacomp
where (TExento >-0.1 and TExento<0)  or (TExento >0 and TExento<0.1)

update SAACXP
set TExento=0, baseimpo = BaseImpo+TExento
from SAACXP
where ((TExento >-0.1 and TExento<0)  or (TExento >0 and TExento<0.1))

update tc
set tc.TGravable = c.TGravable
from SACOMP c inner join SATAXCOM tc on tc.NumeroD = c.NumeroD and tc.TipoCom = c.TipoCom
where tc.TGravable <> c.TGravable and c.NumeroD not in('000823')


select TExento,baseimpo, Monto, MtoTax,*
from SAACXP
where (TExento >-0.1 and TExento<0)  or (TExento >0 and TExento<0.1)

select tc.TGravable, c.TGravable, *
from SACOMP c inner join SATAXCOM tc on tc.NumeroD = c.NumeroD and tc.TipoCom = c.TipoCom
where tc.TGravable <> c.TGravable and c.NumeroD not in('000823')
