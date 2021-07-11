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

CALL pCalcularMensalidade(2, 2021); 

SELECT m.CodSocio,  SUM(ad.Valor), SUM(as1.Valor) FROM Mensalidade m 
INNER JOIN Socio s ON m.CodSocio = s.CodSocio 
INNER JOIN AtividadeSocio as1 ON as1.CodSocio = m.CodSocio 
INNER JOIN AtividadeDependente ad ON m.CodSocio = ad.CodSocio 
WHERE s.Ativo = 1 AND m.Ano = 2021 AND m.Mes = 2
GROUP BY m.CodSocio , s.Ativo ;

SELECT m.CodSocio, s.Ativo, SUM(as1.Valor) FROM Mensalidade m 
INNER JOIN Socio s ON m.CodSocio = s.CodSocio 
INNER JOIN AtividadeSocio as1 ON as1.CodSocio = m.CodSocio 
WHERE s.Ativo = 1 AND m.Ano = 2021 AND m.Mes = 1
GROUP BY m.CodSocio , s.Ativo ;


DROP PROCEDURE pPagarMensalidade;

UPDATE Mensalidade 
SET ValorPago = 400
WHERE CodSocio = 1 AND Ano = 2021 AND Mes = 1;

SELECT s.CodSocio, s.NumDependentes FROM Socio s WHERE s.Nome LIKE "%Sasuke Uchiha%" ;
SELECT m.DataPagamento FROM Mensalidade m WHERE m.CodSocio = 4 AND m.Ano = 2021 AND m.Mes = 2;

CALL pPagarMensalidade("%Bruno%", 1, 2021); 
