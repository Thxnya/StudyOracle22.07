CREATE TABLE lprod
(
    lprod_id number(5) NOT NULL,
    lprod_gu char(4) NOT NULL,
    lprod_nm varchar2(40) NOT NULL,
    CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu)
);

SELECT * 
  FROM lprod;
  
INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1, 'p101', '��ǻ����ǰ');
INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1, 'p102', '��ǻ����ǰ');
     
SELECT lprod_gu, lprod_nm
  FROM lprod;
  
commit;
rollback;

-- ȸ������ ���̺�
SELECT *
  FROM member;

-- �ֹ��������� ���̺�
SELECT *
  FROM cart;

-- ��ǰ���� ���̺�
SELECT *
  FROM prod;

-- ��ǰ�з����� ���̺�
SELECT *
  FROM lprod;
  
-- �ŷ�ó���� ���̺�
SELECT *
  FROM buyer;
  
-- �԰��ǰ����(���) ���̺�
SELECT *
  FROM buyprod;
  
-- ȸ�����̺��� ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�..
SELECT mem_id, mem_name
  FROM member;
  
-- ��ǰ�ڵ�� ��ǰ�� ��ȸ�ϱ�..
SELECT prod_id, prod_name
  FROM prod;
  
-- ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ� ��ȸ�ϱ�
-- ��, �Ǹűݾ�=�ǸŴܰ� * 55 �� ����ؼ� ��ȸ�մϴ�.
-- �Ǹűݾ��� 4�鸸 �̻��� �����͸� ��ȸ�ϱ�...
-- ������ �Ǹűݾ��� �������� ��������
-- SELECT > FROM ���̺� > WHERE > �÷���ȸ > ORDER BY

SELECT prod_id, prod_name, (prod_sale*55) AS prod_sale
  FROM prod
 WHERE (prod_sale * 55) >= 4000000
 ORDER BY (prod_sale * 55) DESC;
  
-- ��ǰ�������� �ŷ�ó�ڵ带 ��ȸ�� �ּ���...
-- ��, �ߺ��� �����ϰ� ��ȸ���ּ���..
SELECT DISTINCT prod_buyer
  FROM prod;
 
-- ��ǰ�߿� �ǸŰ����� 17������ ��ǰ ��ȸ�ϱ�..
SELECT *
  FROM prod
 WHERE prod_sale = 170000;
  
-- ��ǰ�߿� �ǸŰ����� 17������ �ƴ� ��ǰ ��ȸ�ϱ�..
SELECT *
  FROM prod
 WHERE prod_sale != 170000;
 
-- ��ǰ�߿� �ǸŰ����� 17������ �̻��̰� 20���� ������ ��ǰ ��ȸ�ϱ�..
SELECT *
  FROM prod
 WHERE prod_sale >= 170000 AND prod_sale <= 200000; 
  
-- ��ǰ�߿� �ǸŰ����� 17������ �̻� �Ǵ� 20���� ������ ��ǰ ��ȸ�ϱ�.. 
SELECT *
  FROM prod
 WHERE prod_sale >= 170000 OR prod_sale <= 200000;  
 
-- ��ǰ �ǸŰ����� 10���� �̻� �̰�,,
-- ��ǰ �ŷ�ó(���޾�ü) �ڵ尡 P30203 �Ǵ� P10201 ��
-- ��ǰ�ڵ�, �ǸŰ���, ���޾�ü �ڵ� ��ȸ�ϱ�...

SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 AND (prod_buyer = 'P30203' OR prod_buyer = 'P10201');

SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 AND prod_buyer not in ('P30203', 'P10201');
 
SELECT DISTINCT prod_buyer
  FROM prod
 ORDER BY prod_buyer ASC;


SELECT *
  FROM buyer
 WHERE buyer_id NOT IN (
                     SELECT DISTINCT prod_buyer
                      FROM prod
                    );
 
 -- �ѹ��� �ֹ��� ���� ���� ȸ�� ���̵�, �̸��� ��ȸ�� �ּ���..
SELECT mem_id, mem_name
  FROM member
 WHERE mem_id NOT IN (
                     SELECT DISTINCT cart_member
                    FROM cart
                     );
 
-- ��ǰ�з� �߿� ��ǰ������ ���� �з��ڵ常 ��ȸ�� �ּ���..
SELECT *
  FROM lprod
 WHERE lprod_gu NOT IN (
                         SELECT DISTINCT prod_lgu
                           FROM prod
                         );

-- ȸ���� ���� �߿� 75����� �ƴ� ȸ�����̵�, ���� ��ȸ�ϱ�..
-- ������ ���� ���� ��������

SELECT mem_id, mem_bir
  FROM member
 WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31'
 ORDER BY mem_bir DESC;
  
-- ȸ�� ���̵� a001�� ȸ���� �ֹ��� ��ǰ�ڵ带 ��ȸ�� �ּ���..
-- ��ȸ�÷��� ȸ�����̵�, ��ǰ�ڵ�
SELECT cart_member, cart_prod
  FROM cart
 WHERE cart_member = 'a001';
 
SELECT DISTINCT cart_member, cart_prod
  FROM cart
 WHERE cart_member IN (
                         SELECT mem_id
                           FROM member
                          WHERE mem_id = 'a001'
 );
 
 
 