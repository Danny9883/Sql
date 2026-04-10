-- 함수
/* 숫자
 1. ABS()
 2. CEIL(n) 과 FLOOR(n) -> 정수형
    CEIL  -> 무조건 올림
    FLOOR -> 버림
 */
 SELECT CEIL(10.123), CEIL(10.541),CEIL(11.001)      FROM  DUAL;

 SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001)  FROM  DUAL;

 SELECT FLOOR(-10.123), FLOOR(-10.541), FLOOR(-11.001)  FROM  DUAL;  -- -11  -11  -12
 
  SELECT TRUNC(-10.123), TRUNC(-10.541), TRUNC(-11.001)  FROM  DUAL; -- -10  -10  -11

-- 3) ROUND(n, i)와 TRUNC(n1, n2)
 SELECT ROUND(10.154, 1), ROUND(10.154, 2), ROUND(10.154, 3) FROM DUAL; -- 10.2  10.15  10.154
 SELECT TRUNC(10.154, 1), TRUNC(10.154, 2), TRUNC(10.154, 3) FROM DUAL; -- 10.1  10.15  10.154
 
 SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2)  FROM DUAL; -- 0  120  100
 SELECT TRUNC(0, 3), TRUNC(115.155, -1), TRUNC(115.155, -2)  FROM DUAL; -- 0  110  100

-- 4) POWER(2, 3)   : 제곱승 : 2의 3승
--    SQRT(n)       : 제곱근 : SQUARE ROOT
 SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001), POWER(4, 0.5) FROM DUAL; -- 9  27  27.002966  1.99999999
 SELECT SQRT(2), SQRT(4)                                          FROM DUAL; -- 1.4142  2
 
 SELECT SQRT(-4)                                                  FROM DUAL; -- ORA-01428: '-4' 인수가 범위를 벗어났습니다
 
 
-- 5) 나머지 
--    MOD(n2, n1)와 REMAINDER(n2, n1)
-- • MOD → n2 - n1 * FLOOR (n2/n1)
-- • REMAINDER → n2 - n1 * ROUND (n2/n1)

 SELECT MOD(19,4), MOD(19.123, 4.2)              FROM DUAL; --  3   2.323
 SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2)  FROM DUAL; -- -1  -1.877
 
-- 6) EXP(n), LN(n) 그리고 LOG(n2, n1)
--    e^n    log e n       log n2 n1
 SELECT EXP(2), LN(2.713), LOG(10, 100)          FROM DUAL;
-- 7.3890560989306502272304274605750078132	0.9980550336767946922014710783755035594696	2


-- 7) SIN(), COS(), TAN()    : DEGREE(도) -> RADIAN(원주율/180 * 각도) -> 0.01745...
-- SIN 30도 -> 0.5  
 SELECT SIN(30), SIN(3.141592653589793238462643383279502884197169399375105820974944/180*30) FROM DUAL; 
 
------------------------------------------------
-- 문자함수
-- INITCAP(char), LOWER(char), UPPER(char)
 SELECT INITCAP('never say goodbye'), INITCAP('never6say*good가bye')   FROM DUAL; 
 --              Never Say Goodbye	           Never6say*Good가Bye
 SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye')        FROM DUAL;
 --              never say goodbye	       NEVER SAY GOODBYE
 
 
 -- CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)
 SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream'   FROM DUAL;
 --              I Have A Dream	         I Have A Dream
 
 SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4)         FROM DUAL; 
 --              ABCD                       G
 -- SUBSTR('ABCDEFG', -1, 4) : -1 뒤로부터 첫번째에서 앞으로 4개 진행 : G
 
 SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('가나다라마바사', 1, 4) FROM DUAL; -- ABCD   가 - 바이트 단위로.
 
-- LTRIM(char, set), RTRIM(char, set)
 SELECT LTRIM('ABCDEFGABC', 'ABC'), -- DEFGABC
        LTRIM('가나다라', '가'),    -- 나다라
        RTRIM('ABCDEFGABC', 'ABC'), -- ABCDEFG
        RTRIM('가나다라', '라'),    -- 가나다
        TRIM (LEADING ' ' FROM '  AAA  '),           -- AAA (앞뒤공백 제거)
        LENGTH(TRIM ('  AAA   '))   -- 3 
  FROM DUAL;
  
--------------------------------------------------
-- 4) LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)
 CREATE TABLE ex4_1 (phone_num VARCHAR2(30));
 INSERT INTO ex4_1 VALUES ('111-1111');
 INSERT INTO ex4_1 VALUES ('111-2222');
 INSERT INTO ex4_1 VALUES ('111-3333');
 
 SELECT * FROM ex4_1;
 
 SELECT LPAD(phone_num, 12, '(02)')
  FROM ex4_1;

 SELECT RPAD(phone_num, 12, '(02)')
  FROM ex4_1;

-- 5) REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
 SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너')
  FROM DUAL;
    
 SELECT LTRIM(' ABC DEF '), -- (ABC DEF  )
        RTRIM(' ABC DEF '), -- (  ABC DEF)
        REPLACE(' ABC DEF ', ' ', '') -- (ABCDEF)
 FROM DUAL;
 
 SELECT employee_id, TRANSLATE(FIRST_NAME,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','thehillsarealivewiththesou') AS TRANS_NAME
  FROM employees;

  
  
-- 6) INSTR(str, substr, pos, occur) - indexOf() 
--    LENGTH(chr)  - 글자수
--    LENGTHB(chr) - 바이트수
 SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1,
        INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2,
        INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3
  FROM DUAL; -- 4 18 32  
  
 SELECT LENGTH('대한민국'),  -- 4  글자
        LENGTHB('대한민국')  -- 12 BYTE
  FROM DUAL; 


-------------------------------------------
-- 날짜 함수
/*
 1. SYSDATE, SYSTIMESTAMP
 2. ADD_MONTHS (date, integer)
 3. MONTHS_BETWEEN(date1, date2)
 4. LAST_DAY(date)
 5. ROUND(date, format), TRUNC(date, format)
 6. NEXT_DAY (date, char)
*/

-------------------------------------------
-- 변환함수
-- 1. TO_CHAR (숫자 혹은 날짜, format)
 SELECT TO_CHAR(123456789, '999,999,999'), --  123,456,789
        TO_CHAR(1234567,   '99,999,999'),  --  1,234,567
        TO_CHAR(1234567,   '00,000,000'),  --  01,234,567
        TO_CHAR(123.45678, '99,990.000'),  --  123.457    -- 소수이하 자동반올림 3자리로
        TO_CHAR(123456789, '$999,999,999'),-- $123,456,789
        TO_CHAR(123456789, 'L999,999,999') --￦123,456,789
  FROM DUAL;
  
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') -- 2026-04-10
  FROM DUAL;
      
      
-- 2. TO_NUMBER(expr, format)

-- 3. TO_DATE(char, format), TO_TIMESTAMP(char, format)

-- 4. GREATEST(expr1, expr2, …), LEAST(expr1, expr2, …)
 SELECT GREATEST(1, 2, 3, 2),  -- 3
           LEAST(1, 2, 3, 2)   -- 1
  FROM DUAL;
  
-- 5. DECODE (expr, search1, result1, search2, result2, …, default)
--------------------------------------------------------------------


-- 직원이름, 담당업무
 SELECT  FIRST_NAME||' '||LAST_NAME   직원이름, 
         JOB_ID                       담당업무
  FROM   EMPLOYEES
;


-- 직원이름, 담당업무, 담당업무 히스토리
 SELECT  EMPLOYEE_ID , JOB_ID
  FROM   EMPLOYEES
 UNION
 SELECT  EMPLOYEE_ID , JOB_ID
  FROM   JOB_HISTORY
;

 SELECT     *
  FROM      (SELECT  EMPLOYEE_ID , JOB_ID      
              FROM   EMPLOYEES
              UNION
              SELECT  EMPLOYEE_ID , JOB_ID
              FROM   JOB_HISTORY) -- INLINE VIEW : ORDER BY 사용가능 : FROM 뒤에 사용
  ORDER BY EMPLOYEE_ID;


-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
 SELECT  * FROM 
 (SELECT  EMPLOYEE_ID                      사번, 
         TO_CHAR(HIRE_DATE,'YYYY-MM-DD')  업무시작일, 
         '재직중'                         업무종료일, 
         JOB_ID                           담당업무, 
         DEPARTMENT_ID                    부서번호
  FROM   EMPLOYEES 
  UNION
 SELECT  EMPLOYEE_ID                      사번, 
         TO_CHAR(START_DATE,'YYYY-MM-DD') 업무시작일, 
         TO_CHAR(END_DATE,'YYYY-MM-DD')   업무종료일, 
         JOB_ID                           담당업무, 
         DEPARTMENT_ID                    부서번호
  FROM   JOB_HISTORY )
  ORDER BY 사번 ASC, 업무시작일 ASC;

-- 사번, 직원명, 업무시작일, 업무종료일, 담당업무명, 부서이름
 SELECT  V.사번,E.FIRST_NAME||' '||E.LAST_NAME 이름 , V.업무시작일, V.업무종료일, J.JOB_TITLE, D.DEPARTMENT_NAME
  FROM   EMPLOYEES E LEFT JOIN
 (SELECT  EMPLOYEE_ID                      사번, 
         TO_CHAR(HIRE_DATE,'YYYY-MM-DD')  업무시작일, 
         '재직중'                         업무종료일, 
         JOB_ID                           담당업무, 
         DEPARTMENT_ID                    부서번호
  FROM   EMPLOYEES 
  UNION
 SELECT  EMPLOYEE_ID                      사번, 
         TO_CHAR(START_DATE,'YYYY-MM-DD') 업무시작일, 
         TO_CHAR(END_DATE,'YYYY-MM-DD')   업무종료일, 
         JOB_ID                           담당업무, 
         DEPARTMENT_ID                    부서번호
  FROM   JOB_HISTORY ) V  ON E.EMPLOYEE_ID = V.사번 LEFT JOIN JOBS J ON V.담당업무 = J.JOB_ID
                                             LEFT JOIN DEPARTMENTS D ON V.부서번호 = D.DEPARTMENT_ID
  ORDER BY V.사번
;
  
  
  
  
-----------------------------------------------------------------
 VIEW : 뷰 -- SQL 문을 저장해놓고 TABLE처럼 호출해서 사용하는 객체
 
 1) INLINE VIEW   -> SELECT 할때만 VIEW 로 작동 : 임시적으로 존재
    --
    SELECT *
     FROM  (
         SELECT EMPLOYEE_ID                사번,
                FIRST_NAME||' '||LAST_NAME 이름,
                EMAIL     ||'@GREEN.COM'   이메일,
                PHONE_NUMBER               전화
          FROM  EMPLOYEES
          ORDER BY 이름
     ) T
     WHERE T.사번 IN (100,101,102);
  -----
  SELECT  *
   FROM  (
       SELECT    DEPARTMENT_ID             DEPT_ID ,
                 COUNT(SALARY)             CNT_SAL , 
                 SUM(SALARY)               SUM_SAL ,
                 AVG(SALARY)               AVG_SAL
        FROM     EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY DEPT_ID     )  T
   WHERE  T.AVG_SAL >= 4000;
   
    
 
 2) 일반적인 VIEW -> 영구저장된 객체 
 
    VIEW 생성 - 영구 보관
    CREATE OR REPLACE VIEW "HR"."VIEW_EMP" ("사번","이름","이메일","전화")
    AS 
         SELECT EMPLOYEE_ID                사번,
                FIRST_NAME||' '||LAST_NAME 이름,
                EMAIL     ||'@GREEN.COM'   이메일,
                PHONE_NUMBER               전화
          FROM  EMPLOYEES
          ORDER BY 이름
    ;
    
    SELECT * 
     FROM  VIEW_EMP
     WHERE UPPER(이름) LIKE '%KING%'
     ;
     
-------------------------------------------
 2) WITH  -- 가상의 테이블 생성
    WITH  A  ("사번","이름","이메일","전화") 
      AS (
         SELECT EMPLOYEE_ID                사번,
                FIRST_NAME||' '||LAST_NAME 이름,
                EMAIL     ||'@GREEN.COM'   이메일,
                PHONE_NUMBER               전화
          FROM  EMPLOYEES
          ORDER BY 이름
      )  
    SELECT * FROM A;

 -----------------------------------------------------------------
 SELF JOIN
 -- 직원번호, 직속상사번호
 SELECT EMPLOYEE_ID, MANAGER_ID
  FROM  EMPLOYEES;
 
 
  
 -- 직원이름, 직속상사이름, 
 -- 상사정보 : E1, 부하정보 E2 - 테이블 복사
 SELECT  E1.FIRST_NAME||' '||E1.LAST_NAME    직원이름 , E2.FIRST_NAME||' '||E2.LAST_NAME 직속상사이름
  FROM   EMPLOYEES E1 , EMPLOYEES E2
  WHERE  E1.MANAGER_ID = E2.EMPLOYEE_ID
  ORDER BY E2.EMPLOYEE_ID
  ; -- 사장이 출력되지 않는다
  
 -- 직원이름, 직속상사이름
 SELECT E.EMPLOYEE_ID                  직원번호,
        E.FIRST_NAME||' '||E.LAST_NAME 직원이름, 
        M.FIRST_NAME||' '||M.LAST_NAME 직속상사
  FROM  EMPLOYEES E LEFT JOIN  EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID
  ORDER BY E.EMPLOYEE_ID
  ; 
  
 -----------------------------------------------------------------  
  -- 계층형 쿼리, CASCADING
  계층형쿼리 : HIRERACHY

  LEVEL : 예약어 , 계층형 쿼리의 레벨을 구하는 
  직원번호, 직원명, 레벨, 부서명
  
  SELECT   E.EMPLOYEE_ID                                                직원번호, 
           LPAD(' ' , 3 * (LEVEL-1)) || E.FIRST_NAME||' '||E.LAST_NAME  직원명, 
           LEVEL, 
           D.DEPARTMENT_NAME                                            부서명
   FROM    EMPLOYEES  E  LEFT JOIN  DEPARTMENTS  D
     ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
   START WITH   E.MANAGER_ID IS NULL
   CONNECT BY  PRIOR  E.EMPLOYEE_ID  = E.MANAGER_ID
;
  
  
  
 
 -----------------------------------------------------------------
 EQUI JOIN, 등가조인 : 조인 조건이 = 인 것들
 
 NON-EQUI JOIN : 비등가 조인 : 조인조건이 = 이 아닌것
 
 직원등급
 월급             등급
 20000 초과 ~   :  S
 15001 ~ 20000  :  A
 10001 ~ 15000  :  B
  5001 ~ 10000  :  C
  3001 ~  5000  :  D
     0 ~  3000  :  E
     
 직원번호   직원명   월급   등급
 SELECT  EMPLOYEE_ID                직원번호,
         FIRST_NAME||' '||LAST_NAME 직원명,
         SALARY                     월급,
         CASE 
           WHEN  SALARY > 20000                 THEN 'S'
           WHEN  SALARY BETWEEN 15001 AND 20000 THEN 'A'
           WHEN  SALARY BETWEEN 10001 AND 15000 THEN 'B'
           WHEN  SALARY BETWEEN  5001 AND 10000 THEN 'C'
           WHEN  SALARY BETWEEN  3001 AND  5000 THEN 'D'
           WHEN  SALARY BETWEEN     0 AND  3000 THEN 'E'
           ELSE                                      '등급없음'
         END                        등급
  FROM   EMPLOYEES;
  
  -- 등급 테이블 생성
  DROP TABLE SALGRADE;
  CREATE  TABLE  SALGRADE
  (
    GRADE  VARCHAR2(1)  PRIMARY KEY
   ,LOSAL  NUMBER(11)
   ,HISAL  NUMBER(11)
  );
  
  INSERT INTO SALGRADE VALUES ( 'S', 20001, 99999999999 );
  INSERT INTO SALGRADE VALUES ( 'A', 15001, 20000 );
  INSERT INTO SALGRADE VALUES ( 'B', 10001, 15000 );
  INSERT INTO SALGRADE VALUES ( 'C',  5001, 10000 );
  INSERT INTO SALGRADE VALUES ( 'D',  3001,  5000 );
  INSERT INTO SALGRADE VALUES ( 'E',     0,  3000 );
  COMMIT;
  
  
  직원번호   직원명   월급   등급
  SELECT  E.EMPLOYEE_ID                   직원번호,
          E.FIRST_NAME||' '||E.LAST_NAME  직원명,
          E.SALARY                        월급,
          NVL(SG.GRADE,'등급없음')        등급
   FROM   EMPLOYEES  E  LEFT JOIN SALGRADE  SG 
     ON   E.SALARY   BETWEEN SG.LOSAL AND SG.HISAL
   ORDER BY E.EMPLOYEE_ID ASC
;

-----------------------------------------------------------
-- 분석함수와 WINDOW 함수
 1. ROW_NUMBER()  : 줄번호
 2. RANK()        : 석차  (1,2,2,4,5,5,7...)
 3. DENSE_RANK()  : 석차  (1,2,2,3,4,4,5,6...)
 4. NTILE()       : 그룹으로 분류
 5. LISTAGG()     : 
 
 DESC  NULLS LAST   -- NULL 맨 아래로  
 DESC  NULLS FIRST  -- NULL 맨 위로   : 기본값
 ----
 1. ROW_NUMBER() : 페이징 기법
 --------------------
 전체
 SELECT    EMPLOYEE_ID,  FIRST_NAME, LAST_NAME, SALARY
  FROM     EMPLOYEES
  ORDER BY SALARY DESC NULLS LAST
  ;

 -- 자료를 10개만 출력 - 페이징 기술
 1) OLD 문법 : ROWNUM --  의사(psuedo) 칼럼 
 SELECT  ROWNUM, EMPLOYEE_ID,  FIRST_NAME, LAST_NAME, SALARY
  FROM   EMPLOYEES
--  WHERE  ROWNUM  BETWEEN 1 AND 10
  ORDER BY  SALARY DESC NULLS LAST
;


  SELECT ROWNUM, EMPLOYEE_ID,  FIRST_NAME, LAST_NAME, SALARY
  FROM 
     (SELECT  ROWNUM, EMPLOYEE_ID,  FIRST_NAME, LAST_NAME, SALARY
       FROM   EMPLOYEES
       ORDER BY  SALARY DESC NULLS LAST) T
;
 
 
 2) ANSI 문법 : ROW_NUMBER() -- 11G
 SELECT *
  FROM
 (
  SELECT  ROW_NUMBER() OVER (ORDER BY SALARY DESC NULLS LAST)  RN, 
          EMPLOYEE_ID,  
          FIRST_NAME, 
          LAST_NAME, 
          SALARY
   FROM   EMPLOYEES
   )  T
   WHERE T.RN BETWEEN 11 AND 20
;
 
 
 3) ORACLE  12C 부터는 OFFSET
 SELECT    * 
  FROM     EMPLOYEES
  ORDER BY SALARY DESC NULLS LAST
  OFFSET   11 ROWS FETCH  NEXT 10 ROWS ONLY;
  -- 11 부터 10개 : ROW_NUMBER 보다 속도가 빠르다
  
  ---------------------------------------------------------
 2. RANK()        : 석차  (1,2,2,4,5,5,7...)
 
 월급순으로 석차를 출력(1~10등까지)
 사번,  이름,  월급,  석차
 SELECT * FROM
     (
     SELECT   EMPLOYEE_ID                  사번,  
              FIRST_NAME||' '||LAST_NAME   이름,  
              SALARY                       월급,  
              RANK() OVER (ORDER BY SALARY DESC NULLS LAST) 석차
      FROM    EMPLOYEES ) T
  WHERE  T.석차  BETWEEN 1 AND 10
 ;
 
-----------
 3. DENSE_RANK()  : 석차  (1,2,2,3,4,4,5,6...)
   
 SELECT * FROM
     (
     SELECT   EMPLOYEE_ID                  사번,  
              FIRST_NAME||' '||LAST_NAME   이름,  
              SALARY                       월급,  
              DENSE_RANK() OVER (ORDER BY SALARY DESC NULLS LAST) 석차
      FROM    EMPLOYEES ) T
  WHERE  T.석차  BETWEEN 1 AND 10
 ;
 
 
 --------------------------------------
 LISTAGG()  여러줄을 한줄짜리 문자열로 변경
 
 SELECT  DEPARTMENT_ID   FROM   EMPLOYEES;
 
 SELECT  DISTINCT DEPARTMENT_ID   FROM   EMPLOYEES;
 
 SELECT  LISTAGG(DISTINCT DEPARTMENT_ID)   FROM   EMPLOYEES;
 
 SELECT  LISTAGG(DISTINCT DEPARTMENT_ID, ',')   
  FROM   EMPLOYEES; -- 무순
 
 SELECT  LISTAGG(DISTINCT DEPARTMENT_ID, ',')   
   WITHIN GROUP(ORDER BY DEPARTMENT_ID DESC)  -- 정렬
  FROM   EMPLOYEES;
 
 
 



 
 

 
 