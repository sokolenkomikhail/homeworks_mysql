-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT COUNT(id) AS likes_qty 
	FROM likes 
		WHERE target_id IN (SELECT * FROM 
			(SELECT user_id FROM profiles ORDER BY TIMESTAMPDIFF(YEAR, birthday, NOW()) LIMIT 10) AS likes_qty)
		AND target_type_id = 2
;


