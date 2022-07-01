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
     VALUES (1, 'p101', '컴퓨터제품');
INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1, 'p102', '컴퓨터제품');
     
SELECT lprod_gu, lprod_nm
  FROM lprod;
  
commit;
rollback;

-- 회원정보 테이블
SELECT *
  FROM member;

-- 주문내역관리 테이블
SELECT *
  FROM cart;

-- 상품정보 테이블
SELECT *
  FROM prod;

-- 상품분류정보 테이블
SELECT *
  FROM lprod;
  
-- 거래처정보 테이블
SELECT *
  FROM buyer;
  
-- 입고상품정보(재고) 테이블
SELECT *
  FROM buyprod;
  
-- 회원테이블에서 회원아이디, 회원이름 조회하기..
SELECT mem_id, mem_name
  FROM member;
  
-- 상품코드와 상품명 조회하기..
SELECT prod_id, prod_name
  FROM prod;
  
-- 상품코드, 상품명, 판매금액 조회하기
-- 단, 판매금액=판매단가 * 55 로 계산해서 조회합니다.
-- 판매금액이 4백만 이상인 데이터만 조회하기...
-- 정렬은 판매금액을 기준으로 내림차순
-- SELECT > FROM 테이블 > WHERE > 컬럼조회 > ORDER BY

SELECT prod_id, prod_name, (prod_sale*55) AS prod_sale
  FROM prod
 WHERE (prod_sale * 55) >= 4000000
 ORDER BY (prod_sale * 55) DESC;
  
-- 상품정보에서 거래처코드를 조회해 주세요...
-- 단, 중복을 제거하고 조회해주세요..
SELECT DISTINCT prod_buyer
  FROM prod;
 
-- 상품중에 판매가격이 17만원인 상품 조회하기..
SELECT *
  FROM prod
 WHERE prod_sale = 170000;
  
-- 상품중에 판매가격이 17만원이 아닌 상품 조회하기..
SELECT *
  FROM prod
 WHERE prod_sale != 170000;
 
-- 상품중에 판매가격이 17만원이 이상이고 20만원 이하인 상품 조회하기..
SELECT *
  FROM prod
 WHERE prod_sale >= 170000 AND prod_sale <= 200000; 
  
-- 상품중에 판매가격이 17만원이 이상 또는 20만원 이하인 상품 조회하기.. 
SELECT *
  FROM prod
 WHERE prod_sale >= 170000 OR prod_sale <= 200000;  
 
-- 상품 판매가격이 10만원 이상 이고,,
-- 상품 거래처(공급업체) 코드가 P30203 또는 P10201 인
-- 상품코드, 판매가격, 공급업체 코드 조회하기...

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
 
 -- 한번도 주문한 적이 없는 회원 아이디, 이름을 조회해 주세요..
SELECT mem_id, mem_name
  FROM member
 WHERE mem_id NOT IN (
                     SELECT DISTINCT cart_member
                    FROM cart
                     );
 
-- 상품분류 중에 상품정보에 없는 분류코드만 조회해 주세요..
SELECT *
  FROM lprod
 WHERE lprod_gu NOT IN (
                         SELECT DISTINCT prod_lgu
                           FROM prod
                         );

-- 회원의 생일 중에 75년생이 아닌 회원아이디, 생일 조회하기..
-- 정렬은 생일 기준 내림차순

SELECT mem_id, mem_bir
  FROM member
 WHERE mem_bir NOT BETWEEN '75/01/01' AND '75/12/31'
 ORDER BY mem_bir DESC;
  
-- 회원 아이디가 a001인 회원이 주문한 상품코드를 조회해 주세요..
-- 조회컬럼은 회원아이디, 상품코드
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
 
 
 