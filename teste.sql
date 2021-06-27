CREATE database aula_trigger;

DROP database aula_trigger;
use aula_trigger;

CREATE TABLE Cidade
(
	CodCidade	INTEGER NOT NULL,	
	Nome		VARCHAR(100) NOT NULL,
	UF		CHAR(2),
	CONSTRAINT pkCidade PRIMARY KEY (CodCidade)
);

CREATE TABLE Cliente
(
	CodCliente	INTEGER NOT NULL,	
	Nome		VARCHAR(100) NOT NULL,
	Email		VARCHAR(250),
	CodCidade	INTEGER NOT NULL,
	CONSTRAINT pkCliente PRIMARY KEY (CodCliente),
	CONSTRAINT fkClienteCidade FOREIGN KEY (CodCidade) REFERENCES Cidade(CodCidade)
);

CREATE TABLE Fornecedor
(
	CodFornecedor	INTEGER NOT NULL,	
	Nome		VARCHAR(100) NOT NULL,
	Email		VARCHAR(250),
	CodCidade	INTEGER NOT NULL,
	CONSTRAINT pkFornecedor PRIMARY KEY (CodFornecedor),
	CONSTRAINT fkFornecedorCidade FOREIGN KEY (CodCidade) REFERENCES Cidade(CodCidade)
);

CREATE TABLE Produto
(
	CodProduto	INTEGER NOT NULL,	
	Descricao	VARCHAR(100) NOT NULL,
	Estoque		DOUBLE DEFAULT 0 NOT NULL,
	CONSTRAINT pkProduto PRIMARY KEY (CodProduto)
);

CREATE TABLE Pedido	
(
	CodPedido	INTEGER NOT NULL,
	CodCliente	INTEGER NOT NULL,
	Data		DATE,
	ValorTotal	DOUBLE DEFAULT 0 NOT NULL,
	NumParcelas	INTEGER,
	CONSTRAINT pkPedido PRIMARY KEY (CodPedido),
	CONSTRAINT fkPedidoCliente FOREIGN KEY (CodCliente) REFERENCES Cliente(CodCliente)
);

CREATE TABLE Requisicao
(
	CodRequisicao	INTEGER NOT NULL,
	CodFornecedor	INTEGER NOT NULL,
	Data		DATE,
	ValorTotal	DOUBLE DEFAULT 0 NOT NULL,
	CONSTRAINT pkRequisicao PRIMARY KEY (CodRequisicao),
	CONSTRAINT fkRequisicaoFornecedor FOREIGN KEY (CodFornecedor) REFERENCES Fornecedor(CodFornecedor)
);

CREATE TABLE ItemPedido
(
	CodPedido	INTEGER NOT NULL,
	CodProduto	INTEGER NOT NULL,
	Quantidade	DOUBLE DEFAULT 0 NOT NULL,
	ValorUnitario	DOUBLE DEFAULT 0 NOT NULL,
	CONSTRAINT pkItemPedido PRIMARY KEY (CodPedido, CodProduto),
	CONSTRAINT fkItemPedidoPedido 	FOREIGN KEY (CodPedido) REFERENCES Pedido(CodPedido),
	CONSTRAINT fkItemPedidoProduto	FOREIGN KEY (CodProduto) REFERENCES Produto(CodProduto)
);

CREATE TABLE ItemRequisicao
(
	CodRequisicao	INTEGER NOT NULL,
	CodProduto	INTEGER NOT NULL,
	Quantidade	DOUBLE DEFAULT 0 NOT NULL,
	ValorUnitario	DOUBLE DEFAULT 0 NOT NULL,
	CONSTRAINT pkItemRequisicao PRIMARY KEY (CodRequisicao, CodProduto),
	CONSTRAINT fkItemRequisicaoRequisicao 	FOREIGN KEY (CodRequisicao) REFERENCES Requisicao(CodRequisicao),
	CONSTRAINT fkItemRequisicaoProduto	FOREIGN KEY (CodProduto) REFERENCES Produto(CodProduto)
);

CREATE TABLE Historico
(
	Documento	INTEGER NOT NULL,
	CodProduto	INTEGER NOT NULL,
	Movimento	CHAR(1) NOT NULL,
	Data		DATE,
	Quantidade	DOUBLE,
	Saldo		DOUBLE,
	CONSTRAINT pkHistorico PRIMARY KEY (Documento, CodProduto, Movimento),
	CONSTRAINT fkHistoricoProduto	FOREIGN KEY (CodProduto) REFERENCES Produto(CodProduto)
);

CREATE TABLE PedidoParcela
(
	CodPedido	INTEGER NOT NULL,	
	NumParcela	INTEGER NOT NULL,
	DataVencimento	DATE,
	DataPagamento	DATE,
	ValorTotal	DOUBLE DEFAULT 0 NOT NULL,
	ValorPago	DOUBLE DEFAULT 0 NOT NULL,
	Desconto	DOUBLE DEFAULT 0 NOT NULL,
	Acrescimo	DOUBLE DEFAULT 0 NOT NULL,
	CONSTRAINT pkPedidoParcela PRIMARY KEY (CodPedido, NumParcela),
	CONSTRAINT fkPedidoParcelaPedido FOREIGN KEY (CodPedido) REFERENCES Pedido(CodPedido)	
);



INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (1, 'São Chicio', 'MG');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (2, 'Muriaé', 'MG');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (3, 'Viçosa', 'MG');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (4, 'Barbacena', 'MG');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (5, 'Rio de Janeiro', 'RJ');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (6, 'Vitória', 'ES');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (7, 'São Paulo', 'SP');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (8, 'Belo HOrizonte', 'MG');
INSERT INTO Cidade (CodCidade, Nome, UF) VALUES (9, 'Salvador', 'BA');

INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 1, 'Antonio', '', 1);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 2, 'José', '', 2);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 3, 'Lurdes', '', 2);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 4, 'Marcelo', '', 3);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 5, 'Marcos', '', 2);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 6, 'Paulo', '', 5);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 7, 'Maria', '', 5);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 8, 'Vanilda', '', 7);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES ( 9, 'Carla', '', 6);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES (10, 'Petrina', '', 8);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES (11, 'Solange', '', 8);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES (12, 'João', '', 7);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES (13, 'Marlon', '', 6);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES (14, 'Lucas', '', 6);
INSERT INTO Cliente (CodCliente, Nome, Email, CodCidade) VALUES (15, 'Luciana', '', 9);

INSERT INTO Fornecedor (CodFornecedor, Nome, Email, CodCidade) VALUES (1, 'Nestlé', '', 7);
INSERT INTO Fornecedor (CodFornecedor, Nome, Email, CodCidade) VALUES (2, 'Dist. de Bebidas Muriaé', '', 2);
INSERT INTO Fornecedor (CodFornecedor, Nome, Email, CodCidade) VALUES (3, 'Sadia', '', 7);
INSERT INTO Fornecedor (CodFornecedor, Nome, Email, CodCidade) VALUES (4, 'Adams', '', 5);
INSERT INTO Fornecedor (CodFornecedor, Nome, Email, CodCidade) VALUES (5, 'Unilever', '', 5);
INSERT INTO Fornecedor (CodFornecedor, Nome, Email, CodCidade) VALUES (6, 'Martins', '', 8);

INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 1, 'Cerveja Skol', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 2, 'Refrigerante Coca-Cola', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 3, 'Refrigerante Simba', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 4, 'Sabão em pó OMO', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 5, 'Detergente Limpol', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 6, 'Palha de aço Bom-Bril', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 7, 'Presunto', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 8, 'Leite Integral', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES ( 9, 'Leite Desnatado', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (10, 'Chiclete de Menta', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (11, 'Desodorante Rexona', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (12, 'Sabonete Lux', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (13, 'Amaciante lave-baby', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (14, 'Sabão em barra Brilhante', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (15, 'Escova dental Oral B', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (16, 'Creme dental Colgate', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (17, 'Creme dental Sorriso', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (18, 'Achocolatado Tody', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (19, 'Biscoito Água e Sal Aymoré', 0);
INSERT INTO Produto (CodProduto, Descricao, Estoque) VALUES (20, 'Embapanado Sadia', 0);

DROP table Produto ;

INSERT INTO Requisicao (CodRequisicao, CodFornecedor, `Data`, ValorTotal)
VALUES (1, 1, now(), 650);

INSERT INTO Requisicao (CodRequisicao, CodFornecedor, `Data`, ValorTotal)
VALUES (3, 1, now(), 1000);

INSERT INTO ItemRequisicao (CodRequisicao, CodProduto, Quantidade, ValorUnitario)
VALUES (1, 3, 100, 5.50);

INSERT INTO Requisicao (CodRequisicao, CodFornecedor, `Data`, ValorTotal)
VALUES (10, 1, now(), 800);

INSERT INTO ItemRequisicao (CodRequisicao, CodProduto, Quantidade, ValorUnitario)
VALUES (3, 1, 150, 5.50);

INSERT INTO ItemRequisicao (CodRequisicao, CodProduto, Quantidade, ValorUnitario)
VALUES (10, 2, 10, 5);

INSERT INTO ItemRequisicao (CodRequisicao, CodProduto, Quantidade, ValorUnitario)
VALUES (10, 2, 100, 10);

DELETE FROM ItemRequisicao WHERE CodRequisicao = 10 AND CodProduto = 2;

DELETE FROM Historico WHERE Documento = 1;

UPDATE ItemRequisicao ir
SET ir.Quantidade = 20
WHERE ir.CodRequisicao = 9 AND CodProduto = 1;

DELETE FROM ItemRequisicao WHERE CodRequisicao = 1;

INSERT INTO Pedido (CodPedido, CodCliente, `Data`, ValorTotal, NumParcelas)
VALUES (2, 1, now(), 100, 0);

INSERT INTO Pedido (CodPedido, CodCliente, `Data`, ValorTotal, NumParcelas)
VALUES (3, 1, now(), 100, 0);

INSERT INTO Pedido (CodPedido, CodCliente, `Data`, ValorTotal, NumParcelas)
VALUES (4, 1, now(), 100, 0);

INSERT INTO Pedido (CodPedido, CodCliente, `Data`, ValorTotal, NumParcelas)
VALUES (5, 1, now(), 100, 0);

INSERT INTO ItemPedido (CodPedido, CodProduto, Quantidade, ValorUnitario)
VALUES(2, 3, 30, 3.2);

INSERT INTO ItemPedido (CodPedido, CodProduto, Quantidade, ValorUnitario)
VALUES(4, 3, 20, 3.2);

INSERT INTO ItemPedido (CodPedido, CodProduto, Quantidade, ValorUnitario)
VALUES(5, 3, 20, 3.2);


UPDATE ItemPedido ip 
SET ip.Quantidade = 10
WHERE ip.CodPedido = 5;

DELETE FROM ItemPedido WHERE CodPedido = 5;
SELECT DISTINCT * FROM Historico h ;
