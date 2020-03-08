-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Думаю, что этот запрос можно улучшить.
-- Малоюзабелен из-за того, что нужно подставлять id во многие места.
SELECT (IF(from_user_id = 73, to_user_id, from_user_id)) AS f,  						-- замена id исследуемого пользователя на id отправителя/получателя 
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = f) AS name,  		-- для получения списка пользователей, с которыми он переписывался
	COUNT(*) AS message_qty
	FROM messages 
		WHERE (from_user_id = 73 
			AND to_user_id IN (SELECT (IF(user_id = 73, friend_id, user_id))  		-- проверка на вхождение в множество подтвержденных друзей
				FROM friendship WHERE status_id = 
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed') 
				AND (user_id = 73 OR friend_id = 73))) 
		OR (to_user_id = 73															-- пользователь либо отправитель, либо получатель (чтобы была выборка по всем письмам)	
			AND from_user_id IN (SELECT (IF(user_id = 73, friend_id, user_id)) 		-- проверка на вхождение в множество подтвержденных друзей
				FROM friendship WHERE status_id = 
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed') 
				AND (user_id = 73 OR friend_id = 73)))
		GROUP BY f 
		ORDER BY COUNT(*) DESC 
		LIMIT 1
;


-- Вариант с UNION. Меньше подстановок id.
SELECT (IF(from_user_id = 73, to_user_id, from_user_id)) AS f, 
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = f) AS name,  
	COUNT(*) AS message_qty
	FROM messages 
		WHERE (from_user_id = 73 
			AND to_user_id IN (SELECT user_id FROM friendship WHERE status_id = 
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed') AND friend_id = 73
				UNION
				SELECT friend_id FROM friendship WHERE status_id = 
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed')AND user_id = 73)) 
		OR (to_user_id = 73
			AND from_user_id IN (SELECT user_id FROM friendship WHERE status_id = 
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed') AND friend_id = 73
				UNION
				SELECT friend_id FROM friendship WHERE status_id = 
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed')AND user_id = 73))
		GROUP BY f 
		ORDER BY COUNT(*) DESC 
		LIMIT 1
;

