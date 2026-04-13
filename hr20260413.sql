-----------------------------------------------
-- 부프로그램 : 프로시저 , 함수
1. 프로시저 ( PROCEDURE ) -- SUBROUTINE : 함수보다 더 많이 사용한다
   : 리턴값이 0 개 이상 
   STORED PROCEDURE : 저장 프로시저
2. 함수 ( FUNCTION )
   : 반드시 리턴값이 1 개 
   
USER DEFINE FUNCTION - 사용자 정의 함수 , 우리가 함수를 만든다.
-----------------------------------------------



-- 107 번 직원의 이름과 월급 조회
SELECT  EMPLOYEE_ID , FIRST_NAME||' ' ||LAST_NAME, SALARY
 FROM   EMPLOYEES
 WHERE  EMPLOYEE_ID = 107;
 
익명 블럭
SET SERVEROUTPUT ON;
DECLARE
  V_NAME  VARCHAR2(46);
  V_SAL   NUMBER(8, 2);
BEGIN
  V_NAME  := '카리나';
  V_SAL   := 10000;
  DBMS_OUTPUT.PUT_LINE(V_NAME);
  DBMS_OUTPUT.PUT_LINE(V_SAL);
  IF V_SAL >= 10000 THEN
     DBMS_OUTPUT.PUT_LINE('Good');
  ELSE 
     DBMS_OUTPUT.PUT_LINE('Not Good');
  END IF;
END;
/

저장 프로시저 (IN : INPUT , OUT : OUTPUT, INOUT : INPUTOUTPUT)
CREATE  PROCEDURE  GET_EMPSAL ( IN_EMPID IN NUMBER )
IS 
  V_NAME   VARCHAR2(46);
  V_SAL    NUMBER(8, 2);
  BEGIN
    SELECT FIRST_NAME||' '||LAST_NAME, SALARY
      INTO V_NAME                    , V_SAL
    FROM   EMPLOYEES
    WHERE  EMPLOYEE_ID = IN_EMPID;
    
    DBMS_OUTPUT.PUT_LINE('이름: '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('월급: '||V_SAL);
  END;
/

 
-- ORACLE 로 프로시저를 생성한다
 
 


-- 부서번호 입력, 해당 부서의 최고월급자의 이름, 월급 출력
SELECT    DEPARTMENT_ID, FIRST_NAME||' ' ||LAST_NAME , SALARY
 FROM     EMPLOYEES
 WHERE    (SELECT  MAX(SALARY)
             FROM  EMPLOYEES
             WHERE DEPARTMENT_ID = 90) = SALARY; 


-- 90번 부서번호 입력, 직원들 출력
SELECT  DEPARTMENT_ID, FIRST_NAME||' ' ||LAST_NAME
 FROM   EMPLOYEES
 WHERE  DEPARTMENT_ID = 90;






