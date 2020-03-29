-- 1. INSERT

-- 1) ��� �������� ������ �����
INSERT INTO product
VALUES
    ('Master Yoda', 6000, 2, '05.02.18', 'LEGO'),
	('Princess Celestia', 1500, 10, NULL, 'Hasbro'),
	('Bumblebee', 3700, 17, NULL, 'Hasbro'),
	('Elsa', 3500, 3, '13.02.2020', 'Hasbro'),
	('Puppy Smart Stages', 3000, 1, NULL, 'Fisher-Price');	

INSERT INTO seller
VALUES
    ('������', '�����', '01.03.1998', NULL, 1),
	('�������', '�������', '17.09.2001', NULL, 2),
	('�������', '��������', '07.10.2001', NULL, 3),
	('����������', '�������', '03.09.2004', NULL, 4);

-- 2) � ��������� ������ �����
INSERT INTO product
    (name, manufacturer, price, quantity) 
VALUES
    ('Rey Skywalker', 'LEGO', 1300, 5);

SELECT * FROM seller
-- 3) � ������� �������� �� ������ �������
INSERT INTO seller (appointment_id)
SELECT appointment_id
FROM appointment
WHERE appointment_id = 3;

-- 2. DELETE

-- 1) ���� �������
DELETE product

-- 2) �� �������
DELETE FROM product
WHERE quantity = 0 OR quantity IS NULL;

-- 3) �������� �������
TRUNCATE TABLE sold_product;

-- 3. UPDATE

-- 1) ���� �������
UPDATE product
SET quantity = 15;

-- 2) �� ������� �������� ���� �������
UPDATE product
SET price = 3300
WHERE name = 'Elsa';

-- 3) �� ������� �������� ��������� ���������
UPDATE seller
SET first_name = '����', last_name = '�������', date_of_birth = '10.11.1997'
WHERE first_name IS NULL;

-- 4. SELECT

-- 1) � ������������ ������� ����������� ���������
SELECT name, price FROM product; 

-- 2)  �� ����� ����������
SELECT * FROM product; 

-- 3) � �������� �� ��������
SELECT * FROM product
WHERE  price > 1000;

-- 5. SELECT ORDER BY + TOP (LIMIT)

-- 1)  � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT TOP 5 * FROM product
ORDER BY name;

-- 2) � ����������� �� �������� DESC
SELECT * FROM product
ORDER BY price DESC;

-- 3) � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT TOP 10 * FROM product
ORDER BY name, price;

-- 4) � ����������� �� ������� ��������, �� ������ �����������
SELECT name, price
FROM product
ORDER BY 1;

-- 6. ������ � ������

-- 1) WHERE �� ����
SELECT * FROM product
WHERE YEAR(date) = 2018;

-- 2) ������� �� ������� �� ��� ����, � ������ ���
SELECT YEAR(date) FROM product

-- 7. SELECT GROUP BY � ��������� ���������

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

-- 1) LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
LEFT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
WHERE seller.appointment_id <= 4;

-- 2)  RIGHT JOIN. �������� ����� �� �������, ��� � � 5.1
SELECT TOP 5 seller_id, first_name, last_name, name AS appointment
FROM seller
RIGHT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
ORDER BY last_name;

-- 3) LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������

SELECT sale_id, last_name AS seller_name, name AS product_name, amount
FROM sale LEFT OUTER JOIN product ON sale.product_id = product.product_id
LEFT OUTER JOIN seller  ON sale.seller_id = seller.seller_id
WHERE seller.appointment_id = 4 AND amount > 1 AND sale.total_cost > 1000;

-- 4) FULL OUTER JOIN ���� ������
(SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
LEFT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id)
UNION ALL
(SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
RIGHT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
WHERE seller_id IS NULL)

-- 10. ����������

-- 1) �������� ������ � WHERE IN (���������)
SELECT name FROM product
WHERE name IN (SELECT name FROM product WHERE quantity = 5);

-- 2) �������� ������ SELECT atr1, atr2, (���������) FROM ...    
SELECT seller_id, first_name, last_name, (SELECT appointment_id FROM appointment WHERE appointment_id = 2) as appointment
FROM seller WHERE seller.appointment_id = 2;