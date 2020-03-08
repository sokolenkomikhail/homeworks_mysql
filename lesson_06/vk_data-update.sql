-- Обновление значений таблицы лайков в соответствии с данными из связанных таблиц.
-- Чтобы не получилось так, чтобы лайк ссылался на объект, которого нет.
-- Актуально в том случае, если кол-во данных в таблицах разнится, 
-- а данные генерились по самой большой таблице
UPDATE likes SET target_id = 
  (SELECT id FROM messages ORDER BY RAND() LIMIT 1) 
    WHERE target_id > (SELECT COUNT(id) FROM messages) AND target_type_id = 1
;
  
UPDATE likes SET target_id = 
  (SELECT id FROM users ORDER BY RAND() LIMIT 1)
    WHERE target_id > (SELECT COUNT(id) FROM users) AND target_type_id = 2
;

UPDATE likes SET target_id = 
  (SELECT id FROM media ORDER BY RAND() LIMIT 1)
    WHERE target_id > (SELECT COUNT(id) FROM media) AND target_type_id = 3
;

UPDATE likes SET target_id = 
  (SELECT id FROM posts ORDER BY RAND() LIMIT 1)
    WHERE target_id > (SELECT COUNT(id) FROM posts) AND target_type_id = 4
;
  
-- Проверка
SELECT * FROM likes WHERE target_type_id = 1;
SELECT * FROM likes WHERE target_type_id = 2;
SELECT * FROM likes WHERE target_type_id = 3;
SELECT * FROM likes WHERE target_type_id = 4;

-- Приведение дат в более правдоподобный вид.
-- Отнимаем рандомный промежуток времени в секундах в пределах одного года.
UPDATE likes SET created_at = 
  DATE_ADD(created_at , INTERVAL -(FLOOR(1 + RAND() * 31536000)) SECOND)
;

-- проверка
SELECT created_at FROM likes LIMIT 10;
