TRUNCATE TABLE sold_product;
TRUNCATE TABLE appointment;
TRUNCATE TABLE seller;
TRUNCATE TABLE sale;
TRUNCATE TABLE product;

-- 1. INSERT

-- 1) ��� �������� ������ �����
INSERT INTO product
VALUES
    ('Master Yoda', 6000, 2, 'LEGO'),
	('Princess Celestia', 1500, 10, 'Hasbro'),
	('Bumblebee', 3700, 17,  'Hasbro'),
	('Elsa', 3500, 3, 'Hasbro'),
	('Puppy Smart Stages', 3000, NULL, 'Fisher-Price'),
	('Bumblebee', 3000, 10, 'Hasbro'),
	('Elsa', 2500, 1, 'Hasbro');

INSERT INTO appointment
VALUES
    ('��������'),
	('����������� ���������'),
	('��������'),
	('������');

INSERT INTO seller
VALUES
    ('����', '�������', '10.11.1997', NULL, 1),
	('�������', '�������', '17.09.2001', NULL, 2),
	('�������', '��������', '07.10.2001', NULL, 3),
	('����������', '�������', '03.09.2004', NULL, 4),
	('A�����', '���������', '05.02.2000', NULL, 4);

SELECT * FROM product;
SELECT * FROM appointment;
SELECT * FROM seller

-- 2) � ��������� ������ �����
INSERT INTO product
    (name, manufacturer, price, quantity) 
VALUES
    ('Rey Skywalker', 'LEGO', 1300, 5);

SELECT * FROM product;

INSERT INTO sale
    (total_cost, date, seller_id)
VALUES
    (6000, '20.06.2020', 4),
	(2500, '25.06.2020', 5),
	(3300, '1.07.2020', 4);

SELECT * FROM sale;

INSERT INTO sold_product
    (sale_id, product_id)
VALUES 
    (1, 1),
	(2, 7);

SELECT * FROM sold_product;


-- 3) � ������� �������� �� ������ �������
INSERT INTO seller (appointment_id)
SELECT appointment_id
FROM appointment
WHERE appointment_id = 4;

SELECT * FROM seller;

-- 2. DELETE

-- 1) ���� �������
DELETE sold_product;

SELECT * FROM sold_product;


-- 2) �� �������
DELETE FROM product
WHERE quantity = 0 OR quantity IS NULL;

SELECT * FROM product;

-- 3) �������� �������
TRUNCATE TABLE sold_product;

SELECT * FROM sold_product;

-- 3. UPDATE

-- 1) ���� �������
UPDATE product
SET quantity = 15;

SELECT * FROM product;

-- 2) �� ������� �������� ���� �������
UPDATE product
SET price = 3300
WHERE manufacturer = 'LEGO';

SELECT * FROM product;

-- 3) �� ������� �������� ��������� ���������
UPDATE seller
SET first_name = '������', last_name = '�����', date_of_birth = '25.06.2000'
WHERE first_name IS NULL;

SELECT * FROM seller;

-- 4. SELECT

-- 1) � ������������ ������� ����������� ���������
SELECT name, price FROM product; 

-- 2)  �� ����� ����������
SELECT * FROM product; 

-- 3) � �������� �� ��������
SELECT * FROM product
WHERE  price > 3000;

-- 5. SELECT ORDER BY + TOP (LIMIT)

-- 1)  � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT TOP 3 * FROM product
ORDER BY name;

-- 2) � ����������� �� �������� DESC
SELECT * FROM product
ORDER BY price DESC;

-- 3) � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT TOP 4 * FROM product
ORDER BY name, price;

-- 4) � ����������� �� ������� ��������, �� ������ �����������
SELECT name, price
FROM product
ORDER BY 1;

-- 6. ������ � ������

-- 1) WHERE �� ����
SELECT * FROM seller
WHERE YEAR(date_of_birth) = 2000;

-- 2) ������� �� ������� �� ��� ����, � ������ ���
SELECT YEAR(date_of_birth) AS year FROM seller;

-- 7. SELECT GROUP BY � ��������� ���������

-- 1) MIN
SELECT name, MIN(price) AS min_price
FROM product GROUP BY name; 

-- 2) MAX
SELECT name, MAX(price) AS max_price
FROM product GROUP BY name; 

-- 3) AVG
SELECT quantity, AVG(price) AS avg_price
FROM product GROUP BY quantity; 

-- 4) SUM
SELECT manufacturer, SUM(price) AS sum_price
FROM product GROUP BY manufacturer; 

-- 5) COUNT
SELECT name, COUNT(*) AS all_products
FROM product GROUP BY name; 

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
HAVING AVG(quantity) >= 10;

-- 3)
SELECT name, SUM(quantity) AS sum_quantity
FROM product
GROUP BY name
HAVING AVG(price) >= 3000;

-- 9. SELECT JOIN

-- 1) LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
LEFT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
WHERE seller.appointment_id <= 4;

-- 2)  RIGHT JOIN. �������� ����� �� �������, ��� � � 9.1
SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
RIGHT OUTER JOIN appointment  ON seller.appointment_id = appointment.appointment_id
ORDER BY seller_id;

-- 3) LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������

SELECT sale_id, first_name AS seller_name, name AS appointment
FROM sale
LEFT OUTER JOIN seller on sale.seller_id = seller.seller_id
LEFT OUTER JOIN appointment ON seller.appointment_id = appointment.appointment_id
WHERE seller.seller_id = 4;

-- 4) FULL OUTER JOIN ���� ������
SELECT seller_id, first_name, last_name, name AS appointment
FROM seller
FULL OUTER JOIN appointment 
ON seller.appointment_id = appointment.appointment_id
WHERE seller.appointment_id >= 3;


-- 10. ����������

-- 1) �������� ������ � WHERE IN (���������)
SELECT name FROM product
WHERE name IN (SELECT name FROM product WHERE price < 2000);

-- 2) �������� ������ SELECT atr1, atr2, (���������) FROM ...    
SELECT seller_id, first_name, last_name, (SELECT name FROM appointment WHERE appointment_id = 2) as appointment
FROM seller WHERE seller.appointment_id = 2;