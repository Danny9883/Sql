DDL : data definition language
 구조를 생성(CREATE), 변경(ALTER), 제거(DROP)
 
CREATE
ALTER
DROP

계정생성
 아이디   : SKY
 비밀번호 : 1234
 CMD
 
 Microsoft Windows [Version 10.0.19045.6218]
(c) Microsoft Corporation. All rights reserved.

C:\Users\GGG>sqlplus /nolog

SQL*Plus: Release 21.0.0.0.0 - Production on 월 4월 13 14:06:02 2026
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

SQL> conn /as sysdba
연결되었습니다.

SQL> ALTER SESSION SET "_ORACLE_SCRIPT"=true;
세션이 변경되었습니다.

SQL> CREATE USER SKY IDENTIFIED BY 1234;
사용자가 생성되었습니다.

SQL> GRANT CONNECT, RESOURCE TO SKY;
권한이 부여되었습니다.

SQL> ALTER USER SKY DEFAULT TABLESPACE
  2  USERS QUOTA UNLIMITED ON USERS;
사용자가 변경되었습니다.
 
SQL> conn SKY/1234
연결되었습니다.
SQL> show user
USER은 "SKY"입니다


----------------------------------------------------------
새 계정으로 접속한 뒤에 작업

sky 에서 hr 계정의 data 를 가져온다
sqlplus 에서 작업
1. 먼저 hr 로 로그인한다
win + r : cmd
c:\> sqlplus hr/1234

2. hr 에서 다른계정인 sky 에게 select 할 수 있는 권한을 부여
SQL> GRANT SELECT ON EMPLOYEES TO SKY;
권한이 부여되었습니다.

3. sky로 로그인 한다
SQL> CONN SKY/1234
연결되었습니다.

SQL> SHOW USER
USER은 "SKY"입니다

SQL> SELECT * FROM TAB;
선택된 레코드가 없습니다.

4. sky 에서 hr 계정의 EMPLOYEES 를 조회
SQL> SELECT * FROM HR.EMPLOYEES;       -- 조회성공
SQL> SELECT * FROM HR.DEPARTMENTS;     -- 조회실패

-----------------------------------------------------
ORACLE 의 TABLE 복사하기
HR  의 EMPLOYEES TABLE 을 복사해서 SKY 로 가져온다

[1] 테이블 생성 - CREATE
1. 테이블 복사
  대상 : 테이블 구조, 테이터 (제약 조건의 일부만 복사(NOT NULL))
  
  1) 구조, 테이터 전부 복사, 제약조건은 일부만 복사(null 관련) -- 109건
   CREATE TABLE EMP1
    AS 
       SELECT * FROM HR.EMPLOYEES;
       
  2) 구조, 테이터 전부 복사, 50번 80번 부서만 복사  -- 79건
   CREATE TABLE EMP2
    AS 
       SELECT * FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID IN (50,80)
       ;
       
       
  3) DATA 빼고 구조만 복사
   CREATE TABLE EMP3
    AS
      SELECT * FROM HR.EMPLOYEES
       WHERE 1 = 0;
    
  
  
  4) 구조만 복사된 TABLE EMP3 에 DATA 만 추가
   CREATE TABLE EMP4
    AS
      SELECT * FROM HR.EMPLOYEES
       WHERE 1 = 0;

   -- DATA 만 추가
   INSERT INTO EMP4
     SELECT * FROM HR.EMPLOYEES;
   COMMIT;

  5) 일부 칼럼만 복사해서 새로운 테이블 생성
   CREATE TABLE  EMP5
     AS
       SELECT EMPLOYEE_ID                   EMPID,
              FIRST_NAME ||' '|| LAST_NAME  ENAME,
              SALARY                        SAL,
              SALARY * COMMISSION_PCT       BONUS,
              MANAGER_ID                    MGR,
              DEPARTMENT_ID                 DEPTID
        FROM  HR.EMPLOYEES;


SELECT * FROM TAB;
--------------------------------------------------------
-- 2026-04-14
--------------------------------------------------------
2. SQL DEVELOPER 메뉴 에서 TABLE 생성
   SKY 계정
     테이블 메뉴클릭 -> 새 테이블 클릭 -> TABLE1 생성 : EMP6
                  EMPID NUMBER(8,2)  NOT NULL  PRIMARY KEY
                , ENAME VARCHAR2(46) NOT NULL 
                , TEL VARCHAR2(20) 
                , EMAIL VARCHAR2(320) 




3. SCRIPT 로 생성
CREATE TABLE EMP7 
(
  EMPID NUMBER(8,2)   NOT NULL 
, ENAME VARCHAR2(46)  NOT NULL 
, TEL   VARCHAR2(20) 
, EMAIL VARCHAR2(320) 
, CONSTRAINT EMP7_PK PRIMARY KEY 
  (
    EMPID 
  )
  ENABLE 
);


[2] 테이블 제거(DROP) - 영구적으로 구조와 데이터가 제거된다 

 DROP TABLE EMP1;
  -- DROP 되는 테이블이 부모테이블일 경우 자식을 먼저 지워야 제거가능

   
DROP TABLE EMPLOYEES; -- 삭제 안됨 
 ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다

 테이블이 삭제되지 않는다 : 부모키를 가진 부모테이블은 자식테이블에 데이터가 있다면.
 
-- DROP TABLE EMPLOYEES  CASCADE;  -- 부모 자식관계의 테이터를 전체삭제

[3] 구조변경 (ALTER)
  1. 칼럼추가
    ALTER TABLE EMP5
     ADD ( LOC VARCHAR2(6) ); -- 추가된 칼럼은 NULL 로 채워짐
  
  2. 칼럼제거
    ALTER TABLE EMP5
     DROP COLUMN LOC;
  
  3. 테이블 이름 변경 - ORACLE 명령
    RENAME  EMP4 TO NEWEMP;
     
  
  4. 칼럼 속성 변경 -- 크기를 늘려주거나 줄인다
    ALTER TABLE EMP5
     MODIFY ( ENAME VARCHAR2(60) ); -- 46  ->  60
     줄일때 데이터의 내용이 있으면 내용이 잘려나갈(소실될) 수 있다
     
     
     
-------------------------------------------
테이블을 생성하고 데이터를 파일에서 가져온다
CREATE TABLE  ZIPCODE
(
    ZIPCODE  VARCHAR2(7)             -- 우편번호
    ,SIDO    VARCHAR2(6)             -- 시/도
    ,GUGUN   VARCHAR2(26)            -- 구/군
    ,DONG    VARCHAR2(78)            -- 동
    ,BUNJI   VARCHAR2(26)            -- 번지
    ,SEQ     NUMBER(5)   PRIMARY KEY -- 일련번호
);


테이블 생성 후 ZIPCODE 테이블 선택하고
 우클릭 -> 데이터임포트
   ZIPCODE_UTF8.CSV 선택

SELECT * FROM ZIPCODE;    -- 
   
SELECT COUNT(*) FROM ZIPCODE;    -- 52144

SELECT COUNT(*) FROM ZIPCODE  --  3605
 WHERE SIDO = '부산';
 
-- 시/도별 우편번호 갯수
SELECT    SIDO     시도, COUNT(ZIPCODE) 우편번호갯수
 FROM     ZIPCODE
 GROUP BY SIDO
 ;
 
SELECT  COUNT(ZIPCODE), COUNT(DISTINCT ZIPCODE) -- 52144 , 31840
 FROM   ZIPCODE ;
 
SELECT   '['||ZIPCODE||'] ' || 
          SIDO  || ' ' ||
          GUGUN || ' ' ||
          DONG  || ' ' ||
          BUNJI || ' '   AS ADDR
 FROM     ZIPCODE
 WHERE    DONG  LIKE '%부전2동%'
 ORDER BY SEQ ASC
 ;
   
  


   


  
  
  
  

  









