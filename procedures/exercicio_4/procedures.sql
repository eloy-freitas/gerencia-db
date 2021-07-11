DELIMITER $$
	CREATE PROCEDURE pAtualizarStatusEmprestimo()
	BEGIN
		DECLARE cd_emprestimo INTEGER;
		DECLARE cd_emprestimo_devolvido INTEGER;
		DECLARE qtd_emprestimos INTEGER;
		DECLARE qtd_emprestimos_devolvidos INTEGER;
		DECLARE fim_cursor INTEGER;
		DECLARE cQtdEmprestimos CURSOR FOR SELECT oe.CodEmprestimo, COUNT(oe.CodObra) FROM ObraEmprestimo oe GROUP BY oe.CodEmprestimo; 
		DECLARE cQtdEmprestimosDevolvidos CURSOR FOR SELECT oe.CodEmprestimo, COUNT(oe.CodObra) FROM ObraEmprestimo oe WHERE oe.Devolvido = 1 GROUP BY oe.CodEmprestimo ; 
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = 1;
		OPEN cQtdEmprestimos;
		OPEN cQtdEmprestimosDevolvidos;
		REPEAT
			FETCH cQtdEmprestimos INTO cd_emprestimo, qtd_emprestimos;
			FETCH cQtdEmprestimosDevolvidos INTO cd_emprestimo_devolvido, qtd_emprestimos_devolvidos;
			IF qtd_emprestimos = qtd_emprestimos_devolvidos AND cd_emprestimo = cd_emprestimo_devolvido THEN
				UPDATE Emprestimo 
				SET Finalizado = 1
				WHERE CodEmprestimo = cd_emprestimo;
			END IF;
		UNTIL fim_cursor = 1 END REPEAT;
		CLOSE cQtdEmprestimos;
		CLOSE cQtdEmprestimosDevolvidos;
	END
$$

DELIMITER $$
	CREATE PROCEDURE pStatusMUltaUsuario (IN matricula INTEGER, OUT status VARCHAR(3))
	BEGIN 
		DECLARE multa INTEGER;
		DECLARE valor FLOAT;
		DECLARE fim_cursor INTEGER;
		DECLARE cUsuario CURSOR FOR SELECT u.Multa, u.Valor FROM Usuario u WHERE u.Matricula = matricula; 
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = 1;
		OPEN cUsuario;
		FETCH cUsuario INTO multa, valor;
		IF multa = 1 AND valor > 5 THEN 
			SET status = 'Não';
		ELSE
			SET status = 'Sim';
		END IF;
	END
$$

CALL pStatusMUltaUsuario(4, @status);
SELECT @status;


SELECT u.Multa, u.Valor FROM Usuario u WHERE u.Matricula = 4;

CALL pAtualizarStatusEmprestimo(); 
DROP PROCEDURE pAtualizarStatusEmprestimo;

SELECT e.CodEmprestimo FROM Emprestimo e ;

SELECT CodEmprestimo, COUNT(CodObra) FROM ObraEmprestimo oe
GROUP BY CodEmprestimo; 

SELECT CodEmprestimo, COUNT(CodObra) FROM ObraEmprestimo oe 
where oe.Devolvido = 1
GROUP BY CodEmprestimo ; 

