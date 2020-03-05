-- 1.
-- Подсчитайте средний возраст пользователей в таблице users

SELECT FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday, NOW()))) AS avg_age FROM users;


-- 2.
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT COUNT(*) 
		AS total, 
	WEEKDAY(DATE_FORMAT(birthday, CONCAT(YEAR(CURDATE()), '-%m-%d'))) 
		AS day_of_week 
	FROM users 
	GROUP BY 
		day_of_week 
	ORDER BY 
		day_of_week
;


-- 3.
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы
-- уже не успел сделать
