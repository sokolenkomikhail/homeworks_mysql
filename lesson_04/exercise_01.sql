USE vk_main;

SHOW TABLES;


-- users
SELECT * FROM users;

UPDATE users SET updated_at  = CURRENT_TIMESTAMP WHERE created_at > updated_at;


-- messages
SELECT * FROM messages;
-- таблица messages с моими тестовыми данными в порядке


-- media_types
SELECT * FROM media_types;

TRUNCATE media_types; 

INSERT INTO media_types (name) VALUES 
	('photo'), 
	('video'),
	('audio')
;


-- media
SELECT * FROM media LIMIT 10;

UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 3));

-- Обновление идентификаторов владельцев не требуется, т.к. при начальной генерации были присвоены случайные значения

-- Произведена замена названия на ссылки к медиафайлам. В зависимости от типа меняется путь и расширение файла
UPDATE media SET filename = CONCAT('https://dropbox.com/vk/images/', filename, '.jpg') WHERE media_type_id = 1;
UPDATE media SET filename = CONCAT('https://dropbox.com/vk/video/', filename, '.mp4') WHERE media_type_id = 2;
UPDATE media SET filename = CONCAT('https://dropbox.com/vk/audio/', filename, '.mp3') WHERE media_type_id = 3;

DESC media;

ALTER TABLE media MODIFY COLUMN metadata JSON;

UPDATE media SET metadata = CONCAT('{"owner":"', 
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id), 
	'"}');


-- profiles
SELECT * FROM profiles;

CREATE TEMPORARY TABLE gender (gender CHAR(1));
INSERT INTO gender VALUES ('M'), ('F');
SELECT * FROM gender;
UPDATE profiles SET gender = (SELECT gender FROM gender ORDER BY RAND() LIMIT 1);

-- Команда ниже не обязательна, т.к. после присвоения пола пользователям, время обновления изменилось на время присвоения.
-- UPDATE profiles SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;

DESC profiles;

ALTER TABLE profiles MODIFY COLUMN photo_id INT UNSIGNED;

UPDATE profiles SET photo_id = (
	SELECT id FROM media 
		WHERE media.user_id = profiles.user_id AND media_type_id = 1 LIMIT 1
);


-- friendship_statuses
SELECT * FROM friendship_statuses; 

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) 
	VALUES ('Requsted'), ('Confirmed'), ('Rejected');


-- friendship
SELECT * FROM friendship;

UPDATE friendship SET status_id = (
	SELECT id FROM friendship_statuses ORDER BY RAND() LIMIT 1
);


-- communities
SELECT * FROM communities;

DELETE FROM communities WHERE id > 20;


-- communities_users
SELECT * FROM communities_users;

-- У меня не получилось обойти ограничение PRIMARY KEY для моих данных (300 строк). Поэтому пришлось загрузить данную таблицу из приложенного к уроку дампа. 
-- Было бы неплохо, если на уроке, при разборе ДЗ, мы рассмотрим возможности обхода данного ограничения для большого количества строк
UPDATE communities_users SET
	community_id = (SELECT id FROM communities ORDER BY RAND() LIMIT 1),
	user_id = (SELECT id FROM users ORDER BY RAND() LIMIT 1)
;










