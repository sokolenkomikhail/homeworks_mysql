-- Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

DROP DATABASE IF EXISTS test1;

CREATE DATABASE test1;

USE test1;

DROP TABLE IF EXISTS tbl;

CREATE TABLE tbl (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  created_at DATE,
  PRIMARY KEY (id)
);

INSERT INTO tbl (created_at) 
	SELECT DATE_ADD(NOW(), INTERVAL -(FLOOR(1 + (RAND() * 180))) DAY)
		FROM test.august;


SELECT * FROM tbl;

DELETE FROM tbl 
	WHERE id NOT IN 
		(SELECT * FROM (SELECT id FROM tbl ORDER BY created_at DESC LIMIT 5) AS date);

SELECT * FROM tbl ORDER BY created_at DESC;

