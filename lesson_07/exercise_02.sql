-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.id, 
	p.name,
	p.catalog_id, 
	c.name AS 'catalogs'
	FROM products AS p 
	JOIN catalogs AS c 
	ON p.catalog_id = c.id;


