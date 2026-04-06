/*
  HTH 계정 생성후
  + 버튼 클릭 후 
  이름 : HTHTeacher
  사용자 이름 : hth
  비밀 번호   : 1234
  
  호스트 이름 : 접속할 ip주소 -> 192.168.0.246 (cmd > ipconfig)
  포트        : 1521 -> 방화벽 인바운드, 아웃바운드에 포트 1521 추가 필요
  SID         : xe
*/

INSERT INTO MYCLASS 
 VALUES (4,'하민욱','010-2246-9883','danny9883@naver.com',SYSDATE);
 COMMIT;
 
 SELECT * FROM MYCLASS
 ORDER BY 번호 ASC;