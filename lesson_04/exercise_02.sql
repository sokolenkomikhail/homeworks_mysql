USE vk_main;

-- создание таблицы постов
CREATE TABLE posts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	media_id INT UNSIGNED,
	user_id INT UNSIGNED NOT NULL,
	head VARCHAR(255),
	body MEDIUMTEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- добавление новых столбцов в messages
DESC messages;

ALTER TABLE messages ADD COLUMN read_at DATETIME;
ALTER TABLE messages ADD COLUMN edited_at DATETIME;

SELECT * FROM messages;


-- добавление нового столбца в profiles
DESC profiles;

ALTER TABLE profiles ADD COLUMN status_message VARCHAR(255) AFTER photo_id;

SELECT * FROM profiles;


-- добавление новых столбцов в communities
DESC communities;

ALTER TABLE communities ADD COLUMN media_id INT UNSIGNED AFTER name;
ALTER TABLE communities ADD COLUMN motto VARCHAR(255) AFTER media_id;
ALTER TABLE communities ADD COLUMN info TEXT AFTER motto;

SELECT * FROM communities;











