#exercicio 1
USE aula_trigger;

# MOVIMENTO DE ENTRADA DE PRODUTOS

DELIMITER |
CREATE TRIGGER tInsertEstoqueIR 
AFTER INSERT ON ItemRequisicao
FOR EACH ROW 
BEGIN
	UPDATE Produto p
	SET p.Estoque = p.Estoque + NEW.Quantidade
	wHERE p.CodProduto = NEW.CodProduto;
	
	INSERT INTO Historico
	(Documento, CodProduto, Movimento, `Data`, Quantidade, Saldo)
	VALUES (
		NEW.CodRequisicao,
		NEW.CodProduto,
		'E',
		(SELECT r.Data FROM Requisicao r WHERE CodRequisicao = NEW.CodRequisicao),
		NEW.Quantidade,
		(SELECT Estoque FROM Produto WHERE CodProduto = NEW.CodProduto)
	);

	UPDATE Requisicao 
		SET ValorTotal = ValorTotal + (NEW.Quantidade * NEW.ValorUnitario)
		WHERE CodRequisicao = NEW.CodRequisicao;
END;
|

DELIMITER |
CREATE TRIGGER tUpdateEstoqueIR 
AFTER UPDATE ON ItemRequisicao
FOR EACH ROW 
BEGIN 
	UPDATE Produto p 
	SET p.Estoque = p.Estoque - OLD.Quantidade
	WHERE p.CodProduto = OLD.CodProduto;

	DELETE FROM Historico 
	WHERE (Documento = OLD.CodRequisicao) 
	AND (CodProduto = OLD.CodProduto)
	AND (Movimento = 'E');

	UPDATE Requisicao 
	SET ValorTotal = ValorTotal - (OLD.Quantidade * OLD.ValorUnitario)
	WHERE (CodRequisicao = OLD.CodRequisicao);

	UPDATE Produto p
	SET p.Estoque = p.Estoque + NEW.Quantidade
	wHERE p.CodProduto = NEW.CodProduto;
	
	INSERT INTO Historico
	(Documento, CodProduto, Movimento, `Data`, Quantidade, Saldo)
	VALUES (
		NEW.CodRequisicao,
		NEW.CodProduto,
		'E',
		(SELECT r.Data FROM Requisicao r WHERE CodRequisicao = NEW.CodRequisicao),
		NEW.Quantidade,
		(SELECT Estoque FROM Produto WHERE CodProduto = NEW.CodProduto)
	);

	UPDATE Requisicao 
		SET ValorTotal = ValorTotal + (NEW.Quantidade * NEW.ValorUnitario)
		WHERE CodRequisicao = NEW.CodRequisicao;	
END;		
|
	
	
DELIMITER |
CREATE TRIGGER tDeleteEstoqueIR 
BEFORE DELETE ON ItemRequisicao
FOR EACH ROW 
BEGIN 
	UPDATE Produto p 
	SET p.Estoque = p.Estoque - OLD.Quantidade
	WHERE p.CodProduto = OLD.CodProduto;

	DELETE FROM Historico 
	WHERE (Documento = OLD.CodRequisicao) 
	AND (CodProduto = OLD.CodProduto)
	AND (Movimento = 'E');

	UPDATE Requisicao 
	SET ValorTotal = ValorTotal - (OLD.Quantidade * OLD.ValorUnitario)
	WHERE (CodRequisicao = OLD.CodRequisicao);
END;	
|
	
# MOVIMENTO DE SAÍDA DE PRODUTOS
	
DELIMITER |
CREATE TRIGGER tInsertEstoqueIP 
AFTER INSERT ON ItemPedido
FOR EACH ROW 
BEGIN 
	UPDATE Produto p 
	SET p.Estoque = p.Estoque - NEW.Quantidade
	WHERE p.CodProduto = NEW.CodProduto;

	INSERT INTO Historico (Documento, CodProduto, Movimento, `Data`, Quantidade, Saldo)
	VALUES (
		NEW.CodPedido, 
		NEW.CodProduto, 
		'S', 
		(SELECT p.`Data` FROM Pedido p WHERE p.CodPedido = NEW.CodPedido), 
		NEW.Quantidade, 
		(SELECT p.Estoque FROM Produto p WHERE CodProduto = NEW.CodProduto)
	);
	
	UPDATE Pedido 
	SET ValorTotal = ValorTotal + (NEW.Quantidade * NEW.ValorUnitario)
	WHERE (CodPedido = NEW.CodPedido);
	
END;	
|
	
DELIMITER |
CREATE TRIGGER tUpdateEstoqueIP 
AFTER UPDATE ON ItemPedido
FOR EACH ROW 
BEGIN 
	UPDATE Produto p 
	SET p.Estoque = p.Estoque + OLD.Quantidade
	WHERE p.CodProduto = OLD.CodProduto;

	DELETE FROM Historico 
	WHERE (Documento = OLD.CodPedido) 
	AND (CodProduto = OLD.CodProduto)
	AND (Movimento = 'S');

	UPDATE Pedido 
	SET ValorTotal = ValorTotal - (OLD.Quantidade * OLD.ValorUnitario)
	WHERE (CodPedido = OLD.CodPedido);
	
	UPDATE Produto p 
	SET p.Estoque = p.Estoque - NEW.Quantidade
	WHERE p.CodProduto = NEW.CodProduto;

	INSERT INTO Historico (Documento, CodProduto, Movimento, `Data`, Quantidade, Saldo)
	VALUES (
		NEW.CodPedido, 
		NEW.CodProduto, 
		'S', 
		(SELECT p.`Data` FROM Pedido p WHERE p.CodPedido = NEW.CodPedido), 
		NEW.Quantidade, 
		(SELECT p.Estoque FROM Produto p WHERE CodProduto = NEW.CodProduto)
	);
	
	UPDATE Pedido 
	SET ValorTotal = ValorTotal + (NEW.Quantidade * NEW.ValorUnitario)
	WHERE (CodPedido = NEW.CodPedido);

END;		
|
	
DELIMITER |
CREATE TRIGGER tDeleteEstoqueIP 
BEFORE DELETE ON ItemPedido
FOR EACH ROW 
BEGIN 
	UPDATE Produto p 
	SET p.Estoque = p.Estoque + OLD.Quantidade
	WHERE p.CodProduto = OLD.CodProduto;

	DELETE FROM Historico 
	WHERE (Documento = OLD.CodPedido) 
	AND (CodProduto = OLD.CodProduto)
	AND (Movimento = 'S');

	UPDATE Pedido 
	SET ValorTotal = ValorTotal - (OLD.Quantidade * OLD.ValorUnitario)
	WHERE (CodPedido = OLD.CodPedido);
END;	
|

