-- Fazer um SELECT unindo o Fabricante e Vacina através de um FULL JOIN.
-- Garantir que exista NULL tanto no lado do Fabricante como do lado da Vacina.

PRINT 'Unindo Fabricantes e Vacinas com FULL JOIN...';

SELECT
    f.NomeFabricante,
    l.CodigoLote,
    v.IdVacina,
    tv.NomeVacina AS TipoVacina
FROM
    Fabricante f
    FULL JOIN Lote l ON f.IdFabricante = l.IdFabricante
    FULL JOIN Vacina v ON l.IdLote = v.IdLote
    LEFT JOIN TipoVacina tv ON v.IdTipoVacina = tv.IdTipoVacina -- LEFT JOIN aqui para não perder os NULLs
ORDER BY
    f.NomeFabricante;
GO
