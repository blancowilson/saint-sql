/*    
 ****************************************************************************** 
 
 MOVIMIENTO DE INVENTARIO DETALLADO                                          
 
 Last update: 2023-02-05
 ------------------------------------------------------------------------------
 Copyright (c) 2017 Guillermo J. Rivero and SAINT DE VENEZUELA Team        
 ****************************************************************************** 
 Licensed under the Apache License, Version 2.0 (the "License");             
 you may not use this file except in compliance with the License.            

 You may obtain a copy of the License at www.apache.org/licenses/LICENSE-2.0                                    
                                                                              
 Unless required by applicable law or agreed to in writing, software         
 distributed under the License is distributed on an "AS IS" BASIS,           
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    
 See the License for the specific language governing permissions and         
 limitations under the License.                                              
 ****************************************************************************** 
  -- Consulta modificado y actualizada por 
  -- Integrador - Franklin González
  -- Empresa    - Orión Computer System, C.A.
  -- Dirección  - Maturin – Edo. Monagas
  -- Teléfonos  - 0414-7659152 
  -- emails     - orioncomputer@gmail.com
  -- Fecha      - 2023-07-31
 ******************************************************************************
*/
DECLARE
 @FECHAINI DATETIME = '20231101 00:00:00',
 @FECHAFIN DATETIME = '20241101 23:59:59',
 @FECHAPER DATETIME ='20231101' ,
 @ESENSER  INT = CONVERT(INT,0),  
 @CODSUCU  VARCHAR(5) = '00000',
 @CODUBIC  VARCHAR(15) = '01'

;WITH InventoryMove AS
(
 SELECT T.CODSUCU, T.CODITEM CODPROD, T.FECHAE, T.TIPO, T.NUMEROD, T.CODIGO, T.DESCRIP, T.CODUBIC,
        SUM(T.EXENTRADA) EXENTRADA, SUM(T.EXSALIDA) EXSALIDA, SUM(T.EXSALDO) EXSALDO,
        SUM(T.UDENTRADA) UDENTRADA, SUM(T.UDSALIDA) UDSALIDA, SUM(T.UDSALDO) UDSALDO, T.UNDS
   FROM (
         SELECT FA.CODSUCU, IT.CODITEM, IT.FECHAE,
                IT.TIPOFAC TIPO, IT.NUMEROD, FA.CODCLIE CODIGO, FA.DESCRIP,
                IT.CODUBIC,
                (CASE WHEN IT.TIPOFAC IN ('B','D') THEN
                           IIF(IT.ESUNID=0,IT.CANTIDAD*IT.CANTMAYOR,IT.CANTIDADT)
                 ELSE 0 END) EXENTRADA,

                (CASE WHEN IT.TIPOFAC IN ('A','C') THEN
                           IIF(IT.ESUNID=0,IT.CANTIDAD*IT.CANTMAYOR,IT.CANTIDADT)
                 ELSE 0 END) EXSALIDA,

                0 EXSALDO,

                (CASE WHEN IT.TIPOFAC IN ('A','C') THEN
                           IIF(IT.ESUNID=1,IT.CANTIDADT*PR.CANTEMPAQ,0)
                      WHEN IT.TIPOFAC IN ('B','D') THEN
                           IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                 ELSE 0 END) UDENTRADA,

                (CASE WHEN IT.TIPOFAC IN ('A','C') THEN
                           IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                      WHEN IT.TIPOFAC IN ('B','D') THEN
                           IIF(IT.ESUNID=1,IT.CANTIDADT*PR.CANTEMPAQ,0)
                 ELSE 0 END) UDSALIDA,
                0 UDSALDO

				, ROUND(IIF(IT.EsUnid=0,IT.Cantidad * PR.CantEmpaq * IT.CANTMAYOR,IT.Cantidad * IT.CANTMAYOR),4) * FA.Signo * -1 AS UNDS

           FROM SAITEMFAC IT WITH (NOLOCK)
                INNER JOIN (SELECT CODPROD, IIF(CANTEMPAQ=0,1,CANTEMPAQ) CANTEMPAQ FROM SAPROD) PR
                   ON (PR.CODPROD=IT.CODITEM)
                INNER JOIN SAFACT FA
                   ON (FA.CODSUCU=IT.CODSUCU) AND
                      (FA.TIPOFAC=IT.TIPOFAC) AND (FA.NUMEROD=IT.NUMEROD)
          WHERE (IT.TIPOFAC IN ('A','B','C','D')) AND (IT.ESSERV=0)
          UNION ALL
         SELECT CO.CODSUCU, IT.CODITEM, IT.FECHAE,
                IT.TIPOCOM, IT.NUMEROD, CO.CODPROV, CO.DESCRIP, IT.CODUBIC,
                (CASE WHEN IT.TIPOCOM IN ('H','J') THEN
                      IIF(IT.ESUNID=0,IT.CANTIDAD,IT.CANTIDADT)
                      WHEN IT.TIPOCOM IN ('I','K') THEN
                      IIF(IT.ESUNID=0,0,IT.CANTIDAD)
                 ELSE 0 END) EXENTRADA,

                (CASE WHEN IT.TIPOCOM IN ('I','K') THEN
                      IIF(IT.ESUNID=0,IT.CANTIDAD,IT.CANTIDADT)
                 ELSE 0 END) EXSALIDA,

                0 EXSALDO,
                (CASE WHEN IT.TIPOCOM IN ('H','J') THEN
                      IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                      WHEN IT.TIPOCOM IN ('I','K') THEN
                      IIF(IT.ESUNID=1,IT.CANTIDADT*PR.CANTEMPAQ,0)
                 ELSE 0 END) UDENTRADA,

                (CASE WHEN IT.TIPOCOM IN ('H','J') THEN
                      IIF(IT.ESUNID=1,IT.CANTIDADT*PR.CANTEMPAQ,0)
                      WHEN IT.TIPOCOM IN ('I','K') THEN
                      IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                 ELSE 0 END) UDSALIDA,

                0 UDSALDO
				
				, ROUND(IIF(IT.EsUnid=0,IT.Cantidad * PR.CantEmpaq,IT.Cantidad),4) * CO.Signo AS UNDS

           FROM SAITEMCOM IT WITH (NOLOCK)
                INNER JOIN (SELECT CODPROD, IIF(CANTEMPAQ=0,1,CANTEMPAQ) CANTEMPAQ FROM SAPROD) PR
                   ON (PR.CODPROD=IT.CODITEM)
                INNER JOIN SACOMP CO
                   ON (CO.CODSUCU=IT.CODSUCU) AND (CO.TIPOCOM=IT.TIPOCOM) AND
                      (CO.NUMEROD=IT.NUMEROD) AND (CO.CODPROV=IT.CODPROV)
          WHERE (IT.TIPOCOM IN ('H','I','J','K')) AND (IT.ESSERV=0)
          UNION ALL
         SELECT OI.CODSUCU, IT.CODITEM, IT.FECHAE,
                IT.TIPOOPI, IT.NUMEROD, '' CODOPEI, OI.AUTORI, IT.CODUBIC,
                (CASE WHEN (IT.TIPOOPI='O') THEN
                           IIF(IT.ESUNID=0,IT.CANTIDAD,IT.CANTIDADT)
                      WHEN (IT.TIPOOPI='T') THEN
                           IIF(IT.ESUNID=0,IT.CANTIDAD,0)
                      WHEN (IT.TIPOOPI='Q') THEN -- CARGOS
                           IIF(IT.CANTIDAD-IT.CANTIDADA>0,(IT.CANTIDAD-IT.CANTIDADA),0)
                 ELSE 0 END) EXENTRADA,

                (CASE WHEN (IT.TIPOOPI='P') THEN -- DESCARGOS
                           IIF(IT.ESUNID=0,IT.CANTIDAD,IT.CANTIDADT)
                      WHEN (IT.TIPOOPI='N') THEN -- TRASALADO
                           IIF(IT.ESUNID=0,IT.CANTIDAD,0)
                      WHEN (IT.TIPOOPI='Q') THEN -- AJUSTE
                           IIF(IT.CANTIDAD-IT.CANTIDADA<0,(IT.CANTIDADA-IT.CANTIDAD),0)
                 ELSE 0 END) EXSALIDA,
                0 EXSALDO,

                (CASE WHEN (IT.TIPOOPI IN ('O','T')) THEN
                           IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                      WHEN (IT.TIPOOPI IN ('P')) THEN
                           IIF(IT.ESUNID=1,IT.CANTIDADT*PR.CANTEMPAQ,0)
                      WHEN (IT.TIPOOPI IN ('N')) THEN
                           IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                      WHEN (IT.TIPOOPI='Q') THEN
                           IIF(IT.CANTIDADU-IT.CANTIDADUA>0, IT.CANTIDADU-IT.CANTIDADUA,0)
                 ELSE 0 END) UDENTRADA,

                (CASE WHEN (IT.TIPOOPI IN ('O','T')) THEN
                           IIF(IT.ESUNID=1,IT.CANTIDADT*PR.CANTEMPAQ,0)
                      WHEN (IT.TIPOOPI IN ('P','N')) THEN
                           IIF(IT.ESUNID=1,IT.CANTIDAD,0)
                      WHEN (IT.TIPOOPI='Q') THEN
                           IIF(IT.CANTIDADU-IT.CANTIDADUA<0, IT.CANTIDADUA-IT.CANTIDADU,0)
                 ELSE 0 END) UDSALIDA,
                0 UDSALDO
				
				, ROUND(IIF(IT.EsUnid=0,IT.Cantidad * PR.CantEmpaq,IT.Cantidad),4) * OI.Signo AS UNDS

           FROM SAITEMOPI IT WITH (NOLOCK)
                INNER JOIN (SELECT CODPROD, IIF(CANTEMPAQ=0,1,CANTEMPAQ) CANTEMPAQ FROM SAPROD) PR
                   ON (PR.CODPROD=IT.CODITEM)
                INNER JOIN SAOPEI OI
                   ON (OI.CODSUCU=IT.CODSUCU) AND
                      (OI.TIPOOPI=IT.TIPOOPI) AND (OI.NUMEROD=IT.NUMEROD)
          WHERE (IT.TIPOOPI IN ('N','O','P','Q','T')) AND (IT.ESSERV=0)
        ) T
  WHERE (T.FECHAE>=@FECHAPER) AND
        (T.FECHAE<=@FECHAFIN) AND
        (SUBSTRING(ISNULL(T.CODSUCU,''),1,LEN(@CODSUCU))=@CODSUCU)
  GROUP BY T.CODSUCU, T.TIPO, T.NUMEROD, T.CODITEM, T.FECHAE, T.CODIGO, T.DESCRIP, T.CODUBIC, T.UNDS
)

SELECT T.CODPROD, P.DESCRIP DESCRIPPROD, T.FECHAE,
       (CASE WHEN T.TIPO='A' THEN 'FAC'
         WHEN T.TIPO='B' THEN 'DEV'
         WHEN T.TIPO='C' THEN 'NEV'
         WHEN T.TIPO='D' THEN 'DNE'
         WHEN T.TIPO='H' THEN 'COM'
         WHEN T.TIPO='I' THEN 'DEC'
         WHEN T.TIPO='J' THEN 'NEC'
         WHEN T.TIPO='K' THEN 'DNC'
         WHEN T.TIPO IN ('N','T') THEN 'TRA'
         WHEN T.TIPO='O' THEN 'CAR'
         WHEN T.TIPO='P' THEN 'DES'
         WHEN T.TIPO='Q' THEN 'AJU'
        END) TIPOMOV,
       T.NUMEROD, T.CODIGO, T.DESCRIP, T.CODUBIC, T.EXENTRADA, T.EXSALIDA,

       SUM(T.EXSALDO)
           OVER (PARTITION BY T.CODPROD, T.CODUBIC
                     ORDER BY T.FECHAE
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) +
		IIF(P.CANTEMPAQ=1, SUM(T.UNDS)
							   OVER (PARTITION BY T.CODPROD, T.CODUBIC
										 ORDER BY T.FECHAE
										  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
						 , ROUND(SUM(T.UNDS)
								   OVER (PARTITION BY T.CODPROD, T.CODUBIC
											 ORDER BY T.FECHAE
											  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  / P.CANTEMPAQ,0,1)) EXSALDO,

       T.UDENTRADA, T.UDSALIDA,

       SUM(T.UDSALDO)
           OVER (PARTITION BY T.CODPROD, T.CODUBIC
                     ORDER BY T.FECHAE
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) +
		IIF(P.CANTEMPAQ=1, 0, SUM(T.UNDS)
							   OVER (PARTITION BY T.CODPROD, T.CODUBIC
										 ORDER BY T.FECHAE
										  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  % P.CANTEMPAQ) UDSALDO
  FROM (
        SELECT IT.CODPROD, @FECHAINI FECHAE,
               '0' TIPO, NULL NUMEROD, NULL CODIGO, 'SALDO INICIAL...  ' DESCRIP,
               IT.CODUBIC,
               0 EXENTRADA, 0 EXSALIDA, SUM(IT.EXSALDO) EXSALDO,
               0 UDENTRADA, 0 UDSALIDA, SUM(IT.UDSALDO) UDSALDO, SUM(IT.UNDS) UNDS
          FROM (
                SELECT IT.CODPROD, @FECHAINI FECHAE, IT.CODUBIC,
                       0 EXENTRADA, 0 EXSALIDA, SUM(IT.EXINICIAL) EXSALDO,
                       0 UDENTRADA, 0 UDSALIDA, SUM(IT.EXUNDINI ) UDSALDO, 0 UNDS
                  FROM SAINITI IT WITH (NOLOCK)
                 WHERE (IT.PERIODO=FORMAT(@FECHAPER,'yyyyMM'))
                 GROUP BY IT.CODPROD, IT.PERIODO, IT.CODUBIC
                 UNION ALL
                 SELECT IT.CODPROD, @FECHAINI FECHAE, IT.CODUBIC,
                        0 EXENTRADA, 0 EXSALIDA, SUM(IT.EXSALDO+IT.EXENTRADA-IT.EXSALIDA) EXSALDO,
                        0 UDENTRADA, 0 UDSALIDA, SUM(IT.UDSALDO+IT.UDENTRADA-IT.UDSALIDA) UDSALDO, IT.UNDS
                   FROM INVENTORYMOVE IT  WITH (NOLOCK)
                  WHERE (IT.FECHAE>=@FECHAPER) AND (IT.FECHAE< @FECHAINI)
                  GROUP BY IT.CODPROD, IT.FECHAE, IT.CODUBIC, IT.UNDS
               ) IT
         GROUP BY IT.CODPROD, IT.FECHAE, IT.CODUBIC
         UNION ALL
        SELECT IT.CODPROD, IT.FECHAE,
               IT.TIPO, IT.NUMEROD, IT.CODIGO, IT.DESCRIP,
               IT.CODUBIC,
               IT.EXENTRADA, IT.EXSALIDA, IT.EXSALDO,
               IT.UDENTRADA, IT.UDSALIDA, IT.UDSALDO, IT.UNDS
          FROM INVENTORYMOVE IT  WITH (NOLOCK)
         WHERE     (IT.FECHAE>=@FECHAINI)
               AND (IT.FECHAE<=@FECHAFIN)
       ) T
       INNER JOIN (SELECT	CodProd, IIF(CANTEMPAQ=0,1,CANTEMPAQ) CANTEMPAQ,
							CodInst, EsEnser, EsImport, Descrip
					FROM	SAPROD) P
          ON (P.CODPROD=T.CODPROD)
       INNER JOIN VW_ADM_INSTANCIAS I
          ON (P.CODINST=I.CODINST) AND
             (P.ESENSER=@ESENSER)
 WHERE     (T.FECHAE>=@FECHAINI)
       AND (T.FECHAE<=@FECHAFIN)
       AND (SUBSTRING(ISNULL(T.CODUBIC,''),1,LEN(@CODUBIC))=@CODUBIC)
 GROUP BY T.CODPROD, T.CODUBIC, P.DESCRIP, T.FECHAE, T.TIPO,
       T.NUMEROD, T.CODIGO, T.DESCRIP, T.CODUBIC,
       T.EXENTRADA, T.EXSALIDA, T.EXSALDO,
       T.UDENTRADA, T.UDSALIDA, T.UDSALDO, P.CANTEMPAQ, T.UNDS
 ORDER BY T.CODPROD, T.CODUBIC, T.FECHAE