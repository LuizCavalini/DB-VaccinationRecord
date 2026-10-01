-- CARGA DE DADOS

SET NOCOUNT ON;
GO

PRINT 'Iniciando a inserção de dados estratégicos...';
GO

-- Inserindo dados de domínio
INSERT INTO Sexo (NomeSexo) VALUES ('Masculino'), ('Feminino'), ('Intersexo'), ('Não informado'), ('Outro');
INSERT INTO Cor (NomeCor) VALUES ('Branca'), ('Parda'), ('Preta'), ('Amarela'), ('Indígena');
INSERT INTO EstadoCivil (NomeEstadoCivil) VALUES ('Solteiro(a)'), ('Casado(a)'), ('Divorciado(a)'), ('Viúvo(a)'), ('União Estável');
INSERT INTO Genero (NomeGenero) VALUES ('Homem'), ('Mulher'), ('Não-binário'), ('Transgênero'), ('Prefere não declarar');
INSERT INTO Pais (NomePais) VALUES ('Brasil'), ('Argentina'), ('Portugal'), ('Alemanha'), ('Estados Unidos');
INSERT INTO TipoLogradouro (NomeTipoLogradouro) VALUES ('Rua'), ('Avenida'), ('Praça'), ('Travessa'), ('Alameda');
INSERT INTO Fabricante (NomeFabricante) VALUES ('Pfizer'), ('AstraZeneca'), ('Sinovac'), ('Janssen'), ('Moderna'), ('Medigen');
INSERT INTO TipoVacina (NomeVacina, NumeroDoses) VALUES ('COVID-19 Comirnaty', 2), ('COVID-19 Vaxzevria', 2), ('COVID-19 CoronaVac', 2), ('Gripe Quadrivalente', 1), ('Tríplice Viral (SRC)', 1);
INSERT INTO Doenca (NomeDoenca, CodigoCID10) VALUES ('COVID-19', 'U07.1'), ('Influenza (Gripe)', 'J11.1'), ('Sarampo', 'B05'), ('Caxumba', 'B26'), ('Rubéola', 'B06');
GO

-- Relacionamentos e estruturas
INSERT INTO Imunizacao (IdTipoVacina, IdDoenca) VALUES (1, 1), (2, 1), (3, 1), (4, 2), (5, 3), (5, 4), (5, 5);
INSERT INTO UF (NomeUF, IdPais) VALUES ('São Paulo', 1), ('Rio de Janeiro', 1), ('Minas Gerais', 1), ('Bahia', 1), ('Santa Catarina', 1);
INSERT INTO Cidade (NomeCidade, IdUF) VALUES ('São Paulo', 1), ('Campinas', 1), ('Rio de Janeiro', 2), ('Belo Horizonte', 3), ('Salvador', 4);
INSERT INTO Bairro (NomeBairro, IdCidade) VALUES ('Pinheiros', 1), ('Taquaral', 2), ('Copacabana', 3), ('Savassi', 4), ('Pelourinho', 5);
INSERT INTO Logradouro (NomeLogradouro, IdTipoLogradouro) VALUES ('Faria Lima', 2), ('Norte-Sul', 2), ('Atlântica', 2), ('Getúlio Vargas', 2), ('Cardeal da Silva', 1);
INSERT INTO Endereco (IdLogradouro, IdBairro, Numero, Complemento, CEP) VALUES (1, 1, '1500', '10 Andar', '01452-001'),(2, 2, 'S/N', NULL, '13075-420'),(3, 3, '2000', 'Apto 501', '22070-001'),(4, 4, '500', 'Loja B', '30112-021'),(5, 5, '10', NULL, '40025-000');
GO

-- Pessoas e Históricos
INSERT INTO Pessoa (NomePessoa, DataNascimento, IdNaturalidade, IdSexo, IdCor) VALUES
('Carlos Siqueira', CAST('1980-05-15' AS DATE), 1, 1, 2),
('Maria Oliveira', CAST('1992-11-20' AS DATE), 3, 2, 1),
('João Almeida', CAST('1975-03-10' AS DATE), 2, 1, 3),
('Ana Souza', CAST('2001-07-22' AS DATE), 4, 2, 1),
('Roberto Lima', CAST('1988-01-30' AS DATE), 5, 1, 2),
('Fernanda Costa', CAST('1995-09-05' AS DATE), 1, 2, 4);
INSERT INTO HistoricoEstadoCivil (IdPessoa, IdEstadoCivil, DataInicio) VALUES (1, 2, '2010-06-20'), (2, 1, '1992-11-20'), (3, 3, '2015-01-10'), (4, 1, '2001-07-22'), (5, 5, '2018-02-14');
INSERT INTO HistoricoGenero (IdPessoa, IdGenero, DataInicio) VALUES (1, 1, '1980-05-15'), (2, 2, '1992-11-20'), (3, 1, '1975-03-10'), (4, 2, '2001-07-22'), (5, 1, '1988-01-30');
INSERT INTO HistoricoEndereco (IdPessoa, IdEndereco, DataInicio) VALUES (1, 1, '2012-03-01'), (2, 3, '2019-11-15'), (3, 4, '2016-08-01'), (4, 5, '2022-01-20'), (5, 2, '2020-05-10');
INSERT INTO Nacionalidade (IdPessoa, IdPais) VALUES (1, 1), (2, 1), (3, 1), (4, 1), (5, 3);
GO

-- Lotes e Vacinas específicas
INSERT INTO Lote (CodigoLote, DataFabricacao, DataValidade, idFabricante, Quantidade) VALUES
-- Lotes para a TAREFA 3 (um de cada fabricante principal)
('PFR-T3', CAST('2024-01-01' AS DATE), CAST('2025-12-31' AS DATE), 1, 100),
('AZ-T3', CAST('2024-01-01' AS DATE), CAST('2025-12-31' AS DATE), 2, 100),
('SNV-T3', CAST('2024-01-01' AS DATE), CAST('2025-12-31' AS DATE), 3, 100),
('JSN-T3', CAST('2024-01-01' AS DATE), CAST('2025-12-31' AS DATE), 4, 100),
('MDR-T3', CAST('2024-01-01' AS DATE), CAST('2025-12-31' AS DATE), 5, 100),
-- Lotes para outras tarefas
('PFR-T5', CAST('2023-01-01' AS DATE), CAST('2024-01-01' AS DATE), 1, 50),
('AZ-T4', CAST('2025-06-01' AS DATE), DATEADD(day, 20, GETDATE()), 2, 80),
('SNV-T6', CAST('2025-05-01' AS DATE), DATEADD(day, -20, GETDATE()), 3, 70);
INSERT INTO Vacina (IdLote, IdTipoVacina) VALUES (1, 1), (2, 2), (3, 3), (4, 1), (5, 4), (6, 1), (7, 2), (8, 3);
GO

-- Eventos de Aplicação
INSERT INTO Paciente (IdPessoa, CodigoSUS) VALUES (1, '111222333444555'), (2, '222333444555666'), (3, '333444555666777'), (4, '444555666777888'), (5, '555666777888999');
INSERT INTO Aplicador (IdPessoa, RegistroProfissional) VALUES (2, 'COREN-RJ 54321'), (6, 'COREN-SP 98765'), (1, 'COREN-SP 12345'), (3, 'COREN-MG 67890'), (4, 'COREN-BA 09876');
INSERT INTO LocalAplicacao (NomeLocal, IdEndereco) VALUES ('Posto de Saúde Pinheiros', 1), ('Drive-Thru Lagoa do Taquaral', 2), ('Posto Orla de Copacabana', 3), ('Centro de Saúde Savassi', 4), ('UBS Pelourinho', 5);
INSERT INTO Aplicacao (DataAplicacao, IdPaciente, IdAplicador, IdVacina, IdLocal) VALUES
-- TAREFA 3: Paciente 1 (Carlos) tomando vacina de TODOS os 5 fabricantes principais
(CAST('2024-02-01' AS DATETIME2), 1, 1, 1, 1),
(CAST('2024-03-01' AS DATETIME2), 1, 2, 2, 2),
(CAST('2024-04-01' AS DATETIME2), 1, 3, 3, 3),
(CAST('2024-05-01' AS DATETIME2), 1, 4, 4, 4),
(CAST('2024-06-01' AS DATETIME2), 1, 5, 5, 5),
-- TAREFA 7: Paciente 3 (João) tomando vacina do lote vencido
(CAST('2025-02-15' AS DATETIME2), 3, 2, 6, 2),
-- Outras aplicações para ter dados
(CAST('2025-06-20' AS DATETIME2), 2, 1, 7, 3),
(CAST('2025-06-01' AS DATETIME2), 4, 2, 8, 4);
GO

PRINT 'Carga de dados estratégicos concluída com sucesso!';
GO
