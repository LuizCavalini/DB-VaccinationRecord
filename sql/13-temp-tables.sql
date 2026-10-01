-- Criar uma Tabela Temporária Global com os dados da Tabela de Fabricantes.

PRINT 'Criando a tabela temporária global ##Fabricantes...';

-- Se a tabela já existir de uma execução anterior, ela é removida.
IF OBJECT_ID('tempdb..##Fabricantes') IS NOT NULL
    DROP TABLE ##Fabricantes;
GO

-- Cria a tabela temporária global e copia os dados da tabela Fabricante para ela.
SELECT * INTO ##Fabricantes FROM Fabricante;
GO

PRINT 'Tabela temporária criada com sucesso.';

SELECT * FROM ##Fabricantes;
GO