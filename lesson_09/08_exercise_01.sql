-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS TEXT NO SQL
BEGIN 
	DECLARE ctime INT;
    SET ctime = TIME_TO_SEC(CURTIME());
	CASE 
		WHEN ctime BETWEEN (60 * 60 * 6) AND ((60 * 60 * 12) - 1) THEN RETURN 'Доброе утро!';
		WHEN ctime BETWEEN (60 * 60 * 12) AND ((60 * 60 * 18) - 1) THEN RETURN 'Добрый день!';
		WHEN ctime BETWEEN (60 * 60 * 18) AND ((60 * 60 * 24) - 1) THEN RETURN 'Добрый вечер!';
		WHEN ctime BETWEEN (60 * 60 * 0) AND ((60 * 60 * 6) - 1) THEN RETURN 'Доброй ночи!';
	END CASE;
END //
DELIMITER ;

SELECT hello();

