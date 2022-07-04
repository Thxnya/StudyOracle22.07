--day2

SELECT *
  FROM member;
  
-- ��̰� ������ ȸ���� �߿�
-- ���ϸ����� ���� 1000 �̻���
-- ȸ�����̵�, ȸ���̸�, ȸ�����, ȸ�����ϸ��� ��ȸ
-- ������ ȸ���̸� ���� ��������

SELECT mem_id, mem_name, mem_like, mem_mileage
  FROM member
 WHERE mem_like = '����' 
   AND mem_mileage >= 1000
 ORDER BY mem_id ASC;
 
-- ������ ȸ���� ������ ��̸� ������
-- ȸ�� ���̵�, ȸ���̸�, ȸ����� ��ȸ�ϱ�...
 
SELECT mem_id, mem_name, mem_like
  FROM member
 WHERE mem_like = (SELECT mem_like
                     FROM member
                    WHERE mem_name = '������');
                    
-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ����� ��ȸ�ϱ�

SELECT cart_member,
       (SELECT mem_name
          FROM member
         WHERE mem_id = cart_member) as name,
       cart_no, 
       cart_qty
  FROM cart;
  
-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ�����, ��ǰ�� ��ȸ�ϱ�

SELECT cart_member,
       (SELECT mem_name
          FROM member
         WHERE mem_id = cart_member) as name,
       cart_no, 
       cart_qty,
       (SELECT prod_name
          FROM prod
         WHERE prod_id = cart_prod) as prod_name
  FROM cart;
  
-- a001 ȸ���� �ֹ��� ��ǰ�� ����
-- ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ�ϱ�..

SELECT DISTINCT prod_lgu,
       (SELECT lprod_nm
          FROM lprod
         WHERE lprod_gu = prod_lgu) as lprod_nm
  FROM prod
 WHERE prod_id IN (SELECT cart_prod
                     FROM cart
                    WHERE cart_member = 'a001');

SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu
                      FROM prod
                     WHERE prod_id IN (SELECT cart_prod
                                         FROM cart
                                        WHERE cart_member = 'a001'));

-- �̻��� ��� ȸ���� �ֹ��� ��ǰ �߿�
-- ��ǰ�з��ڵ尡 P201�̰�,
-- �ŷ�ó�ڵ尡 P20101��
-- ��ǰ�ڵ�, ��ǰ���� ��ȸ�� �ּ���..

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_lgu = 'P201' 
   AND prod_buyer = 'P20101'
   AND prod_id IN (SELECT cart_prod
                     FROM cart
                    WHERE cart_member = (SELECT mem_id
                                           FROM member
                                          WHERE mem_name = '�̻���'));
   
-- ��������(SubQuery) ����
-- (���1) Select ��ȸ �÷� ��ſ� ����ϴ� ���
--      : ���� �÷��� �����ุ ��ȸ

-- (���2) Where ���� ����ϴ� ���
--     In () : �����÷��� ������ �Ǵ� ������ ��ȸ ����
--     =     : �����÷��� �����ุ ��ȸ ����

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '��%';

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '_��%';

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '%ġ';

SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_nm LIKE '%ȫ\%' ESCAPE '\';
 
SELECT 'a' || 'bcde'
  FROM dual;

SELECT mem_id || ' name is ' || mem_name
  FROM member;

SELECT '<' || TRIM('    AAA    ') || '>' TRIM1,
       '<' || TRIM(LEADING 'a' from 'aaAaBaAaa') || '>' TRIM2,
       '<' || TRIM('a' FROM 'aaAaBaAaa') || '>' TRIM3
  FROM dual;

SELECT mem_id, SUBSTR(mem_name, 1, 1) ����
  FROM member;
  
-- ��ǰ���̺��� ��ǰ���� 4° �ڸ����� 2���ڰ� 'Į��'�� ��ǰ��
-- ��ǰ�ڵ�, ��ǰ���� �˻��Ͻÿ�..

SELECT prod_id, prod_name
  FROM prod
 WHERE SUBSTR(prod_name, 4, 2) = 'Į��';
 
SELECT buyer_name, REPLACE(buyer_name, '��', '��') "��->��"
  FROM buyer;
  
-- ȸ�����̺��� ȸ������ �� '��'�� ���� -> '��'�� ������ ġȯ �˻��Ͻÿ�
-- ������ �ٲ� �� �̸� ��ȸ..
SELECT REPLACE(SUBSTR(mem_name, 1, 1), '��', '��') || 
               SUBSTR(mem_name, 2) AS mem_name
  FROM member;

-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�.
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��...
-- �׸���, ȸ���� ��̰� ������ ȸ��..

SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '����'
   AND mem_id in (SELECT cart_member
                   FROM cart
                   WHERE cart_prod IN (SELECT prod_id
                                         FROM prod
                                        WHERE prod_name LIKE '%�Ｚ����%'
                                          AND prod_lgu IN (SELECT lprod_gu
                                                             FROM lprod
                                                            WHERE lprod_nm LIKE '%����%')));

-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
-- (�Ҽ�3°�ڸ� �ݿø�, ����)
SELECT mem_mileage,
       ROUND(mem_mileage / 12, 2),
       TRUNC(mem_mileage / 12, 2)
  FROM member;

SELECT MOD(10,3)
  FROM dual;

SELECT mem_id, 
       mem_name, 
       MOD(SUBSTR(mem_regno2, 1, 1), 2) AS gender
  FROM member;

SELECT SYSDATE AS "����ð�",
       SYSDATE - 1 AS "���� �̽ð�",
       SYSDATE + 1 AS "���� �̽ð�"
  FROM dual;

-- ȸ�����̺��� ���ϰ� 12000��° �Ǵ� ���� �˻��Ͻÿ�..
SELECT mem_name, mem_bir, mem_bir + 12000
  FROM member;

SELECT ADD_MONTHS(SYSDATE, 5)
  FROM dual;

SELECT NEXT_DAY(SYSDATE, '������'),
       LAST_DAY(SYSDATE)
  FROM dual;

-- �̹����� ��ĥ�� ���Ҵ��� �˻��Ͻÿ�
SELECT LAST_DAY(SYSDATE) - SYSDATE AS "�̹��� ���� ��¥"
  FROM dual;

SELECT ROUND(SYSDATE, 'YYYY'),
       ROUND(SYSDATE, 'q')
  FROM dual;

SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
       EXTRACT(MONTH FROM SYSDATE) "��",
       EXTRACT(DAY FROM SYSDATE) "��"
  FROM dual;

-- ������ 3���� ȸ���� �˻��Ͻÿ�...
SELECT *
  FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;
 
-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000, 
--   00-00-00,   00/00/00,  00.00.00
SELECT CAST('1997/12/25' AS DATE) 
  FROM dual;
 
SELECT '[' || CAST('Hello' AS CHAR(30)) || ']' "����ȯ"
  FROM dual;

SELECT '[' || CAST('Hello' AS VARCHAR(30)) || ']' "����ȯ"
  FROM dual;

SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC"����"')
  FROM dual;

SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
                'YYYY.MM.DD HH24:MI')
  FROM dual;
  
-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻��Ͻÿ�..
SELECT TO_CHAR(prod_insdate, 'YYYY-MM-DD')
  FROM prod;

-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�.
SELECT mem_name || '���� ' || TO_CHAR(mem_bir, 'YYYY"��" MM"�� ����̰� �¾ ������" ') || TO_CHAR(mem_bir, 'DAY')
  FROM member;

SELECT TO_CHAR(1234.6, '99,999.00'),
       TO_CHAR(1234.6, '9999.99'),
       TO_CHAR(1234.6, '9,999,999,999,999.99')
  FROM dual;

SELECT TO_CHAR(1234.6, 'L9999.00PR'),
       TO_CHAR(-1234.6, 'L9999.00PR')
  FROM dual;

-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�..
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer IN (SELECT buyer_id
                        FROM buyer
                       WHERE buyer_add1 LIKE '%����%')
   AND prod_lgu IN (SELECT lprod_gu
                      FROM lprod
                     WHERE lprod_nm LIKE '%����%')
   AND prod_id IN (SELECT cart_prod
                     FROM cart
                    WHERE cart_member IN (SELECT mem_id
                                            FROM member
                                           WHERE MOD(SUBSTR(mem_regno2, 1, 1), 2) = 0));
   
SELECT ROUND(AVG(DISTINCT prod_cost), 2),
       ROUND(AVG(ALL prod_cost), 2),
       ROUND(AVG(prod_cost), 2) "���԰� ���"
  FROM prod;
   
SELECT COUNT(DISTINCT prod_cost),
       COUNT(ALL prod_cost),
       COUNT(prod_cost)
  FROM prod;
  
-- ȸ�����̺��� ������ COUNT���� �Ͻÿ�...
SELECT mem_job,
       COUNT(mem_job),
       COUNT(*)
  FROM member
 GROUP BY mem_job;

-- �׷�(����) �Լ��� ����ϴ� ��쿡��
--  - GROUP BY ���� ������� �ʾƵ� ��..
-- ��ȸ�� �Ϲ��÷��� ���Ǵ� ��쿡�� GROUP BY���� ����ؾ� �մϴ�.
--  - GROUP BY ������ ��ȸ�� ���� �Ϲ��÷��� ������ �־� �ݴϴ�.
--  - �Լ��� ����� ��쿡�� �Լ��� ����� ���� �״�θ� �־� �ݴϴ�.
-- ORDER BY���� ����ϴ� �Ϲ��÷� �Ǵ� �Լ��� �̿��� �÷���
--  - ������ GROUP BY���� �־� �ݴϴ�.
-- SUM(), AVG(), MIN(), MAX(), COUNT()
SELECT mem_job, 
       mem_like, 
       COUNT(mem_job) AS cnt1, 
       COUNT(*) AS cnt2
  FROM member
 WHERE mem_mileage > 10
   AND mem_mileage < 9999999999
 GROUP BY mem_job, mem_like
 ORDER BY cnt1 DESC;

-- ������ ��̷��ϴ� ȸ������
-- �ַ� �����ϴ� ��ǰ�� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ��ǰ���� COUNT �����մϴ�.
-- ��ȸ�÷�, ��ǰ��, ��ǰ COUNT
-- ������ ��ǰ�ڵ带 �������� ��������.
SELECT prod_name, 
       COUNT(prod_name)
  FROM prod
 WHERE prod_id IN (SELECT cart_prod
                     FROM cart
                    WHERE cart_member IN (SELECT mem_id
                                            FROM member
                                           WHERE mem_like = '����'))
 GROUP BY prod_name, prod_id
 ORDER BY prod_id DESC;