-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

-- Анализ активности осуществляется по сумме следующих действий: 
-- количество сообществ, в которые вступил пользователь,
-- количество людей, которым пользователь предложил дружбу, 
-- количество ответов на предложение дружбы (принял или отверг),
-- количество лайков, сделанных пользователем, 
-- количество медиафайлов, загруженных пользователем,
-- количество отправленных сообщений,
-- количество постов пользователя.
-- Все что не требует от пользователя действий в расчет не берется 
-- (полученные сообщения, лайки от других пользователей, предложения дружбы, на которые не ответил и т.д.).
-- Общая сумма произведенных пользователем действий вынесена в столбец 'activity'
SELECT id, 
	CONCAT(first_name, ' ', last_name) AS user,
		(
	(SELECT COUNT(*) FROM communities_users WHERE user_id = users.id) + 
	(SELECT COUNT(*) FROM friendship WHERE user_id = users.id) + 
	(SELECT COUNT(*) FROM friendship WHERE friend_id = users.id AND status_id > 1) + 
	(SELECT COUNT(*) FROM likes WHERE user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE from_user_id = users.id) + 
	(SELECT COUNT(*) FROM posts WHERE user_id = users.id)
		) AS activity
			FROM users 
			ORDER BY activity LIMIT 10
;

