SELECT  SYSDATE  FROM DUAL;

SELECT EMPLOYEE_ID , HIRE_DATE
 FROM  EMPLOYEES
 WHERE HIRE_DATE = '15/09/21';
 
 ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 
SELECT EMPLOYEE_ID , HIRE_DATE
 FROM  EMPLOYEES
 WHERE HIRE_DATE = '2015-09-21';
 
-------------------------------------
-- 앞으로 날짜 표현은 다음과 같이 표현한다
SELECT EMPLOYEE_ID , TO_CHAR(HIRE_DATE,'YYYY-MM-DD')
 FROM  EMPLOYEES
-- WHERE TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') = '2015-09-21';
 WHERE TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') = '2026-04-07';
 
-- 입사후 일주일 이내인 직원명단
SELECT  EMPLOYEE_ID , TO_CHAR(HIRE_DATE,'YYYY-MM-DD')
 FROM   EMPLOYEES
 WHERE  HIRE_DATE >= SYSDATE -7 ;
 
 
-- 08월 입사자의 사번 , 이름, 입사일 을 입사일 순으로
SELECT  EMPLOYEE_ID                     "사 번",
        FIRST_NAME ||' '|| LAST_NAME     이름,
        TO_CHAR(HIRE_DATE,'YYYY-MM-DD')  입사일
 FROM   EMPLOYEES
 WHERE  TO_CHAR(HIRE_DATE,'MM') = '08';
 
-- 부서번호 80이 아닌 직원
SELECT   EMPLOYEE_ID , DEPARTMENT_ID
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID <> 80;   
 
--   =, <> , > , >= , < , <= , BETWEEN ~ AND
--   +, -, *, / , MOD(7, 2)
 
 
-- 2026년 04 월 08일 09시 45분 00초 오전 수요일
SELECT  SYSDATE,
        TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS DAY AM'),
        TO_CHAR(SYSDATE,'AM')
 FROM   DUAL;
 
 -- 1) TO_CHAR 활용
SELECT  SYSDATE,
        TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS DAY AM') 날짜1,
--      TO_CHAR(SYSDATE,'YYYY년MM월DD일 HH24시MI분SS초 DAY AM')             날짜2,  ORA-01821: 날짜 형식이 부적합합니다
        TO_CHAR(SYSDATE,'YYYY"年"MM"月"DD"日" HH24"時"MI"分"SS"秒" DAY AM') 날짜2,
        TO_CHAR(SYSDATE,'AM')
 FROM   DUAL;
 
 
 -- 2) IF를 구현
 -- 2-1) NVL(), NVL2() : NULL VALUE
 ---- 사번, 이름, 월급, COMMISSION_PCT( 단 NULL 이면 0으로 출력)
 SELECT   EMPLOYEE_ID                   사번,
          FIRST_NAME ||' '|| LAST_NAME  이름,
          SALARY                        월급,
          NVL (COMMISSION_PCT, 0 )      COMMISSION_PCT,
          NVL2(COMMISSION_PCT, SALARY+(SALARY*COMMISSION_PCT), SALARY) 보너스
  FROM    EMPLOYEES;

 
 -- 2-2) NULLIF(expr1, expr2)
 -- 둘을 비교해서 같으면 null, 같지않으면 expr1

 
 -- 2-3) DECODE() : DECODE (expr, search1, result1, 
 --                               search2, result2, …, default)
 -- DECODE는 expr과 search1을 비교해 두 값이 같으면 result1을, 
 -- 같지 않으면 다시 search2와 비교해 값이 같으면 result2를 반환하고,
 -- 이런 식으로 계속 비교한 뒤 최종적으로 같은 값이 없으면 default 값을 반환한다.
 
 -- 사번, 부서번호 ( 단 부서번호가 NULL 이면 '부서없음')
 SELECT  EMPLOYEE_ID                       사번, 
--       NVL(DEPARTMENT_ID, '부서없음')    부서번호 -- <-- (NUMBER)    -- ORA-01722: 수치가 부적합합니다 두 TYPE이 같아야함
         DECODE(DEPARTMENT_ID, NULL , '부서없음', DEPARTMENT_ID) 부서번호
  FROM   EMPLOYEES;
   
   
 SELECT   TO_CHAR(SYSDATE,'AM'),
          DECODE(TO_CHAR(SYSDATE,'AM') , '오전' , '午前' , '午後' )
  FROM    DUAL;
  ----------------------------------------------------
/*
10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
110	Accounting */
  -- DECODE 로
  -- 사번, 이름, 부서명
 SELECT   EMPLOYEE_ID                       부서번호, 
          FIRST_NAME ||' '|| LAST_NAME      이름, 
          DECODE(DEPARTMENT_ID, 
                                60 , 'IT' ,
                                80 , 'Sales' ,
                                90 , 'Executive' , '부서 없음' ) 부서명
  FROM    EMPLOYEES;
  
  
 -- 사번, 이름, 부서명 : 모든 부서명, NULL : 부서없음
  SELECT  EMPLOYEE_ID                       사번, 
          FIRST_NAME ||' '|| LAST_NAME      이름, 
          DECODE(DEPARTMENT_ID, 10 , 'Administration' ,
                                20 , 'Marketing' , 
                                30 , 'Purchasing',
                                40 , 'Human Resources',
                                50 , 'Shipping',
                                60 , 'IT' ,
                                70 , 'Public Relations' ,
                                80 , 'Sales' ,
                                90 , 'Executive' , 
                                100 , 'Finance' ,
                                110 , 'Accounting', '부서 없음' ) 부서명
  FROM    EMPLOYEES
  ;
  
  
  -- NULL 이 계산에 포함되면 결과는 NULL
  -- 직원명단, 직원의 월급 , 보너스 출력 연봉 출력
 SELECT EMPLOYEE_ID                                사번,
        FIRST_NAME ||' '|| LAST_NAME               이름,
        DECODE(SALARY,NULL,'급여미정',SALARY)      월급,
        NVL(SALARY*COMMISSION_PCT,0)               보너스,
--      SALARY * 13 + SALARY*COMMISSION_PCT        연봉
        SALARY * 13 + NVL(SALARY*COMMISSION_PCT,0) 연봉
  FROM  EMPLOYEES
  ;
  

--------------------------------------------------
 -- 3) CASE WHEN THEN END
 -- WHEN SCORE BETWEEN 90 AND 100       THEN 'A'
 -- WHEN 90 <= SCORE AND SCORE <= 100   THEN 'A'
 
 
 -- 사번, 이름, 부서명
  SELECT   EMPLOYEE_ID                   사번,
          FIRST_NAME ||' '|| LAST_NAME  이름,
          CASE DEPARTMENT_ID
              WHEN  60  THEN  'IT'
              WHEN  80  THEN  'Sales'
              WHEN  90  THEN  'Executive'
              ELSE            '그 외'
          END                           부서명
  FROM    EMPLOYEES
  ;
 
 
 SELECT   EMPLOYEE_ID                   사번,
          FIRST_NAME ||' '|| LAST_NAME  이름,
          CASE 
              WHEN  DEPARTMENT_ID = 60  THEN  'IT'
              WHEN  DEPARTMENT_ID = 80  THEN  'Sales'
              WHEN  DEPARTMENT_ID = 90  THEN  'Executive'
              ELSE                            '그 외'
          END                           부서명
  FROM    EMPLOYEES
  ;
  
  
  ----------------------------------------------------
  -- 집계함수 : AGGREGATE 함수
  -- 모든 집계함수는 NULL 값은 포함하지 않는다
  -- SUM(), AVG(), MIN(), MAX(), COUNT(), VARIANCE() 
  -- 그루핑 : GROUP BY
  -- ~ 별 인원수
  
 SELECT *                    FROM EMPLOYEES;
 SELECT COUNT(*)             FROM EMPLOYEES;  -- 109 : ROW 줄 수
 SELECT COUNT(EMPLOYEE_ID)   FROM EMPLOYEES;  -- 109
 SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES;  -- 106 : NULL값 3개 제외
 
 SELECT EMPLOYEE_ID          FROM EMPLOYEES
  WHERE DEPARTMENT_ID        IS NULL;         -- 총 3개
 
 SELECT COUNT(EMPLOYEE_ID)   FROM EMPLOYEES
  WHERE DEPARTMENT_ID        IS NULL;         -- 3
  
  
 -- 전체 직원의 월급 합 : 세로합 (NULL 제외) 
 SELECT COUNT(SALARY)        FROM EMPLOYEES;  -- 107 
 SELECT SUM(SALARY)          FROM EMPLOYEES;  -- 691416
 SELECT AVG(SALARY)          FROM EMPLOYEES;  -- 6461.831775700934579439252336448598130841
 SELECT MAX(SALARY)          FROM EMPLOYEES;  -- 24000
 SELECT MIN(SALARY)          FROM EMPLOYEES;  -- 2100
 
 SELECT SUM(SALARY)/COUNT(SALARY) FROM EMPLOYEES;  -- 6461.831775700934579439252336448598130841
 SELECT SUM(SALARY)/COUNT(*)      FROM EMPLOYEES;  -- 6343.266055045871559633027522935779816514
 
 
 -- 60번 부서의 평균월급
 SELECT  AVG(SALARY)       
  FROM   EMPLOYEES
  WHERE  DEPARTMENT_ID = 60;   -- 5760
 
 
 -- EMPLOYEES 테이블의 부서수를 알고 싶다
 SELECT   COUNT(DEPARTMENT_ID)
  FROM    EMPLOYEES;           -- 106
  
 SELECT   DEPARTMENT_ID
  FROM    EMPLOYEES;           -- 109개 줄이 나옴.
 
 
 -- 중복을 제거(DISTINCT) 한 부서의 수를 출력
 -- 중복을 제거한 부서번호 리스트
 SELECT   DISTINCT DEPARTMENT_ID
  FROM    EMPLOYEES;               -- 12줄
  
 SELECT  COUNT(DISTINCT DEPARTMENT_ID)
  FROM    EMPLOYEES;               -- 11 
  
  
  -- 직원이 근무하는 부서의 수 : 부서장이 있는 부서수 : DEPARTMENTS
  SELECT  COUNT(DEPARTMENT_ID)
   FROM   DEPARTMENTS
   WHERE  MANAGER_ID IS NOT NULL;             -- 11개
  
  -- 직원수 , 월급합, 월급평균 , 최대월급, 최소월급
  SELECT  COUNT(EMPLOYEE_ID) , SUM(SALARY) , AVG(SALARY), MAX(SALARY), MIN(SALARY)
   FROM   EMPLOYEES;                                 
  
  -- 부서 60번 부서 인원수, 월급합, 월급평균
  SELECT  COUNT(EMPLOYEE_ID) , SUM(SALARY), AVG(SALARY)
   FROM   EMPLOYEES
   WHERE  DEPARTMENT_ID = 60 ;                           -- 5명
  
  -- 부서 50,60,80번 부서가 아닌 인원수, 월급합, 월급평균
  SELECT  COUNT(EMPLOYEE_ID) , SUM(SALARY), AVG(SALARY)
   FROM   EMPLOYEES
   WHERE  DEPARTMENT_ID != 50 AND DEPARTMENT_ID != 60 AND DEPARTMENT_ID != 80;   -- 22명 
 
 
 
 
 