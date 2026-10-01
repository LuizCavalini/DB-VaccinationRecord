-- CRIAÇÃO DAS TABELAS

-- Desativa a contagem de linhas afetadas para uma saída mais limpa
SET NOCOUNT ON;
GO

CREATE TABLE Sexo (
    IdSexo INT IDENTITY(1,1) PRIMARY KEY,
    NomeSexo NVARCHAR(100) NOT NULL
);

CREATE TABLE Cor (
    IdCor INT IDENTITY(1,1) PRIMARY KEY,
    NomeCor NVARCHAR(100) NOT NULL
);

CREATE TABLE EstadoCivil (
    IdEstadoCivil INT IDENTITY(1,1) PRIMARY KEY,
    NomeEstadoCivil NVARCHAR(100) NOT NULL
);

CREATE TABLE Genero (
    IdGenero INT IDENTITY(1,1) PRIMARY KEY,
    NomeGenero NVARCHAR(100) NOT NULL
);

CREATE TABLE Pais (
    IdPais INT IDENTITY(1,1) PRIMARY KEY,
    NomePais NVARCHAR(150) NOT NULL
);

CREATE TABLE TipoLogradouro (
    IdTipoLogradouro INT IDENTITY(1,1) PRIMARY KEY,
    NomeTipoLogradouro NVARCHAR(100) NOT NULL -- Ex: Rua, Avenida, Praça
);

CREATE TABLE Fabricante (
    IdFabricante INT IDENTITY(1,1) PRIMARY KEY,
    NomeFabricante NVARCHAR(150) NOT NULL
);

CREATE TABLE TipoVacina (
    IdTipoVacina INT IDENTITY(1,1) PRIMARY KEY,
    NomeVacina NVARCHAR(150) NOT NULL,
    NumeroDoses INT NOT NULL
);

CREATE TABLE Doenca (
    IdDoenca INT IDENTITY(1,1) PRIMARY KEY,
    NomeDoenca NVARCHAR(200) NOT NULL,
    CodigoCID10 NVARCHAR(10) NULL -- Código da Classificação Internacional de Doenças (ex: B05 para Sarampo)
);
GO

CREATE TABLE Imunizacao (
    IdImunizacao INT IDENTITY(1,1) PRIMARY KEY,
    IdTipoVacina INT NOT NULL,
    IdDoenca INT NOT NULL,
    CONSTRAINT FK_Imunizacao_TipoVacina FOREIGN KEY (IdTipoVacina) REFERENCES TipoVacina(IdTipoVacina),
    CONSTRAINT FK_Imunizacao_Doenca FOREIGN KEY (IdDoenca) REFERENCES Doenca(IdDoenca),
    CONSTRAINT UQ_Imunizacao_Vacina_Doenca UNIQUE (IdTipoVacina, IdDoenca) -- Garante que não haja duplicidade
);
GO

CREATE TABLE UF (
    IdUF INT IDENTITY(1,1) PRIMARY KEY,
    NomeUF NVARCHAR(100) NOT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT FK_UF_Pais FOREIGN KEY (IdPais) REFERENCES Pais(IdPais)
);

CREATE TABLE Cidade (
    IdCidade INT IDENTITY(1,1) PRIMARY KEY,
    NomeCidade NVARCHAR(150) NOT NULL,
    IdUF INT NOT NULL,
    CONSTRAINT FK_Cidade_UF FOREIGN KEY (IdUF) REFERENCES UF(IdUF)
);

CREATE TABLE Bairro (
    IdBairro INT IDENTITY(1,1) PRIMARY KEY,
    NomeBairro NVARCHAR(150) NOT NULL,
    IdCidade INT NOT NULL,
    CONSTRAINT FK_Bairro_Cidade FOREIGN KEY (IdCidade) REFERENCES Cidade(IdCidade)
);

CREATE TABLE Logradouro (
    IdLogradouro INT IDENTITY(1,1) PRIMARY KEY,
    NomeLogradouro NVARCHAR(255) NOT NULL,
    IdTipoLogradouro INT NOT NULL,
    CONSTRAINT FK_Logradouro_TipoLogradouro FOREIGN KEY (IdTipoLogradouro) REFERENCES TipoLogradouro(IdTipoLogradouro)
);

CREATE TABLE Endereco (
    IdEndereco INT IDENTITY(1,1) PRIMARY KEY,
    IdLogradouro INT NOT NULL,
    IdBairro INT NOT NULL,
    Numero NVARCHAR(20) NULL,
    Complemento NVARCHAR(100) NULL,
    CEP CHAR(9) NULL, -- Formato '00000-000'
    CONSTRAINT FK_Endereco_Logradouro FOREIGN KEY (IdLogradouro) REFERENCES Logradouro(IdLogradouro),
    CONSTRAINT FK_Endereco_Bairro FOREIGN KEY (IdBairro) REFERENCES Bairro(IdBairro)
);

CREATE TABLE Pessoa (
    IdPessoa INT IDENTITY(1,1) PRIMARY KEY,
    NomePessoa NVARCHAR(255) NOT NULL,
    DataNascimento DATE NOT NULL,
    IdMae INT NULL, -- Auto-relacionamento, pode ser nulo
    IdPai INT NULL, -- Auto-relacionamento, pode ser nulo
    IdNaturalidade INT NULL, -- FK para Cidade
    IdSexo INT NOT NULL,
    IdCor INT NOT NULL,
    CONSTRAINT FK_Pessoa_Mae FOREIGN KEY (IdMae) REFERENCES Pessoa(IdPessoa),
    CONSTRAINT FK_Pessoa_Pai FOREIGN KEY (IdPai) REFERENCES Pessoa(IdPessoa),
    CONSTRAINT FK_Pessoa_Naturalidade FOREIGN KEY (IdNaturalidade) REFERENCES Cidade(IdCidade),
    CONSTRAINT FK_Pessoa_Sexo FOREIGN KEY (IdSexo) REFERENCES Sexo(IdSexo),
    CONSTRAINT FK_Pessoa_Cor FOREIGN KEY (IdCor) REFERENCES Cor(IdCor)
);

CREATE TABLE HistoricoGenero (
    IdHistoricoGenero INT IDENTITY(1,1) PRIMARY KEY,
    IdPessoa INT NOT NULL,
    IdGenero INT NOT NULL,
    DataInicio DATE NOT NULL,
    DataFim DATE NULL, -- Nulo significa que é o gênero atual
    CONSTRAINT FK_HistoricoGenero_Pessoa FOREIGN KEY (IdPessoa) REFERENCES Pessoa(IdPessoa),
    CONSTRAINT FK_HistoricoGenero_Genero FOREIGN KEY (IdGenero) REFERENCES Genero(IdGenero)
);

CREATE TABLE HistoricoEstadoCivil (
    IdHistoricoEC INT IDENTITY(1,1) PRIMARY KEY,
    IdPessoa INT NOT NULL,
    IdEstadoCivil INT NOT NULL,
    DataInicio DATE NOT NULL,
    DataFim DATE NULL, -- Nulo significa que é o estado civil atual
    CONSTRAINT FK_HistoricoEC_Pessoa FOREIGN KEY (IdPessoa) REFERENCES Pessoa(IdPessoa),
    CONSTRAINT FK_HistoricoEC_EstadoCivil FOREIGN KEY (IdEstadoCivil) REFERENCES EstadoCivil(IdEstadoCivil)
);

CREATE TABLE HistoricoEndereco (
    IdHistoricoEndereco INT IDENTITY(1,1) PRIMARY KEY,
    IdPessoa INT NOT NULL,
    IdEndereco INT NOT NULL,
    DataInicio DATE NOT NULL,
    DataFim DATE NULL, -- Nulo significa que é o endereço atual
    CONSTRAINT FK_HistoricoEndereco_Pessoa FOREIGN KEY (IdPessoa) REFERENCES Pessoa(IdPessoa),
    CONSTRAINT FK_HistoricoEndereco_Endereco FOREIGN KEY (IdEndereco) REFERENCES Endereco(IdEndereco)
);

CREATE TABLE Nacionalidade (
    IdPessoa INT NOT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT PK_Nacionalidade PRIMARY KEY (IdPessoa, IdPais), -- Chave primária composta
    CONSTRAINT FK_Nacionalidade_Pessoa FOREIGN KEY (IdPessoa) REFERENCES Pessoa(IdPessoa),
    CONSTRAINT FK_Nacionalidade_Pais FOREIGN KEY (IdPais) REFERENCES Pais(IdPais)
);

CREATE TABLE Lote (
    IdLote INT IDENTITY(1,1) PRIMARY KEY,
    CodigoLote NVARCHAR(100) NOT NULL,
    DataFabricacao DATE NOT NULL,
    DataValidade DATE NOT NULL,
    Quantidade INT NOT NULL,
    IdFabricante INT NOT NULL,
    CONSTRAINT FK_Lote_Fabricante FOREIGN KEY (IdFabricante) REFERENCES Fabricante(IdFabricante)
);

CREATE TABLE Vacina (
    IdVacina INT IDENTITY(1,1) PRIMARY KEY,
    IdLote INT NOT NULL,
    IdTipoVacina INT NOT NULL,
    CONSTRAINT FK_Vacina_Lote FOREIGN KEY (IdLote) REFERENCES Lote(IdLote),
    CONSTRAINT FK_Vacina_TipoVacina FOREIGN KEY (IdTipoVacina) REFERENCES TipoVacina(IdTipoVacina)
);

-- EVENTO DE APLICAÇÃO (CONECTANDO TUDO)

CREATE TABLE LocalAplicacao (
    IdLocal INT IDENTITY(1,1) PRIMARY KEY,
    NomeLocal NVARCHAR(200) NOT NULL,
    IdEndereco INT NOT NULL,
    CONSTRAINT FK_LocalAplicacao_Endereco FOREIGN KEY (IdEndereco) REFERENCES Endereco(IdEndereco)
);

CREATE TABLE Paciente (
    IdPaciente INT IDENTITY(1,1) PRIMARY KEY,
    IdPessoa INT NOT NULL,
    CodigoSUS CHAR(15) NULL,
    CONSTRAINT UQ_Paciente_Pessoa UNIQUE (IdPessoa), -- Garante que uma pessoa só pode ter um registro de paciente
    CONSTRAINT FK_Paciente_Pessoa FOREIGN KEY (IdPessoa) REFERENCES Pessoa(IdPessoa)
);

CREATE TABLE Aplicador (
    IdAplicador INT IDENTITY(1,1) PRIMARY KEY,
    IdPessoa INT NOT NULL,
    RegistroProfissional NVARCHAR(50) NOT NULL,
    CONSTRAINT UQ_Aplicador_Pessoa UNIQUE (IdPessoa), -- Garante que uma pessoa só pode ter um registro de aplicador
    CONSTRAINT FK_Aplicador_Pessoa FOREIGN KEY (IdPessoa) REFERENCES Pessoa(IdPessoa)
);

-- Tabela FATO, a mais importante
CREATE TABLE Aplicacao (
    IdAplicacao INT IDENTITY(1,1) PRIMARY KEY,
    DataAplicacao DATETIME2 NOT NULL, -- DATETIME2 é mais preciso para data e hora
    IdPaciente INT NOT NULL,
    IdAplicador INT NOT NULL,
    IdVacina INT NOT NULL,
    IdLocal INT NOT NULL,
    CONSTRAINT FK_Aplicacao_Paciente FOREIGN KEY (IdPaciente) REFERENCES Paciente(IdPaciente),
    CONSTRAINT FK_Aplicacao_Aplicador FOREIGN KEY (IdAplicador) REFERENCES Aplicador(IdAplicador),
    CONSTRAINT FK_Aplicacao_Vacina FOREIGN KEY (IdVacina) REFERENCES Vacina(IdVacina),
    CONSTRAINT FK_Aplicacao_LocalAplicacao FOREIGN KEY (IdLocal) REFERENCES LocalAplicacao(IdLocal)
);
GO

PRINT 'Script de criação de tabelas concluído com sucesso!';
GO