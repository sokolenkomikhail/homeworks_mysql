--  Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года 
-- '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, 
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

USE test;

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  created_at DATE DEFAULT NULL,
  PRIMARY KEY (id)
);

INSERT INTO tbl (created_at) 
	VALUES 
	('2018-08-30'), 
	('2018-08-04'), 
	('2018-08-15'), 
	('2018-08-09'), 
	('2018-08-31'), 
	('2018-08-14'), 
	('2018-08-27');

DROP TABLE IF EXISTS august;
CREATE TABLE august (
	day_of_month DATE
	);

DELIMITER //
DROP PROCEDURE IF EXISTS fill_august//
CREATE PROCEDURE fill_august()
	BEGIN
	DECLARE i INT DEFAULT 0;
		WHILE i < 31 DO
		INSERT INTO august (day_of_month) VALUES (DATE_ADD('2018-08-01', INTERVAL i DAY));
		SET i = i + 1;
	END WHILE;
END//
DELIMITER ;


CALL fill_august();

SELECT * FROM august;

SELECT * FROM tbl;

CREATE OR REPLACE VIEW tblview AS SELECT 
	a.day_of_month AS date, 
    t.created_at, 
    IF(t.created_at IS NULL, 0, 1) AS is_exist
		FROM august AS a 
        LEFT JOIN tbl AS t 
			ON a.day_of_month = t.created_at
		ORDER BY date;

SELECT * FROM tblview;

