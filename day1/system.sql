1. cmd 창 열기

-- 계정없이 서버 접속...
2. sqlplus /nolog 입력 엔터

3. SQL>conn /as sysdba

SQL>alter user system identified by 새로운암호
SQL>alter user sys identified by 새로운암호

SQL>conn system/ 새로운암호

-- 접속확인

--SQL>show user

-- 오라클 12버전 이상부터는 아래를 실행해야
-- 일반적인 구분 작성이 가능함
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- 위에 실행을 최초 한번 실행
-- 위에 실행 안하면 아래처럼 구문을 작성해야함
CREATE USER c##busan_06 IDENTIFIED BY dbdb;

-- 1. 사용자 생성하기

CREATE USER busan_06 
    IDENTIFIED BY dbdb;
    
-- 패스워드 수정하기
ALTER USER busan_06
    IDENTIFIED BY 수정패스워드;
    
-- 사용자 삭제하기
DROP USER busan_06;

-- 2. 권한부여하기
GRANT CONNECT, RESOURCE, DBA TO busan_06;

-- 권한 회수하기
REVOKE DBA FROM busan_06;

