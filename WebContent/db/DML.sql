--------------- MEMBER ---------------
-- 1. ID 중복체크
SELECT * FROM MEMBER WHERE MID = 'member1';
-- 2. 회원가입
INSERT INTO MEMBER 
    VALUES ('member4', 'member4', '박지우', null, null, null, 'f', null, SYSDATE);
-- 3. 로그인
SELECT * FROM MEMBER WHERE MID = 'member1' AND MPW = 'member1';
-- 4. 상세보기(MID로 DTO 가져오기)
SELECT * FROM MEMBER WHERE MID = 'member1';
-- 5. 회원정보 수정
UPDATE MEMBER SET MPW = 'member1',
                  MNAME = '김아중',
                  MPHOTO = NULL,
                  MTEL = '010-2943-1182',
                  MEMAIL = 'M@google.com',
                  MGENDER = 'f',
                  MBIRTH = '1992-01-11'
            WHERE MID = 'member1';
-- 6. 회원 리스트(top-N)
SELECT * 
    FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT * FROM MEMBER ORDER BY MNAME) A)
    WHERE RN BETWEEN 1 AND 2;
-- 7. 전체 회원 수 
SELECT COUNT(*) CNT FROM MEMBER;

--------------- ADMIN ---------------
-- 1 admin 로그인
SELECT * FROM ADMIN WHERE AID='admin' AND APW='admin';
-- 2 로그인 후 세션에 넣을 용도 : admin aid로 dto 가져오기
SELECT * FROM ADMIN WHERE AID='admin';

--------------- EXBOARD ---------------
-- 1. 글목록(paging)
SELECT V.*, 
    (SELECT MNAME FROM MEMBER WHERE V.MID=MID) ||
    (SELECT ANAME FROM ADMIN WHERE V.AID=AID) WRITER
    FROM (SELECT ROWNUM RN, B.* FROM (SELECT * FROM EXBOARD ORDER BY BGROUP DESC, BSTEP) B) V
    WHERE RN BETWEEN 1 AND 6;
-- 2. 글개수
SELECT COUNT(*) FROM EXBOARD;
select * from exboard;
-- 3. 글쓰기(원글)
INSERT INTO EXBOARD (BNUM, MID, AID, BTITLE, BCONTENT, BPHOTO, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (EXBOARD_SEQ.NEXTVAL, 'member1', null, '오운완!!', '오늘은 하체', NULL, SYSDATE, 0, EXBOARD_SEQ.CURRVAL, 0, 0, '192.0.0.1');
-- 4. 조회수 올리기
UPDATE EXBOARD SET BHIT = BHIT + 1 WHERE BNUM = 1;
-- 5. 상세보기(BNUM로 DTO 가져오기)
SELECT V.*, 
    (SELECT MNAME FROM MEMBER WHERE V.MID=MID) ||
    (SELECT ANAME FROM ADMIN WHERE V.AID=AID) WRITER
    FROM EXBOARD V WHERE BNUM = 1;
-- 6. 글 수정하기(BTITLE, BCONTENT, BPHOTO, BDATE(SYSDATE), BIP)
UPDATE EXBOARD SET BTITLE = '오늘은 글렀네요',
                   BCONTENT = '운동 하기 귀찮아요',
                   BPHOTO = NULL,
                   BDATE = SYSDATE,
                   BIP = '192.1.2.3'
             WHERE BNUM = 1;
-- 7. 글 삭제(삭제된 글이라고 UPDATE)
UPDATE EXBOARD SET MID = NULL,
                   AID = NULL,
                   BTITLE = '삭제된 글입니다',
                   BCONTENT = NULL,
                   BPHOTO = NULL,
                   BHIT = 0
             WHERE BNUM = 1;
-- 8. 답글 쓰기 전 단계(원글과 BGROUP이 같고 원글의 BSTEP보다 크면 BSTEP 하나 증가)
UPDATE EXBOARD SET BSTEP = BSTEP + 1
    WHERE BGROUP = 1 AND BSTEP>0;
-- 9. 답글 쓰기(3번글 답글)
SELECT * FROM EXBOARD;
INSERT INTO EXBOARD 
    VALUES (EXBOARD_SEQ.NEXTVAL, 'member2', null, '오운완!!', '하체 좋아요', NULL, SYSDATE, 0, 3, 1, 1, '192.0.0.1');
-- 10. 회원 탈퇴 시 탈퇴한 회원이 쓴 글 바꾸기
UPDATE EXBOARD B SET MID = NULL,
                     BTITLE = '탈퇴한 회원입니다',
                     BCONTENT = NULL,
                     BPHOTO = NULL,
                     BHIT = 0
               WHERE MID = 'member1';

--------------- BCOMMENT ---------------
SELECT * FROM BCOMMENT;
-- 1. 댓글 달기
INSERT INTO BCOMMENT (CNUM, BNUM, MID, CCONTENT, CDATE, CIP)
    VALUES (BCOMMENT_SEQ.NEXTVAL, '2', 'member3', '대단해요!', SYSDATE, '192.1.3.7');
-- 2. 댓글 수정
UPDATE BCOMMENT SET CCONTENT = '수정 댓글', CIP = '192.1.1.5'
                WHERE CNUM = 1; 
-- 3. 댓글삭제
DELETE FROM BCOMMENT WHERE CNUM = 2; 
-- 4. 회원 탈퇴 시 탈퇴 회원 댓글 삭제
DELETE FROM BCOMMENT WHERE MID = 'member2';

--------------- INBODY ---------------
-- 내 INBODY 목록 (등록일 내림차순)
SELECT * FROM INBODY WHERE MID = 'member1' 
            ORDER BY IDATE DESC, INUM DESC;
-- INBODY 상세보기
SELECT * FROM INBODY WHERE INUM = 3 AND MID = 'member2';
-- 1. INBODY 등록
INSERT INTO INBODY VALUES (INBODY_SEQ.NEXTVAL, 'member3', '50', '12', '15', SYSDATE);
-- 정보수정VIEW
SELECT * FROM INBODY WHERE INUM = 1 AND MID = 'member1';
-- 2. 정보 수정
UPDATE INBODY SET IWEIGHT = '48',
                  IFAT = '11',
                  IMUSCLE = '16',
                  IDATE = SYSDATE
            WHERE MID = 'member4';
-- 3. 특정 INBODY 삭제
DELETE FROM INBODY WHERE INUM = 6 AND MID = 'member4';
-- 4. 회원 탈퇴시 탈퇴 회원 모든 INBODY 삭제
DELETE FROM INBODY WHERE MID = 'member1';

--------------- EX ---------------
-- 1. 운동회차 목록(날짜 내림차순)
SELECT * FROM
    (SELECT ROWNUM RN, E.* 
        FROM (SELECT E.*, ENAME FROM EX E, EXPART EP
              WHERE E.EPNO = EP.EPNO 
                AND MID = 'member1' ORDER BY ENO DESC, EDATE DESC) E)
    WHERE RN BETWEEN 1 AND 5;
-- 총개수
SELECT COUNT(*) FROM EX WHERE MID = 'member1';
-- 2. 상세보기
SELECT E.*, ENAME 
    FROM EX E, EXPART EP
    WHERE E.EPNO = EP.EPNO 
      AND MID = 'member1' AND ENO = 1;
-- 3. 운동회차 추가
INSERT INTO EX 
    VALUES (EX_SEQ.NEXTVAL, 'member1', '1', NULL, '5', '15', '02', '10', '11', SYSDATE);
-- 4. 운동회차 내용 수정
UPDATE EX SET EPNO = '2',
              EWEIGHT = '15',
              ESET = '3',
              ECOUNT = '30',
              EHOUR = NULL,
              EMIN = NULL,
              ESEC = NULL,
              EDATE = '23-03-01'
        WHERE MID = 'member3' AND ENO = '3';
-- 5. 운동회차 삭제
DELETE FROM EX WHERE ENO = '2' AND MID = 'member3';
-- 6. 회원 탈퇴 시 탈퇴 회원 정보 삭제
DELETE FROM EX WHERE MID = 'member1';

--------------- EXPART ---------------
SELECT * FROM EXPART WHERE EPPART = '상체';
-- 1. 새 운동 등록
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '상체', '파이크 푸시업');
-- 2. 운동 수정
UPDATE EXPART SET EPPART = '상체',
                  ENAME = '파이크 푸시업'
            WHERE EPNO = '23';
-- 3. 운동 삭제
DELETE FROM EXPART WHERE EPNO = '23';
-- 4. 운동 목록
SELECT * FROM 
    (SELECT ROWNUM RN, EP.* FROM
        (SELECT * FROM EXPART ORDER BY EPPART) EP)
    WHERE RN BETWEEN 1 AND 10;
-- 5. 총 개수
SELECT COUNT(*) FROM EXPART;

-- MEMBER 8. 회원탈퇴
DELETE FROM MEMBER WHERE MID = 'member1';
ROLLBACK;