-- 1. INSERT

-- 1) Без указания списка полей
INSERT INTO product
VALUES
    ('Master Yoda', 6000, 2, '05.02.18', 'LEGO'),
	('Princess Celestia', 1500, 10, NULL, 'Hasbro'),
	('Bumblebee', 3700, 17, NULL, 'Hasbro'),
	('Elsa', 3500, 3, '13.02.2020', 'Hasbro'),
	('Puppy Smart Stages', 3000, 1, NULL, 'Fisher-Price');	

INSERT INTO seller
VALUES
    ('Кирилл', 'Панин', '01.03.1998', NULL, 1),
	('Дмитрий', 'Калинин', '17.09.2001', NULL, 2),
	('Дмитрий', 'Гриценко', '07.10.2001', NULL, 3),
	('Александра', 'Шумкина', '03.09.2004', NULL, 4);

-- 2) С указанием списка полей
INSERT INTO product
    (name, manufacturer, price, quantity) 
VALUES
    ('Rey Skywalker', 'LEGO', 1300, 5);

SELECT * FROM seller
-- 3) С чтением значения из другой таблицы
INSERT INTO seller (appointment_id)
SELECT appointment_id
FROM appointment
WHERE appointment_id = 3;

-- 2. DELETE

-- 1) Всех записей
DELETE product

-- 2) По условию
DELETE FROM product
WHERE quantity = 0 OR quantity IS NULL;

-- 3) Очистить таблицу
TRUNCATE TABLE sold_product;

-- 3. UPDATE

-- 1) Всех записей
UPDATE product
SET quantity = 15;

-- 2) По условию обновляя один атрибут
UPDATE product
SET price = 3300
WHERE name = 'Elsa';

-- 3) По условию обновляя несколько атрибутов
UPDATE seller
SET first_name = 'Юлия', last_name = 'Пронина', date_of_birth = '10.11.1997'
WHERE first_name IS NULL;

-- 4. SELECT

-- 1) С определенным набором извлекаемых атрибутов
SELECT name, price FROM product; 

-- 2)  Со всеми атрибутами
SELECT * FROM product; 

-- 3) С условием по атрибуту
SELECT * FROM product
WHERE  price > 1000;

-- 5. SELECT ORDER BY + TOP (LIMIT)

-- 1)  С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT TOP 5 * FROM product
ORDER BY name;

-- 2) С сортировкой по убыванию DESC
SELECT * FROM product
ORDER BY price DESC;

-- 3) С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT TOP 10 * FROM product
ORDER BY name, price;

-- 4) С сортировкой по первому атрибуту, из списка извлекаемых
SELECT name, price
FROM product
ORDER BY 1;

-- 6. Работа с датами

-- 1) WHERE по дате
SELECT * FROM product
WHERE YEAR(date) = 2018;

-- 2) Извлечь из таблицы не всю дату, а только год
SELECT YEAR(date) FROM product

-- 7. SELECT GROUP BY с функциями агрегации

-- 1) MIN
SELECT name, MIN(price) AS min_price
FROM product GROUP BY name; 

-- 2) MAX
SELECT date, MAX(price) AS max_price
FROM product GROUP BY date; 

-- 3) AVG
SELECT quantity, AVG(price) AS avg_price
FROM product GROUP BY quantity; 

-- 4) SUM
SELECT manufacturer, SUM(price) AS sum_price
FROM product GROUP BY manufacturer; 

-- 5) COUNT
SELECT name, COUNT(*) AS all_products
FROM product 
GROUP BY name; 

-- 8. SELECT GROUP BY + HAVING

-- 1)
SELECT name, COUNT(*) AS all_products
FROM product
GROUP BY name
HAVING COUNT(*) >= 2;

-- 2)
SELECT name, SUM(price) AS sum_price
FROM product
GROUP BY name
HAVING name = 'Elsa';

-- 3)
SELECT YEAR(date), MAX(price) AS max_price
FROM product
GROUP BY YEAR(date)
HAVING YEAR(date) IS NOT NULL;

-- 9. SELECT JOIN

-- 1) LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
LEFT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
WHERE seller.appointment_id <= 4;

-- 2)  RIGHT JOIN. Получить такую же выборку, как и в 5.1
SELECT TOP 5 seller_id, first_name, last_name, name AS appointment
FROM seller
RIGHT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
ORDER BY last_name;

-- 3) LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы

SELECT sale_id, last_name AS seller_name, name AS product_name, amount
FROM sale LEFT OUTER JOIN product ON sale.product_id = product.product_id
LEFT OUTER JOIN seller  ON sale.seller_id = seller.seller_id
WHERE seller.appointment_id = 4 AND amount > 1 AND sale.total_cost > 1000;

-- 4) FULL OUTER JOIN двух таблиц
(SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
LEFT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id)
UNION ALL
(SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
RIGHT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
WHERE seller_id IS NULL)

-- 10. Подзапросы

-- 1) Написать запрос с WHERE IN (подзапрос)
SELECT name FROM product
WHERE name IN (SELECT name FROM product WHERE quantity = 5);

-- 2) Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...    
SELECT seller_id, first_name, last_name, (SELECT appointment_id FROM appointment WHERE appointment_id = 2) as appointment
FROM seller WHERE seller.appointment_id = 2;