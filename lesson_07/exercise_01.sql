-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.


-- Вариант 1 (простой)

SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);


-- Вариант 2 (с использованием оператора JOIN)
-- Решил сделать JOIN четырех таблиц.
-- Выводится: имя покупателя, номер заказа, наименование товара, количество и дата создания заказа

SELECT u.name AS 'buyer', 
	o.id, 
	p.name, 
	op.total, 
	o.created_at 
		FROM products AS p
		JOIN orders_products AS op ON p.id = op.product_id
		JOIN orders AS o ON op.order_id = o.id
		JOIN users AS u ON o.user_id = u.id
	ORDER BY o.id;

