CREATE DATABASE exercicio_2;

use exercicio_2;

CREATE TABLE Cidade
(
	CodCidade	INTEGER NOT NULL,
	Nome		VARCHAR(100) NOT NULL,
	UF		CHAR(1),
	CONSTRAINT pkCidade PRIMARY KEY (CodCidade)
);

CREATE TABLE Clube
(
	CodClube	INTEGER NOT NULL,
	Nome		VARCHAR(100) NOT NULL,
	CodCidade	INTEGER NOT NULL,
	CONSTRAINT pkClube PRIMARY KEY (CodClube),
	CONSTRAINT fkClubeCidade FOREIGN KEY (CodCidade) REFERENCES Cidade(CodCidade)
);

CREATE TABLE Campeonato
(
	CodCampeonato	INTEGER NOT NULL,
	Descricao	VARCHAR(100),
	CONSTRAINT pkCampeonato PRIMARY KEY (CodCampeonato)
);

CREATE TABLE ClubeCampeonato
(
	CodClube	INTEGER NOT NULL,
	CodCampeonato 	INTEGER NOT NULL,
	Ano		INTEGER NOT NULL,
	Pontos		INTEGER DEFAULT 0 NOT NULL,
	CONSTRAINT pkClubeCampeonato PRIMARY KEY (CodClube, CodCampeonato, Ano),
	CONSTRAINT fkClubeCampeonatoCampeonato FOREIGN KEY (CodCampeonato) REFERENCES Campeonato(CodCampeonato),
	CONSTRAINT fkClubeCampeonatoClube FOREIGN KEY (CodClube) REFERENCES Clube(CodClube)
);

CREATE TABLE Jogador
(
	CodJogador	INTEGER NOT NULL,
	Nome		VARCHAR(100) NOT NULL,
	DataNascimento	DATE,	
	ValorPasse	FLOAT DEFAULT 0 NOT NULL,
	CONSTRAINT pkJogador PRIMARY KEY (CodJogador)
);

CREATE TABLE JogadorClubeCampeonato
(
	CodClube	INTEGER NOT NULL,
	CodCampeonato	INTEGER NOT NULL,
	Ano				INTEGER NOT NULL,
	CodJogador	INTEGER NOT NULL,	
	Gols		INTEGER DEFAULT 0 NOT NULL,	
	CONSTRAINT pkJogadorClubeCampeonato PRIMARY KEY (CodClube, CodCampeonato, Ano, CodJogador),
	CONSTRAINT fkJogadorClubeCampeonato FOREIGN KEY (CodClube, CodCampeonato, Ano) REFERENCES ClubeCampeonato (CodClube, CodCampeonato, Ano),
	CONSTRAINT fkJogadorCCJogador	FOREIGN KEY (CodJogador) REFERENCES Jogador(CodJogador)	
);

CREATE TABLE Estadio
(
	CodEstadio	INTEGER NOT NULL,
	Nome		VARCHAR(100) NOT NULL,
	CodCidade	INTEGER NOT NULL,
	Capacidade	INTEGER DEFAULT 0 NOT NULL,
	CONSTRAINT pkEstadio PRIMARY KEY (CodEstadio),
	CONSTRAINT fkEstadioCidade FOREIGN KEY (CodCidade) REFERENCES Cidade(CodCidade)
);

ALTER TABLE Estadio ADD COLUMN NumPartidas INTEGER NOT NULL;

CREATE TABLE Partida
(
	CodCampeonato	INTEGER NOT NULL,
	Ano		INTEGER	NOT NULL,
	CodPartida	INTEGER NOT NULL,
	DataHora	TIMESTAMP NOT NULL,
	CodEstadio	INTEGER NOT NULL,
	CodClube1	INTEGER NOT NULL,
	GolsClube1	INTEGER DEFAULT 0 NOT NULL,
	CodClube2	INTEGER NOT NULL,
	GolsClube2	INTEGER DEFAULT 0 NOT NULL,
	CONSTRAINT pkPartida	PRIMARY KEY (CodCampeonato, Ano, CodPartida),
	CONSTRAINT fkPartidaCampeonato FOREIGN KEY (CodCampeonato) REFERENCES Campeonato(CodCampeonato),
	CONSTRAINT fkPartidaEstadio FOREIGN KEY (CodEstadio) REFERENCES Estadio(CodEstadio),
	CONSTRAINT fkPartidaClube1	FOREIGN KEY (CodClube1) REFERENCES Clube(CodClube),
	CONSTRAINT fkPartidaClube2	FOREIGN KEY (CodClube2) REFERENCES Clube(CodClube)
);

INSERT INTO Cidade (CodCidade, Nome, UF) VALUES 
(1, 'Linhares', 'E'),
(2, 'Vitória', 'E');

INSERT INTO Estadio (CodEstadio, Nome, CodCidade, Capacidade, NumPartidas)
VALUES (1, 'Clube do América', 1, 60000, 0);

INSERT INTO Estadio (CodEstadio, Nome, CodCidade, Capacidade, NumPartidas)
VALUES (2, 'Mestre Alvaro', 2, 100000, 0);

INSERT INTO Clube (CodClube, Nome, CodCidade) VALUES 
(1, 'Linhares esporte clube', 1),
(2, 'Desportiva', 2);

INSERT INTO Campeonato (CodCampeonato, Descricao)
VALUES (1, 'Capixabão');

INSERT INTO ClubeCampeonato (CodClube, CodCampeonato, Ano, Pontos)
VALUES 
(1, 1, 2021, 0),
(2, 1, 2021, 0);


INSERT INTO Partida 
(CodCampeonato, Ano, CodPartida, DataHora, CodEstadio, CodClube1, GolsClube1, CodClube2, GolsClube2)
VALUES
(1, 2021, 1, now(), 1, 1, 3, 2, 0);

INSERT INTO Partida 
(CodCampeonato, Ano, CodPartida, DataHora, CodEstadio, CodClube1, GolsClube1, CodClube2, GolsClube2)
VALUES
(1, 2021, 2, now(), 1, 1, 1, 2, 1);

INSERT INTO Partida 
(CodCampeonato, Ano, CodPartida, DataHora, CodEstadio, CodClube1, GolsClube1, CodClube2, GolsClube2)
VALUES
(1, 2021, 3, now(), 1, 1, 1, 2, 2);

INSERT INTO Partida 
(CodCampeonato, Ano, CodPartida, DataHora, CodEstadio, CodClube1, GolsClube1, CodClube2, GolsClube2)
VALUES
(1, 2021, 4, now(), 1, 1, 3, 2, 1);

DELETE FROM Partida WHERE CodPartida = 4;

UPDATE Partida 
SET CodEstadio = 2
WHERE CodPartida = 4;


INSERT into Jogador (CodJogador, Nome, DataNascimento, ValorPasse)
VALUES 
(1, 'Etevaldo', now(), 1000),
(2, 'Garibaldo', now(), 2000),
(3, 'G0rdox', now(), 5000),
(4, 'Pesado', now(), 10000);


INSERT INTO JogadorClubeCampeonato (CodClube, CodCampeonato, Ano, CodJogador, Gols)
VALUES
(1, 1, 2021, 1, 3),
(1, 1, 2021, 2, 0),
(2, 1, 2021, 3, 18),
(2, 1, 2021, 4, 23);

UPDATE JogadorClubeCampeonato 
SET Gols = 0
WHERE CodJogador = 2;
