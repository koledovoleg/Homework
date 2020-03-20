-- mysql -uroot -p123456 -P3360

use shop_online;

SELECT * FROM products;

-- *** les 03 ex 01 ***
-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
UPDATE products
    SET created_at = NULL where id = 3;

UPDATE products
    SET created_at = NULL where id = 1;

UPDATE products
    SET created_at = NOW() where created_at is NULL;

UPDATE products
    SET created_at = NOW() where id = 3;
    
  
-- 2.������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� ��������
-- � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
-- 
-- �����������, ��� ��� �������� created_at � updated_at - VARCHAR(256), ���� � ���������� ����� ��� ��� ������ ����� - DATETIME,
-- c �������������� DEFAULT CURRENT_TIMESTAMP � DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP.
-- ������� ������� �������� ��� �������� � ����������� � ����������� ��.
ALTER TABLE products 
    CHANGE COLUMN `created_at` `created_at` VARCHAR(256) NULL,
    CHANGE COLUMN `updated_at` `updated_at` VARCHAR(256) NULL;

describe products;
SELECT created_at from products;

ALTER TABLE products 
    CHANGE COLUMN `created_at` `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

describe products;
SELECT created_at from products;



-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0,
-- ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������,
-- ����� ��� ���������� � ������� ���������� �������� value. ������� ������ ������ ���������� � �����, ����� ���� �������.
create table storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT '����� �������� ������� �� �������',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ �� ������';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15),
    (1, 3, 0),
    (1, 5, 10),
    (1, 7, 5),
    (1, 8, 0);

SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;
    -- storehouses_products ORDER BY IF(value > 0, 0, 1), value; // ������� �� GB



-- 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���.
-- ������ ������ � ���� ������ ���������� �������� ('may', 'august')
SELECT
    name, birthday_at, 
    CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;

SELECT
    name, birthday_at, DATE_FORMAT(birthday_at, '%m') as mounth_of_birth
FROM
    users;

-- SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%m') IN ('may', 'august'); -- // ������� �� GB - � ���������
SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august'); -- // ������� �� GB - � ���������




-- 5. (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������:
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.
-- 
-- ��� ��� ��������� � ����� id 5 � ���� ������� ���� ����� �������,
-- ������ ��� ������������ ��������� � ����� id 3 
SELECT * FROM catalogs WHERE id IN (3, 1, 2);

SELECT 
    *
FROM
    catalogs WHERE id IN (3, 1, 2) 
ORDER BY CASE
    WHEN id = 3 THEN 0
    WHEN id = 1 THEN 1
    WHEN id = 2 THEN 2
END;

-- SELECT* FROM catalogs WHERE id IN (3, 1, 2) ORDER BY FIELD(id, 3, 1, 2); // ������� �� GB