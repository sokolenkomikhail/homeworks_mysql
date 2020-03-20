-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
	CASE (p.gender)
		WHEN 'M' THEN 'Mens'
		WHEN 'F' THEN 'Womens'
	END AS gender, 
	COUNT(*) AS likes 
		FROM profiles AS p 
		JOIN likes AS l ON p.user_id = l.user_id 
			GROUP BY p.gender
			ORDER BY likes DESC;
