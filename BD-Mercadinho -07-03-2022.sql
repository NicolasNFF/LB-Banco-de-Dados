Exemplo 1

IF NOT EXISTS (SELECT * FROM SYS.databases WHERE NAME='MERCADINHO')
BEGIN
    CREATE DATABASE MERCADINHO;
	END
  
  Exemplo2 USE MERCADINHO;
	CREATE TABLE MER_PRODUTO(
	PRO_IN_CODIGO INT NOT NULL IDENTITY
		CONSTRAINT MER_PK_PRODUTO PRIMARY KEY,
	PRO_CH_BARRAS CHAR(13) NOT NULL CONSTRAINT MER_CK_BARRAS CHECK(PRO_CH_BARRAS LIKE 
	'[0-9][0-9][0-9][0-9][0-9][.][0-9][0-9][0-9][0-9][0-9][-][0-9]')
		CONSTRAINT MER_UK_BARRAS UNIQUE,
	PRO_ST_NOME VARCHAR(100) NOT NULL,
	PRO_RE_PRECO NUMERIC(10,2) NOT NULL CONSTRAINT MER_DF_PRECO DEFAULT 0
		CONSTRAINT MER_CK_PRECO CHECK(PRO_RE_PRECO >=0),
	PRO_DT_INCLUSAO SMALLDATETIME NOT NULL
		CONSTRAINT MER_DF_INCLUSAO DEFAULT GETDATE(),
	PRO_CH_ATIVO CHAR(3) NOT NULL CONSTRAINT MER_DF_ATIVO DEFAULT 'SIM'
		CONSTRAINT MER_CK_ATIVO CHECK(PRO_CH_ATIVO IN ('SIM','NÃO'))
);

INSERT INTO MER_PRODUTO (PRO_CH_BARRAS, PRO_ST_NOME)
VALUES ('12345.6789-1','PÃO AMANHECIDO');
SELECT * FROM MER_PRODUTO;


INSERT INTO MER_PRODUTO (PRO_CH_BARRAS, PRO_ST_NOME, PRO_RE_PRECO)
VALUES ('98765.43210-9','PRODUTO NEGATIVO', 10);


INSERT INTO MER_PRODUTO (PRO_CH_BARRAS, PRO_ST_NOME, PRO_RE_PRECO, PRO_CH_ATIVO)
VALUES ('98765.43211-4','PRESUNTO PARMA', 100, 'NÃO');


SELECT *FROM MER_PRODUTO;


---EXEMPLO3

--DROP PROCEDURE dbo.SP_S_MER_PRODUTO;
CREATE PROCEDURE dbo.SP_S_MER_PRODUTO

@PRODUTO VARCHAR(100)
AS

SELECT
	PRO.PRO_CH_BARRAS,
	PRO.PRO_ST_NOME,
	PRO.PRO_RE_PRECO,
	PRO.PRO_DT_INCLUSAO,
	PRO.PRO_CH_ATIVO


FROM
	MER_PRODUTO AS PRO

WHERE
	PRO.PRO_ST_NOME LIKE @PRODUTO

	ORDER BY
		PRO.PRO_ST_NOME ASC

EXEC SP_S_MER_PRODUTO 'PRESUNTO PARMA'

SP_S_MER_PRODUTO 'PRESUNTO PARMA' --EXEC É OPCIONAL


EXEMPLO 4

--DROP PROCEDURE dbo.SP_S_MER_PRODUTO;
CREATE OR ALTER PROCEDURE dbo.SP_S_MER_PRODUTO

@PRODUTO VARCHAR(100)
AS

SELECT
	PRO.PRO_CH_BARRAS,
	PRO.PRO_ST_NOME,
	PRO.PRO_RE_PRECO,
	PRO.PRO_DT_INCLUSAO,
	PRO.PRO_CH_ATIVO


FROM
	MER_PRODUTO AS PRO

WHERE
	PRO.PRO_ST_NOME LIKE '%'+@PRODUTO+'%' --CONCATENADO

	ORDER BY
		PRO.PRO_ST_NOME ASC

EXEC SP_S_MER_PRODUTO 'PRESUNTO PARMA'

SP_S_MER_PRODUTO 'PRESUNTO' --EXEC É OPCIONAL

EXEXMPLO 5


CREATE OR ALTER PROCEDURE DBO.SP_I_MER_PRODUTO
@BARRAS CHAR(13),
@NOME VARCHAR(100),
@PRECO NUMERIC(10,2),
@ATIVO CHAR(3)
AS
    --CRIANDO VARIAVEIS
	DECLARE @QTDEBARRAS INT

	SELECT @QTDEBARRAS=COUNT(*) FROM MER_PRODUTO 
	WHERE PRO_CH_BARRAS = @BARRAS;

	IF QTDEBARRAS > 0
	BEGIN
		RAISERROR('O codigo de barras informado ja existe',15,1);

	END

	SET NOCOUNT ON --DESLIGA A MSG DE LINHAS AFETADAS


IF LEN(@NOME)=0 --VERIFICANDO SE O NOME FOI PASSADO
		BEGIN
			RAISERROR('O nome é obrigatório',15,1);
		END


IF @PRECO <0 --VERIFICANDO SE O PREÇO É NEGATIVO
	BEGIN
		RAISERROR('O preço não pode ser nativo',15,1) 
	END

IF @ATIVO NOT IN ('SIM','NÃO') --VERIFICANDO SE O ATIVO É VALIDO
	BEGIN
		RAISERROR('O campo ativo deve ser Sim ou Não',15,1)
	END
	--IREMOS INSERIR OS DADOS
INSERT INTO MER_PRODUTO (PRO_CH_BARRAS, PRO_ST_NOME, PRO_RE_PRECO,
PRO_CH_ATIVO) VALUES (@BARRAS,@NOME,@PRECO, @ATIVO);

RETURN

SP_I_MER_PRODUTO '12345.12345-0','',50,'SIM'
SP_I_MER_PRODUTO '12343.12345-0','ARROZ',50,'SIM'
SP_I_MER_PRODUTO '12344.12345-0','ARROZ',50,'OI'

SP_I_MER_PRODUTO '12345.12345-0','ARROZ AGULHINHA',14.90,'SIM'

SELECT COUNT(*) FROM MER_PRODUTO --EXEMPLO USO DO COUNT 
WHERE PRO_CH_BARRAS ='12345.12345-2';

SP_HELP 'MER_PRODUTO'


EXEMPLO 6 

CREATE OR ALTER PROCEDURE DBO.SP_I_MER_PRODUTO
@BARRAS CHAR(13),
@NOME VARCHAR(100),
@PRECO NUMERIC(10,2),
@ATIVO CHAR(3)
AS
    --CRIANDO VARIAVEIS
	DECLARE @QTDEBARRAS INT

	SELECT @QTDEBARRAS=COUNT(*) FROM MER_PRODUTO 
	WHERE PRO_CH_BARRAS = @BARRAS;

	IF @QTDEBARRAS > 0
	BEGIN
		RAISERROR('O codigo de barras informado ja existe',15,1);

	END

	SET NOCOUNT ON --DESLIGA A MSG DE LINHAS AFETADAS


IF LEN(@NOME)=0 --VERIFICANDO SE O NOME FOI PASSADO
		BEGIN
			RAISERROR('O nome é obrigatório',15,1);
		END


IF @PRECO <0 --VERIFICANDO SE O PREÇO É NEGATIVO
	BEGIN
		RAISERROR('O preço não pode ser nativo',15,1) 
	END

IF @ATIVO NOT IN ('SIM','NÃO') --VERIFICANDO SE O ATIVO É VALIDO
	BEGIN
		RAISERROR('O campo ativo deve ser Sim ou Não',15,1)
	END
	--IREMOS INSERIR OS DADOS
INSERT INTO MER_PRODUTO (PRO_CH_BARRAS, PRO_ST_NOME, PRO_RE_PRECO,
PRO_CH_ATIVO) VALUES (@BARRAS,@NOME,@PRECO, @ATIVO);

RETURN

SP_I_MER_PRODUTO '12345.12345-0','',50,'SIM'
SP_I_MER_PRODUTO '12343.12345-0','ARROZ',50,'SIM'
SP_I_MER_PRODUTO '12344.12345-0','ARROZ',50,'OI'

SP_I_MER_PRODUTO '12345.12345-0','ARROZ AGULHINHA',14.90,'SIM'

SELECT COUNT(*) FROM MER_PRODUTO --EXEMPLO USO DO COUNT 
WHERE PRO_CH_BARRAS ='12345.12345-2';

SP_HELP 'MER_PRODUTO'


  
  
