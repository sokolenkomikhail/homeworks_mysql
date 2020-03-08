-- Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).

-- Не удалось улучшить запросы, которые применялись на уроке. Ниже представлен запрос без объединения. 
-- Не думаю, что он чем-то лучше изначального. Только короче


-- Выбираем только друзей с активным статусом
SELECT * FROM friendship_statuses;

(SELECT friend_id 
  FROM friendship 
  WHERE user_id = 8 AND status_id IN (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
)
UNION
(SELECT user_id 
  FROM friendship 
  WHERE friend_id = 8 AND status_id IN (
      SELECT id FROM friendship_statuses WHERE name = 'Confirmed'
    )
);

-- Вызов запросом без объединения. Минус в том, что id нужно подставлять в 3-ех местах. 
-- Поэтому этот способ врядли можно считать улучшением. 
-- Этот способ мне пригодился при решении задачи по выводу друга, с которым больше всего
-- общался пользователь, т.к. мне не получилось сделать подсчет сообщений при объединении
-- запросов. Возможно я смотрел не в ту сторону
SELECT IF(user_id = 8, friend_id, user_id) AS friends
	FROM friendship 
	WHERE user_id = 8 
		OR friend_id = 8 
	AND status_id = 
		(SELECT id FROM friendship_statuses WHERE name = 'Confirmed')
;

