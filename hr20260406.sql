SELECT * FROM TAB;

DESC EMPLOYEES;


SELECT * FROM EMPLOYEES;

-- 직원 번호가 100인 사람을 출력
SELECT * 
 FROM   EMPLOYEES
 WHERE  employee_id = 100;
 
 -- King 이라는 직원을 출력
SELECT *
 FROM  EMPLOYEES
 WHERE LAST_NAME = 'King';
 
 -- 월급 내림차순으로 직원정보를 출력
SELECT     EMPLOYEE_ID, FIRST_NAME, LAST_NAME , SALARY
 FROM      EMPLOYEES
 ORDER BY  SALARY DESC;     -- 107명
 
  -- 월급이 내림차순으로 월급이 5000 이상인 직원정보를 출력
SELECT     EMPLOYEE_ID, FIRST_NAME, LAST_NAME , SALARY
 FROM      EMPLOYEES
 WHERE     SALARY >= 5000
 ORDER BY  SALARY DESC;   -- 58명
 

-- 전화번호에 100이 포함된 직원
SELECT  *
FROM   EMPLOYEES
WHERE  PHONE_NUMBER LIKE '%100%';

-- 50번 부서의 직원을 출력해라
SELECT  *
FROM  employees
WHERE department_id = 50;
 
-- 부서가 없는 직원을 출력
SELECT  *
FROM  employees
WHERE department_id IS NULL;



