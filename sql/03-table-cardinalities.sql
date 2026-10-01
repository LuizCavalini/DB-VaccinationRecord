-- Consulta para verificar a cardinalidade (número de linhas) de cada tabela

SELECT
    T.name AS NomeTabela,
    P.rows AS Cardinalidade
FROM
    sys.tables AS T
INNER JOIN
    sys.partitions AS P ON T.object_id = P.object_id
WHERE
    P.index_id IN (0, 1) -- 0=Heap, 1=Clustered Index (a própria tabela)
ORDER BY
    NomeTabela;
