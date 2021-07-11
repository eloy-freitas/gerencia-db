CREATE DATABASE exercicio_4;
#DROP DATABASE exercicio_4;
USE exercicio_4;

CREATE TABLE Atividade(
	CodAtividade INTEGER NOT NULL,
	Descricao VARCHAR(100) NOT NULL,
	CONSTRAINT pkAtividade PRIMARY KEY (CodAtividade)
);

CREATE TABLE PrecoAtividade(
	CodAtividade INTEGER NOT NULL,
	Ano INTEGER NOT NULL,
	Mes INTEGER NOT NULL,
	Valor FLOAT NOT NULL,
	CONSTRAINT fkAtividadePA FOREIGN KEY (CodAtividade) REFERENCES Atividade(CodAtividade),
	CONSTRAINT pkPrecoAtividade PRIMARY KEY (CodAtividade, Ano, Mes)
);

CREATE TABLE Socio(
	CodSocio INTEGER NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Sexo CHAR NOT NULL,
	Telefone VARCHAR(20) NOT NULL,
	DataNascimento DATETIME NOT NULL,
	Diretoria INTEGER NOT NULL,
	NumDependentes INTEGER DEFAULT 0,
	Ativo INTEGER DEFAULT 0,
	CONSTRAINT pkSocio PRIMARY KEY (CodSocio)
);

CREATE TABLE Mensalidade(
	CodSocio INTEGER NOT NULL,
	Ano INTEGER NOT NULL,
	Mes INTEGER NOT NULL,
	DataPagamento DATETIME NULL,
	ValorPago FLOAT NOT NULL,
	ValorTotal FLOAT NOT NULL,
	CONSTRAINT fkSocicioM FOREIGN KEY (CodSocio) REFERENCES Socio(CodSocio),
	CONSTRAINT pkMensalidade PRIMARY KEY (CodSocio, Ano, Mes)
);

CREATE TABLE AtividadeSocio(
	CodSocio INTEGER NOT NULL,
	CodAtividade INTEGER NOT NULL,
	DataInicio DATETIME NOT NULL,
	DataFim DATETIME,
	Valor FLOAT NOT NULL,
	CONSTRAINT fkSocioAS FOREIGN KEY (CodSocio) REFERENCES Socio(CodSocio),
	CONSTRAINT fkAtividadeAS FOREIGN KEY (CodAtividade) REFERENCES Atividade(CodAtividade),
	CONSTRAINT pkAtividadeSocio PRIMARY KEY (CodSocio, CodAtividade)
);

CREATE TABLE Dependente(
	CodSocio INTEGER NOT NULL,
	CodDependente INTEGER NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Sexo CHAR NOT NULL,
	DataNascimento DATETIME NOT NULL,
	Ativo INTEGER DEFAULT 0,
	CONSTRAINT fkSocioD FOREIGN KEY (CodSocio) REFERENCES Socio(CodSocio),
	CONSTRAINT pkDependente PRIMARY KEY (CodDependente, CodSocio)
);

CREATE TABLE AtividadeDependente(
	CodSocio INTEGER NOT NULL,
	CodDependente INTEGER NOT NULL,
	CodAtividade INTEGER NOT NULL,
	DateInicio DATETIME NOT NULL,
	DataTermino DATETIME,
	Valor FLOAT NOT NULL,
	CONSTRAINT fkDependenteAD FOREIGN KEY (CodDependente) REFERENCES Dependente(CodDependente),
	CONSTRAINT fkSocicioAD FOREIGN KEY (CodSocio) REFERENCES Dependente(CodSocio),
	CONSTRAINT fkAtividadeAD FOREIGN KEY (CodAtividade) REFERENCES Atividade(CodAtividade),
	CONSTRAINT pkAtividadeDependente PRIMARY KEY (CodSocio, CodDependente, CodAtividade)
);


INSERT INTO Atividade (CodAtividade, Descricao)
VALUES
(1, "Atividade 1"),
(2, "Atividade 2"),
(3, "Atividade 3"),
(4, "Atividade 4");

INSERT INTO PrecoAtividade (CodAtividade, Ano, Mes, Valor)
VALUES
(1, 2021, 1, 200),
(2, 2021, 2, 350),
(3, 2021, 3, 2000),
(4, 2021, 4, 500);

INSERT INTO Socio (CodSocio, Nome, Sexo, Telefone, DataNascimento, Diretoria, NumDependentes, Ativo)
VALUES 
(1, "Bruno diferente", "M", "(27)79846-1843", now(), 1, 1, 1),
(2, "Marimbondo", "M", "(27)79846-1843", now(), 1, 2, 1),
(3, "Silvio Santos", "M", "(27)79846-1843", now(), 1, 0, 0),
(4, "Sasuke Uchiha", "M", "(27)79846-1843", now(), 0, 5, 1);

INSERT INTO Dependente (CodSocio, CodDependente, Nome, Sexo, DataNascimento, Ativo)
VALUES 
(1, 1, "Carinha que mora logo ali", "M", now(), 1),
(2, 2, "Goleiro Cassio", "M", now(), 1),
(2, 3, "Optimus Prime", "F", now(), 0),
(4, 4, "Pikachu", "F", now(), 1),
(4, 5, "Loko Abreu", "M", now(), 1),
(4, 6, "Rubinho Barichelo", "M", now(), 1),
(4, 7, "Supla", "M", now(), 0),
(4, 8, "Ronaldinho Gaúcho (THE WIZARD)", "M", now(), 1);


INSERT INTO AtividadeSocio (CodSocio, CodAtividade, DataInicio, Valor)
VALUES 
(1, 1, now(), (SELECT Valor FROM PrecoAtividade WHERE CodAtividade = 1)),
(2, 1, now(), (SELECT Valor FROM PrecoAtividade WHERE CodAtividade = 1)),
(3, 2, now(), (SELECT Valor FROM PrecoAtividade WHERE CodAtividade = 2));

INSERT INTO AtividadeDependente (CodSocio, CodDependente, CodAtividade, DateInicio, Valor)
VALUES 
(1, 1, 1, now(), (SELECT Valor FROM PrecoAtividade WHERE CodAtividade = 1)),
(2, 2, 3, now(), (SELECT Valor FROM PrecoAtividade WHERE CodAtividade = 3));

INSERT INTO Mensalidade (CodSocio, Ano, Mes, DataPagamento, ValorPago, ValorTotal)
VALUES
(1, 2021, 1, now(), 0, 0),
(2, 2021, 2, now(), 0, 0),
(3, 2021, 2, now(), 0, 0);






