
--consultar diferencias
		WITH It (Codprod,CodUbic, Pedidos) AS
		(
		   SELECT It.CodItem,It.CodUbic, SUM(It.cantidad) as Pedidos
			 -- FROM SAEXIS Ex
			   --  JOIN SAITEMFAC It ON Ex.CodProd = It.CodItem and Ex.CodUbic = It.CodUbic
			from SAITEMFAC IT 	
				where It.TipoFac ='E'
			  GROUP BY It.CodItem,It.CodUbic
		)
		select ex.cantcom, it.Pedidos
		   FROM SAEXIS Ex
			  INNER JOIN It ON It.Codprod = Ex.CodProd and Ex.CodUbic=It.CodUbic
		where It.Pedidos<>ex.CantCom;


		UPDATE SAEXIS
		SET CantCom =0
		where CodProd not in (select coditem 
								from SAITEMFAC
								where TipoFac ='E' and Cantidad>0
								group by CodItem) and CantCom<>0;

		WITH It (Codprod,CodUbic, Pedidos) AS
		(
		   SELECT It.CodItem,It.CodUbic, SUM(It.cantidad) as Pedidos
			 -- FROM SAEXIS Ex
			   --  JOIN SAITEMFAC It ON Ex.CodProd = It.CodItem and Ex.CodUbic = It.CodUbic
			from SAITEMFAC IT 	
				where It.TipoFac ='E'
			  GROUP BY It.CodItem,It.CodUbic
		)
		UPDATE Ex SET Ex.CantCom = It.Pedidos
		   FROM SAEXIS Ex
			  INNER JOIN It ON It.Codprod = Ex.CodProd and Ex.CodUbic=It.CodUbic
		where It.Pedidos<>ex.CantCom;

		WITH Exis (Codprod, Pedidos) AS
		(
		   SELECT Ex.CodProd, SUM(Ex.cantcom) as Pedidos
			  FROM SAEXIS Ex
			  GROUP BY Ex.CodProd
		)
		UPDATE Pr SET Pr.Compro = Exis.Pedidos
		   FROM SAPROD pr
			  INNER JOIN Exis ON Exis.Codprod = Pr.CodProd 
		where Exis.Pedidos<>Pr.Compro;





