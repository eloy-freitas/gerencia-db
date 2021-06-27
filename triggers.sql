#exercicio 1

DELIMITER |

CREATE TRIGGER new_item_requisicao AFTER INSERT ON ItemRequisicao
	FOR EACH ROW 
		BEGIN
			UPDATE Produto p
			SET p.Estoque = NEW.Quantidade + p.Estoque 
			WHERE p.CodProduto = NEW.CodProduto;
		END;
	|


DELIMITER |
CREATE TRIGGER update_item_requisicao AFTER UPDATE ON ItemRequisicao
	FOR EACH ROW 
		BEGIN 
			UPDATE Produto p 
			SET p.Estoque = p.Estoque - OLD.Quantidade + NEW.Quantidade
			WHERE p.CodProduto = NEW.CodProduto;
		END;
		
	|
	
	
	
DELIMITER |
CREATE TRIGGER delete_item_requisicao BEFORE DELETE ON ItemRequisicao
	FOR EACH ROW 
		BEGIN 
			UPDATE Produto p 
			SET p.Estoque = p.Estoque - OLD.Quantidade
			WHERE p.CodProduto = OLD.CodProduto;
		END;	
	|
	
#exercicio 2
	
DELIMITER |
CREATE TRIGGER new_item_pedido AFTER INSERT ON ItemPedido
	FOR EACH ROW 
		BEGIN 
			UPDATE Produto p 
			SET p.Estoque = p.Estoque - NEW.Quantidade
			WHERE p.CodProduto = NEW.CodProduto;
		END;	
	|
	
DELIMITER |
CREATE TRIGGER update_item_pedido AFTER UPDATE ON ItemPedido
	FOR EACH ROW 
		BEGIN 
			UPDATE Produto p 
			SET p.Estoque = p.Estoque + OLD.Quantidade - NEW.Quantidade
			WHERE p.CodProduto = NEW.CodProduto;
		END;
		
	|
	
DELIMITER |
CREATE TRIGGER delete_item_pedido BEFORE DELETE ON ItemPedido
	FOR EACH ROW 
		BEGIN 
			UPDATE Produto p 
			SET p.Estoque = p.Estoque + OLD.Quantidade
			WHERE p.CodProduto = OLD.CodProduto;
		END;	
	|
	

#exercicio 3

DELIMITER |
CREATE TRIGGER insert_historico_requisicao BEFORE INSERT ON ItemRequisicao
	FOR EACH ROW 
		BEGIN 
			SET @last_id = (SELECT MAX(h.Documento) + 1 FROM Historico h);
			INSERT INTO Historico (Documento, CodProduto, Movimento, `Data`, Quantidade, Saldo)
			VALUES (@last_id, NEW.CodProduto, 'E', now(), NEW.Quantidade, NEW.ValorUnitario);
		END;
|

DELIMITER |
CREATE TRIGGER update_historico_requisicao BEFORE INSERT ON ItemRequisicao
	FOR EACH ROW 
		BEGIN 
			UPDATE Historico 
			SET Quantidade = NEW.Quantidade, Saldo = NEW.ValorUnitario
			WHERE CodProduto = NEW.CodProduto AND Movimento = 'E'
		END;
|

#exercicio 4
DELIMITER |
CREATE TRIGGER insert_historico_pedido BEFORE INSERT ON ItemPedido
	FOR EACH ROW 
		BEGIN 
			SET @last_id = (SELECT MAX(h.Documento) + 1 FROM Historico h);
			INSERT INTO Historico (Documento, CodProduto, Movimento, `Data`, Quantidade, Saldo)
			VALUES (@last_id, NEW.CodProduto, 'S', now(), NEW.Quantidade, NEW.ValorUnitario);
		END;
|


#exercicio 5
DELIMITER |
CREATE TRIGGER insert_update_valor_total BEFORE INSERT ON ItemRequisicao
	FOR EACH ROW 
	BEGIN 
		UPDATE Requisicao 
		SET ValorTotal = ValorTotal + (NEW.Quantidade * NEW.ValorUnitario)
		WHERE NEW.CodRequisicao = CodRequisicao ;
	END
|

DELIMITER |
CREATE TRIGGER update_update_valor_total BEFORE UPDATE ON ItemRequisicao
	FOR EACH ROW 
	BEGIN 
		UPDATE Requisicao 
		SET ValorTotal = ValorTotal - (OLD.Quantidade * OLD.ValorUnitario) + (NEW.Quantidade * NEW.ValorUnitario)
		WHERE OLD.CodRequisicao = CodRequisicao ;
	END
|


DELIMITER |
CREATE TRIGGER delete_update_valor_total BEFORE DELETE ON ItemRequisicao
	FOR EACH ROW 
	BEGIN 
		UPDATE Requisicao 
		SET ValorTotal = ValorTotal - (OLD.Quantidade * OLD.ValorUnitario)
		WHERE OLD.CodRequisicao = CodRequisicao ;
	END
|

DROP TRIGGER delete_update_valor_total;
