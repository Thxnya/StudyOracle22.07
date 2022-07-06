--day4
--[문제]
-- 상품테이블과 ㅏ상품분류테이블에서 상품분류코드가 'P101' 인 것에 대한
-- 상품분류코드 (상품테이블에 있는 컬럼), 상품명, 상품분류명을 조회해 주세요.
-- 정렬은 상품아이디로 내림차순...
-- 1.테이블
-- lprod, prod
-- 2.관계
-- lprod_gu = prod_lgu
--<일반방식>
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
   AND lprod_gu = 'P101'
 ORDER BY prod_id DESC;

--<표준방식>
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu)
 WHERE lprod_gu = 'P101'
 ORDER BY prod_id DESC;

--[문제]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다.
-- 거래처코드, 거래처명, 회원거주지역(서울 or 인천...) 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만...
-- 1. 테이블
-- member, cart, prod, buyer, lprod
-- 2. 관계
-- buyer_id = prod_buyer, lprod_gu = prod_lgu, prod_id = cart_prod, mem_id = cart_member
--<일반방식>
SELECT buyer_id, buyer_name, SUBSTR(mem_add1, 1, 2)
  FROM member, cart, prod, buyer, lprod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND lprod_nm LIKE '%캐주얼%'
   AND mem_name = '김형모';

--<표준방식>
SELECT buyer_id, buyer_name, SUBSTR(mem_add1, 1, 2)
  FROM member INNER JOIN cart
                ON(mem_id = cart_member)
              INNER JOIN prod
                ON(prod_id = cart_prod)
              INNER JOIN buyer
                ON(buyer_id = prod_buyer)
              INNER JOIN lprod
                ON(lprod_gu = prod_lgu
                    AND lprod_nm LIKE '%캐주얼%')
 WHERE mem_name = '김형모';

--[문제]
-- 상품분류명에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름, 상품분류명 조회하기.
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원과...
--     회원의 취미가 수영인 회원..
--1. 테이블
-- lprod, prod, cart, member
--2. 관계
-- lprod_gu = prod_lgu, prod_id = cart_prod, cart_member = mem_id
--<일반방식>
SELECT mem_id, mem_name, lprod_nm
  FROM lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu 
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_name LIKE '%삼성전자%'
   AND mem_like = '수영'
   AND lprod_nm = '%전자%';

--<표준방식>
SELECT mem_id, mem_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu
                    AND prod_name LIKE '%삼성전자%')
             INNER JOIN cart
                ON(prod_id = cart_prod)
             INNER JOIN member
                ON(cart_member = mem_id
                    AND mem_like = '수영')
 WHERE lprod_nm = '%전자%';

--[문제]
-- 상품분류테이블과 상품테이블과 거래처테이블과 장바구니 테이블 사용..
-- 상품분류코드가 'P101' 인것을 조회..
-- 그리고, 정렬은 상품분류명을 기준으로 내림차순,
--                상품아이디를 기준으로 오름차순 하세요..
-- 상품분류명, 상품아이디, 상품판매가, 거래처담당자, 회원아이디,
-- 주문수량을 조회...
--1. 테이블
-- lprod, prod, buyer, cart
--2. 관계
-- lprod_gu = prod_lgu, prod_buyer = buyer_id, prod_id = cart_prod
--<일반방식>
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod, prod, buyer, cart
 WHERE lprod_gu = prod_lgu
   AND prod_buyer = buyer_id
   AND prod_id = cart_prod
   AND lprod_gu = 'P101'
 ORDER BY lprod_nm DESC, prod_id ASC;

--<표준방식>
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod INNER JOIN prod
                ON(lprod_gu = prod_lgu)
             INNER JOIN buyer
                ON(prod_buyer = buyer_id)
             INNER JOIN cart
                ON(prod_id = cart_prod)
 WHERE lprod_gu = 'P101'
 ORDER BY lprod_nm DESC, prod_id ASC;

--[문제]
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회하기.
-- 단, 상품명에 삼성이 포함된 상품을 구매한 회원에 대해서만
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수
--1. 테이블
-- cart, prod
--2. 관계
-- cart_prod = prod_id
--<일반방식>
SELECT prod_id, 
       MAX(cart_qty) AS mq, 
       MIN(cart_qty) AS miq, 
       ROUND(AVG(cart_qty), 2) AS aq, 
       SUM(cart_qty) AS sq, 
       COUNT(cart_qty) AS cq
  FROM prod, cart
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%삼성%'
 GROUP BY prod_id;

--<표준방식>
SELECT prod_id, 
       MAX(cart_qty) AS mq, 
       MIN(cart_qty) AS miq, 
       ROUND(AVG(cart_qty), 2) AS aq, 
       SUM(cart_qty) AS sq, 
       COUNT(cart_qty) AS cq
  FROM prod INNER JOIN cart
                ON( prod_id = cart_prod
                    AND prod_name LIKE '%삼성%')
 GROUP BY prod_id;

--[문제]
-- 거래처코드 및 상품분류코드별로,
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회해 주세요..
-- 조회컬럼, 거래처코드, 거래처명, 상품분류코드, 상품분류명,
--           판매가에 대한 최고, 최소, 자료수, 평균, 합계
-- 정렬은 평균을 기준으로 내림차순
-- 단, 판매가의 평균이 100 이상인 것
-- 1. 테이블
-- buyer, prod, lprod
-- 2. 관계
-- buyer_id = prod_buyer, prod_lgu = lprod_gu
--<일반방식>
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

--<표준방식>
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

--[문제]
/*
-- 거래처별로 group 지어서 매입금액의 합을 검색하고자 합니다....
-- 조건은 상품입고테이블의 2005년도 1월의 매입일자(입고일자)인것들...
-- 매입금액 = 매입수량 * 매입금액..
-- 조회컬럼 : 거래처코드, 거래처명, 매입금액의합
-- (매입금액의합이 null인 경우 0으로 조회)
-- 정렬은 거래처 코드 및 거래처명을 기준으로 내림차순
*/
--1. 테이블
-- buyer, prod, buyprod
--2. 관계
-- buyer_id = prod_buyer, prod_id = buy_prod
--<일반방식>
SELECT buyer_id, buyer_name, SUM(NVL(buy_qty * buy_cost, 0)) AS ASVSUM
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND buy_date BETWEEN '05/01/01' AND '05/01/31'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC;

--<표준방식>
SELECT buyer_id, buyer_name, SUM(NVL(buy_qty * buy_cost, 0)) AS ASVSUM
  FROM buyer INNER JOIN prod
                ON(buyer_id = prod_buyer)
             INNER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '05/01/01' AND '05/01/31')
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC;  

-- 위의 결과를 이용하여..
-- 매입금액의합이 1천만원 이상인 상품코드, 상품명을 검색하고자 합니다.....
--1. 테이블
-- 필터링한 테이블, prod
--2. 관계
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
 
--<일반방식>
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu) 
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;

--<표준방식>
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod
       LEFT OUTER JOIN prod ON(lprod_gu = prod_lgu)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;
 
--<일반조인>
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name;

--<일반 OUTER 조인>
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod(+)
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;
 
--<표준 OUTER 조인> 
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod LEFT OUTER JOIN buyprod
                ON(prod_id = buy_prod
                    AND buy_date BETWEEN '2005-01-01' AND '2005-01-31')
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;
 
--<셀프 조인>
SELECT B.buyer_id, B.buyer_name, B.buyer_add1 || '' || B.buyer_add2
  FROM buyer A, buyer B
 WHERE A.buyer_id = 'P30203'
   AND SUBSTR(A.buyer_add1, 1, 2) = SUBSTR(B.buyer_add1, 1, 2);
 
--[문제1]  
-- 1974년 7월 이후 1980년 12월 까지 태어난 여성이 구입하였고,
-- 거래처 담당자가 존재하거나 주소가 부산이 아니며, 
-- 입고일자가 4월 이상이고 
-- 매입수량이 10 이상이거나 매입단가가 200000원 이하인 상품 중에서
-- 크기가 L인 상품명에 2가 포함된 제품을 조회하고 여자옷 사이즈 77 남자옷은 32
-- 할인이 가장 많이 된 상품의 상품명, 판매가, 할인율(2번째자리까지),사이즈를 
-- 1~5등만 나타내시오!
-- 단, 서브쿼리만을 이용해서!

-- 1. 테이블
-- member, cart, prod, buyer, buyprod
-- 2. 관계
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
                   AND SUBSTR(buyer_add1, 1, 2) != '부산')
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

-- [문제2]
-- 예금주의 성이 김씨이고 
-- 거래처 주소의 행정구 이름이 강으로 시작하며 
--   (구분자로 분리하여 조회하시오, 단독 substr 사용 불가)
-- 거래처 팩스번호 가운데 3자리수 중에 3이 들어가고 
--   (구분자로 분리하여 조회하시오, 단독 substr 사용 불가)
-- 제일은행을 사용하는 거래처 상품의 신규 등록일이 1월이며(to_char 사용 불가)
-- 그 중 상품개략설명에 봄, 여름, 가을, 겨울이 있는 상품의 색상, (소비자가-판매가),
-- 매입수량, 매입단가 조회
-- 정렬은 (소비자가-판매가), 매입수량 기준으로 내림차순 
 
--1. 테이블
-- prod, buyer, buyprod, cart, member
--2. 관계
-- prod_buyer = buyer_id, prod_id = buy_prod, prod_id = cart_prod, cart_member = mem_id

SELECT prod_color, prod_price - prod_sale AS margin, buy_qty, buy_cost
  FROM prod, buyer, buyprod
 WHERE prod_buyer = buyer_id
   AND prod_id = buy_prod
   AND (prod_outline LIKE '%봄%' OR prod_outline LIKE '%여름%' OR prod_outline LIKE '%가을%' OR prod_outline LIKE '%겨울%')
   AND buyer_bank = '제일은행'
   AND EXTRACT(MONTH FROM prod_insdate) = 1
   AND buyer_bankname LIKE '김%'
   AND SUBSTR(buyer_add1, INSTR(buyer_add1, ' ')+1) LIKE '강%'
   AND SUBSTR(buyer_fax, INSTR(buyer_fax, '-')+1, 3) LIKE '%3%'
 ORDER BY margin DESC, buy_qty DESC;