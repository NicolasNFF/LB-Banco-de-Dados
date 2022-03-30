CREATE DATABASE folha;
GO
USE folha
GO
DROP TABLE FOl_INSS
CREATE TABLE FOL_INSS(
INS_IN_CODIGO INT NOT NULL IDENTITY 
	CONSTRAINT FOL_PK_INSS PRIMARY KEY,
INS_DT_INICIO DATE NOT NULL,
INS_RE_INICIAL NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_CK_INICIAL CHECK (INS_RE_INICIAL >= 0),
INS_RE_FINAL NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_CK_FINAL CHECK (INS_RE_FINAL >= 0)
	CONSTRAINT FOL_UK_FINAL UNIQUE (INS_DT_INICIO, INS_RE_FINAL),
INS_RE_ALIQUOTA NUMERIC(4,2) NOT NULL
	CONSTRAINT FOL_CK_ALIQUOTA CHECK(INS_RE_ALIQUOTA >=0),
INS_RE_TETO NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_DF_TETO DEFAULT 0
	CONSTRAINT FOL_CK_TETO CHECK (INS_RE_TETO >=0)

);

/* DADOS DO INSS 01/2022 */

INSERT INTO FOL_INSS VALUES ('2022-01-01',0,1212,7.5,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',1212.01,2427.35,9.0,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',2427.36,3641.03,12.0,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',3641.04,7087.22,14.0,992.21)

/* DADOS DO INSS 01/2021 */

INSERT INTO FOL_INSS VALUES ('2021-01-01',0,1100,7.5,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',1100.01,2203.48,9.0,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',2203.49,3305.22,12.0,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',3305.23,6433.57,14.0,900.70)

SELECT * from FOL_INSS

GO
CREATE FUNCTION VALORINSS(@salario NUMERIC(10,2))
RETURNS NUMERIC(10,2) AS
BEGIN

 --DECLARANDO VARIAVEUS
 DECLARE @inss NUMERIC(10,2)
 DECLARE @aliquota NUMERIC(4,2)
 DECLARE @tetoimposto NUMERIC(10,2)
 --INICIALIZANDO AS VARIAVEIS
 SET @inss = 0
 SET @aliquota = 0
 SELECT @tetoimposto = MAX(INS_RE_TETO) FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE();
 END

 SELECT INS_RE_TETO FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE();

  SELECT INS_RE_ALIQUOTA FROM FOL_INSS
 WHERE 5000 BETWEEN INS_RE_INICIAL AND INS_RE_FINAL AND
	INS_DT_INICIO = '2022-01-01'

  SELECT INS_DT_INICIO FROM FOL_INSS
  WHERE INS_DT_INICIO <= GETDATE()


EXEMPLO 2

CREATE DATABASE folha;
GO
USE folha
GO
DROP TABLE FOl_INSS
CREATE TABLE FOL_INSS(
INS_IN_CODIGO INT NOT NULL IDENTITY 
	CONSTRAINT FOL_PK_INSS PRIMARY KEY,
INS_DT_INICIO DATE NOT NULL,
INS_RE_INICIAL NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_CK_INICIAL CHECK (INS_RE_INICIAL >= 0),
INS_RE_FINAL NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_CK_FINAL CHECK (INS_RE_FINAL >= 0)
	CONSTRAINT FOL_UK_FINAL UNIQUE (INS_DT_INICIO, INS_RE_FINAL),
INS_RE_ALIQUOTA NUMERIC(4,2) NOT NULL
	CONSTRAINT FOL_CK_ALIQUOTA CHECK(INS_RE_ALIQUOTA >=0),
INS_RE_TETO NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_DF_TETO DEFAULT 0
	CONSTRAINT FOL_CK_TETO CHECK (INS_RE_TETO >=0)

);

/* DADOS DO INSS 01/2022 */

INSERT INTO FOL_INSS VALUES ('2022-01-01',0,1212,7.5,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',1212.01,2427.35,9.0,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',2427.36,3641.03,12.0,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',3641.04,7087.22,14.0,992.21)

/* DADOS DO INSS 01/2021 */

INSERT INTO FOL_INSS VALUES ('2021-01-01',0,1100,7.5,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',1100.01,2203.48,9.0,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',2203.49,3305.22,12.0,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',3305.23,6433.57,14.0,900.70)

SELECT * from FOL_INSS

GO
CREATE FUNCTION VALORINSS(@salario NUMERIC(10,2))
RETURNS NUMERIC(10,2) AS
BEGIN

 --DECLARANDO VARIAVEUS
 DECLARE @inss NUMERIC(10,2)
 DECLARE @aliquota NUMERIC(4,2)
 DECLARE @tetoimposto NUMERIC(10,2)
 --INICIALIZANDO AS VARIAVEIS
 SET @inss = 0
 SET @aliquota = 0
 SELECT @tetoimposto = MAX(INS_RE_TETO) FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE();
 END

 SELECT INS_RE_TETO FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE();

  SELECT INS_RE_ALIQUOTA FROM FOL_INSS
 WHERE 5000 BETWEEN INS_RE_INICIAL AND INS_RE_FINAL AND
	INS_DT_INICIO =  (SELECT MAX(INS_DT_INICIO) FROM FOL_INSS
  WHERE INS_DT_INICIO <= GETDATE())


EXEMPLO 3

CREATE DATABASE folha;
GO
USE folha
GO
DROP TABLE FOl_INSS
CREATE TABLE FOL_INSS(
INS_IN_CODIGO INT NOT NULL IDENTITY 
	CONSTRAINT FOL_PK_INSS PRIMARY KEY,
INS_DT_INICIO DATE NOT NULL,
INS_RE_INICIAL NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_CK_INICIAL CHECK (INS_RE_INICIAL >= 0),
INS_RE_FINAL NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_CK_FINAL CHECK (INS_RE_FINAL >= 0)
	CONSTRAINT FOL_UK_FINAL UNIQUE (INS_DT_INICIO, INS_RE_FINAL),
INS_RE_ALIQUOTA NUMERIC(4,2) NOT NULL
	CONSTRAINT FOL_CK_ALIQUOTA CHECK(INS_RE_ALIQUOTA >=0),
INS_RE_TETO NUMERIC(10,2) NOT NULL
	CONSTRAINT FOL_DF_TETO DEFAULT 0
	CONSTRAINT FOL_CK_TETO CHECK (INS_RE_TETO >=0)

);

/* DADOS DO INSS 01/2022 */

INSERT INTO FOL_INSS VALUES ('2022-01-01',0,1212,7.5,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',1212.01,2427.35,9.0,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',2427.36,3641.03,12.0,0);
INSERT INTO FOL_INSS VALUES ('2022-01-01',3641.04,7087.22,14.0,992.21)

/* DADOS DO INSS 01/2021 */

INSERT INTO FOL_INSS VALUES ('2021-01-01',0,1100,7.5,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',1100.01,2203.48,9.0,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',2203.49,3305.22,12.0,0);
INSERT INTO FOL_INSS VALUES ('2021-01-01',3305.23,6433.57,14.0,900.70)

SELECT * from FOL_INSS

GO
CREATE FUNCTION VALORINSS(@salario NUMERIC(10,2))
RETURNS NUMERIC(10,2) AS
BEGIN

 --DECLARANDO VARIAVEUS
 DECLARE @inss NUMERIC(10,2)
 DECLARE @aliquota NUMERIC(4,2)
 DECLARE @tetoimposto NUMERIC(10,2)
 --INICIALIZANDO AS VARIAVEIS
 SET @inss = 0
 SET @aliquota = 0
 SELECT @tetoimposto = MAX(INS_RE_TETO) FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE();

 SELECT @aliquota = INS_RE_ALIQUOTA FROM FOL_INSS
 WHERE @salario BETWEEN INS_RE_INICIAL AND INS_RE_FINAL AND
 INS_DT_INICIO =  (SELECT MAX(INS_DT_INICIO) FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE())

 SET @inss = (@salario * (@aliquota / 100))
 IF (@inss > @tetoimposto)
	BEGIN
	 SET @inss = @tetoimposto

 END
 RETURN @inss
 END

 SELECT dbo.VALORINSS(3641.18)

 SELECT INS_RE_TETO FROM FOL_INSS
 WHERE INS_DT_INICIO <= GETDATE();

 

 



