/*
 ---------------------------------------------------------------------------
 ASYSCA - www.asysca.com
 Ernesto Arenas N.
 ---------------------------------------------------------------------------
 Qry_ASS_Truncate tablas excepto basicas del sistema y basicas para usar
 Creado: 02-06-2020
 Mejorado: 07-02-221
 ---------------------------------------------------------------------------
 --select *  from dbo.sysobjects   where xtype = 'u' order by name
*/ 
declare @tbls varchar(30)

----------------------------------------------------
declare @accion int = 0  -- 0 = Ver / 1 = Borrar
----------------------------------------------------
declare mcursor cursor for
select name 
  from dbo.sysobjects   
  where xtype = 'u' 
    and substring(name,1,2) in ('SA','SB')  -- sino quieres borrar las tablas del BANCO elimina SB del filtro
	and name not in ('SAACAMPOS','SAAGRUPOS','SAAOPER','SACONF','SACORRELSIS','SAESTA','SAJOIN','SAESTADO','SACIUDAD','SAPAIS','SAMUNICIPIO',
	                 'SAFIEL','SATABL','SAFLDREF','SAITRE','SAREPO','SASUCURSAL','SATAXES')  -- TABLAS BASICAS NO TOCAR
--	and name not in ('SAACXC','SACLIE') -- FILTRO=Agregar las tablas que no quiere truncate para activar eliminar los 2 guiones de esta linea
	and name  not like '%_0%'
  order by name
open mcursor
fetch next from mcursor into @tbls
while @@fetch_status = 0
begin
  if @accion = 0
    print 'truncate table [' + @tbls + ']' 
  else
    EXEC('truncate table [' + @tbls + ']') 
  fetch next from mcursor into @tbls
end
close mcursor;
deallocate mcursor;
