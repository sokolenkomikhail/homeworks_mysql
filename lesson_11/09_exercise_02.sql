-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- Опробовано два варианта. В обоих вариантах используется дополнительная таблица names, 
-- в которую внес 10 наиболее часто встречающихся имен в соцсети VK* 
-- *по данным приведенным в https://ppt-online.org/399173

CREATE TABLE names (
  name VARCHAR(64)
  );

INSERT INTO names VALUES 
  ('Александр'), 
  ('Елена'), 
  ('Сергей'),
  ('Татьяна'),
  ('Анндрей'),
  ('Ольга'),
  ('Дмитрий'),
  ('Наталья'),
  ('Максим'),
  ('Анастасия');


-- 1-ый вариант (более оптимальный)
-- Время вставки 1 млн строк составило 219с
-- Осуществляется JOIN names к самой себе 6 раз
-- Таким образом результирующая таблица имеет 10^6 = 1000000 строк

INSERT INTO users 
  SELECT 
    NULL, 
    n1.name, 
    SUBDATE(NOW(), FLOOR(1 + (RAND() * 36500))),
    NOW(),
    NOW() 
  FROM names AS n1 
  JOIN names AS n2
  JOIN names AS n3
  JOIN names AS n4
  JOIN names AS n5
  JOIN names AS n6;


-- 2-ой вариант (не оптимальный)
-- Предполагаемое время вставки 1 млн строк составит около ~18000-19000с
-- Создание процедуры, в которой описан цикл для INSERT значений в таблицу users и ее последующий вызов

DELIMITER //
DROP PROCEDURE IF EXISTS generate_users_values//
CREATE PROCEDURE generate_users_values(IN value INT)
BEGIN 
  DECLARE i INT;
    SET i = value;
    WHILE i > 0 DO
    INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
        ((SELECT name FROM names ORDER BY RAND() LIMIT 1), 
        SUBDATE(NOW(), FLOOR(1 + (RAND() * 36500))),
        NOW(),
        NOW());
        SET i = i - 1;
  END WHILE;
END//
DELIMITER ;

CALL generate_users_values(1000000);


-- Полагаю, что второй запрос менее оптимален из-за того, что в цикле осуществляется коррелирующий подзапрос для каждой вставки (1 млн раз)
-- А первый работает уже по готовой таблице с 1 млн строк
-- Вероятно, что первое решение также не является достаточно оптимальным
-- MySQL установлен на виртуальной машине с Ubuntu-server 18.04. Было выделено: 1 ядро (Ryzen 7 3750H, 2.3-4.0Ghz) и 1024MB RAM

