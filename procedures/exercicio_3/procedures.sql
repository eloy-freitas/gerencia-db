 
 
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

CALL CalcularRodadas(Date(now()), 1); 
DROP PROCEDURE CalcularRodadas;

SELECT p.CodPartida FROM Partida p WHERE (p.CodCampeonato = 1 AND DATE(p.DataHora) = DATE(now()));

SELECT MAX(r.CodRodada) + 1 FROM Rodada r;

SELECT p.CodPartida FROM Partida p WHERE p.CodCampeonato = CodCampeonato AND DATE(p.DataHora) = DATE(now());
 
 SELECT CodPartida 
	FROM Partida p 
	WHERE p.CodCampeonato = CodCampeonato AND DATE(p.DataHora) = DATE(now()); 
 
 CALL calcularValorPasse('Capixabão', 2021);
 

SELECT DATE(p.DataHora) FROM Partida p ;