-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

-- Привел два варианта. Первый с использованием цикла. Второй с использованием формулы Бине. 
-- Есть еще и третий, рекурсивный... Но при его использовании (для последовательности Фибоначчи), я думаю, и побить могут... 
-- Да и судя по информаци, в MySQL не допускаются рекурсивные вызовы функций

DELIMITER //
DROP FUNCTION IF EXISTS fibonacci//
CREATE FUNCTION fibonacci (value INT)
RETURNS BIGINT NO SQL 
BEGIN 
	DECLARE a BIGINT DEFAULT 0;
    DECLARE b BIGINT DEFAULT 1;
    DECLARE c BIGINT DEFAULT 1;
    DECLARE i INT DEFAULT (value + 2)DIV 3;  	-- за одну итерацию цикла получаются значения для 3-ех элементов
    IF (value = 0) THEN
		RETURN 0;
	ELSE 
		WHILE i > 0 DO 
			SET c = a + b;
            SET b = a + c;
            SET a = b + c;
            SET i = i - 1;
		END WHILE;
        CASE 									-- выбор переменной для отображения в качестве результата
			WHEN value % 3 = 1 THEN RETURN c;
            WHEN value % 3 = 2 THEN RETURN b;
            WHEN value % 3 = 0 THEN RETURN a;
		END CASE;
	END IF;
END//
DELIMITER ;

SELECT fibonacci(10);
SELECT fibonacci(11);
SELECT fibonacci(12);
SELECT fibonacci(90);  -- максимальный элемент для данной реализации. При вызове 91-го элемента подсчитываются значения для 91, 92 и 93. 93-ий элемент выходит за пределы BIGINT


-- Нахождение по формуле Бине. Более лаконичный способ. Но есть минус. Т.к. в формуле применяется деление и работа с корнями (дробными степенями),  
-- на 72-ом элементе (и далее), из-за накопления ошибок при оперировании числами с плавающей точкой, выдает некорректный результат

DELIMITER //
DROP FUNCTION IF EXISTS fib//
CREATE FUNCTION fib (value INT)
RETURNS BIGINT NO SQL
BEGIN 
	IF value = 0 THEN
		RETURN 0;
	ELSEIF value = 1 THEN 
		RETURN 1;
	ELSE 
		RETURN FLOOR((POW((1 + POW(5, 1/2))/2, value) - POW((1 - POW(5, 1/2))/2, value))/POW(5, 1/2));
	END IF;
END//
DELIMITER ;

SELECT fib(10);
SELECT fib(11);
SELECT fib(12);
SELECT fib(71);			-- максимальный достоверный результат.
SELECT fib(92);			-- мвксимальный элемент. 93-ий выходит за пределы BIGINT

