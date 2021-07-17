#Questão 1
CREATE DATABASE empresa;

USE empresa;

CREATE TABLE EMPREGADO(
	PNome VARCHAR(100) NOT NULL,
	MInicial VARCHAR(100) NOT NULL,
	UNome VARCHAR(100) NOT NULL,
	SSN INTEGER NOT NULL,
	DataNasc DATE NOT NULL,
	Endereco VARCHAR(200) NOT NULL,
	Sexo CHAR NOT NULL,
	Salario FLOAT DEFAULT 0 NOT NULL,
	SuperSSN INTEGER NOT NULL,
	DNO VARCHAR(100),
	CONSTRAINT pkEmpregado PRIMARY KEY (SSN)
);

CREATE TABLE DEPARTAMENTO(
	DNome VARCHAR(100) NOT NULL,
	DNumero INTEGER NOT NULL,
	GerSSN INTEGER NOT NULL,
	GerDataInicio DATE NOT NULL,
	CONSTRAINT pkDepartamento PRIMARY KEY (DNumero)
);

CREATE TABLE DEPTO_LOCALIZACOES(
	DNumero INTEGER NOT NULL,
	DLocalizacao INTEGER NOT NULL,
	CONSTRAINT fkDepartamento FOREIGN KEY (DNumero) REFERENCES DEPARTAMENTO(DNumero),
	CONSTRAINT pkLocalizacao PRIMARY KEY (DLocalizacao)
);

CREATE TABLE PROJETO (
	PJNome VARCHAR(100) NOT NULL,
	PNumero INTEGER NOT NULL,
	PLocalizacao INTEGER NOT NULL,
	DNum INTEGER NOT NULL,
	CONSTRAINT pkNumero PRIMARY KEY (PNumero)
);

CREATE TABLE TRABALHA_EM(
	ESSN INTEGER NOT NULL,
	PNO INTEGER NOT NULL,
	Horas FLOAT DEFAULT 0 NOT NULL,
	CONSTRAINT pkTrabalha_em PRIMARY KEY (ESSN, PNO)
);

CREATE TABLE DEPENDENTE(
	ESSN INTEGER NOT NULL,
	NomeDependente VARCHAR(100) NOT NULL,
	Sexo CHAR NOT NULL,
	DataNasc DATE NOT NULL,
	Parenteco VARCHAR(100) NOT NULL,
	CONSTRAINT pkDependente PRIMARY KEY (ESSN, NomeDependente),
	CONSTRAINT fkESSN FOREIGN KEY (ESSN) REFERENCES TRABALHA_EM(ESSN)
);



/*
SELECT CONCAT("GRANT SELECT, UPDATE ON empresa.", table_name, " TO 'A'@'172.16.1.2' WITH GRANT OPTION;")
FROM information_schema.TABLES t 
WHERE t.TABLE_SCHEMA = "empresa" AND table_name <> "DEPENDENTE";

DROP USER 'A'@'172.16.1.2';
*/

#a)
CREATE USER 'A'@'localhost' IDENTIFIED BY 'a123';

GRANT SELECT, UPDATE ON empresa.DEPARTAMENTO TO 'A'@'172.16.1.2' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON empresa.DEPTO_LOCALIZACOES TO 'A'@'172.16.1.2' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON empresa.EMPREGADO TO 'A'@'172.16.1.2' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON empresa.PROJETO TO 'A'@'172.16.1.2' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON empresa.TRABALHA_EM TO 'A'@'172.16.1.2' WITH GRANT OPTION;

SHOW GRANTS FOR 'A'@'localhost';

FLUSH PRIVILEGES;

#b)
CREATE USER 'B'@'localhost' IDENTIFIED BY 'b123';
CREATE VIEW view_empregado_b 
AS SELECT e.PNome, e.MInicial, e.UNome, e.SSN, e.DataNasc, e.Endereco, e.Sexo, e.SuperSSN, e.DNO 
FROM EMPREGADO e;

CREATE VIEW view_departamento_b 
AS SELECT d.DNome, d.DNumero 
FROM DEPARTAMENTO d;

GRANT SELECT ON view_empregado_b TO 'B'@'localhost';
GRANT SELECT ON view_departamento_b TO 'B'@'localhost';

#c)
CREATE USER 'C'@'localhost' IDENTIFIED BY 'c123';

GRANT SELECT, UPDATE ON empresa.TRABALHA_EM TO 'C'@'localhost';

CREATE VIEW view_empregado_c 
AS SELECT e.PNome, e.MInicial, e.SSN 
FROM EMPREGADO e ;

CREATE VIEW view_projeto_c 
AS SELECT p.PJNome, p.PNumero 
FROM PROJETO p; 

GRANT SELECT ON view_projeto_c TO 'C'@'localhost';
GRANT SELECT ON view_empregado_c TO 'C'@'localhost';

#d)
CREATE USER 'D'@'localhost' IDENTIFIED BY 'd123';
GRANT SELECT ON empresa.EMPREGADO TO 'D'@'localhost';
GRANT SELECT, UPDATE ON empresa.DEPENDENTE TO 'D'@'localhost';

#e)
CREATE USER 'E'@'localhost' IDENTIFIED BY 'e123';
CREATE VIEW view_empregado_e 
AS SELECT * FROM EMPREGADO e WHERE e.DNO = 3;

GRANT SELECT ON view_empregado_e TO 'E'@'localhost';
GRANT UPDATE(PNome) ON empresa.EMPREGADO TO 'A'@'localhost';

#Questão 2
GRANT SELECT, INSERT, UPDATE, DELETE ON escola.Grade TO 'Coordenador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON escola.Disciplina TO 'Coordenador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON escola.Turma TO 'Coordenador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON escola.Oferta TO 'Coordenador'@'localhost';

GRANT SELECT ON escola.Professor TO 'Professor'@'localhost';
GRANT SELECT ON escola.Turma TO 'Professor'@'localhost';
GRANT SELECT ON escola.Matricula TO 'Professor'@'localhost';
GRANT UPDATE ON (Email, Telefone) ON escola.Professor TO 'Professor'@'localhost';

GRANT SELECT ON escola.Aluno TO 'Aluno'@'localhost';
GRANT SELECT ON escola.Avaliacao TO 'Aluno'@'localhost';
GRANT SELECT ON escola.Matricula TO 'Aluno'@'localhost';
GRANT SELECT ON escola.Turma TO 'Aluno'@'localhost';

#Questão 3

#a)
CREATE VIEW vwNomeFuncionario
AS SELECT f.nomeFunc FROM Funcionario f;

CREATE VIEW vwInfoDepto
AS SELECT f.dpto, f.salario FROM Funcionario f;

#b
GRANT SELECT ON vwInfoDepto TO 'user'@'localhost';

GRANT SELECT ON vwNomeFuncionario TO 'secretario'@'localhost' WITH GRANT OPTION;

#c
#Os privilégios de Marta também são revogados

#d
GRANT SELECT, UPDATE ON Funcionario TO 'Helder'@'localhost' WITH GRANT OPTION;
GRANT SELECT, UPDATE ON vwNomeFuncionario TO 'Helder'@'localhost' WITH GRANT OPTION;
