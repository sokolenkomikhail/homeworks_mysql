-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT u.id, 
	CONCAT(u.first_name, ' ', u.last_name) AS name,
	p.birthday AS birthday, 
	TIMESTAMPDIFF(YEAR, p.birthday, NOW()) AS age, 
	COUNT(l.id) AS likes_qty
		FROM profiles AS p
		JOIN users AS u ON p.user_id = u.id 
		LEFT JOIN likes AS l ON u.id = l.target_id AND target_type_id = 2
			GROUP BY name, u.id, age, birthday 	
			ORDER BY birthday DESC LIMIT 10;
