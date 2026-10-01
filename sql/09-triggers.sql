-- Fazer um trigger que atualize a data de Vacinação toda vez que houver uma inclusão de Vacinação.

PRINT 'Criando o Trigger TRG_ForcaDataAtualAplicacao...';

-- Se o Trigger já existir, ele será removido e recriado.
IF OBJECT_ID('TRG_ForcaDataAtualAplicacao', 'TR') IS NOT NULL
    DROP TRIGGER TRG_ForcaDataAtualAplicacao;
GO

CREATE TRIGGER TRG_ForcaDataAtualAplicacao
ON Aplicacao       
AFTER INSERT       
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Aplicacao
    SET DataAplicacao = GETDATE()
    WHERE IdAplicacao IN (SELECT IdAplicacao FROM inserted);
END
GO

PRINT 'Trigger criado com sucesso.';

-- Inserindo uma nova aplicação com uma data errada  de propósito.
INSERT INTO Aplicacao(DataAplicacao, IdPaciente, IdAplicador, IdVacina, IdLocal)
VALUES (CAST('1900-01-01' AS DATETIME2), 5, 5, 7, 5); -- Paciente Roberto, Aplicador Ana, Vacina do Lote que vence em breve

-- Seleciona a última aplicação inserida para o Paciente 5 para provar que o Trigger funcionou.
SELECT * FROM Aplicacao WHERE IdPaciente = 5 ORDER BY IdAplicacao DESC;
GO
