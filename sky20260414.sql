성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.
 
 TABLE 생성
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE  
 
 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID
 
 -- 제약조건(CONSTRAINTS) - 무결성  
  TABLE 에 저장될 데이터에 조건을 부여하여 잘못된 DATA 입력 방지
  1. 주식별자 설정 : 기본키
     PRIMARY KEY     : NOT NULL + UNIQUE 기본 적용
      CREATE TABLE 명령안에 한번만 사용가능
  2. NOT NULL / NULL : 필수입력, 컬럼단위 제약조건
  3. UNIQUE          : 중복방지
  4. CHECK           : 값의 범위지정 , DOMAIN 제약 조건 
  5. FOREIGN KEY     : 외래키 제약조건

-- 관계가 설정된 테이블 삭제방법 1
DROP TABLE SCORES;  -- 자식테이블 먼저 삭제
DROP TABLE STUDENT; -- 부모테이블을 나중에 삭제
  
DROP TABLE STUDENT CASCADE CONSTRAINT PURGE; -- 순서에 무관하게 삭제
  
  
  
  
----------------------------------------------------------------------
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE
 CREATE  TABLE   STUDENT
 (
     STID    NUMBER(6)    PRIMARY KEY     -- 학번   숫자(6)  기본키
    ,STNAME  VARCHAR2(30) NOT NULL        -- 이름  문자(30) 필수입력
    ,PHONE   VARCHAR2(20) UNIQUE          -- 전화  문자(20) 중복방지
    ,INDATE  DATE         DEFAULT SYSDATE -- 입학일 날짜 기본값(오늘)
 );
 
 -- 학생정보 입력
 INSERT  INTO  STUDENT (STID, STNAME, PHONE, INDATE)
  VALUES               (1   , '가나', '010', SYSDATE);
  
 INSERT  INTO  STUDENT
  VALUES               (2   , '나나', '011', SYSDATE);
 
 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (3   , '다나', '012' ); 

 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (4   , '라나', '013' ); 
  
 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (5   , '라나', '014' ); 

 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (NULL   , '사나', '015' ); -- 입력안됨
-- SQL 오류: ORA-01400: NULL을 ("SKY"."STUDENT"."STID") 안에 삽입할 수 없습니다

 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (5   , '라나', '014' ); -- 입력안됨 기본키 중복X
-- ORA-00001: 무결성 제약 조건(SKY.SYS_C008389)에 위배됩니다

 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (6   , '하나', '014' ); -- 입력안됨 PHONE 넘버 중복
-- ORA-00001: 무결성 제약 조건(SKY.SYS_C008390)에 위배됩니다

 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (7   , NULL, '014' );   -- 입력안됨 STNAME NOT NULL
-- SQL 오류: ORA-01400: NULL을 ("SKY"."STUDENT"."STNAME") 안에 삽입할 수 없습니다

 INSERT  INTO  STUDENT (STID, STNAME, PHONE )
  VALUES               (6   , '하나', '019' );

COMMIT;
SELECT * FROM STUDENT;
  
  
 
 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID
 CREATE  TABLE  SCORES
 (
     SCID     NUMBER(7)    NOT NULL                        -- 일련번호 숫자(7)  , 기본키  , 번호자동증가
    ,SUBJECT  VARCHAR2(60) NOT NULL                        -- 교과목   문자(60) , 필수입력
    ,SCORE    NUMBER(3)    CHECK (SCORE BETWEEN 0 AND 100) -- 점수     숫자(3)  , 범위 0~100
    ,STID     NUMBER(6)                                    -- 학번     숫자(6)  , 외래키
    , CONSTRAINT  SCID_PK
        PRIMARY KEY ( SCID, SUBJECT )
    , CONSTRAINT  STID_FK
        FOREIGN KEY ( STID )
        REFERENCES  STUDENT(STID)
 );


INSERT INTO SCORES (SCID,  SUBJECT , SCORE , STID)
 VALUES            (1   ,  '국어'  , 100   , 1);
 
INSERT INTO SCORES VALUES (2,  '영어', 100, 1);
INSERT INTO SCORES VALUES (3,  '수학', 100, 1);
INSERT INTO SCORES VALUES (4,  '국어', 100, 2);
INSERT INTO SCORES VALUES (5,  '수학',  80, 2);
INSERT INTO SCORES VALUES (6,  '국어',  70, 4);
INSERT INTO SCORES VALUES (7,  '영어',  80, 4);
INSERT INTO SCORES VALUES (8,  '수학',  85, 4);
INSERT INTO SCORES VALUES (9,  '국어', 805, 5); -- ORA-02290: 체크 제약조건(SKY.SYS_C008393)이 위배되었습니다
INSERT INTO SCORES VALUES (10, '영어', 100, 8); -- ORA-02291: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 부모 키가 없습니다
COMMIT;

DML 추가, 수정, 삭제 -- COMMIT 필수
1. INSERT(추가) - 줄(DATA) 추가
  1)  INSERT INTO SCORES (SCID, SUBJECT, SCORE, STID)
       VALUES            (1,     '국어',  100,    1);
       
  2)  여러줄 추가
      INSERT INTO EMP4
       SELECT * FROM HR.EMPLOYEES;
       
  3)  INSERT 문을 여러개를 한번에 실행 - 여러줄 추가 : 새문법
      CREATE TABLE EX_SKY (
        ID    NUMBER(7)     PRIMARY KEY,
        NAME  VARCHAR2(30)  NOT NULL
      );
  
      INSERT ALL 
        INTO EX_SKY VALUES (103,'이순신')
        INTO EX_SKY VALUES (104,'김유신')
        INTO EX_SKY VALUES (105,'강감찬')
      SELECT  *  FROM DUAL;
      COMMIT;
         
2. DELETE  -- 줄(DATA) 를 삭제한다 , 기본적으로 여러줄이 대상
   DELETE  -- WHERE 이 없으면 전체를 대상으로 작업한다
    FROM  테이블명
    WHERE 조건;


3. UPDATE  -- 줄에 변화는 없고 칸에 있는 정보만 수정
           -- WHERE 이 없으면 전체를 대상으로 작업한다
   UPDATE  테이블
    SET    칼럼1 = 고칠값1,
           칼럼2 = 고칠값2,
           칼럼3 = 고칠값3
    WHERE  조건;

   SELECT * FROM SCORES;
   
   UPDATE  SCORES
    SET    SCORE = 70
    WHERE  SCID  = 6;
    
    ROLLBACK;
---------------------------------------------
 DATA 제거
 1. DROP TABLE SCORES;     -- 구조(테이블), DATA 모두 삭제, 복구 불가능
 
 2. TRUNCATE TABLE SCORES; -- 구조는 남기고 DATA 만 삭제, 속도 "빠름"
 
 3. DELETE FROM SCORES;    -- 구조는 남기고 DATA 만 삭제, 속도 '느림'
 
 SCORES DATA 삭제
 
 -- SET TIMING ON
 
 SELECT * FROM SCORES;
 DELETE FROM SCORES;
 ROLLBACK;
 
 SELECT * FROM STUDENT;
 DELETE FROM STUDENT;      -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
 
 INSERT INTO STUDENT  VALUES (11, '히나', '0111', SYSDATE);
 COMMIT;
 
 DELETE  FROM  STUDENT
  WHERE  STID = 1;     -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

 DELETE  FROM  STUDENT
  WHERE  STID = 11;
  
 외래키 관계에서 자식테이블의 DATA 를 지우고 부모테이블의 DATA 를 삭제하면 된다
 
 DELETE  FROM STUDENT
  WHERE  STID = 1;
  
--DROP TABLE SCORES;
--DROP TABLE STUDENT;
  


---------------------------------------------
성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.
 
---------------------------------------------
학생
SELECT * FROM STUDENT;

 -- 조회
 1. 학번, 이름, 점수(국어)
 SELECT  ST.STID            학번,
         ST.STNAME          이름,
         SC.SCORE           국어점수
  FROM   STUDENT  ST JOIN  SCORES  SC
    ON   ST.STID = SC.STID
  WHERE  SC.SUBJECT = '국어';
 
 2. 학번, 이름, 총점, 평균
 SELECT  STID,SUM(SCORE) , ROUND(AVG(SCORE),2)
   FROM  SCORES
   GROUP BY STID;   -- 총점 및 평균 계산
 
 SELECT  ST.STID           학번,
         ST.STNAME         이름,
         V.TOTSC           총점,
         V.AVGSC           평균
  FROM  STUDENT  ST LEFT JOIN ( SELECT  STID,SUM(SCORE) TOTSC , ROUND(AVG(SCORE),2)  AVGSC
                               FROM  SCORES
                               GROUP BY STID) V  ON ST.STID = V.STID
  ORDER BY 학번 ASC;
         
 
 
 3. 모든 학생의 학번, 이름, 총점, 평균
    점수가 NULL 인 학생은 '미응시'
    
 SELECT  ST.STID                                학번,
         ST.STNAME                              이름,
         DECODE(V.TOTSC,NULL,'미응시',V.TOTSC)  총점,
         DECODE(V.AVGSC,NULL,'미응시',V.AVGSC)  평균
  FROM  STUDENT  ST LEFT JOIN ( SELECT  STID,SUM(SCORE) TOTSC , ROUND(AVG(SCORE),2)  AVGSC
                               FROM  SCORES
                               GROUP BY STID) V  ON ST.STID = V.STID
  ORDER BY 학번 ASC
;
 

 
 4. 모든 학생의 학번, 이름, 총점, 평균, 등급, 석차
 -- 점수가 NULL 인 학생은 미응시
 SELECT  ST.STID                                        학번,
         ST.STNAME                                      이름,
         DECODE(V.TOTSC,NULL,'미응시',V.TOTSC)          총점,
         DECODE(V.AVGSC,NULL,'미응시',V.AVGSC)          평균,
         CASE                WHEN 90 <= V.AVGSC THEN 'A'
            WHEN 80 <= V.AVGSC AND V.AVGSC < 90 THEN 'B'
            WHEN 70 <= V.AVGSC AND V.AVGSC < 80 THEN 'C'
            WHEN 60 <= V.AVGSC AND V.AVGSC < 70 THEN 'D'
            WHEN 50 <= V.AVGSC AND V.AVGSC < 60 THEN 'E'
            WHEN                   V.AVGSC < 50 THEN 'F'
            ELSE '미응시'
            END AS 등급,
        RANK() OVER (ORDER BY V.AVGSC DESC NULLS LAST)  석차
  FROM  STUDENT  ST LEFT JOIN ( SELECT  STID,SUM(SCORE) TOTSC , ROUND(AVG(SCORE),2)  AVGSC
                               FROM  SCORES
                               GROUP BY STID) V  ON ST.STID = V.STID
  ORDER BY 학번 ASC
;

4-2) 2026-04-15 선생님 예제

SELECT  ST.STID                                           학번,
        ST.STNAME                                         이름,
        CASE
          WHEN SUM(SC.SCORE) IS NULL THEN '미응시'
          ELSE         TO_CHAR(SUM(SC.SCORE),'990')
        END                                               총점,
        CASE
          WHEN AVG(SC.SCORE) IS NULL THEN '미응시'
          ELSE         TO_CHAR(AVG(SC.SCORE),'990.00')
        END                                               평균,
        CASE
          WHEN ROUND(AVG(SC.SCORE),2) BETWEEN 90 AND 100   THEN 'A'
          WHEN ROUND(AVG(SC.SCORE),2) BETWEEN 80 AND 89.99 THEN 'B'
          WHEN ROUND(AVG(SC.SCORE),2) BETWEEN 70 AND 79.99 THEN 'C'
          WHEN ROUND(AVG(SC.SCORE),2) BETWEEN 60 AND 69.99 THEN 'D'
          ELSE                                                  'F'
        END                                               등급,
        RANK() OVER(ORDER BY SUM(SC.SCORE) DESC NULLS LAST)          석차
 FROM       STUDENT  ST
  LEFT JOIN SCORES   SC
   ON       ST.STID = SC.STID
 GROUP BY ST.STID, ST.STNAME
;

----------------------------------------------------------------------
 5. 모든 학생의 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차
 SELECT  STID , 
         SUM(SCORE) TOTSC , 
         ROUND(AVG(SCORE),2)  AVGSC
    FROM  SCORES
    GROUP BY STID;
 
 SELECT S.STID 학번, SCORE    KOR , ENG , MAT
  FROM  SCORES  S  LEFT JOIN (SELECT STID , SCORE    ENG
                          FROM  SCORES
                          WHERE SUBJECT = '영어') E ON E.STID = S.STID
                  LEFT JOIN  ( SELECT STID , SCORE    MAT
                          FROM  SCORES
                          WHERE SUBJECT = '수학') M ON M.STID = S.STID
  WHERE SUBJECT = '국어';
  
 SELECT STID 학번, SCORE    ENG
  FROM  SCORES
  WHERE SUBJECT = '영어';
  
 SELECT STID 학번, SCORE    MAT
  FROM  SCORES
  WHERE SUBJECT = '수학'; 
 
 --------------
 SELECT  ST.STID                                        학번,
         ST.STNAME                                      이름,
         DECODE(K.KOR,NULL,'미응시',K.KOR)              국어,
         DECODE(E.ENG,NULL,'미응시',E.ENG)              영어,
         DECODE(M.MAT,NULL,'미응시',M.MAT)              수학,
         DECODE(V.TOTSC,NULL,'미응시',V.TOTSC)          총점,
         DECODE(V.AVGSC,NULL,'미응시',V.AVGSC)          평균,
         CASE                WHEN 90 <= V.AVGSC THEN 'A'
            WHEN 80 <= V.AVGSC AND V.AVGSC < 90 THEN 'B'
            WHEN 70 <= V.AVGSC AND V.AVGSC < 80 THEN 'C'
            WHEN 60 <= V.AVGSC AND V.AVGSC < 70 THEN 'D'
            WHEN 50 <= V.AVGSC AND V.AVGSC < 60 THEN 'E'
            WHEN                   V.AVGSC < 50 THEN 'F'
            ELSE '미응시'
            END AS 등급,
        RANK() OVER (ORDER BY V.AVGSC DESC NULLS LAST)  석차
  FROM  STUDENT  ST LEFT JOIN ( SELECT  STID,SUM(SCORE) TOTSC , ROUND(AVG(SCORE),2)  AVGSC
                               FROM  SCORES
                               GROUP BY STID) V  ON ST.STID = V.STID
                    LEFT JOIN ( SELECT STID, SCORE   KOR
                                  FROM  SCORES
                                  WHERE SUBJECT = '국어') K ON K.STID = ST.STID
                    LEFT JOIN ( SELECT STID, SCORE   ENG
                                  FROM  SCORES
                                  WHERE SUBJECT = '영어') E ON E.STID = ST.STID
                    LEFT JOIN ( SELECT STID, SCORE   MAT
                                  FROM  SCORES
                                  WHERE SUBJECT = '수학') M ON M.STID = ST.STID
  ORDER BY 석차 ASC
;
------------------------------------------------------------------------------------
                               2026-04-15
------------------------------------------------------------------------------------
-- 모든 학생의 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차
1. ORACLE 10G 방식
1-1) 학번, 국어, 영어, 수학
  SELECT  SC.STID                                 학번, 
          DECODE( SC.SUBJECT, '국어' , SC.SCORE)  국어, 
          DECODE( SC.SUBJECT, '영어' , SC.SCORE)  영어, 
          DECODE( SC.SUBJECT, '수학' , SC.SCORE)  수학
   FROM   SCORES  SC;
   
1-2) 학번, 국어, 영어, 수학
  SELECT  SC.STID                                      학번, 
          SUM(DECODE( SC.SUBJECT, '국어' , SC.SCORE))  국어, 
          SUM(DECODE( SC.SUBJECT, '영어' , SC.SCORE))  영어, 
          SUM(DECODE( SC.SUBJECT, '수학' , SC.SCORE))  수학
   FROM   SCORES  SC
   GROUP BY SC.STID
;


1-3) JOIN 추가 : 학번, 이름, 국어, 영어, 수학 
   SELECT ST.STID                                     학번,
          ST.STNAME                                    이름,
          SUM(DECODE( SC.SUBJECT, '국어' , SC.SCORE))  국어, 
          SUM(DECODE( SC.SUBJECT, '영어' , SC.SCORE))  영어, 
          SUM(DECODE( SC.SUBJECT, '수학' , SC.SCORE))  수학
   FROM       SCORES  SC
   RIGHT JOIN  STUDENT ST
      ON  SC.STID = ST.STID
   GROUP BY ST.STID ,  ST.STNAME
   ORDER BY ST.STID ,  ST.STNAME;


1-4) 학번, 이름, 국어, 영어, 수학, 총점, 평균
   SELECT ST.STID                                      학번,
          ST.STNAME                                    이름,
          SUM(DECODE( SC.SUBJECT, '국어' , SC.SCORE))  국어, 
          SUM(DECODE( SC.SUBJECT, '영어' , SC.SCORE))  영어, 
          SUM(DECODE( SC.SUBJECT, '수학' , SC.SCORE))  수학,
          SUM(SCORE)                                   총점,
          ROUND(AVG(SCORE),2)                          평균
   FROM       SCORES  SC
   RIGHT JOIN  STUDENT ST
      ON  SC.STID = ST.STID
   GROUP BY ST.STID ,  ST.STNAME
   ORDER BY ST.STID ,  ST.STNAME;
   
   
1-5) 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차
  -- 미응시자는 '미응시' 로 출력
  -- 등급 : 비등가 조인으로 해결
  CREATE TABLE  SCOREGRADE 
  (
    GRADE    VARCHAR2(1)   PRIMARY KEY,
    LOSCORE  NUMBER(6,2),
    HISCORE  NUMBER(6,2)
  );
  
INSERT  INTO SCOREGRADE VALUES ('A', 90, 100);
INSERT  INTO SCOREGRADE VALUES ('B', 80, 89.99);
INSERT  INTO SCOREGRADE VALUES ('C', 70, 79.99);
INSERT  INTO SCOREGRADE VALUES ('D', 60, 69.99);
INSERT  INTO SCOREGRADE VALUES ('F',  0, 59.99);
COMMIT;

  SELECT  T.학번, 
          T.이름, 
          DECODE(T.국어,NULL,'미응시',T.국어)          국어, 
          DECODE(T.영어,NULL,'미응시',T.영어)          영어,
          DECODE(T.수학,NULL,'미응시',T.수학)          수학,
          DECODE(T.총점,NULL,'미응시',T.총점)          총점,
          DECODE(T.평균,NULL,'미응시',T.평균)          평균,
          DECODE(SG.GRADE,NULL,'미응시',SG.GRADE)      등급,
          RANK() OVER(ORDER BY T.총점 DESC NULLS LAST) 석차
   FROM  
  (  
  SELECT  ST.STID                                      학번,
          ST.STNAME                                    이름,
          SUM(DECODE( SC.SUBJECT, '국어' , SC.SCORE))  국어, 
          SUM(DECODE( SC.SUBJECT, '영어' , SC.SCORE))  영어, 
          SUM(DECODE( SC.SUBJECT, '수학' , SC.SCORE))  수학,
          SUM(SCORE)                                   총점,
          ROUND(AVG(SCORE),2)                          평균
   FROM        SCORES  SC
   RIGHT JOIN  STUDENT ST
      ON       SC.STID = ST.STID
   GROUP BY ST.STID ,  ST.STNAME
   ORDER BY ST.STID ,  ST.STNAME
   )  T   LEFT JOIN SCOREGRADE  SG
                 ON T.평균 BETWEEN SG.LOSCORE AND SG.HISCORE
;

-----------------------------------------------------------------
2. ORACLE 11G 방식  PIVOT 명령사용 : 통계를 생성 -- 일반적으로 집계함수와 같이 사용

학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차

1) 학번, 국어, 영어, 수학
SELECT * FROM (
    SELECT  STID, SUBJECT, SCORE
      FROM  SCORES
)
PIVOT
(
  SUM(SCORE)
     FOR SUBJECT
       IN('국어' AS 국어, '영어' AS 영어,'수학' AS 수학)
);

2) 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차

SELECT  ST.STID  학번, ST.STNAME, T.국어, T.영어, T.수학, 
        ( NVL(T.국어,0) +  NVL(T.영어,0) + NVL(T.수학,0) )     총점, 
        ( NVL(T.국어,0) +  NVL(T.영어,0) + NVL(T.수학,0) ) / 3 평균, 
        SG.GRADE                                               등급, 
        RANK() OVER(ORDER BY (NVL(T.국어,0) +  NVL(T.영어,0) + NVL(T.수학,0)) DESC NULLS LAST)  석차
  FROM  (SELECT * FROM (
            SELECT  STID, SUBJECT, SCORE
              FROM  SCORES
        )
        PIVOT
        (
          SUM(SCORE)
             FOR SUBJECT
               IN('국어' AS 국어, '영어' AS 영어,'수학' AS 수학)
        )
    )  T RIGHT JOIN STUDENT    ST ON T.STID = ST.STID
          LEFT JOIN SCOREGRADE SG ON ( NVL(T.국어,0) +  NVL(T.영어,0) + NVL(T.수학,0) ) / 3
               BETWEEN SG.LOSCORE AND SG.HISCORE;
          




