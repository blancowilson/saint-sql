-- si se crea un RISL tipo 21 debe:
-- Generar el pago en sapagcxp
-- Aumentar el correlativo en Sacorrelsis
-- Colocarle el numerod en todas las tablas
Create trigger Insertar_RISL
  on saacxp
  After insert
  as
   declare @numerodF varchar(16)
   declare @tipocxp varchar(2)
   declare @Esreten smallint
   declare @NroUnico int
   declare @MontoFac decimal(28,4)
   declare @NroReten varchar(10)
   select @numerodF= F.NumeroD,@tipocxp = i.TipoCxP,@Esreten = i.EsReten, @NroUnico = i.NroUnico, @MontoFac = f.Monto  from SAACXP F
		 join inserted i
		 on i.NumeroN=f.NumeroD
		 where f.TipoCxP in ('10','20')
		 -- Colocar el numero de digitos del correlativos que usen la base de datos en este caso 8
		select @NroReten = RIGHT('0000000' + Ltrim(Rtrim(ValueInt)),8)
		from SACORRELSIS
		where Fieldname ='PrxImpue'
  if ((@tipocxp='21' and @Esreten =1) or (@tipocxp='31' and @Esreten =1))
	begin
		update SAACXP set NumeroD = @NroReten,FromTran=0 where nrounico = @nrounico
		insert into SAPAGCXP ([NroPpal], [NroRegi], [TipoCxP], [MontoDocA], [Monto], [NumeroD], [Descrip], [FechaE], [FechaO], [EsReten], [codsucu],[BaseReten])--,[CodRete], [CodOper])
		select				 nrounico,	NroRegi,	tipocxp,  @MontoFac,	 monto,  NumeroD,Document, fechae,		fechae, esreten,	codsucu,	BaseImpo--, 'R2','R2'
		from SAACXP
		where NroUnico =@NroUnico  and EsReten=1
		update SACORRELSIS
		set ValueInt = ValueInt+1
		where Fieldname ='PrxImpue'
	end
