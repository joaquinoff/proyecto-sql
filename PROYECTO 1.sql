SELECT * 
FROM [VENTAS 2023 ]

-- RENOMBRANDO COLUMNAS

EXEC sp_rename 'VENTAS 2023 .FEC_MOVI', 'FECHA', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .COD_DOCU', 'TIPO_DE_COMPROBANTE', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .SER_DOCU', 'SERIE', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .NUM_DOCU', 'CORRELATIVO', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .TDO_CORR', 'TIPO_DOCUMENTO', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .DES_CORR', 'NOMBRE', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .IMP_TOTA', 'TOTAL', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .EST_DOCU', 'ESTADO', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .ANO_EJER', 'A�O', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .MES_EJER', 'MES', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .DOC_CORR', 'DOCUMENTO', 'COLUMN'
--IDENTIFICANDO TIPO DE COMBROBANTE(BOLETA,FACTURA)
SELECT TIPO_DE_COMPROBANTE, COUNT (TIPO_DE_COMPROBANTE)
FROM  [VENTAS 2023 ]
GROUP BY TIPO_DE_COMPROBANTE


SELECT TIPO_DE_COMPROBANTE,
CASE WHEN TIPO_DE_COMPROBANTE = 3 THEN 'BOLETA'
     WHEN TIPO_DE_COMPROBANTE = 7 THEN 'NOTA DE CREDITO'
	 WHEN TIPO_DE_COMPROBANTE = 1 THEN 'FACTURA'
	 END AS TIPO_COMPROBANTE
FROM [VENTAS 2023 ]

--UPDATE [VENTAS 2023 ]
--SET TIPO_DE_COMPROBANTE = 
--CASE WHEN TIPO_DE_COMPROBANTE = 3 THEN 'BOLETA'
    -- WHEN TIPO_DE_COMPROBANTE = 7 THEN 'NOTA DE CREDITO'
	 --WHEN TIPO_DE_COMPROBANTE = 1 THEN 'FACTURA'
	 --END


ALTER TABLE [VENTAS 2023 ]
ADD TIPO_COMPROBANTE VARCHAR(250)

UPDATE [VENTAS 2023 ]
SET TIPO_COMPROBANTE = 
CASE WHEN TIPO_DE_COMPROBANTE = 3 THEN 'BOLETA'
     WHEN TIPO_DE_COMPROBANTE = 7 THEN 'NOTA DE CREDITO'
	 WHEN TIPO_DE_COMPROBANTE = 1 THEN 'FACTURA'
	 END

-- DEFINIENDO  TIPO_DOCUMENTO Y CORRIEGIENDO OBSERVACIONES VACIAS
SELECT TIPO_DOCUMENTO, COUNT (TIPO_DOCUMENTO)
FROM  [VENTAS 2023 ]
GROUP BY TIPO_DOCUMENTO

--NO FUNCIONA EN ESTE MOMENTO
--UPDATE [VENTAS 2023 CARPIO] 
--SET TIPO_DOCUMENTO = CONVERT(nvarchar(255),TIPO_DOCUMENTO)

ALTER TABLE [VENTAS 2023 ]
ADD TIPO_DOCU NVARCHAR(255)

UPDATE [VENTAS 2023 ]
SET TIPO_DOCU = 
CASE WHEN TIPO_DOCUMENTO = 0 THEN 'S/N'
     WHEN TIPO_DOCUMENTO = 1 THEN 'DNI'
	 WHEN TIPO_DOCUMENTO = 4 THEN 'CARNET DE EXTRANJERIA'
	 WHEN TIPO_DOCUMENTO = 6 THEN 'RUC'
	 WHEN TIPO_DOCUMENTO = 7 THEN 'PASAPORTE'
	 END




SELECT * 
FROM[VENTAS 2023 ]
WHERE TIPO_DOCUMENTO = 0


--QUITANDO VALORES NULOS Y VACIOS (0) 
SELECT ESTADO,COUNT(ESTADO)
FROM [VENTAS 2023 ]
GROUP BY ESTADO

DELETE 
FROM [VENTAS 2023 ]
WHERE ESTADO = 'ANULADO'



-- NOMBRANDO VALORES VALIDOS Y NULOS
SELECT ESTADO,
CASE WHEN ESTADO = 1 THEN 'VALIDO'
     WHEN ESTADO = 2 THEN 'ANULADO'
	  END AS VALIDEZ
FROM [VENTAS 2023 ]

ALTER TABLE [VENTAS 2023 ]
ADD VALIDEZ VARCHAR (255)



UPDATE [VENTAS 2023 ]
SET VALIDEZ = 
CASE WHEN ESTADO = '1' THEN 'VALIDO'
     WHEN ESTADO = '2' THEN 'ANULADO'
	 END 
--DESPEJANDO COLUMNAS SIN USO
ALTER TABLE [VENTAS 2023 ]
DROP COLUMN TIPO_DE_COMPROBANTE,ESTADO
ALTER TABLE [VENTAS 2023 ]
DROP COLUMN PER_MOVI,CUO_MOVI
ALTER TABLE [VENTAS 2023 ]
DROP COLUMN TIPO_DOCUMENTO

--CAMBIANDO VALIDEZ POR ESTADO,TIPO_DOCU POR TIPO_DOCUMENTO
EXEC sp_rename 'VENTAS 2023 .VALIDEZ', 'ESTADO', 'COLUMN'
EXEC sp_rename 'VENTAS 2023 .TIPO_DOCU', 'TIPO_DOCUMENTO', 'COLUMN'


--verificando series
SELECT SERIE,COUNT(SERIE) FROM [VENTAS 2023 ]
GROUP BY SERIE













