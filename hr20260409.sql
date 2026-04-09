SELECT * FROM TAB;


/*--------------------------------------------------------------
SUBQUERY : SQL 문 안에 SQL문을 넣어서 실행한 방법
         : 반드시 () 안에 있어야 한다
         : () 안에는 ORDER BY를 사용 불가
         : WHERE 조건에 맞도록 작성 한다
         : 쿼리를 실행하는 순서가 필요할때
--------------------------------------------------------------*/
----  IT 부서의 직원정보를 출력하시오
-- 1) IT부서의 부서번호를 찾는다.
SELECT  DEPARTMENT_ID
 FROM   DEPARTMENTS
 WHERE  DEPARTMENT_NAME = 'IT';

-- 2) 60번 부서의 직원정보를 출력
SELECT   EMPLOYEE_ID                 사번,
         FIRST_NAME||' '||LAST_NAME  이름,
         DEPARTMENT_ID               부서번호
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID = 60;
 
-- 1+2) 합치기 
SELECT   EMPLOYEE_ID                 사번,
         FIRST_NAME||' '||LAST_NAME  이름,
         DEPARTMENT_ID               부서번호
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID IN (SELECT  DEPARTMENT_ID
                            FROM   DEPARTMENTS
                            WHERE  DEPARTMENT_NAME IN ('IT','Sales') )
;


-- 평균월급보다 많은 월급을 받는 사람의 명단
-- 1) 평균 월급       --6461.831775700934579439252336448598130841
SELECT  AVG(SALARY)
 FROM   EMPLOYEES
 ;

-- 2) 월급이 --> 6461.83177 보다 많은 직원
SELECT  EMPLOYEE_ID   ,
        FIRST_NAME||' '||LAST_NAME,
        SALARY
 FROM   EMPLOYEES
 WHERE  SALARY >= 6461.83177;
 
-- 1+2)
SELECT  EMPLOYEE_ID   ,
        FIRST_NAME||' '||LAST_NAME,
        SALARY
 FROM   EMPLOYEES
 WHERE  SALARY >= (SELECT AVG(SALARY)
                    FROM  EMPLOYEES)
 ORDER BY SALARY DESC
;


-- 60번(IT) 부서의 평균월급보다 많은 월급을 받는 사람의 명단  -- 5760
SELECT  EMPLOYEE_ID   ,
        FIRST_NAME||' '||LAST_NAME,
        SALARY
 FROM   EMPLOYEES
 WHERE  SALARY >= (SELECT  AVG(SALARY)
                    FROM   EMPLOYEES
                    WHERE  DEPARTMENT_ID = (SELECT  DEPARTMENT_ID
                                             FROM   DEPARTMENTS
                                             WHERE  DEPARTMENT_NAME = 'IT'))
 ORDER BY SALARY DESC
;

-- 50번 부서의 최고 월급자의 이름을 출력
SELECT  EMPLOYEE_ID   ,
        FIRST_NAME||' '||LAST_NAME,
        SALARY,
        DEPARTMENT_ID
 FROM   EMPLOYEES
 WHERE  SALARY = (SELECT  MAX(SALARY)
                    FROM   EMPLOYEES
                    WHERE  DEPARTMENT_ID = 50) AND DEPARTMENT_ID = 50
;




-- SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단
-- Sales 부서 ID 찾기 - 80
SELECT  DEPARTMENT_ID
 FROM   DEPARTMENTS
 WHERE  DEPARTMENT_NAME = 'Sales';
-- Salse 부서의 평균월급  -- 8955
SELECT  AVG(SALARY)
 FROM   EMPLOYEES
 WHERE  DEPARTMENT_ID = (SELECT  DEPARTMENT_ID
                          FROM   DEPARTMENTS
                          WHERE  DEPARTMENT_NAME = 'Sales')
 ;
-- Sales 부서의 평균월급(8955)보다 많은 월급
SELECT  EMPLOYEE_ID   ,
        FIRST_NAME||' '||LAST_NAME,
        SALARY
 FROM   EMPLOYEES
 WHERE  SALARY >= (SELECT  AVG(SALARY)
                    FROM   EMPLOYEES
                    WHERE  DEPARTMENT_ID = (SELECT  DEPARTMENT_ID
                                             FROM   DEPARTMENTS
                                             WHERE  UPPER(DEPARTMENT_NAME) = 'SALES'))
 ORDER BY SALARY DESC
;


-- 다중 열 SUBQUERY
SELECT *
 FROM  EMPLOYEES A
 WHERE ( A.JOB_ID, A.SALARY) IN (
            SELECT JOB_ID, MIN(SALARY) 그룹별급여
              FROM EMPLOYEES
              GROUP BY JOB_ID)
 ORDER BY A.SALARY DESC
;

-- 상관 서브 쿼리 CORELATIVE SUBQUERY
-- job_history 에 있는 부서번호와 DEPARTMENTS 에 있는 부서번호가 같은 부서를 찾아서
-- DEPARTMENTS 에 있는 부서 번호와 부서명을 출력
SELECT A.DEPARTMENT_ID, A.DEPARTMENT_NAME
      FROM DEPARTMENTS A
     WHERE EXISTS ( SELECT 1
                      FROM JOB_HISTORY B
                     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID );
                     
-- SHIPPING 부서의 직원명단
-- 부서번호 찾기
SELECT  DEPARTMENT_ID
 FROM   DEPARTMENTS
 WHERE  UPPER(DEPARTMENT_NAME) = 'SHIPPING'; -- 50번
 
SELECT  EMPLOYEE_ID , FIRST_NAME||' '||LAST_NAME, DEPARTMENT_ID
 FROM   EMPLOYEES 
 WHERE  DEPARTMENT_ID = (SELECT  DEPARTMENT_ID
                            FROM   DEPARTMENTS
                            WHERE  UPPER(DEPARTMENT_NAME) = 'SHIPPING')
;
                     
                     
-------------------------------------------------------------------
-- join
-------------------------------------------------------------------
-- 직원이름 , 부서명  -- 출력줄수 109줄
SELECT 109 * 27 FROM DUAL;

-- ORACLE OLD 문법
-- 1) 109 * 27 = 2943개   카티션 프로덕트(cartesian product) -> CROSS JOIN  : 조건이 없는.
SELECT FIRST_NAME||' '||LAST_NAME     직원이름 , 
       DEPARTMENT_NAME                부서명
 FROM  EMPLOYEES, DEPARTMENTS
 ;
 
-- 2) 109 - 3(부서번호 NULL) 106 개    
-- 내부조인  -> INNER JOIN  : 양쪽 다 존재하는 DATA만, NULL 제외
-- 비교조건이 필수
SELECT EMPLOYEES.FIRST_NAME||' '||EMPLOYEES.LAST_NAME     직원이름 , 
       DEPARTMENTS.DEPARTMENT_NAME                        부서명
 FROM  EMPLOYEES, DEPARTMENTS
 WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
;

SELECT E.FIRST_NAME||' '||E.LAST_NAME     직원이름 , 
       D.DEPARTMENT_NAME                  부서명
 FROM  EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

-- 3) LEFT OUTER JOIN
-- 모든 직원을 출력하라 : 109 줄
-- 직원의 부서번호가 NULL 이라도 출력해야한다
-- (+) : 기준(직원)이 되는 조건의 반대방향에 붙인다
--       NULL이 출력될 곳
SELECT  E.FIRST_NAME||' '||E.LAST_NAME     이름 , 
        D.DEPARTMENT_NAME                  부서명
 FROM   EMPLOYEES E , DEPARTMENTS D
 WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
 ;

-- 4) RIGHT OUTER JOIN  -- 109
SELECT  E.FIRST_NAME||' '||E.LAST_NAME     이름 , 
        D.DEPARTMENT_NAME                  부서명
 FROM   EMPLOYEES E , DEPARTMENTS D
 WHERE  D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID
 ;


-- 4) RIGHT OUTER JOIN  -- 122   :   (109 - 3) + (27 - 11)
-- 모든 부서를 출력하라
-- 직원정보가 없더라도 출력해야한다
SELECT  E.FIRST_NAME||' '||E.LAST_NAME     이름 , 
        D.DEPARTMENT_NAME                  부서명
 FROM   EMPLOYEES E , DEPARTMENTS D
 WHERE  E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID
 ;
 
-- 5) FULL OUTER JOIN  -  OLD 문법에서 존재하지 않는 명령
-- 모든 직원과 모든 부서를 출력 

---------------------------------------------------------
-- 표준 SQL 문법
-- 1) CROSS JOIN : 2943개
SELECT E.FIRST_NAME||' '||E.LAST_NAME,  D.DEPARTMENT_NAME
 FROM  EMPLOYEES E CROSS JOIN DEPARTMENTS D
 ;

-- 2) (INNER) JOIN : 106  - INNER 생략 가능.
-- WHERE과 별도로 TABLE을 합치는 조건에 해당하는 부분만 ON을 사용하여 조건을 입력
SELECT  E.FIRST_NAME, E.LAST_NAME , D.DEPARTMENT_NAME
 FROM   EMPLOYEES E INNER JOIN DEPARTMENTS D  
   ON E.DEPARTMENT_ID = D.department_id
 ;



-- 3) OUTER JOIN
-- 3-1 LEFT (OUTER) JOIN -- 109
SELECT  E.FIRST_NAME||' '||E.LAST_NAME , D.DEPARTMENT_NAME
 FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

-- 3-2 RIGHT (OUTER) JOIN : 122
SELECT  E.FIRST_NAME||' '||E.LAST_NAME , D.DEPARTMENT_NAME
 FROM   EMPLOYEES E RIGHT JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

-- 3-3 FULL (OUTER) JOIN : 125   109 + 27 - 16(있는 부서수)
SELECT  E.FIRST_NAME||' '||E.LAST_NAME , D.DEPARTMENT_NAME
 FROM   EMPLOYEES E FULL JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

---------------------------------------------------
-- 직원이름, 담당업무(JOB_TITLE)   : 109
SELECT  E.FIRST_NAME||' '||E.LAST_NAME, J.JOB_TITLE
 FROM   EMPLOYEES E JOIN JOBS J
  ON    E.JOB_ID = J.JOB_ID
;

-- 부서명, 부서위치(CITY, STREET_ADDRESS) : 27
SELECT  D.DEPARTMENT_NAME , L.CITY , L.STREET_ADDRESS
 FROM  DEPARTMENTS D  LEFT JOIN LOCATIONS L
  ON   D.LOCATION_ID = L.LOCATION_ID
  ORDER BY DEPARTMENT_NAME
;

-- 직원명, 부서명, 부서위치(CITY, STREET_ADDRESS) : 109
SELECT  E.FIRST_NAME||' '||E.LAST_NAME 직원명, D.DEPARTMENT_NAME, L.CITY||' '|| L.STREET_ADDRESS 부서위치
 FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                    LEFT JOIN LOCATIONS L    ON D.LOCATION_ID = L.LOCATION_ID
 ORDER BY 직원명
;

-- 직원명, 부서명, 국가, 부서위치(CITY, STREET_ADDRESS) : 109
SELECT  E.FIRST_NAME||' '||E.LAST_NAME 직원명, D.DEPARTMENT_NAME 부서명, C.COUNTRY_NAME ,L.CITY||' '|| L.STREET_ADDRESS
 FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                    LEFT JOIN LOCATIONS L    ON D.LOCATION_ID = L.LOCATION_ID
                    LEFT JOIN COUNTRIES C    ON L.COUNTRY_ID  = C.COUNTRY_ID
 ORDER BY 직원명, 부서명
;


-- 부서명, CITY : 모든부서 : 27줄 이상 :  27
SELECT D.DEPARTMENT_NAME , L.CITY 
 FROM   DEPARTMENTS D LEFT JOIN LOCATIONS L
 ON     D.LOCATION_ID = L.LOCATION_ID
;

-- 부서명, 국가(COUNTRY_NAME) : 모든부서 : 27줄 이상 :  27
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME , C.COUNTRY_NAME
 FROM   DEPARTMENTS D LEFT JOIN LOCATIONS L  ON   D.LOCATION_ID = L.LOCATION_ID
                      LEFT JOIN COUNTRIES C  ON   L.COUNTRY_ID  = C.COUNTRY_ID
;

------------------- 전부다--
SELECT E.FIRST_NAME||' '||E.LAST_NAME , D.DEPARTMENT_NAME ,R.REGION_NAME, C.COUNTRY_NAME , L.CITY||' '||L.STREET_ADDRESS
 FROM   EMPLOYEES E   LEFT JOIN DEPARTMENTS D ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID
                      LEFT JOIN LOCATIONS L   ON  D.LOCATION_ID = L.LOCATION_ID
                      LEFT JOIN COUNTRIES C   ON  L.COUNTRY_ID = C.COUNTRY_ID
                      LEFT JOIN REGIONS R     ON  C.REGION_ID  = R.REGION_ID
;


-- 직원명, 부서위치 단 IT 부서만.
SELECT  E.FIRST_NAME||' '||E.LAST_NAME   직원명,
        L.STATE_PROVINCE ||', '|| L.CITY ||', '|| L.STREET_ADDRESS   부서위치,
        D.DEPARTMENT_NAME                부서명,  
        C.COUNTRY_NAME                   나라명
 FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D  ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                    LEFT JOIN LOCATIONS L    ON D.LOCATION_ID = L.LOCATION_ID
                    LEFT JOIN COUNTRIES C    ON L.COUNTRY_ID  = C.COUNTRY_ID
 WHERE UPPER(D.DEPARTMENT_NAME) = 'IT'
;


-- 부서명별 월급평균
SELECT  D.DEPARTMENT_NAME  부서명 , E.DEPARTMENT_ID , ROUND(AVG(E.SALARY),2) 평균월급
 FROM   EMPLOYEES E   JOIN  DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_NAME , E.DEPARTMENT_ID
 ORDER BY E.DEPARTMENT_ID
;

-- 모든 부서를 출력
SELECT  D.DEPARTMENT_NAME  부서명 , E.DEPARTMENT_ID , 
        DECODE(AVG(E.SALARY), NULL, '직원없음' , ROUND(AVG(E.SALARY),2)) 평균월급
 FROM   EMPLOYEES E  RIGHT JOIN  DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_NAME , E.DEPARTMENT_ID
 ORDER BY E.DEPARTMENT_ID
;

-- 직원의 근무연수
-- MONTHS_BETWEEN(날짜1,날짜2) : 날짜1 - 날짜2 : 월 단위로
-- ADD_MONTHS(날짜, n) : 날짜+n 개월 / 날짜-n 개월
SELECT  FIRST_NAME||' '||LAST_NAME                      직원명 , 
        TO_CHAR(HIRE_DATE,'YYYY-MM-DD')                 입사일,
        TO_CHAR(TRUNC(HIRE_DATE,'MM'),'YYYY-MM-DD')     "입사월의 첫번째날",
        TO_CHAR(LAST_DAY(HIRE_DATE),'YYYY-MM-DD')       "입사월의 마지막날",
        TRUNC(SYSDATE-HIRE_DATE)                        근무일수, 
        TRUNC( (SYSDATE-HIRE_DATE) / 365.2422)          근무연수, 
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) 근무연수
 FROM   EMPLOYEES
 ;

SELECT ADD_MONTHS(SYSDATE,+12) FROM DUAL;



-- 60번 부서 최소월급과 같은 월급자의 명단출력
SELECT EMPLOYEE_ID , FIRST_NAME||' '||LAST_NAME, SALARY  
 FROM  EMPLOYEES
 WHERE  (SELECT MIN(SALARY)
         FROM  EMPLOYEES
         WHERE DEPARTMENT_ID = 60) = SALARY
;
         
         
-- 부서명, 부서장의 이름
SELECT  D.DEPARTMENT_NAME , E.FIRST_NAME||' '||E.LAST_NAME
 FROM   DEPARTMENTS D LEFT JOIN EMPLOYEES E  ON D.MANAGER_ID = E.EMPLOYEE_ID
;

/*------------------------------
 결합연산자 - 줄단위 결합
 조건 - 두 테이블의 칸수와 타입이 동일해야 한다
 1) UNION      : 중복제거
 2) UNION ALL  : 중복포함
 3) INTERSECT  : 교집합 - 공통부분
 4) MINUS      : 차집합  a - b 
 */
 
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;  -- 34
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;  -- 45
 
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80
 UNION
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;  -- 79
 
 -- 칼럼수와 칼럼들의 TYPE 이 같으면 합쳐진다 -> 주의할 것  : 의미없는 결합
 SELECT EMPLOYEE_ID,   FIRST_NAME      FROM EMPLOYEES
 UNION
 SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;
 


-- 직원정보, 담당업무

-- 직원이름, 담당업무, 담당업무 히스토리
SELECT  E.EMPLOYEE_ID , E.FIRST_NAME||' '||E.LAST_NAME , J.JOB_TITLE
 FROM   EMPLOYEES E LEFT JOIN JOBS J  ON E.JOB_ID = J.JOB_ID
 ;


-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
SELECT  EMPLOYEE_ID  사번 , TO_CHAR(HIRE_DATE,'YYYY-MM-DD')업무시작일, '재직중' 업무종료일 , JOB_ID 업무, DEPARTMENT_ID 부서번호
 FROM   EMPLOYEES 
 UNION
 SELECT EMPLOYEE_ID , TO_CHAR(START_DATE,'YYYY-MM-DD'),TO_CHAR(END_DATE,'YYYY-MM-DD') , JOB_ID, DEPARTMENT_ID
 FROM   JOB_HISTORY
 ORDER BY 사번
 ;


