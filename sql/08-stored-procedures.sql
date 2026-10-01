-- Criar um STORED PROCEDURE que mostre os Pacientes que tomaram Vacina Vencida.

PRINT 'Criando o Stored Procedure SP_PacientesComVacinaVencida...';

-- Se o Procedure já existir, ele será removido e recriado.
IF OBJECT_ID('SP_PacientesComVacinaVencida', 'P') IS NOT NULL
    DROP PROCEDURE SP_PacientesComVacinaVencida;
GO

CREATE PROCEDURE SP_PacientesComVacinaVencida
AS
BEGIN
 
    SET NOCOUNT ON;

    SELECT
        p.NomePessoa,
        t.NomeVacina AS 'Tipo de Vacina',
        l.CodigoLote,
        l.DataValidade AS 'Validade do Lote',
        ap.DataAplicacao AS 'Data da Aplicação'
    FROM Aplicacao ap
    JOIN Paciente pac ON ap.IdPaciente = pac.IdPaciente
    JOIN Pessoa p ON pac.IdPessoa = p.IdPessoa
    JOIN Vacina v ON ap.IdVacina = v.IdVacina
    JOIN Lote l ON v.IdLote = l.IdLote
    JOIN TipoVacina t ON v.IdTipoVacina = t.IdTipoVacina
    WHERE
        ap.DataAplicacao > l.DataValidade; 
END
GO

PRINT 'Stored Procedure criado com sucesso.';

EXEC SP_PacientesComVacinaVencida;
GO
