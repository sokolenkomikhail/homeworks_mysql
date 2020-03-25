-- 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.

-- users
-- По имени, фамилии
CREATE INDEX users_first_name_idx ON users(first_name);
CREATE INDEX users_last_name_idx ON users(last_name);


-- communities
-- По названию группы
CREATE INDEX communities_name_idx ON communities(name);


-- profiles
-- Страны и города в них для поиска пользователей в нужной локации
CREATE INDEX profiles_country_city_birthday_gender_idx ON profiles(country, city, birthday, gender);

-- Пол и возраст
CREATE INDEX profiles_birthday_gender_idx ON profiles(birthday, gender);


-- media
-- Тип и название
CREATE INDEX media_media_type_id_filename_idx ON media(media_type_id, filename);

-- Пользователь и типы файлов
CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);


-- friendship
-- Пользователь и друзья с обоих сторон с подтвержденным статусом
CREATE INDEX friendship_user_id_status_id_idx ON friendship(user_id, status_id);
CREATE INDEX friendship_friend_id_status_id_idx ON friendship(friend_id, status_id);


-- likes
-- Тип объекта и id объекта
CREATE INDEX likes_target_type_id_target_id_idx ON likes(target_type_id, target_id);
-- Индексирование по пользователям (для аналитики по активности). 
-- Хотя возможно и не нужно, т.к. в данной таблице пользователь объект, а не субъект
CREATE INDEX likes_user_id_idx ON likes(user_id);


-- posts
-- Индексирование по пользователям и дате создания
CREATE INDEX posts_user_id_created_at_idx ON posts(user_id, created_at);


-- communities_users
-- Индексация по группам, для получения пользоватей в них
CREATE INDEX communities_users_community_id_idx ON communities_users(community_id);
-- Индексация по пользователям для получения списка групп, в которых состоит пользователь
CREATE INDEX communities_users_users_id_idx ON communities_users(user_id);

