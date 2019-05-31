

insert into  SSAUTR (CodAutr, Modulo, Parametro, Autoriza)
select CodAutr, Modulo, Parametro, Autoriza
from EnterpriseMTAdminDb.dbo.SSAUTR

---***------------------ migrar usuarios

insert into SSNIVL (CodNivl,Descrip)
SELECT      CodNivl, Descrip
FROM     EnterpriseMTAdminDb.dbo.SSNIVL
where CodNivl not in (select CodNivl from SSNIVL)

insert into SSUSRS (CodUsua, Descrip, Email, Movil, IdUserNot, Profile, CodVend, UsrDta1, UsrDta2, UsrDta3, UsrDta4, UsrDta5, SData1, SData2, SData3)
SELECT     CodUsua, Descrip, Email, Movil, IdUserNot, Profile, CodVend, UsrDta1, UsrDta2, UsrDta3, UsrDta4, UsrDta5, SData1, SData2, SData3
FROM            EnterpriseMTAdminDb.dbo.SSUSRS
where CodUsua not in (select CodUsua from SSUSRS)


--no tiene nada
insert into SSDTAA (CodArch, CodData, IndDta, TipDta)
SELECT         CodArch, CodData, IndDta, TipDta
FROM            EnterpriseMTAdminDb.dbo.SSDTAA
