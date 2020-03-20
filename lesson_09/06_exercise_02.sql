-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW prodview AS SELECT 
	p.name, 
	c.name AS catalogs 
		FROM products AS p 
		LEFT JOIN catalogs AS c 
			ON p.catalog_id = c.id;

SELECT * FROM prodview;

