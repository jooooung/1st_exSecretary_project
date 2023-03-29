-- DROP TABLE
DROP TABLE INBODY;
DROP TABLE BCOMMENT;
DROP TABLE EXBOARD;
DROP TABLE ADMIN;
DROP TABLE EX;
DROP TABLE EXPART;
DROP TABLE MEMBER;
-- DROP SEQUENCE
DROP SEQUENCE INBODY_SEQ;
DROP SEQUENCE BCOMMENT_SEQ;
DROP SEQUENCE EX_SEQ;
DROP SEQUENCE EXBOARD_SEQ;
DROP SEQUENCE EXPART_SEQ;

-- CREATE TABLE & SEQUENCE
    -- ADMIN
CREATE TABLE ADMIN(
    AID VARCHAR2(100) PRIMARY KEY,
    APW VARCHAR2(100) NOT NULL,
    ANAME VARCHAR2(100) NOT NULL
);

    -- MEMBER
CREATE TABLE MEMBER(
    MID VARCHAR2(100) PRIMARY KEY,
    MPW VARCHAR2(100) NOT NULL,
    MNAME VARCHAR2(100) NOT NULL,
    MPHOTO VARCHAR2(100),
    MTEL VARCHAR2(100),
    MEMAIL VARCHAR2(100),
    MGENDER VARCHAR2(10),
    MBIRTH DATE,
    MRDATE DATE DEFAULT SYSDATE
);

    -- INBODY
CREATE TABLE INBODY(
    INUM    NUMBER(4) PRIMARY KEY,
    MID VARCHAR2(100) REFERENCES MEMBER (MID) NOT NULL, 
    IWEIGHT NUMBER(3) NOT NULL,
    IFAT    NUMBER(3),
    IMUSCLE NUMBER(3),
    IDATE DATE DEFAULT SYSDATE NOT NULL
);
CREATE SEQUENCE INBODY_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;

    -- ExPART
CREATE TABLE EXPART(
    EpNO NUMBER(3) PRIMARY KEY,
    EpPART VARCHAR2(100) NOT NULL,
    ENAME VARCHAR2(100) NOT NULL
);
    -- EXPART SEQUENCE
CREATE SEQUENCE EXPART_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;

    -- EX
CREATE TABLE EX(
    ENO NUMBER(4) PRIMARY KEY,
    MID VARCHAR2(100) REFERENCES MEMBER (MID) NOT NULL,
    EPNO NUMBER(3) REFERENCES EXPART (EPNO) NOT NULL,
    EWEIGHT NUMBER(3) DEFAULT 0,
    ESET NUMBER(3) NOT NULL,
    ECOUNT NUMBER(3) NOT NULL,
    EHOUR NUMBER(2),
    EMIN NUMBER(2),
    ESEC NUMBER(2),
    EDATE DATE DEFAULT SYSDATE NOT NULL
);
CREATE SEQUENCE EX_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;

    -- EXBOARD
CREATE TABLE EXBOARD(
    BNUM NUMBER(4) PRIMARY KEY,
    MID VARCHAR2(100) REFERENCES MEMBER (MID), 
    AID VARCHAR2(100) REFERENCES ADMIN (AID), 
    BTITLE VARCHAR2(100) NOT NULL,
    BCONTENT VARCHAR2(4000),
    BPHOTO VARCHAR2(100),
    BDATE DATE DEFAULT SYSDATE NOT NULL,
    BHIT NUMBER(4) DEFAULT 0 NOT NULL,
    BGROUP NUMBER(4) NOT NULL,
    BSTEP NUMBER(4) NOT NULL,
    BINDENT NUMBER(4) NOT NULL,
    BIP VARCHAR2(100) NOT NULL
);
CREATE SEQUENCE EXBOARD_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
    
    -- BCOMMENT
CREATE TABLE BCOMMENT(
    CNUM NUMBER(4) PRIMARY KEY,
    BNUM NUMBER(4) REFERENCES EXBOARD (BNUM) NOT NULL,
    MID VARCHAR2(100) REFERENCES MEMBER (MID), 
    AID VARCHAR2(100) REFERENCES ADMIN (AID),
    CCONTENT VARCHAR2(300) NOT NULL,
    CDATE DATE DEFAULT SYSDATE NOT NULL,
    CIP VARCHAR2(100) NOT NULL
);
CREATE SEQUENCE BCOMMENT_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
    
------ DUMMY DATA --------
    -- MEMBER
INSERT INTO MEMBER 
    VALUES ('member1', 'member1', '김수호', null, '010-2836-2273', 'member1@google.com', 'm', null, sysdate);
INSERT INTO MEMBER 
    VALUES ('member2', 'member2', '박지우', null, '010-1175-3345', 'member2@naver.com', 'f', '1993-04-11', sysdate);
INSERT INTO MEMBER 
    VALUES ('member3', 'member3', '최수영', null, '010-1944-2235', 'member3@google.com', 'm', '1990-07-21', sysdate);
INSERT INTO MEMBER 
    VALUES ('member4', 'member4', '홍길동', null, '010-0266-4451', 'member4@naver.com', 'm', '2000-11-30', sysdate);
INSERT INTO MEMBER 
    VALUES ('member4', 'member5', '김수영', null, '010-1997-3396', 'member5@naver.com', 'f', null, sysdate);
    -- ADMIN
INSERT INTO ADMIN VALUES ('admin', 'admin', '관리자');

    -- EXPART
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '상체', '푸시업');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '상체', '턱걸이');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '상체', '덤벨로우');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '상체', '덤벨컬');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '상체', '덤벨풀오버');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '복근', '크런치');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '복근', '레그레이즈');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '복근', '시티드니업');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '복근', '리버스크런치');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '복근', '크로스크런치');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '복근', '플랭크 니업');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '하체', '스쿼트');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '하체', '펄스스쿼트');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '하체', '와이드스쿼트');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '하체', '점프스쿼트');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '하체', '런지');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '하체', '백런지');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '코어', '플랭크');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '코어', '트위스트플랭크');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '코어', '포암플랭크');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '코어', '플랭크');
INSERT INTO EXPART VALUES (EXPART_SEQ.NEXTVAL, '코어', '사이트플랭크');

    -- EX
INSERT INTO EX 
    VALUES (EX_SEQ.NEXTVAL, 'member1', '1', NULL, '5', '15', '02', '10', '11', SYSDATE);
INSERT INTO EX 
    VALUES (EX_SEQ.NEXTVAL, 'member1', '5', NULL, '5', '15', '01', '30', '15', SYSDATE);
INSERT INTO EX 
    VALUES (EX_SEQ.NEXTVAL, 'member1', '11', NULL, '5', '15', '02', '10', '11', SYSDATE);
INSERT INTO EX 
    VALUES (EX_SEQ.NEXTVAL, 'member2', '2', NULL, '5', '15', '00', '30', '11', SYSDATE);
INSERT INTO EX 
    VALUES (EX_SEQ.NEXTVAL, 'member3', '3', NULL, '5', '15', '02', '50', '11', SYSDATE);    

    -- INBODY
INSERT INTO INBODY VALUES (INBODY_SEQ.NEXTVAL, 'member1', '55', '15', '10', SYSDATE);
INSERT INTO INBODY VALUES (INBODY_SEQ.NEXTVAL, 'member1', '53', '13', '11', SYSDATE);
INSERT INTO INBODY VALUES (INBODY_SEQ.NEXTVAL, 'member2', '50', '17', '13', SYSDATE);
INSERT INTO INBODY VALUES (INBODY_SEQ.NEXTVAL, 'member3', '60', '20', '15', SYSDATE);

    -- EXBOARD
INSERT INTO EXBOARD 
    VALUES (EXBOARD_SEQ.NEXTVAL, 'member1', null, '운동 힘들어요', '동기부여해주세요', NULL, SYSDATE, 0, EXBOARD_SEQ.CURRVAL, 0, 0, '192.0.0.1');
INSERT INTO EXBOARD 
    VALUES (EXBOARD_SEQ.NEXTVAL, 'member2', null, '오운완!', '오늘은 상체했네요', NULL, SYSDATE, 0, EXBOARD_SEQ.CURRVAL, 0, 0, '192.0.0.1');
INSERT INTO EXBOARD 
    VALUES (EXBOARD_SEQ.NEXTVAL, 'member3', null, '덤벨 추천 부탁드려요', '어떤 덤벨이 좋을까요', NULL, SYSDATE, 0, EXBOARD_SEQ.CURRVAL, 0, 0, '192.0.0.1');
INSERT INTO EXBOARD 
    VALUES (EXBOARD_SEQ.NEXTVAL, null, 'admin', '공지사항', '원하는 운동을 댓글로 달아주세요', NULL, SYSDATE, 0, EXBOARD_SEQ.CURRVAL, 0, 0, '192.0.0.1');
    
    -- BCOMMENT
INSERT INTO BCOMMENT
    VALUES (BCOMMENT_SEQ.NEXTVAL, '1', 'member1', 'null', '대단해요!', SYSDATE, '192.3.5.2');
INSERT INTO BCOMMENT
    VALUES (BCOMMENT_SEQ.NEXTVAL, '2', 'member2', 'null', '대단해요!', SYSDATE, '192.3.5.2');
INSERT INTO BCOMMENT
    VALUES (BCOMMENT_SEQ.NEXTVAL, '3', 'member3', 'null', '대단해요!', SYSDATE, '192.3.5.2');
SELECT * FROM MEMBER;
SELECT * FROM ADMIN;
SELECT * FROM EXPART;
SELECT * FROM INBODY;
SELECT * FROM EX;
SELECT * FROM EXBOARD;
SELECT * FROM BCOMMENT;
COMMIT;