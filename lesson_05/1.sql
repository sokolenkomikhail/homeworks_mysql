-- 1.
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE users SET 
	created_at = DATETIME DEFAULT NOW(),
	updated_at = DATETIME DEFAULT NOW()
;


-- 2.
-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

-- Вариант 1
UPDATE users SET 
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i')
;

-- Вариант 2
UPDATE users SET 
	created_at = 
		CONCAT(SUBSTRING(created_at, 7, 4),
		'-',
		SUBSTRING(created_at, 4, 2), 
		'-',
		SUBSTRING(created_at, 1, 2),
		' ',
		SUBSTRING(created_at, 12, 5), 
		':00'),
	updated_at = 
		CONCAT(SUBSTRING(updated_at, 7, 4),
		'-',
		SUBSTRING(updated_at, 4, 2), 
		'-',
		SUBSTRING(updated_at, 1, 2),
		' ',
		SUBSTRING(updated_at, 12, 5), 
		':00'
); 

-- изменение типа столбца на DATETIME
ALTER TABLE users MODIFY COLUMN created_at DATETIME;
ALTER TABLE users MODIFY COLUMN updated_at DATETIME;



-- 3.
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

SELECT value FROM storehouses_products 
	ORDER BY 
		CASE value 
			WHEN '0' THEN '16777216' 
		END, 
		value;


-- 4.
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT * FROM users WHERE birthday RLIKE 'may|august';


-- 5.
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

-- В порядке остатка от деления
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY id % 5;

-- С использованием функции FIELD()
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

