
--CAMBIAR CODIGO DE UN CLIENTE ERRADO
declare @rif_errado varchar(20)
declare @rif_correcto varchar(20)

set @rif_errado = 'J40241620'
set @rif_correcto='J402491620'

UPDATE SACLIE SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SACLIE SET ID3=@rif_correcto WHERE ID3=@rif_errado
UPDATE SAFACT SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SAFACT SET ID3=@rif_correcto WHERE ID3=@rif_errado
UPDATE SAACXC SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SACLIE_01 SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SACLIE_02 SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SACLIE_03 SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SACLIE_04 SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SAECLI SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SACLICNV SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SAICLI SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SAPTOSCLIENTE SET CodClie=@rif_correcto WHERE CodClie=@rif_errado
UPDATE SBOPMSTR SET CodClie=@rif_correcto WHERE CodClie=@rif_errado