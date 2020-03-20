-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;

DESC products;

SELECT * FROM products;

DELIMITER //
DROP TRIGGER IF EXISTS check_products_update//
CREATE TRIGGER check_products_update BEFORE UPDATE ON products 
FOR EACH ROW
BEGIN 
	IF (NEW.name IS NULL AND NEW.description IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
	END IF;
END//
DELIMITER ;

START TRANSACTION;
UPDATE products SET name = NULL, description = NULL WHERE id = 6;
ROLLBACK;

