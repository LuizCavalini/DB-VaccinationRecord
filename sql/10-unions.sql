-- Fazer a união dos Lotes com vencimento em 30 dias com as vencidas há 30 dias.

PRINT 'Listando lotes com validade próxima ou recentemente vencidos:';

-- Lotes que vencerão nos próximos 30 dias
SELECT
    CodigoLote,
    DataValidade,
    'Vence em breve' AS Status
FROM Lote
WHERE
    DataValidade BETWEEN GETDATE() AND DATEADD(day, 30, GETDATE())

UNION ALL 

-- Lotes que venceram nos últimos 30 dias
SELECT
    CodigoLote,
    DataValidade,
    'Venceu recentemente' AS Status
FROM Lote
WHERE
    DataValidade BETWEEN DATEADD(day, -30, GETDATE()) AND GETDATE();
GO
