-- Criar uma VIEW de todos os Lotes com data vencida.

PRINT 'Criando a VIEW V_LotesVencidos...';

-- Se a VIEW já existir, ela será removida e recriada.
IF OBJECT_ID('V_LotesVencidos', 'V') IS NOT NULL
    DROP VIEW V_LotesVencidos;
GO

CREATE VIEW V_LotesVencidos AS
SELECT
    l.IdLote,
    l.CodigoLote,
    l.DataValidade,
    f.NomeFabricante,
    l.Quantidade
FROM
    Lote l
    JOIN Fabricante f ON l.IdFabricante = f.IdFabricante
WHERE
    l.DataValidade < GETDATE(); -- A condição que define se um lote está vencido
GO

PRINT 'VIEW criada com sucesso.';

SELECT * FROM V_LotesVencidos;
GO
