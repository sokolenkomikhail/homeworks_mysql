-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE flights (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	departure VARCHAR(255) NOT NULL,
	destination VARCHAR(255) NOT NULL
);

CREATE TABLE cities (
	label VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL
);


INSERT INTO flights (departure, destination)
	VALUES 
	('moscow', 'omsk'), 
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan')
;
	

INSERT INTO cities 
	VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск')
;

-- тут пришлось попотеть, но решение нашлось. 
-- сначала думал, что невозможно решить с JOIN

SELECT f.id, 
	dep_c.name AS 'from', 
	dest_c.name AS 'to'
		FROM cities AS dep_c 
		JOIN flights AS f ON dep_c.label = f.departure 
		JOIN cities AS dest_c ON f.destination = dest_c.label 
	ORDER BY f.id;

