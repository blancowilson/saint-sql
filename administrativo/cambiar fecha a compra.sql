declare @NumeroD varchar(15),
        @Tipocom varchar(1),
		@codprov varchar(15),
		@TIPOCXP VARCHAR(2),
		@tipoRetencion varchar(2),
		@tipopago varchar(2),
		@nrolote varchar (15)
SET @Numerod='00206316'


select  fechai,fechae,fechat,*   From    SACOMP where NumeroD=@NumeroD and TipoCom=@Tipocom and CodProv=@codprov
-- items de compra
select  fechae,*    From   SAITEMCOM  where NumeroD=@NumeroD and TipoCom=@Tipocom and CodProv=@codprov

select  *    From   SASEPRCOM  where NumeroD=@NumeroD and TipoCom=@Tipocom and CodProv=@codprov

select  *    From   SATAXITC where NumeroD=@NumeroD and TipoCom=@Tipocom and CodProv=@codprov

select  *    From   SATAXCOM where NumeroD=@NumeroD and TipoCom=@Tipocom and CodProv=@codprov

select  fechae,*    From   SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@NumeroD  and CodProv=@codprov) and NumeroD=@NumeroD

select  fechae,*    From    SAPAGCXP where NroPpal=(select NroUnico from SAACXP where NumeroN=@NumeroD  and CodProv=@codprov) and NumeroD=@NumeroD

select  fechai,fechae,fechat,*    From   SAACXP where NumeroD=@NumeroD and CodProv=@codprov

select  fechai,fechae,fechat,*    From   SAACXP where NumeroN=@NumeroD and CodProv=@codprov






update saacxp 
set FechaE ='20220729 00:00:00.000', FechaI='20220718 00:00:00.000'
where tipocxp =10 and Numerod=@NumeroD



update SACOMP
set FechaE ='20220729 00:00:00.000', FechaI='20220718 00:00:00.000'
where NumeroD = @NumeroD and CodProv =@codprov