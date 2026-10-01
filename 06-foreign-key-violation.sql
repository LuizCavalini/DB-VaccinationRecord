-- Mostrar o erro que acontece se tentarmos incluir um Lote sem que o Fabricante exista

PRINT 'Tentando inserir um Lote com um IdFabricante inválido (999)...';

INSERT INTO Lote (CodigoLote, DataFabricacao, DataValidade, IdFabricante, Quantidade)
VALUES ('LOTE-FALSO', CAST('2025-01-01' AS DATE), CAST('2026-01-01' AS DATE), 999, 50);

GO
