-- day3
-- [��ȸ ��� ����]

-- 1. ���̺� ã��
--  - ���õ� �÷����� �Ҽ� ã��
-- 2. ���̺� ���� ���� ã��
--  - ERD���� ����� ������� PK�� FK�÷� �Ǵ�,
--  - ������ ���� ������ ������ �� �ִ� �÷� ã��
-- 3. �ۼ� ���� ���ϱ�
--  - ��ȸ�ϴ� �÷��� ���� ���̺��� ���� ��..1����..
--  - 1���� ���̺���� ERD ������� �ۼ�..
--  - ������ : �ش� �÷��� ���� ���̺��� ���� ó��..

-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�.
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��...
--      �׸���, ȸ���� ��̰� ������ ȸ��..
SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '����'
   AND mem_id IN (
                  SELECT cart_member
                    FROM cart
                   WHERE cart_prod IN (
                                       SELECT prod_id
                                         FROM prod
                                        WHERE prod_name LIKE '%�Ｚ����%'
                                          AND prod_lgu IN (
                                                          SELECT lprod_gu
                                                            FROM lprod
                                                           WHERE lprod_nm LIKE '%����%')));

-- [����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó�ڵ�, �ŷ�ó��, ����(���� or ��õ...), �ŷ�ó ��ȭ��ȣ ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���....

SELECT buyer_id, buyer_name, SUBSTR(buyer_add1, 1, 2) as buyer_region, buyer_comtel
  FROM buyer
 WHERE buyer_lgu IN (
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_nm LIKE '%ĳ�־�%'
           AND lprod_gu IN (
                SELECT prod_lgu
                  FROM prod
                 WHERE prod_id IN (
                        SELECT cart_prod
                          FROM cart
                         WHERE cart_member IN (
                                SELECT mem_id
                                  FROM member
                                 WHERE mem_name = '������'))));
        
-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�....
-- 1. ���̺�ã��
-- member, lprod, buyer, *prod*, cart
-- 2. ����ã��
-- prod_id = cart_prod, cart_member = mem_id 
-- prod_lgu = lprod_gu
-- prod_buyer = buyer_id
-- 3. ����
-- MOD(SUBSTR(mem_regno2, 1, 1)) = 0
-- lprod_nm LIKE '%����%'
-- buyer_add1 LIKE '%����%'

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_id IN (
        SELECT cart_prod
          FROM cart
         WHERE cart_member IN (
                SELECT mem_id
                  FROM member
                 WHERE MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0))
   AND prod_lgu IN (
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_nm LIKE '%����%')
   AND prod_buyer IN (
        SELECT buyer_id
          FROM buyer
         WHERE buyer_add1 LIKE '%����%');

-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�.
SELECT cart_prod, 
       MAX(cart_qty) AS MAX_qty, 
       MIN(cart_qty) AS MIN_qty, 
       ROUND(AVG(cart_qty), 2) AS AVG_qty, 
       SUM(cart_qty) AS SUM_qty, 
       COUNT(cart_qty) AS COUNT_qty
  FROM cart
 GROUP BY cart_prod;

-- ������ 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻��� 
-- �߰��ֹ���ȣ�� �˻��Ͻÿ�..
SELECT MAX(cart_no) AS mno, 
       MAX(cart_no) + 1 AS mpno
  FROM cart
 WHERE SUBSTR(cart_no, 1, 8) = '20050711';

-- ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�,
-- �ְ� ���ϸ���, �ּ� ���ϸ���, �ο����� �˻��Ͻÿ�
-- ��ȸ�÷��� ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���
SELECT ROUND(AVG(mem_mileage), 2) AS AVG_MILE, 
       SUM(mem_mileage) AS SUM_MILE, 
       MAX(mem_mileage) AS MAX_MILE, 
       MIN(mem_mileage) AS MIN_MILE, 
       COUNT(mem_id) AS COUNT_MEM
  FROM member;

-- [����]
-- ��ǰ���̺��� �ŷ�ó��, ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ�� �ּ���..
-- ������ �ڷ���� �������� ��������
-- �߰���, �ŷ�ó��, ��ǰ�з��� ��ȸ..
SELECT prod_buyer, 
       (SELECT DISTINCT buyer_name
          FROM buyer
         WHERE buyer_id = prod_buyer) AS buyer_name,
       prod_lgu,
       (SELECT DISTINCT lprod_nm
          FROM lprod
         WHERE lprod_gu = prod_lgu) AS lprod_nm,
       MAX(prod_sale) AS ms, 
       MIN(prod_sale) AS mis, 
       COUNT(prod_id) AS cs, 
       ROUND(AVG(prod_sale), 2) AS "AS", 
       SUM(prod_sale) AS ss
  FROM prod
 GROUP BY prod_buyer, prod_lgu
HAVING SUM(prod_sale) >= 100
 ORDER BY cs DESC;

UPDATE buyer SET buyer_charger = NULL
 WHERE buyer_charger LIKE '��%';

UPDATE buyer SET buyer_charger = ''
 WHERE buyer_charger LIKE '��%';

SELECT buyer_charger
  FROM buyer
 WHERE buyer_charger IS NULL;

SELECT buyer_charger
  FROM buyer
 WHERE buyer_charger IS NOT NULL;
 
SELECT buyer_name, NVL(buyer_charger, '����')
  FROM buyer;

SELECT DECODE(SUBSTR(prod_lgu, 1, 2),
              'P1', '��ǻ��/���� ��ǰ',
              'P2', '�Ƿ�',
              'P3', '��ȭ', 
              '��Ÿ')
  FROM prod;

SELECT prod_id, prod_name, prod_lgu
  FROM prod
 WHERE EXISTS (
        SELECT *
          FROM lprod
         WHERE lprod_gu = prod_lgu);

SELECT *
  FROM lprod, prod;

SELECT *
  FROM lprod
 CROSS JOIN prod;
 
-- INNER JOIN ����
-- PK�� FK�� �־�� �մϴ�.
-- �������� ���� : PK = FK
-- ���������� ���� : FROM���� ���õ� (���̺��� ���� - 1��)
-- <�Ϲݹ��>
SELECT prod.prod_id,
       prod.prod_name,
       lprod.lprod_nm,
       buyer_name,
       cart_qty,
       mem_name
  FROM lprod, prod, buyer, cart, member
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND mem_id = 'a001';
   
-- <ǥ�ع��>
SELECT prod.prod_id,
       prod.prod_name,
       lprod.lprod_nm,
       buyer_name,
       cart_qty,
       mem_name
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_Lgu)
             INNER JOIN buyer
                ON(buyer_id = prod_buyer)
             INNER JOIN cart
                ON(prod_id = cart_prod)
             INNER JOIN member
                ON(mem_id = cart_member
                    AND mem_id = 'a001');

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��,
-- �ŷ�ó�ּҸ� ��ȸ.
--1) �ǸŰ����� 10���� ���� �̰�
--2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
-- �Ϲݹ��, ǥ�ع��..��� �غ���..

--1.���̺� ã��.
-- prod, lprod, buyer
--2.�������ǽ� ã��
-- lprod_gu = prod_lgu
-- buyer_id = prod_buyer
--3.���� ���ϱ�..
-- <�Ϲݹ��>
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM lprod, prod, buyer
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_sale <= 100000
   AND buyer_add1 LIKE '%�λ�%';
   
-- <ǥ�ع��>   
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM lprod INNER JOIN prod
                 ON(lprod_gu = prod_lgu
                    AND prod_sale <= 100000)
             INNER JOIN buyer
                 ON(buyer_id = prod_buyer
                    AND buyer_add1 LIKE '%�λ�%');

--[����]
--��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
-- ��, ��ǰ�з� �ڵ尡 P101, P201, P301�� ��
--     ���Լ����� 15�� �̻��� ��
--     ���￡ ��� �ִ� ȸ�� �߿� ������ 1974����� ȸ��
-- ������ ȸ�����̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲݹ��, ǥ�ع��..
--1. ���̺�
-- prod, buyprod, cart, buyer, lprod, member
--2. ����
-- prod_id = buy_prod
-- prod_id = cart_prod
-- cart_member = mem_id
-- prod_buyer = buyer_id
-- prod_lgu = lprod_gu
--3. ����
--<�Ϲݹ��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM prod, buyprod, cart, buyer, lprod, member
 WHERE prod_id = buy_prod
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_buyer = buyer_id
   AND prod_lgu = lprod_gu
   AND prod_lgu IN ('P101', 'P201', 'P301')
   AND buy_qty >= 15
   AND mem_bir BETWEEN '74/01/01' AND '74/12/31'
   AND mem_add1 LIKE '����%'
 ORDER BY mem_id DESC, buy_qty ASC;
   
--<ǥ�ع��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM prod INNER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_qty >= 15)
            INNER JOIN cart
                ON(prod_id = cart_prod)
            INNER JOIN buyer
                ON(prod_buyer = buyer_id)
            INNER JOIN lprod
                ON(prod_lgu = lprod_gu
                    AND lprod_gu IN ('P101', 'P201', 'P301'))
            INNER JOIN member
                ON(cart_member = mem_id
                    AND mem_bir BETWEEN '74/01/01' AND '74/12/31'
                    AND mem_add1 LIKE '����%')
 ORDER BY mem_id DESC, buy_qty ASC;
 
 
 
 
SELECT *
  FROM member;
  
SELECT *
  FROM buyer;

SELECT *
  FROM prod;
-- 1�� ����
--���ݱ��� ȸ������ �����ߴ� ��ǰ���� ���ݿ� �� 5%�� ���ϸ����� �������ִ� �̺�Ʈ�� �Ѵٰ� �մϴ�.
--��ǰ ���̺��� ��ǰ ���ϸ��� ������Ʈ(�ǸŰ��� 5%)��Ű�� �� �÷��� �̿��Ͽ�,
--������� ������ ��ǰ ������ŭ ���ϸ����� ����, ������ �ִ� ���ϸ����� ���ؼ� ȸ����ȣ ���� ���� ������ �����ֱ�
--��ȸ�ϴ� �÷��� ȸ����ȣ, ȸ����, ������ �ִ� ���ϸ���, 
--�̺�Ʈ�� �����Ǵ� ���ϸ���(�÷����� eve_mile�� ��Ī), ���� ���ϸ���(�÷����� total�� ��Ī)
--ȸ����ȣ ������ �������� ����

--1) ���̺�
--member, cart, prod
--2) ����
--prod_id = cart_prod
--cart_member = mem_id

UPDATE prod SET prod_mileage = prod_sale * 0.05;

SELECT mem_id, mem_name, mem_mileage, SUM(prod_mileage * cart_qty) AS eve_mile, mem_mileage + SUM(prod_mileage * cart_qty) AS total
  FROM member, cart, prod
 WHERE prod_id = cart_prod
   AND cart_member = mem_id
 GROUP BY mem_id, mem_name, mem_mileage
 ORDER BY mem_id ASC;
 
 
SELECT cart_qty, prod_sale, prod_sale * cart_qty AS total
  FROM cart, prod
 WHERE prod_id = cart_prod
 ORDER BY total;
