DROP DATABASE IF EXISTS vk; 

CREATE DATABASE vk;

USE vk;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(120) NOT NULL UNIQUE,
	phone_number VARCHAR(120) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Добавил таблицу со странами
CREATE TABLE countries (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	country VARCHAR(100)
);

-- Добавил таблицу с городами с ссылкой на страны, к которым относятся города
CREATE TABLE cities (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	country_id INT UNSIGNED NOT NULL, 
	city VARCHAR(100)
);

-- Добавил таблицу для определения половой принадлежности пользователя
CREATE TABLE genders (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	gender CHAR(1) NOT NULL
);

-- Название города изменено на индекс в соответствующей таблице. 
-- Убрал страну, т.к. ссылка на страну присутствует в таблице с городами. 
-- Половая принадлежность определяется индексом в соответствующей таблице
CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL,
	gender_id INT UNSIGNED NOT NULL,
	birthday DATE,
	city_id INT UNSIGNED,
	media_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

CREATE TABLE messages (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	from_user_id INT UNSIGNED NOT NULL,
	to_user_id INT UNSIGNED NOT NULL,
	body TEXT NOT NULL,
	is_important BOOLEAN,
	is_delivered BOOLEAN,
	created_at DATETIME DEFAULT NOW()
);

CREATE TABLE friendship (
	user_id INT UNIGNED NOT NULL,
	friend_id INT UNSIGNED NOT NULL,
	status_id INT UNSIGNED NOT NULL,
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
	PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE friendship_statuses (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW()
);

-- Добавлены столбцы с девизом и информацией о сообществе
-- Добавлен столбец с ссылкой на картинку группы
CREATE TABLE communities (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE,
	media_id INT UNSIGNED, 
	motto TEXT, 
	info TEXT,
	created_at DATETIME DEFAULT NOW()
);

CREATE TABLE communities_users (
	community_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (community_id, user_id)
);

CREATE TABLE media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	media_type_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	filename VARCHAR(255) NOT NULL,
	file_size INT NOT NULL,
	metadata JSON,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE media_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW()
);


