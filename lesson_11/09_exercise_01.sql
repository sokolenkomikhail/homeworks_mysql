-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

CREATE TABLE logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP,
  table_title VARCHAR(32), 
  external_id INT,
  value VARCHAR(255)
) ENGINE=ARCHIVE;

DELIMITER //
DROP TRIGGER IF EXISTS check_users_insert//
CREATE TRIGGER check_users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN 
	INSERT INTO logs (created_at, table_title, external_id, value)
    VALUES (NOW(), 'users', NEW.id, NEW.name);
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS check_catalogs_insert//
CREATE TRIGGER check_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN 
	INSERT INTO logs (created_at, table_title, external_id, value)
    VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS check_products_insert//
CREATE TRIGGER check_products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN 
	INSERT INTO logs (created_at, table_title, external_id, value)
    VALUES (NOW(), 'products', NEW.id, NEW.name);
END//
DELIMITER ;

