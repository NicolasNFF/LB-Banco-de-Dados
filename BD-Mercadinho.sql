Exemplo 1

CREATE DATABASE MERCADINHO
go
USE MERCADINHO
GO

CREATE TABLE MERCLIENTE(
CLI_CH_CPF CHAR(14) NOT NULL
           CONSTRAINT MER_PK_CLIENTE PRIMARY KEY
		   CONSTRAINT MER_CK_CLI_CPF CHECK (CLI_CH_CPF LIKE
'[0-9][0-9][0-9][.][0-9][0-9][0-9][.][0-9][0-9][0-9][-][0-9][0-9]'),
CLI_ST_NOME VARCHAR(100) NOT NULL,
CLI_ST_EMAIL VARCHAR(100) NOT NULL
            CONSTRAINT MER_UK_CLI_EMAIL UNIQUE
);

Exemplo 2

DROP DATABASE MERCADINHO
CREATE DATABASE MERCADINHO
go
USE MERCADINHO
GO

CREATE TABLE MER_CLIENTE(
CLI_CH_CPF CHAR(14) NOT NULL
           CONSTRAINT MER_PK_CLIENTE PRIMARY KEY
		   CONSTRAINT MER_CK_CLI_CPF CHECK (CLI_CH_CPF LIKE
'[0-9][0-9][0-9][.][0-9][0-9][0-9][.][0-9][0-9][0-9][-][0-9][0-9]'),
CLI_ST_NOME VARCHAR(100) NOT NULL,
CLI_ST_EMAIL VARCHAR(100) NOT NULL
            CONSTRAINT MER_UK_CLI_EMAIL UNIQUE
);

INSERT INTO MER_CLIENTE VALUES ('123.456.789-01','MARIA ALVES', 'maria.alves@uol.com.br'); -- ok
INSERT INTO MER_CLIENTE VALUES ('123.456.789-02','JOSE ALVES', 'jose@ig.com.br');

Exemplo 3 

USE MERCADINHO;
GO
CREATE TABLE MER_PEDIDO(
PED_IN_NUMERO INT NOT NULL IDENTITY(1,1)
       CONSTRAINT MER_PK_PEDIDO PRIMARY KEY,
PED_DT_EMISSAO SMALLDATETIME NOT NULL
       CONSTRAINT MER_DF_PED_EMISSAO DEFAULT GETDATE (),
PED_RE_VALOR NUMERIC(10,2) NOT NULL
       CONSTRAINT MER_DF_PED_VALOR DEFAULT 0
	   CONSTRAINT MER_CK_PED_VALOR CHECK (PED_RE_VALOR >= 0),
CLI_CH_CPF CHAR(14) NULL
       CONSTRAINT MER_FK_PED_CLI
	   FOREIGN KEY REFERENCES MER_CLIENTE(CLI_CH_CPF)
	   );

INSERT INTO  MER_PEDIDO(PED_RE_VALOR, CLI_CH_CPF) VALUES (200.35,'123.456.789-01');
SELECT *FROM MER_PEDIDO;


Exemplo4


INSERT INTO MER_CLIENTE VALUES ('987.654.321-09', 'MARIAS LImA lOPeS  ','MARIA@uol.com.br');


INSERT INTO MER_PEDIDO (PED_RE_VALOR, CLI_CH_CPF) VALUES (120.40,'987.654.321-09');

INSERT INTO MER_PEDIDO (PED_RE_VALOR, CLI_CH_CPF) VALUES (930.52,'987.654.321-09');

SELECT * FROM MER_PEDIDO;
SELECT *

Exemplo5

SELECT
 CLI.CLI_CH_CPF AS 'CPF',
 TRIM(UPPER(CLI.CLI_ST_NOME)) AS 'NOME',
 TRIM(LOWER(CLI.CLI_ST_EMAIL)) AS 'EMAIL',
 PED.PED_IN_NUMERO  AS 'PEDIDO',
 PED.PED_DT_EMISSAO AS 'DATA EMISS??O',
 PED.PED_RE_VALOR AS 'VALOR'


FROM 
  MER_CLIENTE AS CLI,
   MER_PEDIDO AS PED

WHERE
 CLI.CLI_CH_CPF = PED.CLI_CH_CPF


Exemplo 6

SELECT
 CLI.CLI_CH_CPF AS 'CPF',
 TRIM(UPPER(CLI.CLI_ST_NOME)) AS 'NOME',
 TRIM(LOWER(CLI.CLI_ST_EMAIL)) AS 'EMAIL',
 PED.PED_IN_NUMERO  AS 'PEDIDO',
 DATEPART(DD,PED.PED_DT_EMISSAO) AS 'DATA EMISS??O',
  DATEPART(MM,PED.PED_DT_EMISSAO) AS 'DATA EMISS??O',
   DATEPART(YYYY,PED.PED_DT_EMISSAO) AS 'DATA EMISS??O',
 PED.PED_RE_VALOR AS 'VALOR'


FROM 
  MER_CLIENTE AS CLI,
   MER_PEDIDO AS PED

WHERE
 CLI.CLI_CH_CPF = PED.CLI_CH_CPF
 
 
 Exemplo 7
 
 
SELECT
 CLI.CLI_CH_CPF AS 'CPF',
 TRIM(UPPER(CLI.CLI_ST_NOME)) AS 'NOME',
 TRIM(LOWER(CLI.CLI_ST_EMAIL)) AS 'EMAIL',
 PED.PED_IN_NUMERO  AS 'PEDIDO',
 STR(DATEPART(DD,PED.PED_DT_EMISSAO),2,0)+'/'+
 STR(DATEPART(MM,PED.PED_DT_EMISSAO),2,0)+'/'+ 
 STR(DATEPART(YYYY,PED.PED_DT_EMISSAO),4,0)
 AS 'DATA EMISS??O',

 PED.PED_RE_VALOR AS 'VALOR'


FROM 
  MER_CLIENTE AS CLI,
   MER_PEDIDO AS PED

WHERE
 CLI.CLI_CH_CPF = PED.CLI_CH_CPF
 
 Exemplo 8
 
 
SELECT
 CLI.CLI_CH_CPF AS 'CPF',
 TRIM(UPPER(CLI.CLI_ST_NOME)) AS 'NOME',
 TRIM(LOWER(CLI.CLI_ST_EMAIL)) AS 'EMAIL',
 PED.PED_IN_NUMERO  AS 'PEDIDO',
 REPLACE(STR(DATEPART(DD,PED.PED_DT_EMISSAO),2,0), '  ','0')+'/'+
 REPLACE(STR(DATEPART(MM,PED.PED_DT_EMISSAO),2,0), '  ','0')+'/'+
 STR(DATEPART(YYYY,PED.PED_DT_EMISSAO),4,0) AS 'DATA EMISS??O',

 PED.PED_RE_VALOR AS 'VALOR'


FROM 
  MER_CLIENTE AS CLI,
   MER_PEDIDO AS PED

WHERE
 CLI.CLI_CH_CPF = PED.CLI_CH_CPF


Exemplo 9

CREATE VIEW MER_VW_VENDAS AS
SELECT
 CLI.CLI_CH_CPF AS 'CPF',
 TRIM(UPPER(CLI.CLI_ST_NOME)) AS 'NOME',
 TRIM(LOWER(CLI.CLI_ST_EMAIL)) AS 'EMAIL',
 PED.PED_IN_NUMERO  AS 'PEDIDO',
 REPLACE(STR(DATEPART(DD,PED.PED_DT_EMISSAO),2,0), '  ','0')+'/'+
 REPLACE(STR(DATEPART(MM,PED.PED_DT_EMISSAO),2,0), '  ','0')+'/'+
 STR(DATEPART(YYYY,PED.PED_DT_EMISSAO),4,0) AS 'DATA EMISS??O',

 PED.PED_RE_VALOR AS 'VALOR'


FROM 
  MER_CLIENTE AS CLI,
   MER_PEDIDO AS PED

WHERE
 CLI.CLI_CH_CPF = PED.CLI_CH_CPF


