declare @Numerod as varchar(16)='00000557'
declare @NuevoNumero as varchar(16)='*00000846'
declare @tipofac as varchar(2)='B'

--select * From SAFACT where NumeroD =@NumeroD and TipoFac =@tipofac
--select * from SAITEMFAC where NumeroD =@NumeroD and TipoFac =@tipofac

update SAFACT
set NumeroD=@NuevoNumero
where NumeroD =@NumeroD and TipoFac =@tipofac

update SAFACT
set NumeroR=@NuevoNumero 
where NumeroR =@NumeroD and TipoFac ='A' -- verificar el tipo de documento y reversar el contrario

update SAITEMFAC
set NumeroD=@NuevoNumero 
where NumeroD =@NumeroD and TipoFac =@tipofac

update SAFACT_01
set NumeroD=@NuevoNumero 
where NumeroD =@NumeroD and TipoFac =@tipofac

update SAACXC
set NumeroD=@NuevoNumero 
where NumeroD =@NumeroD and TipoCxc ='31'

update SAACXC
set NumeroN=@NuevoNumero 
where NumeroN =@NumeroD and TipoCxc ='10'

update SAPAGCXC
set NumeroD=@NuevoNumero 
where NumeroD =@NumeroD and TipoCxc ='31'

update SATAXITF
set NumeroD=@NuevoNumero 
where NumeroD =@NumeroD and TipoFac =@tipofac

update SATAXVTA
set NumeroD=@NuevoNumero 
where NumeroD =@NumeroD and TipoFac =@tipofac






