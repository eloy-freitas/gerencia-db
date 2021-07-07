 
 
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
 
 DROP procedure calcularValorPasse;
 
 CALL calcularValorPasse('Capixabão', 2021);
 

				
				
				