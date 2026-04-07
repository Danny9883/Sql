 SELECT * FROM tab;  -- 테이블 목록 조회

 /*
 SELECT     칼럼명1  별칭1 , 칼럼명2  별칭2 , 칼럼명3  별칭3  ...
  FROM      테이블명
  WHERE     조건
  ORDER BY  정렬할칼럼1 ASC, 칼럼2 DESC
  */
  
 -- 직원의 이름을 성과 이름을 붙여서 출력
  SELECT    FIRST_NAME , LAST_NAME, FIRST_NAME || ' ' || LAST_NAME  EMPNAME
   FROM     EMPLOYEES
 --  ORDER BY FIRST_NAME || ' ' || LAST_NAME
 --  ORDER BY EMPNAME
 ORDER BY 3;         -- 3번째 칼럼을 기준으로
 
 
 -- 부서번호가 60인 직원정보 (번호 , 이름 , 이메일 , 부서번호)
 -- 조건 : = , !=(<>, ^=)
 --        > , < , >= , <=
 --        NOT , AND , OR
 SELECT     EMPLOYEE_ID                     번호, 
            FIRST_NAME || ' ' || LAST_NAME  이름, 
            EMAIL                           이메일, 
            DEPARTMENT_ID                   부서번호
  FROM      EMPLOYEES
  WHERE     DEPARTMENT_ID = 60
  ORDER BY  이름 ASC;
  
  
  -- 직원번호가 90인 직원정보
 SELECT     EMPLOYEE_ID                     번호, 
            FIRST_NAME || ' ' || LAST_NAME  이름, 
            EMAIL                           이메일, 
            DEPARTMENT_ID                   부서번호
  FROM      EMPLOYEES
  WHERE     DEPARTMENT_ID = 90
  ORDER BY  이름 ASC;
  
  
  -- 부서번호가 60, 90 인 직원정보 (번호, 이름, 이메일, 부서번호)
 SELECT     E.EMPLOYEE_ID                       번호, 
            E.FIRST_NAME || ' ' || E.LAST_NAME  이름, 
            E.EMAIL                             이메일, 
            DEPARTMENT_ID                       부서번호
  FROM      EMPLOYEES  E
  WHERE     E.DEPARTMENT_ID = 60 OR E.DEPARTMENT_ID = 90   -- OR : 이거나 + 논리합
  ORDER BY  번호 ASC;
  
  
  -- IN 명령어 - 다중 OR을 대체
 SELECT     E.EMPLOYEE_ID                       번호, 
            E.FIRST_NAME || ' ' || E.LAST_NAME  이름, 
            E.EMAIL                             이메일, 
            DEPARTMENT_ID                       부서번호
  FROM      EMPLOYEES  E
  WHERE     E.DEPARTMENT_ID   IN   (60,90,80)
  ORDER BY  부서번호 ASC, 이름 ASC 
  -- 부서번호순, 부서번호가 같으면 이름순
  ;
  
  
  -- 1. 월급이 12000 이상인 직원의 번호, 이름, 이메일, 월급을 월급순으로 출력
  SELECT  EMPLOYEE_ID                     번호, 
          FIRST_NAME || ' ' || LAST_NAME  이름, 
          EMAIL                           이메일, 
          SALARY                          월급
   FROM   EMPLOYEES
   WHERE  SALARY >= 12000
   ORDER BY SALARY DESC;
  
  -- 2. 월급이 10000 ~ 15000 인 직원의 사번, 이름, 월급, 부서번호
  SELECT  EMPLOYEE_ID                     번호,
          FIRST_NAME || ' ' || LAST_NAME  이름, 
          SALARY                          월급,
          DEPARTMENT_ID                   부서번호
   FROM   EMPLOYEES
   WHERE  10000 <= SALARY AND SALARY <= 15000
   ORDER BY SALARY DESC;
   
   
 -- 2-2. 월급이 10000 ~ 15000 인 직원의 사번, 이름, 월급, 부서번호
  SELECT  EMPLOYEE_ID                     번호,
          FIRST_NAME || ' ' || LAST_NAME  이름, 
          SALARY                          월급,
          DEPARTMENT_ID                   부서번호
   FROM   EMPLOYEES
   WHERE  SALARY BETWEEN 10000 AND 15000       -- 월급  10000<=SALARY<=15000
   ORDER BY SALARY DESC;
   
  
  -- 3. 직업 ID가 IT_PROG 인 직원명단
  -- 1)
 SELECT   EMPLOYEE_ID                     번호,
          FIRST_NAME || ' ' || LAST_NAME  이름, 
          JOB_ID                          부서명,
          DEPARTMENT_ID                   부서번호
   FROM   EMPLOYEES
   WHERE  JOB_ID = 'IT_PROG'  OR  JOB_ID = 'it_prog'
   ;
   
 -- 2) UPPER(), LOWER(), INITCAP()  함수
 SELECT   EMPLOYEE_ID                     번호,
          FIRST_NAME || ' ' || LAST_NAME  이름, 
          JOB_ID                          부서명,
          DEPARTMENT_ID                   부서번호
   FROM   EMPLOYEES
   WHERE  LOWER(JOB_ID) = 'it_prog'
   ;
   
   
-- 4. 직원 이름이 GRANT 인 직원을 찾으세요
SELECT    EMPLOYEE_ID                    번호,
          FIRST_NAME || ' ' || LAST_NAME 이름,
          EMAIL                          이메일
 FROM     EMPLOYEES
 WHERE    UPPER(LAST_NAME) = 'GRANT' or UPPER(FIRST_NAME) = 'GRANT'
 ORDER BY 이름 ASC
 ;
 


-- 5. 사번, 월급, 10% 인상한 월급
SELECT   EMPLOYEE_ID                     EMPID,
         FIRST_NAME || ' ' || LAST_NAME  ENAME,
         SALARY                          SAL,
         SALARY*1.1                      SAL2
 FROM    EMPLOYEES
 ORDER BY SALARY DESC
 ;


-- 6. 50번 부서의 직원명단, 월급, 부서번호
SELECT   EMPLOYEE_ID                     번호,
         FIRST_NAME || ' ' || LAST_NAME  이름,
         SALARY                          월급,
         DEPARTMENT_ID                   부서번호
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID = 50
 ;


-- 7. 20, 80, 60, 90 번 부서의 직원명단, 월급 , 부서번호
SELECT   EMPLOYEE_ID                     번호,
         FIRST_NAME || ' ' || LAST_NAME  이름,
         SALARY                          월급,
         DEPARTMENT_ID                   부서번호
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID IN (20,80,60,90)
 ;
 
 -- 중요 데이터를 2개 입력
 ---- 전체 자료수
 SELECT  COUNT(*)
 FROM  EMPLOYEES;     -- 107   ROW 의 COUNT
 
 SELECT SYSDATE -- 오늘의 날짜  연/월/일 시분초
 FROM   DUAL;   -- 1줄 찍기 위한 가상테이블
 
 
 -- 신입사원 입사 ( 박보검 , 장원영 )
 INSERT  INTO  EMPLOYEES
  VALUES ( 207 , '보검' , '박' , 'BOKUM' , '1.515.555.8888' , SYSDATE ,
           'IT_PROG' , NULL , NULL , NULL , NULL);
           
 INSERT  INTO  EMPLOYEES
  VALUES ( 208 , '리나' , '카' , 'LINA' , '1.515.555.9999' , SYSDATE ,
           'IT_PROG' , NULL , NULL , NULL , NULL);
           
 SELECT * FROM EMPLOYEES;
 SELECT COUNT(*) FROM EMPLOYEES;  -- 109
 
 UPDATE   EMPLOYEES
  SET     EMAIL        = 'KRINA' , 
          PHONE_NUMBER = '010-1234-5678'
  WHERE   EMPLOYEE_ID  = 208 ;

 
 COMMIT;
 ROLLBACK;
 
 
 -- 8. 보너스 없는 직원명단 (COMMISSION_PCT 가 없다)
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        COMMISSION_PCT                  커미션
  FROM  EMPLOYEES
--  WHERE COMMISSION_PCT IS NULL;
  WHERE COMMISSION_PCT IS NOT NULL;
 
 
 -- 9. 전화번호가 010으로 시작하는
 -- PATTERN MATCHING  -  LIKE
 -- % : 0 자 이상의 모든 숫자 글자
 -- _ : 1 자의 모든 숫자 글자
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        PHONE_NUMBER                    전화번호
  FROM  EMPLOYEES
--  WHERE PHONE_NUMBER  LIKE  '010%';    -- 010으로 시작하는 / STARTS WITH  ~로 시작하는
--  WHERE PHONE_NUMBER  LIKE  '%555%';   -- CONTAINS   ~를 포함하는
  WHERE PHONE_NUMBER  LIKE  '%16';      -- ENDS WITH  ~로 끝나는
 
 
 
 -- 10. LAST_NAME 세번째, 네번째 글자가 LL 인것을 찾아라
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME                      이름,
        LAST_NAME                       성
  FROM  EMPLOYEES
  WHERE UPPER(LAST_NAME)  LIKE  '__LL%';
  
 -----------------------------------------------
 SELECT   EMPLOYEE_ID , FIRST_NAME, HIRE_DATE
  FROM    EMPLOYEES;

  
 -- 날짜 26/04/07 : 표현법이 틀림  년/월/일
 -- 2026-04-07    : ANSI 표준
 -- 04/07/26      : 월/일/년  -> 미국식
 -- 07/04/26      : 일/월/년  -> 영국식
 
 ALTER   SESSION  SET  NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
 
 SELECT  SYSDATE      FROM  DUAL;   -- 26/04/07
 SELECT  7/2          FROM  DUAL;   -- 3.5
 SELECT  0/2          FROM  DUAL;   -- 0
 SELECT  2.0/0.0      FROM  DUAL;   -- 오류 : ORA-01476 : 제수가 0 입니다
 SELECT  SYSTIMESTAMP FROM  DUAL;   -- 26/04/07 15:35:54.870000000 +09:00
 
 SELECT   SYSDATE - 7   "일주일 전 날짜"
        , SYSDATE       "오늘 날짜"
        , SYSDATE + 7   "일주일 후 날짜"
  FROM   DUAL;
--  날짜 + n , 날짜 - n : 며칠 전 후
--  날짜1 - 날짜2       : 두 날짜 사이의 차이를 일 수로 계산
--  날짜1 + 날짜2       : 오류 잘못된 표현 - 의미없음

-- 크리스마스와 오늘 날짜의 차이
 SELECT  TO_DATE('26/12/25') - SYSDATE
  FROM   DUAL;         -- 261.340972222222222222222222222222222222 일
  
-- 소수이하 3자리로 반올림   : ROUND(VAL,3)
-- 소수이하 3자리로 절사     : TRUNC(VAL,3)
-- 15일 기준으로 반올림 날짜 : ROUND(SYSDATE,'MONTH')
-- 해당달의 첫번째 날짜      : TRUNC(SYSDATE,'MONTH')
 SELECT  SYSDATE, ROUND(SYSDATE,'MONTH'), TRUNC(SYSDATE,'MONTH')
  FROM   DUAL;
  
 SELECT  NEXT_DAY(SYSDATE, '월요일')  FROM  DUAL;  -- 26/04/13 : 다음 월요일
 SELECT  TRUNC(SYSDATE , 'MONTH')     FROM  DUAL;  -- 26/04/01 : 날짜의 해당월의 첫번째 날
 SELECT  LAST_DAY(SYSDATE)            FROM  DUAL;  -- 26/04/30 : 날짜의 해당월의 마지막 날
 
 
  
 -- 11. 입사년월이 17년 2월인 사원 출력
 ALTER   SESSION  SET  NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        HIRE_DATE                       입사일
  FROM  EMPLOYEES
--  WHERE HIRE_DATE  BETWEEN  '2017-02-01'  AND LAST_DAY('2017-02-01');
  WHERE TRUNC(HIRE_DATE,'MONTH') = '2017-02-01';
 
 
 
 -- 12. '17/02/07' 에 입사한 사람 출력
 ALTER   SESSION  SET  NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        HIRE_DATE                       입사일
  FROM  EMPLOYEES
  WHERE '2017-02-07 00:00:00' <= HIRE_DATE AND HIRE_DATE <= '2017-02-07 23:59:59';
  
  
 --     '12/06/07' 에 입사한 사람 출력
 ALTER   SESSION  SET  NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        HIRE_DATE                       입사일
  FROM  EMPLOYEES
  WHERE HIRE_DATE  = '2012-06-07';
  
     

 
 -- 13. 오늘 '26/04/07' 에 입사한 사람
 ALTER   SESSION  SET  NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        HIRE_DATE                       입사일
  FROM  EMPLOYEES
--  WHERE '2026-04-07 00:00:00' <= HIRE_DATE AND HIRE_DATE <= '2026-04-07 23:59:59';
  WHERE TRUNC(HIRE_DATE) = '2026-04-07';
  

  
-- TYPE 변환
-- TO_DATE(문자)     -> 날짜
-- TO_NUMBER(문자)   -> 숫자
-- TO_CHAR( 숫자, '포맷') -> 글자
-- TO_CHAR( 날짜, '포맷') -> 날짜 형태의 문자
-- 포맷 : YYYY-MM-DD HH24:MI:SS DAY AM
--        YYYY : 연도
--        MM   : 월
--        DD   : 일
--        HH24 : 시 24시간  , HH12
--        MI   : 분
--        SS   : 초
--        DAY  : 요일 , 일요일
--        DY   : 요일 , 일
--        AM   : 오전/오후

-- 11. 입사년월이 17년 2월인 사원 출력
 ALTER   SESSION  SET  NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
 SELECT  EMPLOYEE_ID                     사번,
         FIRST_NAME || ' ' || LAST_NAME  이름,
         HIRE_DATE                       입사일
  FROM   EMPLOYEES
  WHERE  TO_CHAR(HIRE_DATE, 'YYYY-MM') = '2017-02';
  
  
 
-- 화요일 입사자를 출력
 SELECT     EMPLOYEE_ID                     사번,
            FIRST_NAME || ' ' || LAST_NAME  이름,
            TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'),
            TO_CHAR(HIRE_DATE, 'DAY')
  FROM      EMPLOYEES
  WHERE     TO_CHAR(HIRE_DATE, 'DAY') = '화요일'
  ORDER BY  HIRE_DATE ASC;
  
  
-- 입사후 일주일 이내인 직원명단
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        HIRE_DATE                       입사일
  FROM  EMPLOYEES
  WHERE HIRE_DATE >= SYSDATE -7;
 
 
-- 08월 입사자의 사번, 이름, 입사일을 입사일 순으로
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        HIRE_DATE                       입사일
  FROM  EMPLOYEES
  WHERE TO_CHAR(HIRE_DATE, 'MM') = 08
  ORDER BY HIRE_DATE ;
 
 
-- 부서번호 80이 아닌직원
 SELECT EMPLOYEE_ID                     사번,
        FIRST_NAME || ' ' || LAST_NAME  이름,
        DEPARTMENT_ID                   부서번호
  FROM  EMPLOYEES
  WHERE DEPARTMENT_ID != 80;
  
  
  
 /*  직원사번 , 입사일  */
 SELECT  EMPLOYEE_ID , HIRE_DATE
  FROM   EMPLOYEES;
 
-- 2024년 04월 07일 17시 16분 30초 오후 수요일
-- 한자로 출력
 SELECT TO_CHAR(SYSDATE,'YYYY')||'年 '||
        TO_CHAR(SYSDATE,'MM')||'月 '||
        TO_CHAR(SYSDATE,'DD')||'日 '||
        TO_CHAR(SYSDATE,'HH24')||'時 '||
        TO_CHAR(SYSDATE,'MI')||'分 '||
        TO_CHAR(SYSDATE,'SS')||'秒 '|| 
         CASE WHEN TO_CHAR(SYSDATE,'AM')='오후' THEN '午後'
              WHEN TO_CHAR(SYSDATE,'AM')='오전' THEN '午前'
              END 
        ||' '||                   
        CASE WHEN TO_CHAR(SYSDATE,'DY')='월' THEN '月曜日'
             WHEN TO_CHAR(SYSDATE,'DY')='화' THEN '火曜日'
             WHEN TO_CHAR(SYSDATE,'DY')='수' THEN '水曜日'
             WHEN TO_CHAR(SYSDATE,'DY')='목' THEN '木曜日'
             WHEN TO_CHAR(SYSDATE,'DY')='금' THEN '金曜日'
             WHEN TO_CHAR(SYSDATE,'DY')='토' THEN '土曜日'
             WHEN TO_CHAR(SYSDATE,'DY')='일' THEN '日曜日'
             END AS "오늘의 날짜"
  FROM DUAL;


  
  
 
 
  
  