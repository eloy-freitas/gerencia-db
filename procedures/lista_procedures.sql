 
 #exercicio 1
DELIMITER |
 CREATE PROCEDURE calcularValorPasse (IN Descricao VARCHAR(100), IN Ano INTEGER)
 BEGIN
	 SET @gols = (SELECT MAX(jcc.Gols) FROM JogadorClubeCampeonato jcc
				INNER JOIN ClubeCampeonato cc ON jcc.CodCampeonato = cc.CodCampeonato 
				INNER JOIN Campeonato c ON cc.CodCampeonato = c.CodCampeonato 
				WHERE c.Descricao = 'Capixabão' AND cc.Ano = 2021);
			
	SET @CodJogador = (SELECT jcc.CodJogador FROM JogadorClubeCampeonato jcc 
						WHERE jcc.Gols = @gols);
	
	UPDATE Jogador j 
	SET j.ValorPasse = j.ValorPasse + (j.ValorPasse * 0.15)
	WHERE j.CodJogador = @CodJogador;

 END
 |
 
 #ecercicio 2
DELIMITER $$
 CREATE PROCEDURE CalcularRodadas (IN DataRodada DATE, IN CodCampeonato INTEGER)
 BEGIN
	DECLARE fim_cursor INTEGER;
	DECLARE cd_partida INTEGER;	
	DECLARE cd_rodada INTEGER;
	DECLARE cPartida CURSOR FOR SELECT p.CodPartida FROM Partida p WHERE (p.CodCampeonato = CodCampeonato AND DATE(p.DataHora) = DataHora);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = 1;
	SET cd_rodada = (SELECT MAX(CodRodada) + 1 FROM Rodada);
	IF cd_rodada IS NULL THEN
		SET cd_rodada = 1;
	END IF;
	OPEN cPartida;
	REPEAT
		FETCH cPartida INTO cd_partida;
		INSERT INTO Rodada(CodRodada, CodCampeonato, CodPartida, DataRodada)
		VALUES (cd_rodada, CodCampeonato, cd_partida, DataRodada);
		UNTIL fim_cursor = 1
	END REPEAT;
	CLOSE cPartida;

END
$$

#exercicio 3
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

#exercicio 4
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

#exercicio 5
DELIMITER $$
	CREATE PROCEDURE pPagarMensalidade(IN NomeSocio VARCHAR(100), IN mes INTEGER, IN ano INTEGER)
	BEGIN
		DECLARE cd_socio INTEGER;
		DECLARE num_dependentes INTEGER;
		DECLARE data_pagamento DATETIME;
		SELECT s.CodSocio, s.NumDependentes INTO cd_socio, num_dependentes FROM Socio s WHERE s.Nome LIKE NomeSocio;
		SET mes = mes - 1;
		SELECT m.DataPagamento INTO data_pagamento FROM Mensalidade m WHERE m.CodSocio = cd_socio AND m.Ano = ano AND m.Mes = mes;
		SET mes = mes + 1;
		IF data_pagamento IS NOT NULL THEN
			UPDATE Mensalidade 
			SET ValorPago = ValorPago - (0.10 * ValorPago)
			WHERE CodSocio = cd_socio AND Ano = ano AND Mes = mes;
		END IF;
	END
$$

#exercicio 6
DELIMITER $$
	CREATE PROCEDURE pCalcularMensalidade (IN mes INTEGER, IN ano INTEGER)
	BEGIN
		DECLARE socio INTEGER;
		DECLARE ativo INTEGER;
		DECLARE mensalidade_s FLOAT DEFAULT 0;
		DECLARE mensalidade_d FLOAT DEFAULT 0;
		DECLARE fim_cursor INTEGER DEFAULT 0;
		DECLARE cursor1 CURSOR FOR (SELECT m.CodSocio,  SUM(ad.Valor), SUM(as1.Valor) FROM Mensalidade m 
								INNER JOIN Socio s ON m.CodSocio = s.CodSocio 
								INNER JOIN AtividadeSocio as1 ON as1.CodSocio = m.CodSocio 
								INNER JOIN AtividadeDependente ad ON m.CodSocio = ad.CodSocio 
								WHERE s.Ativo = 1 AND m.Ano = ano AND m.Mes = mes
								GROUP BY m.CodSocio , s.Ativo );
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_cursor = 1;
		OPEN cursor1;
		REPEAT
			FETCH cursor1 INTO socio, mensalidade_s, mensalidade_d;
			UPDATE Mensalidade 
			SET ValorTotal = mensalidade_s + mensalidade_d
			WHERE Mes = mes AND Ano = ano AND CodSocio = socio;
		UNTIL fim_cursor = 1 END REPEAT; 
		CLOSE cursor1;
	END
$$