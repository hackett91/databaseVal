/* Student joins club             */
DROP TABLE JOINED;
DROP TABLE CCLUB;
DROP TABLE SSTUDENT;
CREATE TABLE SSTUDENT (
  SNO CHAR(9) primary key,
  SNAME varchar2(50),
  STUDYLEVEL CHAR(2) CHECK (STUDYLEVEL IN ('UG','PG')));

INSERT INTO SSTUDENT VALUES('J12345678','John Lennon','UG');
INSERT INTO SSTUDENT VALUES('P12345678','Paul McCartney','UG');
INSERT INTO SSTUDENT VALUES('G12345678','George Harrison','UG');
INSERT INTO SSTUDENT VALUES('R12345678','Ringo Starr','UG');
INSERT INTO SSTUDENT VALUES('B12345678','Brian May','PG');
INSERT INTO SSTUDENT VALUES('A12345678','Angela Merkel','PG');
INSERT INTO SSTUDENT VALUES('E12345678','Edgar Codd','PG');


CREATE TABLE CCLUB (
  CLUBID CHAR(8) PRIMARY KEY,
  CNAME VARCHAR2(40),
  CLUBTYPE VARCHAR2(15) CHECK (CLUBTYPE IN ('SPORT','SCIENCE','ARTS','OTHER')),
  CAMPUS VARCHAR2(20) CHECK (CAMPUS IN ('Kevin Street','Aungier Street','Bolton Street','Rathmines')));

INSERT INTO CCLUB VALUES ('JKS01','JUDO','SPORT','Kevin Street');
INSERT INTO CCLUB VALUES ('SKS01','Swimming','SPORT','Kevin Street');
INSERT INTO CCLUB VALUES ('ABS01','Auto','SCIENCE','Bolton Street');
INSERT INTO CCLUB VALUES ('ABS02','Architecture','OTHER','Bolton Street');
INSERT INTO CCLUB VALUES ('PAS01','Photography','ARTS','Aungier Street');
INSERT INTO CCLUB VALUES ('MRM01','Musical','ARTS','Rathmines');
INSERT INTO CCLUB VALUES ('NKS01','NetSoc','SCIENCE','Kevin Street');

CREATE TABLE JOINED (SNO REFERENCES SSTUDENT, CLUBID REFERENCES CCLUB, PRIMARY KEY (SNO, CLUBID));
INSERT INTO JOINED VALUES ('J12345678','JKS01');
INSERT INTO JOINED VALUES ('J12345678','SKS01');
INSERT INTO JOINED VALUES ('J12345678','NKS01');
INSERT INTO JOINED VALUES ('J12345678','MRM01');
INSERT INTO JOINED VALUES ('P12345678','MRM01');
INSERT INTO JOINED VALUES ('G12345678','MRM01');
INSERT INTO JOINED VALUES ('R12345678','MRM01');
INSERT INTO JOINED VALUES ('P12345678','SKS01');
INSERT INTO JOINED VALUES ('A12345678','SKS01');
INSERT INTO JOINED VALUES ('E12345678','NKS01');
COMMIT;


--  Write	programs	to	accept	a	student's	name	
-- from	the	user	and	display	their	student	number
SET SERVEROUTPUT ON -- Direct output to this session
DECLARE
    V_SNAME SSTUDENT.SNAME%TYPE:='&Student_Name'; -- accept user input
    V_SNO SSTUDENT.SNO%TYPE;
BEGIN
SELECT SNO INTO V_SNO FROM SSTUDENT WHERE SNAME = V_SNAME;
DBMS_OUTPUT.PUT_LINE('Hi '||V_SNO);
EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE(SQLCODE||' '||SQLERRM);
   DBMS_OUTPUT.PUT_LINE('Rolling back');
   ROLLBACK;
END;

-- Create	a	sequence	called	studentseq	that	will	
--auto	increment	from	10000 up.
CREATE SEQUENCE studentseq
START WITH 10000;

--Write	a	program	to	accept	a	student's	name	and	study	level	(UG/PG)	from	
--the	user	and	add	a	new	student,	using	C17	concatenated	with	a	new	student	
--number	generated	from	studentseq.
SET SERVEROUTPUT ON 
DECLARE
V_SNAME SSTUDENT.SNAME%TYPE:='&Student_Name';
V_SLEVEL SSTUDENT.STUDYLEVEL%TYPE:='&Student_Level';
V_SNO SSTUDENT.SNO%TYPE;
BEGIN
V_SNO := 'C17'||TO_CHAR(studentseq.nextval);
INSERT INTO SSTUDENT VALUES(V_SNO,V_SNAME,V_SLEVEL);
COMMIT;
dbms_output.put_line(V_SNAME||' is added, with the student number '||V_SNO);
EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE(SQLCODE||' '||SQLERRM);
   DBMS_OUTPUT.PUT_LINE('Rolling back');
   ROLLBACK;
END;
select * from sstudent;



-- Write	a	program	to	accept	a	student	name	(SNAME)	and	a	club	name	
--(CNAME)	and	if	the	student	has	not	yet	joined	the	club,	insert	a	new	row	in	
-- JOINED,	joining	the	student	to	the	club.
-- INSERT INTO JOINED VALUES ('J12345678','JKS01');
SET SERVEROUTPUT ON 
DECLARE 
V_SNAME SSTUDENT.SNAME%TYPE:='&Student_Name';
V_CNAME CCLUB.CNAME%TYPE:='&Club_Name';
V_SNO SSTUDENT.SNO%TYPE;
V_CLUBID  CCLUB.CLUBID%TYPE;
V_COUNT INTEGER :=0;
BEGIN
SELECT SNO INTO V_SNO FROM SSTUDENT WHERE SNAME = V_SNAME;
SELECT CLUBID INTO V_CLUBID FROM CCLUB WHERE CNAME = V_CNAME;
SELECT COUNT(*) INTO V_COUNT FROM JOINED WHERE (CLUBID  = V_CLUBID AND SNO = V_SNO);
IF V_COUNT < 1 THEN
    INSERT INTO JOINED VALUES(V_SNO, V_CLUBID);
    COMMIT;
    dbms_output.put_line(V_SNAME||' is inserted into '||V_CNAME);
ELSE
    dbms_output.put_line(V_SNAME||' is already part of the club');
END IF;
EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE(SQLCODE||' '||SQLERRM);
   DBMS_OUTPUT.PUT_LINE('Rolling back');
   ROLLBACK;
END;
SELECT * FROM JOINED;