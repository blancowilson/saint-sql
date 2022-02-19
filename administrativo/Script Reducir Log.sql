--Para Limpiar el Log de Transacciones es necesario realizar un Backup del Log
Backup log EnterpriseAdminDb
to disk  ='C:\respaldo\BackupLog.bak'
--�Una vez hecho el backup consultamos el nombre lógico de los archivos del log
sp_helpdb EnterpriseAdminDb

-- Antes de truncar el log cambiamos el modelo de recuperación a SIMPLE.
ALTER DATABASE EnterpriseAdminDb
SET RECOVERY SIMPLE;
GO

--Reducimos el log de transacciones a  1 MB.
DBCC SHRINKFILE(EnterpriseAdminDb_Log, 2);
GO
--Cambiamos nuevamente el modelo de recuperación a Completo.
ALTER DATABASE EnterpriseAdminDb
SET RECOVERY FULL;
GO