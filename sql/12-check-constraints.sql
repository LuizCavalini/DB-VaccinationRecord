-- Criar um CONSTRAINT do tipo CHECK para impedir Lotes cuja Quantidade seja maior que 100 e mostrar o erro de violação.

PRINT 'Adicionando a constraint CK_Lote_QuantidadeMaxima...';

ALTER TABLE Lote
ADD CONSTRAINT CK_Lote_QuantidadeMaxima CHECK (Quantidade <= 100);
GO

PRINT 'Constraint adicionada. Agora, tentando violá-la...';

INSERT INTO Lote (CodigoLote, DataFabricacao, DataValidade, IdFabricante, Quantidade)
VALUES ('LOTE-EXCESSO', CAST('2025-01-01' AS DATE), CAST('2026-01-01' AS DATE), 1, 101);

GO
