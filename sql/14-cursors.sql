-- Declarar um cursor para gerar uma saída com Data, Pacientes, Lotes e Fabricantes.

PRINT 'Iniciando demonstração de CURSOR...';

-- Declarando as variáveis que irão armazenar os dados de cada linha
DECLARE @DataAplicacao DATETIME2,
        @NomePaciente NVARCHAR(255),
        @CodigoLote NVARCHAR(100),
        @NomeFabricante NVARCHAR(150);

-- Declarando o CURSOR
DECLARE cur_RelatorioVacinacao CURSOR FOR
    SELECT
        ap.DataAplicacao,
        p.NomePessoa,
        l.CodigoLote,
        f.NomeFabricante
    FROM Aplicacao ap
    JOIN Paciente pac ON ap.IdPaciente = pac.IdPaciente
    JOIN Pessoa p ON pac.IdPessoa = p.IdPessoa
    JOIN Vacina v ON ap.IdVacina = v.IdVacina
    JOIN Lote l ON v.IdLote = l.IdLote
    JOIN Fabricante f ON l.IdFabricante = f.IdFabricante
    ORDER BY ap.DataAplicacao;

OPEN cur_RelatorioVacinacao;

-- Obter a primeira linha do cursor e armazenar os dados nas variáveis
FETCH NEXT FROM cur_RelatorioVacinacao INTO @DataAplicacao, @NomePaciente, @CodigoLote, @NomeFabricante;

-- Loop para percorrer todas as linhas dos resultados
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Processa a linha atual (imprimindo os dados)
    PRINT 'Data: ' + FORMAT(@DataAplicacao, 'dd/MM/yyyy HH:mm') +
          ' | Paciente: ' + @NomePaciente +
          ' | Lote: ' + @CodigoLote +
          ' | Fabricante: ' + @NomeFabricante;

    -- Obtém a próxima linha
    FETCH NEXT FROM cur_RelatorioVacinacao INTO @DataAplicacao, @NomePaciente, @CodigoLote, @NomeFabricante;
END;

CLOSE cur_RelatorioVacinacao;

-- Liberar a memória alocada pelo CURSOR
DEALLOCATE cur_RelatorioVacinacao;

PRINT 'Demonstração de CURSOR concluída.';
GO
