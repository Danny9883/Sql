/*
HMW/1234 계정 생성후 로그인 하고 작업
데이터 저장공간 만들기 : TABLE 생성
잘못 만들어 졌으면
 DROP TABLE MYCLASS; 실행 후 다시 CREATE
우리정보 : MyClass
번호      숫자(5)   필수입력
이름      문자(60)  필수입력
전화      문자(20)
이메일    문자(320)
가입일    날짜
*/

CREATE  TABLE  MYCLASS (
번호      NUMBER(5)      NOT NULL,
이름      VARCHAR2(60)   NOT NULL,
전화      VARCHAR2(20),
이메일    VARCHAR2(320),
가입일    DATE
);

INSERT INTO MYCLASS VALUES (1,'하민욱','010-2246-9883','danny9883@naver.com',SYSDATE);
COMMIT;

DELETE FROM MYCLASS WHERE 번호 = 99;
COMMIT;

SELECT * FROM MYCLASS;

UPDATE MYCLASS SET 번호 = 1 WHERE 번호 = 2;
COMMIT;

