--day4
--[����]
-- ��ǰ���̺�� ����ǰ�з����̺��� ��ǰ�з��ڵ尡 'P101' �� �Ϳ� ����
-- ��ǰ�з��ڵ� (��ǰ���̺� �ִ� �÷�), ��ǰ��, ��ǰ�з����� ��ȸ�� �ּ���.
-- ������ ��ǰ���̵�� ��������...
-- 1.���̺�
-- lprod, prod
-- 2.����
-- lprod_gu = prod_lgu
--<�Ϲݹ��>
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
   AND lprod_gu = 'P101'
 ORDER BY prod_id DESC;

--<ǥ�ع��>
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu)
 WHERE lprod_gu = 'P101'
 ORDER BY prod_id DESC;

--[����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó�ڵ�, �ŷ�ó��, ȸ����������(���� or ��õ...) ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���...
-- 1. ���̺�
-- member, cart, prod, buyer, lprod
-- 2. ����
-- buyer_id = prod_buyer, lprod_gu = prod_lgu, prod_id = cart_prod, mem_id = cart_member
--<�Ϲݹ��>
SELECT buyer_id, buyer_name, SUBSTR(mem_add1, 1, 2)
  FROM member, cart, prod, buyer, lprod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND lprod_nm LIKE '%ĳ�־�%'
   AND mem_name = '������';

--<ǥ�ع��>
SELECT buyer_id, buyer_name, SUBSTR(mem_add1, 1, 2)
  FROM member INNER JOIN cart
                ON(mem_id = cart_member)
              INNER JOIN prod
                ON(prod_id = cart_prod)
              INNER JOIN buyer
                ON(buyer_id = prod_buyer)
              INNER JOIN lprod
                ON(lprod_gu = prod_lgu
                    AND lprod_nm LIKE '%ĳ�־�%')
 WHERE mem_name = '������';

--[����]
-- ��ǰ�з��� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��� ��ȸ�ϱ�.
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ����...
--     ȸ���� ��̰� ������ ȸ��..
--1. ���̺�
-- lprod, prod, cart, member
--2. ����
-- lprod_gu = prod_lgu, prod_id = cart_prod, cart_member = mem_id
--<�Ϲݹ��>
SELECT mem_id, mem_name, lprod_nm
  FROM lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu 
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_name LIKE '%�Ｚ����%'
   AND mem_like = '����'
   AND lprod_nm = '%����%';

--<ǥ�ع��>
SELECT mem_id, mem_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu
                    AND prod_name LIKE '%�Ｚ����%')
             INNER JOIN cart
                ON(prod_id = cart_prod)
             INNER JOIN member
                ON(cart_member = mem_id
                    AND mem_like = '����')
 WHERE lprod_nm = '%����%';

--[����]
-- ��ǰ�з����̺�� ��ǰ���̺�� �ŷ�ó���̺�� ��ٱ��� ���̺� ���..
-- ��ǰ�з��ڵ尡 'P101' �ΰ��� ��ȸ..
-- �׸���, ������ ��ǰ�з����� �������� ��������,
--                ��ǰ���̵� �������� �������� �ϼ���..
-- ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�,
-- �ֹ������� ��ȸ...
--1. ���̺�
-- lprod, prod, buyer, cart
--2. ����
-- lprod_gu = prod_lgu, prod_buyer = buyer_id, prod_id = cart_prod
--<�Ϲݹ��>
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod, prod, buyer, cart
 WHERE lprod_gu = prod_lgu
   AND prod_buyer = buyer_id
   AND prod_id = cart_prod
   AND lprod_gu = 'P101'
 ORDER BY lprod_nm DESC, prod_id ASC;

--<ǥ�ع��>
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu)
             INNER JOIN buyer
                ON(prod_buyer = buyer_id)
             INNER JOIN cart
                ON(prod_id = cart_prod)
 WHERE lprod_gu = 'P101'
 ORDER BY lprod_nm DESC, prod_id ASC;

--[����]
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�.
-- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ������ ȸ���� ���ؼ���
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����
--1. ���̺�
-- cart, prod
--2. ����
-- cart_prod = prod_id
--<�Ϲݹ��>
SELECT prod_id, 
       MAX(cart_qty) AS mq, 
       MIN(cart_qty) AS miq, 
       ROUND(AVG(cart_qty), 2) AS aq, 
       SUM(cart_qty) AS sq, 
       COUNT(cart_qty) AS cq
  FROM prod, cart
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%�Ｚ%'
 GROUP BY prod_id;

--<ǥ�ع��>
SELECT prod_id, 
       MAX(cart_qty) AS mq, 
       MIN(cart_qty) AS miq, 
       ROUND(AVG(cart_qty), 2) AS aq, 
       SUM(cart_qty) AS sq, 
       COUNT(cart_qty) AS cq
  FROM prod INNER JOIN cart
                ON( prod_id = cart_prod
                    AND prod_name LIKE '%�Ｚ%')
 GROUP BY prod_id;

--[����]
-- �ŷ�ó�ڵ� �� ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ�� �ּ���..
-- ��ȸ�÷�, �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�, ��ǰ�з���,
--           �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ�
-- ������ ����� �������� ��������
-- ��, �ǸŰ��� ����� 100 �̻��� ��
-- 1. ���̺�
-- buyer, prod, lprod
-- 2. ����
-- buyer_id = prod_buyer, prod_lgu = lprod_gu
--<�Ϲݹ��>
SELECT buyer_id, buyer_name, lprod_gu, lprod_nm, 
       MAX(prod_sale) AS ms,
       MIN(prod_sale) AS mis,
       COUNT(prod_sale) AS cs,
       ROUND(AVG(prod_sale), 2) AS "AS",
       SUM(prod_sale) AS ss
  FROM buyer, prod, lprod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
 GROUP BY buyer_id, lprod_gu, buyer_name, lprod_nm
HAVING AVG(prod_sale) >= 100
 ORDER BY "AS" DESC;

--<ǥ�ع��>
SELECT buyer_id, buyer_name, lprod_gu, lprod_nm, 
       MAX(prod_sale) AS ms,
       MIN(prod_sale) AS mis,
       COUNT(prod_sale) AS cs,
       ROUND(AVG(prod_sale), 2) AS "AS",
       SUM(prod_sale) AS ss
  FROM buyer INNER JOIN prod
                ON(buyer_id = prod_buyer)
             INNER JOIN lprod
                ON(lprod_gu = prod_lgu)
 GROUP BY buyer_id, lprod_gu, buyer_name, lprod_nm
HAVING ROUND(AVG(prod_sale), 2) >= 100
 ORDER BY "AS" DESC;

--[����]
/*
-- �ŷ�ó���� group ��� ���Աݾ��� ���� �˻��ϰ��� �մϴ�....
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����)�ΰ͵�...
-- ���Աݾ� = ���Լ��� * ���Աݾ�..
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ�����
-- (���Աݾ������� null�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������
*/
--1. ���̺�
-- buyer, prod, buyprod
--2. ����
-- buyer_id = prod_buyer, prod_id = buy_prod
--<�Ϲݹ��>
SELECT buyer_id, buyer_name, SUM(NVL(buy_qty * buy_cost, 0)) AS ASVSUM
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND buy_date BETWEEN '05/01/01' AND '05/01/31'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC;

--<ǥ�ع��>
SELECT buyer_id, buyer_name, SUM(NVL(buy_qty * buy_cost, 0)) AS ASVSUM
  FROM buyer INNER JOIN prod
                ON(buyer_id = prod_buyer)
             INNER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '05/01/01' AND '05/01/31')
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC;  

-- ���� ����� �̿��Ͽ�..
-- ���Աݾ������� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ���� �˻��ϰ��� �մϴ�.....
--1. ���̺�
-- ���͸��� ���̺�, prod
--2. ����
-- prod_buyer = buyer_id

SELECT prod_id, prod_name
  FROM (SELECT buyer_id
          FROM buyer, prod, buyprod
         WHERE buyer_id = prod_buyer
           AND prod_id = buy_prod
           AND buy_date BETWEEN '05/01/01' AND '05/01/31'
         GROUP BY buyer_id
        HAVING SUM(NVL(buy_qty * buy_cost, 0)) >= 10000000) A,
       prod
 WHERE A.buyer_id  = prod_buyer;
 
SELECT *
  FROM lprod;
 
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
 GROUP BY lprod_gu, lprod_nm;
 
--<�Ϲݹ��>
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;

--<ǥ�ع��>
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod
       LEFT OUTER JOIN prod ON(lprod_gu = prod_lgu)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;
 
--<�Ϲ�����>
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name;

--<�Ϲ� OUTER ����>
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod(+)
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;
 
--<ǥ�� OUTER ����> 
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod LEFT OUTER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;
 
--<���� ����>
SELECT B.buyer_id, B.buyer_name, B.buyer_add1 || '' || B.buyer_add2
  FROM buyer A, buyer B
 WHERE A.buyer_id = 'P30203'
   AND SUBSTR(A.buyer_add1, 1, 2) = SUBSTR(B.buyer_add1, 1, 2);
 
--[����1]  
-- 1974�� 7�� ���� 1980�� 12�� ���� �¾ ������ �����Ͽ���,
-- �ŷ�ó ����ڰ� �����ϰų� �ּҰ� �λ��� �ƴϸ�, 
-- �԰����ڰ� 4�� �̻��̰� 
-- ���Լ����� 10 �̻��̰ų� ���Դܰ��� 200000�� ������ ��ǰ �߿���
-- ũ�Ⱑ L�� ��ǰ�� 2�� ���Ե� ��ǰ�� ��ȸ�ϰ� ���ڿ� ������ 77 ���ڿ��� 32
-- ������ ���� ���� �� ��ǰ�� ��ǰ��, �ǸŰ�, ������(2��°�ڸ�����),����� 
-- 1~5� ��Ÿ���ÿ�!
-- ��, ������������ �̿��ؼ�!

-- 1. ���̺�
-- member, cart, prod, buyer, buyprod
-- 2. ����
-- mem_id = cart_member, cart_prod = prod_id, prod_buyer = buyer_id, prod_id = buy_prod
SELECT prod_name, prod_sale, salep, p_size
  FROM (SELECT prod_name, prod_sale, 
               ROUND((1 - ( prod_sale / prod_price )) * 100, 2) AS salep, 
               DECODE(prod_size,
                       '77', 'L',
                       '32', 'L',
                       'L') AS p_size
          FROM prod
         WHERE prod_buyer IN (
                SELECT buyer_id
                  FROM buyer
                 WHERE buyer_charger IS NOT NULL
                   AND SUBSTR(buyer_add1, 1, 2) != '�λ�')
           AND prod_id IN (
                SELECT buy_prod
                  FROM buyprod
                 WHERE SUBSTR(TO_CHAR(buy_date), 4, 2) >= 4
                   AND (buy_qty >= 10 OR buy_cost <= 200000))
           AND prod_id IN (
                SELECT cart_prod
                  FROM cart
                 WHERE cart_member IN (
                        SELECT mem_id
                          FROM member
                         WHERE mem_bir BETWEEN '74/07/01' AND '80/12/31'
                           AND MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0))
           AND prod_name LIKE '%2%'
           AND (prod_size = 'L' OR prod_size = '77' OR prod_size = '32')
         ORDER BY salep DESC)
 WHERE ROWNUM <= 5;

-- [����2]
-- �������� ���� �达�̰� 
-- �ŷ�ó �ּ��� ������ �̸��� ������ �����ϸ� 
--   (�����ڷ� �и��Ͽ� ��ȸ�Ͻÿ�, �ܵ� substr ��� �Ұ�)
-- �ŷ�ó �ѽ���ȣ ��� 3�ڸ��� �߿� 3�� ���� 
--   (�����ڷ� �и��Ͽ� ��ȸ�Ͻÿ�, �ܵ� substr ��� �Ұ�)
-- ���������� ����ϴ� �ŷ�ó ��ǰ�� �ű� ������� 1���̸�(to_char ��� �Ұ�)
-- �� �� ��ǰ�������� ��, ����, ����, �ܿ��� �ִ� ��ǰ�� ����, (�Һ��ڰ�-�ǸŰ�),
-- ���Լ���, ���Դܰ� ��ȸ
-- ������ (�Һ��ڰ�-�ǸŰ�), ���Լ��� �������� �������� 
 
--1. ���̺�
-- prod, buyer, buyprod, cart, member
--2. ����
-- prod_buyer = buyer_id, prod_id = buy_prod, prod_id = cart_prod, cart_member = mem_id

SELECT prod_color, prod_price - prod_sale AS margin, buy_qty, buy_cost
  FROM prod, buyer, buyprod
 WHERE prod_buyer = buyer_id
   AND prod_id = buy_prod
   AND (prod_outline LIKE '%��%' OR prod_outline LIKE '%����%' OR prod_outline LIKE '%����%' OR prod_outline LIKE '%�ܿ�%')
   AND buyer_bank = '��������'
   AND EXTRACT(MONTH FROM prod_insdate) = 1
   AND buyer_bankname LIKE '��%'
   AND SUBSTR(buyer_add1, INSTR(buyer_add1, ' ')+1) LIKE '��%'
   AND SUBSTR(buyer_fax, INSTR(buyer_fax, '-')+1, 3) LIKE '%3%'
 ORDER BY margin DESC, buy_qty DESC;