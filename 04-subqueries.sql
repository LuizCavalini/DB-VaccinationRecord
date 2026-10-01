-- Listar os nomes dos Pacientes que tomaram a Vacina de todos os Fabricantes existentes que possuem lotes.

SELECT
    p.NomePessoa
FROM
    Pessoa p
    JOIN Paciente pac ON p.IdPessoa = pac.IdPessoa
    JOIN Aplicacao ap ON pac.IdPaciente = ap.IdPaciente
    JOIN Vacina v ON ap.IdVacina = v.IdVacina
    JOIN Lote l ON v.IdLote = l.IdLote
GROUP BY
    p.NomePessoa
HAVING
    COUNT(DISTINCT l.idFabricante) = (
        SELECT COUNT(DISTINCT IdFabricante) FROM Lote
    );
GO
