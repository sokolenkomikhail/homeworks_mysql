-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- вывод пола и кол-ва лайков
SELECT (SELECT 
	CASE (gender) 
		WHEN 'M' THEN 'Mens'
		WHEN 'F' THEN 'Womens'
	END
			FROM profiles WHERE user_id = likes.user_id) AS gender,
		COUNT(*) AS likes_qty
	FROM likes GROUP BY gender ORDER BY likes_qty DESC LIMIT 1
;

-- кол-во лайков по полам
SELECT (SELECT COUNT(id) FROM likes 
		WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'M')) AS mens, 
	(SELECT COUNT(id) FROM likes 
		WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'F')) AS womens
;

