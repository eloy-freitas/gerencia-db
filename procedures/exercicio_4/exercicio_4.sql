CREATE DATABASE exercicio_3;

USE exercicio_3;
#DROP database exercicio_3;
CREATE TABLE Obra(
	CodObra INTEGER NOT NULL,
	NumeroEmprestimos INTEGER NOT NULL,
	CONSTRAINT pkCodObra PRIMARY KEY (CodObra)
);

CREATE TABLE Departamento(
	CodDepartamento INTEGER NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CONSTRAINT pkCodDepartamento PRIMARY KEY (CodDepartamento)
);

CREATE TABLE Funcionario(
	CodFuncionario INTEGER NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CodDepartamento INTEGER NOT NULL,
	CONSTRAINT pkFuncionario PRIMARY KEY (CodFuncionario),
	CONSTRAINT fkCodDepartamento FOREIGN KEY (CodDepartamento) REFERENCES Departamento(CodDepartamento)
);

CREATE TABLE Usuario(
	CodUsuario INTEGER NOT NULL,
	Matricula INTEGER NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CodDepartamento INTEGER NOT NULL,
	Multa INTEGER NOT NULL,
	Valor FLOAT NOT NULL,
	CONSTRAINT pkUsuario PRIMARY KEY (CodUsuario),
	CONSTRAINT fkCodDepartamentoUsuario FOREIGN KEY (CodDepartamento) REFERENCES Departamento(CodDepartamento)
);

CREATE TABLE Emprestimo(
	CodEmprestimo INTEGER NOT NULL,
	CodFuncionario INTEGER NOT NULL,
	CodUsuario INTEGER NOT NULL,
	Finalizado INTEGER NOT NULL,
	CONSTRAINT pkCodEmprestimo PRIMARY KEY (CodEmprestimo),
	CONSTRAINT fkCodUsuario FOREIGN KEY (CodUsuario) REFERENCES Usuario(CodUsuario),
	CONSTRAINT fkFuncionario FOREIGN KEY (CodFuncionario) REFERENCES Funcionario(CodFuncionario)
);

CREATE TABLE ObraEmprestimo(
	CodEmprestimo INTEGER NOT NULL,
	CodObra INTEGER NOT NULL,
	Devolvido INTEGER NOT NULL,
	DataDevolucao DATE,
	CONSTRAINT fkCodEmprestimo FOREIGN KEY (CodEmprestimo) REFERENCES Emprestimo(CodEmprestimo),
	CONSTRAINT fkCodObra FOREIGN KEY (CodObra) REFERENCES Obra(CodObra)
);

CREATE TABLE Devolucao(
	CodEmprestimo INTEGER NOT NULL,
	CodObra INTEGER NOT NULL,
	DataDevolucao DATE NOT NULL,
	CONSTRAINT fkCodEmprestimoDevolucao FOREIGN KEY (CodEmprestimo) REFERENCES ObraEmprestimo(CodEmprestimo),
	CONSTRAINT fkCodObraDevolucao FOREIGN KEY (CodObra) REFERENCES ObraEmprestimo(CodObra)
);

CREATE TABLE Reserva(
	CodReserva INTEGER NOT NULL,
	CodUsuario INTEGER NOT NULL,
	CONSTRAINT pkCodReserva PRIMARY KEY (CodReserva),
	CONSTRAINT fkCodUsuarioReserva FOREIGN KEY (CodUsuario) REFERENCES Usuario(CodUsuario)
);

CREATE TABLE ObraReserva(
	CodReserva INTEGER NOT NULL,
	CodObra INTEGER NOT NULL,
	CONSTRAINT fkCodReserva FOREIGN KEY (CodReserva) REFERENCES Reserva(CodReserva),
	CONSTRAINT fkCodObraReserva FOREIGN KEY (CodObra) REFERENCES Obra(CodObra)
);


INSERT INTO Departamento (CodDepartamento, Nome)
VALUES 
(1, "Financeiro"),
(2, "Informática"),
(3, "Recursos Humanos");

INSERT INTO Funcionario (CodFuncionario, Nome, CodDepartamento)
VALUES
(1, "Paulinho do gogó", 1),
(2, "Chico Xavier", 2),
(3, "Felipe Melo", 3),
(4, "Richarlison", 3);

INSERT INTO Usuario (CodUsuario, Nome, Matricula, CodDepartamento, Multa, Valor)
VALUES
(1, "Naruto Uzumaki", 1, 1, 1, 200),
(2, "Power Ranger Vermelho", 2, 3, 1, 3500.06),
(3, "Bruno diferente", 3, 2, 0, 0),
(4, "Faustão", 4, 3, 1, 1);

INSERT INTO Emprestimo (CodEmprestimo, CodFuncionario, CodUsuario, Finalizado)
VALUES
(1, 1, 1, 0),
(2, 3, 4, 0),
(3, 2, 1, 0),
(4, 2, 3, 0);

INSERT INTO Obra (CodObra, NumeroEmprestimos)
VALUES 
(1, 1),
(2, 2),
(3, 1);


INSERT INTO ObraEmprestimo (CodEmprestimo, CodObra, Devolvido, DataDevolucao)
VALUES
(1, 1, 1, now()),
(2, 2, 1, now()),
(3, 3, 1, now());

INSERT INTO ObraEmprestimo (CodEmprestimo, CodObra, Devolvido)
VALUES
(4, 2, 0);