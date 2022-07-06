-- day3
-- [조회 방법 정리]

-- 1. 테이블 찾기
--  - 제시된 컬럼들의 소속 찾기
-- 2. 테이블 간의 관계 찾기
--  - ERD에서 연결된 순서대로 PK와 FK컬럼 또는,
--  - 성격이 같은 값으로 연결할 수 있는 컬럼 찾기
-- 3. 작성 순서 정하기
--  - 조회하는 컬럼이 속한 테이블이 가장 밖..1순위..
--  - 1순위 테이블부터 ERD 순서대로 작성..
--  - 조건은 : 해당 컬럼이 속한 테이블에서 조건 처리..

-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름 조회하기.
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원...
--      그리고, 회원의 취미가 수영인 회원..
SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '수영'
   AND mem_id IN (
                  SELECT cart_member
                    FROM cart
                   WHERE cart_prod IN (
                                       SELECT prod_id
                                         FROM prod
                                        WHERE prod_name LIKE '%삼성전자%'
                                          AND prod_lgu IN (
                                                          SELECT lprod_gu
                                                            FROM lprod
                                                           WHERE lprod_nm LIKE '%전자%')));

-- [문제]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다.
-- 거래처코드, 거래처명, 지역(서울 or 인천...), 거래처 전화번호 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만....

SELECT buyer_id, buyer_name, SUBSTR(buyer_add1, 1, 2) as buyer_region, buyer_comtel
  FROM buyer
 WHERE buyer_lgu IN (
        SELECT lprod_gu
          FROM lprod
         WHERE lprod_nm LIKE '%캐주얼%'
           AND lprod_gu IN (
                SELECT prod_lgu
                  FROM prod
                 WHERE prod_id IN (
                        SELECT cart_prod
                          FROM cart
                         WHERE cart_member IN (
                                SELECT mem_id
                                  FROM member
                                 WHERE mem_name = '김형모'))));
        
-- 여자인 회원이 구매한 상품 중에
-- 상품분류에 전자가 포함되어 있고,
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회하기....
-- 1. 테이블찾기
-- member, lprod, buyer, *prod*, cart
-- 2. 관계찾기
-- prod_id = cart_prod, cart_member = mem_id 
-- prod_lgu = lprod_gu
-- prod_buyer = buyer_id
-- 3. 조건
-- MOD(SUBSTR(mem_regno2, 1, 1)) = 0
-- lprod_nm LIKE '%전자%'
-- buyer_add1 LIKE '%서울%'

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
         WHERE lprod_nm LIKE '%전자%')
   AND prod_buyer IN (
        SELECT buyer_id
          FROM buyer
         WHERE buyer_add1 LIKE '%서울%');

-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회하기.
SELECT cart_prod, 
       MAX(cart_qty) AS MAX_qty, 
       MIN(cart_qty) AS MIN_qty, 
       ROUND(AVG(cart_qty), 2) AS AVG_qty, 
       SUM(cart_qty) AS SUM_qty, 
       COUNT(cart_qty) AS COUNT_qty
  FROM cart
 GROUP BY cart_prod;

-- 오늘이 2005년도 7월 11일이라 가정하고 장바구니테이블에 발생될 
-- 추가주문번호를 검색하시오..
SELECT MAX(cart_no) AS mno, 
       MAX(cart_no) + 1 AS mpno
  FROM cart
 WHERE SUBSTR(cart_no, 1, 8) = '20050711';

-- 회원테이블의 회원전체의 마일리지 평균, 마일리지 합계,
-- 최고 마일리지, 최소 마일리지, 인원수를 검색하시오
-- 조회컬럼은 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수
SELECT ROUND(AVG(mem_mileage), 2) AS AVG_MILE, 
       SUM(mem_mileage) AS SUM_MILE, 
       MAX(mem_mileage) AS MAX_MILE, 
       MIN(mem_mileage) AS MIN_MILE, 
       COUNT(mem_id) AS COUNT_MEM
  FROM member;

-- [문제]
-- 상품테이블에서 거래처별, 상품분류코드별로,
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회해 주세요..
-- 정렬은 자료수를 기준으로 내림차순
-- 추가로, 거래처명, 상품분류명도 조회..
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
 WHERE buyer_charger LIKE '김%';

UPDATE buyer SET buyer_charger = ''
 WHERE buyer_charger LIKE '성%';

SELECT buyer_charger
  FROM buyer
 WHERE buyer_charger IS NULL;

SELECT buyer_charger
  FROM buyer
 WHERE buyer_charger IS NOT NULL;
 
SELECT buyer_name, NVL(buyer_charger, '없다')
  FROM buyer;

SELECT DECODE(SUBSTR(prod_lgu, 1, 2),
              'P1', '컴퓨터/전자 제품',
              'P2', '의류',
              'P3', '잡화', 
              '기타')
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
 
-- INNER JOIN 조건
-- PK와 FK가 있어야 합니다.
-- 관계조건 성립 : PK = FK
-- 관계조건의 갯수 : FROM절에 제시된 (테이블의 갯수 - 1개)
-- <일반방식>
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
   
-- <표준방식>
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

-- 상품테이블에서 상품코드, 상품명, 분류명, 거래처명,
-- 거래처주소를 조회.
--1) 판매가격이 10만원 이하 이고
--2) 거래처 주소가 부산인 경우만 조회
-- 일반방식, 표준방식..모두 해보기..

--1.테이블 찾기.
-- prod, lprod, buyer
--2.관계조건식 찾기
-- lprod_gu = prod_lgu
-- buyer_id = prod_buyer
--3.순서 정하기..
-- <일반방식>
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM lprod, prod, buyer
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_sale <= 100000
   AND buyer_add1 LIKE '%부산%';
   
-- <표준방식>   
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM lprod INNER JOIN prod
                 ON(lprod_gu = prod_lgu
                    AND prod_sale <= 100000)
             INNER JOIN buyer
                 ON(buyer_id = prod_buyer
                    AND buyer_add1 LIKE '%부산%');

--[문제]
--상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
-- 단, 상품분류 코드가 P101, P201, P301인 것
--     매입수량이 15개 이상인 것
--     서울에 살고 있는 회원 중에 생일이 1974년생인 회원
-- 정렬은 회원아이디 기준 내림차순, 매입수량 기준 오름차순
-- 일반방식, 표준방식..
--1. 테이블
-- prod, buyprod, cart, buyer, lprod, member
--2. 관계
-- prod_id = buy_prod
-- prod_id = cart_prod
-- cart_member = mem_id
-- prod_buyer = buyer_id
-- prod_lgu = lprod_gu
--3. 순서
--<일반방식>
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
   AND mem_add1 LIKE '서울%'
 ORDER BY mem_id DESC, buy_qty ASC;
   
--<표준방식>
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
                    AND mem_add1 LIKE '서울%')
 ORDER BY mem_id DESC, buy_qty ASC;
 
 
 
 
SELECT *
  FROM member;
  
SELECT *
  FROM buyer;

SELECT *
  FROM prod;
-- 1번 문제
--지금까지 회원들이 구매했던 상품들의 가격에 총 5%를 마일리지로 적립해주는 이벤트를 한다고 합니다.
--상품 테이블의 상품 마일리지 업데이트(판매가의 5%)시키고 그 컬럼을 이용하여,
--사람들이 구매한 상품 수량만큼 마일리지를 적립, 가지고 있는 마일리지와 더해서 회원번호 별로 현재 얼마인지 보여주기
--조회하는 컬럼은 회원번호, 회원명, 가지고 있던 마일리지, 
--이벤트로 적립되는 마일리지(컬럼명은 eve_mile로 별칭), 최종 마일리지(컬럼명은 total로 별칭)
--회원번호 순으로 오름차순 정렬

--1) 테이블
--member, cart, prod
--2) 관계
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
