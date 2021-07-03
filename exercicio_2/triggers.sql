DELIMITER |
CREATE TRIGGER tInsertPartida
AFTER INSERT ON Partida
FOR EACH ROW 
BEGIN 
	IF (NEW.GolsClube1 > NEW.GolsClube2) THEN 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 3
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube1 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
	ELSEIF (NEW.GolsClube2 > NEW.GolsClube1) THEN
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 3
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube2 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
	ELSE 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 1
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube1 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
		
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 1
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube2 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
	END IF;
END;
|

DELIMITER |
CREATE TRIGGER tUpdatePartida
AFTER UPDATE ON Partida
FOR EACH ROW 
BEGIN 
	IF (OLD.GolsClube1 > OLD.GolsClube2) THEN 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 3
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube1 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
	ELSEIF (OLD.GolsClube2 > OLD.GolsClube1) THEN
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 3
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube2 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
	ELSE 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 1
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube1 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
		
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 1
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube2 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
	END IF;

	IF (NEW.GolsClube1 > NEW.GolsClube2) THEN 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 3
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube1 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
	ELSEIF (NEW.GolsClube2 > NEW.GolsClube1) THEN
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 3
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube2 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
	ELSE 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 1
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube1 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
		
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos + 1
		WHERE 
			NEW.CodCampeonato = cc.CodCampeonato 
			AND NEW.CodClube2 = cc.CodClube 
			AND NEW.Ano = cc.Ano;
	END IF;

END;
|

DELIMITER |
CREATE TRIGGER tDeletePartida
BEFORE DELETE ON Partida
FOR EACH ROW 
BEGIN 
	IF (OLD.GolsClube1 > OLD.GolsClube2) THEN 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 3
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube1 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
	ELSEIF (OLD.GolsClube2 > OLD.GolsClube1) THEN
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 3
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube2 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
	ELSE 
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 1
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube1 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
		
		UPDATE ClubeCampeonato cc 
		SET cc.Pontos = cc.Pontos - 1
		WHERE 
			OLD.CodCampeonato = cc.CodCampeonato 
			AND OLD.CodClube2 = cc.CodClube 
			AND OLD.Ano = cc.Ano;
	END IF;
END;
|

DELIMITER |
CREATE TRIGGER tInsertNumPartidas
AFTER INSERT ON Partida
FOR EACH ROW 
BEGIN 
	UPDATE Estadio e 
	SET e.NumPartidas = e.Numpartidas + 1
	WHERE NEW.CodEstadio = e.CodEstadio;
END;
|


DELIMITER |
CREATE TRIGGER tUpdateNumPartidas
AFTER UPDATE ON Partida
FOR EACH ROW 
BEGIN 
	UPDATE Estadio e 
	SET e.NumPartidas = e.Numpartidas - 1
	WHERE OLD.CodEstadio = e.CodEstadio;
	
	UPDATE Estadio e 
	SET e.NumPartidas = e.Numpartidas + 1
	WHERE NEW.CodEstadio = e.CodEstadio;
END
| 

DELIMITER |
CREATE TRIGGER tDeleteNumPartidas
BEFORE DELETE ON Partida
FOR EACH ROW 
BEGIN 
	UPDATE Estadio e 
	SET e.NumPartidas = e.Numpartidas - 1
	WHERE OLD.CodEstadio = e.CodEstadio;
END
|



















DROP TRIGGER  tInsertPartida;