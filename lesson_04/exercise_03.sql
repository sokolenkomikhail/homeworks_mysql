USE vk_main;


-- Вконтакте можно оставлять комментарии к постам. Поэтому я бы добавил в БД еще таблицу комментариев
DESC posts;
-- Небольшой затык случился со столбцом comment_id. Не знаю, возможно ли это реализовать
-- Суть в том, что комментарии можно оставлять к другим комментариям. 
-- Т.е. возможны разные ветки обсуждений в комментариях к посту.
-- Чтобы не плодить таблицы для типов комментариев, тривиальным решением мне кажется указывать id комментария, к которому относится комментарий, 
-- в противном случае проставляется 0 (если комментарий относится непосредственно к посту). 
-- Затык в том, что я не уверен, что в пределах одной таблицы можно обращаться по id той же таблицы. Делал ночью, поэтому возможно, что туплю)
CREATE TABLE comments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	post_id INT UNSIGNED NOT NULL,
	comment_id INT DEFAULT 0,
	user_id INT UNSIGNED NOT NULL,
	text MEDIUMTEXT,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);


-- Реализация лайков

-- Вариант 1 (основной)
-- Создаем таблицы для разных типов лайков: посты, медиа, комментарии

CREATE TABLE post_likes (
	post_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (post_id, user_id)
);

CREATE TABLE comment_likes (
	comment_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL
	PRIMARY KEY (comment_id, user_id)
);

CREATE TABLE media_likes (
	media_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (media_id, user_id)
);
	
-- Вариант 2 (сомнительный)
-- Создаем таблицу с типами объектов для лайков (посты, комментарии, медиа).
-- Создаем общую таблицы для лайков.
-- Данный вариант вызывает некоторые сомнения в плане нагрузки на промежуточную таблицу (объекты для лайков)
CREATE TABLE like_obj (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	objects VARCHAR(16) NOT NULL UNIQUE
);

-- source_id ссылается на id разных таблиц (posts, comments, media)
-- Здеcь также есть сомнения в плане запросов
CREATE TABLE likes (
	like_obj_id INT UNSIGNED NOT NULL,
	source_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (like_obj, source_id, user_id)
);

-- с моей точки зрения, 2-ой вариант - не рабочий. Проверить уже не было возможности. Но интересно узнать ваше мнение

