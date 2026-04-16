-- 부서명, 직원명, 직원전화

SELECT  NVL(D.DEPARTMENT_NAME,'부서없음') 부서명, 
        E.FIRST_NAME||' '||E.LAST_NAME    직원명,
        E.PHONE_NUMBER                    직원전화
  FROM  DEPARTMENTS  D  RIGHT JOIN  EMPLOYEES  E  ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
  WHERE D.DEPARTMENT_ID = 90;
  
  