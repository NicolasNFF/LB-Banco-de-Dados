CREATE DATABASE ESTACIONAMENTO;
GO
USE ESTACIONAMENTO
GO
CREATE TABLE EST_VEICULO(
VEI_IN_CODIGO INT NOT NULL IDENTITY
			CONSTRAINT EST_PK_VEICULO PRIMARY KEY,
VEI_CH_PLACA CHAR(7) NOT NULL 
			CONSTRAINT EST_UK_PLACA UNIQUE
			CONSTRAINT EST_CK_PLACA CHECK(VEI_CH_PLACA LIKE '[A-Z][A-Z][A-Z][0-9][A-Z0-9][0-9][0-9]'),
VEI_ST_NOME VARCHAR(50) NOT NULL,
VEI_ST_DESCRICAO VARCHAR(200) NOT NULL,
VEI_DT_INCLUSAO DATE NOT NULL
			CONSTRAINT EST_DF_INCLUSAO DEFAULT GETDATE(),
VEI_DT_FABRICACAO DATE NULL,
VEI_RE_PRECO NUMERIC(12,2) NOT NULL
			CONSTRAINT EST_DF_PRECO DEFAULT 0
			CONSTRAINT EST_CK_PRECO CHECK(VEI_RE_PRECO >=0)
);

GO 
CREATE OR ALTER PROCEDURE SP_D_EST_VEICULO
@PLACA CHAR(7) AS
SET NOCOUNT ON
DECLARE @QTDEPLACA INT
SELECT @QTDEPLACA =COUNT(*) FROM EST_VEICULO
							WHERE VEI_CH_PLACA = @PLACA
IF(@QTDEPLACA <> 1)
BEGIN
	RAISERROR('A placa informada não existe na base de dados!',15,1)
	RETURN
END
DELETE FROM EST_VEICULO WHERE VEI_CH_PLACA = @PLACA
GO

EXMPLO 2 COM CRIPTOGRAFIA

CREATE DATABASE ESTACIONAMENTO;
GO
USE ESTACIONAMENTO
GO
CREATE TABLE EST_VEICULO(
VEI_IN_CODIGO INT NOT NULL IDENTITY
			CONSTRAINT EST_PK_VEICULO PRIMARY KEY,
VEI_CH_PLACA CHAR(7) NOT NULL 
			CONSTRAINT EST_UK_PLACA UNIQUE
			CONSTRAINT EST_CK_PLACA CHECK(VEI_CH_PLACA LIKE '[A-Z][A-Z][A-Z][0-9][A-Z0-9][0-9][0-9]'),
VEI_ST_NOME VARCHAR(50) NOT NULL,
VEI_ST_DESCRICAO VARCHAR(200) NOT NULL,
VEI_DT_INCLUSAO DATE NOT NULL
			CONSTRAINT EST_DF_INCLUSAO DEFAULT GETDATE(),
VEI_DT_FABRICACAO DATE NULL,
VEI_RE_PRECO NUMERIC(12,2) NOT NULL
			CONSTRAINT EST_DF_PRECO DEFAULT 0
			CONSTRAINT EST_CK_PRECO CHECK(VEI_RE_PRECO >=0)
);


GO 
CREATE OR ALTER PROCEDURE SP_D_EST_VEICULO
@PLACA CHAR(7) WITH ENCRYPTION AS
SET NOCOUNT ON
DECLARE @QTDEPLACA INT
SELECT @QTDEPLACA =COUNT(*) FROM EST_VEICULO
							WHERE VEI_CH_PLACA = @PLACA
IF(@QTDEPLACA <> 1)
BEGIN
	RAISERROR('A placa informada não existe na base de dados!',15,1)
	RETURN
END
DELETE FROM EST_VEICULO WHERE VEI_CH_PLACA = @PLACA
GO

ELECT
	VEI_IN_CODIGO AS'Código',
	VEI_CH_PLACA AS'Placa',
	VEI_ST_NOME AS 'Nome',
	VEI_ST_DESCRICAO AS 'Descrição',
	VEI_DT_INCLUSAO AS 'Inclusão',
	VEI_DT_FABRICACAO AS 'Fabricação',
	VEI_RE_PRECO AS 'Preço'
