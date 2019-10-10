DROP TABLE Transaction CASCADE CONSTRAINTS PURGE;
DROP TABLE HasAccount CASCADE CONSTRAINTS PURGE;
DROP TABLE Account CASCADE CONSTRAINTS PURGE;
DROP TABLE Client CASCADE CONSTRAINTS PURGE;
DROP TABLE AccountType CASCADE CONSTRAINTS PURGE;


CREATE TABLE AccountType
(
	AcType  CHAR(8)  primary key,
	AccTypeDesc  VARCHAR2(20),
	DateIntroduced  DATE  NOT NULL ,
	ExpiryDate  DATE  NULL );



CREATE TABLE Client
(
	ClientId  NUMBER(7)  primary key,
	CTitle  VARCHAR2(4)  NULL ,
	CFName  VARCHAR2(30)  not NULL ,
	CLName  VARCHAR2(40)  not NULL ,
	CAddr  varchar2(50)  NULL ,
	CEMail  varchar2(30)  NULL ,
	CPhone  NUMBER(15)  NULL 
);


CREATE TABLE Account
(
	AccNo  NUMBER(8) PRIMARY KEY,
	DateOpened  DATE  NULL ,
	DateModified  DATE  NULL ,
	Balance  DECIMAL(10,2)  NULL ,
	AcType  CHAR(8)  NULL REFERENCES AccountType(AcType));


CREATE TABLE HasAccount
(
	ClientId  NUMBER(7)  NOT NULL REFERENCES Client(ClientId),
	AccNo  NUMBER(8)  NOT NULL REFERENCES Account(AccNo),
 PRIMARY KEY (ClientId,AccNo));


CREATE TABLE Transaction
(
	AccNo  NUMBER(8)  NOT NULL REFERENCES Account(AccNo),
	TXDate  DATE  NOT NULL ,
	TxType  CHAR  check (txtype in ('D','W')) ,
	TXAmount  number(10,2)  not NULL ,
 PRIMARY KEY (AccNo,TXDate)
);



insert into accounttype values (
'Maestro','Master card',SYSDATE-1000,NULL);
insert into accounttype values (
'Visa','Visa card',SYSDATE-2000,NULL);
insert into accounttype values (
'LTDEP','Long term deposit',SYSDATE-1000,NULL);
insert into accounttype values (
'SHORTDEP','Short term deposit',SYSDATE-400,sysdate-20);
insert into accounttype values (
'STDCURR','Standard Current',SYSDATE-1000,NULL);
insert into accounttype values (
'SUPERSAV','Super saver account',SYSDATE-1000,NULL);

INSERT INTO CLIENT VALUES (6545654,'Ms.','Margaret','Bradley','28 Horseshoe Drive','mags@gmail.com',08345544311);
INSERT INTO CLIENT VALUES (9815543,'Prof','Jane','Lacey','14 Dairy Close','jd1@viu.com',08545544311);
INSERT INTO CLIENT VALUES (7543356,'Dr.','Anabelle','Qiao','83 Nutley Ave','ana@hosp.com',08645544311);
INSERT INTO CLIENT VALUES (5444544,'Mr.','John','McDermott','67 Mangrove Hill','jmcd@eircom.net',08745544311);
INSERT INTO CLIENT VALUES (9199337,'Dr.','Kevin','Dunne','28 The Dunes','kdunne@gmail.com',08845544311);
INSERT INTO CLIENT VALUES (9874819,'Ms.','Sally','Greene','44 Highwell Hill','sgreene@hotmail.com',08945544311);
INSERT INTO CLIENT VALUES (9874820,'Ms.','Caroline','Greene','44 Highwell Hill','cgreene@hotmail.com',08945544311);
--
--
--CREATE TABLE Account
--(
--	AccNo  NUMBER(8)  NOT NULL ,
--	DateOpened  DATE  NULL ,
--	DateModified  DATE  NULL ,
--	Balance  DECIMAL(10,2)  NULL ,
--	AcType  CHAR(8)  NULL ,
-- PRIMARY KEY (AccNo),
-- FOREIGN KEY (AcType) REFERENCES AccountType(AcType)
--);
--
insert into ACCOUNT (accno, dateopened) values (9332232,sysdate-1);
insert into ACCOUNT values (87334564,'23-Jan-1998',sysdate-4,5644.44,'SUPERSAV');
insert into ACCOUNT values (68312334,'22-SEP-2008','22-SEP-2008',50.00,'STDCURR');
insert into ACCOUNT values (68311111,'22-SEP-2008','22-SEP-2008',50.00,'STDCURR');
insert into ACCOUNT values (87654321,'22-SEP-2000','22-SEP-2008',50.00,'LTDEP');
insert into ACCOUNT values (40248210,'22-SEP-2004','22-SEP-2008',50.00,'LTDEP');
INSERT INTO ACCOUNT VALUES 
(98765432,'10-JAN-2000','30-OCT-2008',800,'SHORTDEP');
INSERT INTO ACCOUNT VALUES 
(21098765,'10-JAN-2000','30-OCT-2008',800,'Visa');
--
--CREATE TABLE HasAccount
--(
--	ClientId  NUMBER(7)  NOT NULL ,
--	AccNo  NUMBER(8)  NOT NULL ,
-- PRIMARY KEY (ClientId,AccNo),
-- FOREIGN KEY (ClientId) REFERENCES Client(ClientId),
-- FOREIGN KEY (AccNo) REFERENCES Account(AccNo)
--);
--
INSERT INTO HASACCOUNT VALUES (6545654,87334564);
INSERT INTO HASACCOUNT VALUES (6545654,68312334);
INSERT INTO HASACCOUNT VALUES (6545654,21098765);
INSERT INTO HASACCOUNT VALUES (7543356,87654321);
INSERT INTO HASACCOUNT VALUES (7543356,98765432);
INSERT INTO HASACCOUNT VALUES (7543356,68312334);
INSERT INTO HASACCOUNT VALUES (9874819,40248210);
INSERT INTO HASACCOUNT VALUES (9199337,68311111);
--
--CREATE TABLE Transaction
--(
--	AccNo  NUMBER(8)  NOT NULL ,
--	TxId  INTEGER  NOT NULL ,
--	TxType  CHAR  NULL ,
--	TXAmount  number(10,2)  NULL ,
--	TXDate  DATE  NULL ,
-- PRIMARY KEY (AccNo,TxId),
-- FOREIGN KEY (AccNo) REFERENCES Account(AccNo)
--);

INSERT INTO TRANSACTION VALUES (87334564,SYSDATE-50,'D',500);
INSERT INTO TRANSACTION VALUES (87334564,SYSDATE-43,'W',50);
INSERT INTO TRANSACTION VALUES (87334564,SYSDATE-36,'D',500);
INSERT INTO TRANSACTION VALUES (87334564,SYSDATE-29,'D',500);
INSERT INTO TRANSACTION VALUES (87334564,SYSDATE-4,'D',500);
INSERT INTO TRANSACTION VALUES (87654321,SYSDATE-50,'D',500);
INSERT INTO TRANSACTION VALUES (40248210,SYSDATE-50,'D',500);
INSERT INTO TRANSACTION VALUES (98765432,SYSDATE-200,'D',500);
INSERT INTO TRANSACTION VALUES (98765432,SYSDATE-150,'D',500);
INSERT INTO TRANSACTION VALUES (98765432,SYSDATE-100,'D',500);
INSERT INTO TRANSACTION VALUES (98765432,SYSDATE-50,'D',500);
insert into transaction values (21098765,SYSDATE-1,'W',544);
commit;

-- Create a view called CLIENTHAS that will hold the clientid,
-- clientname and accno for each client, regardless of 
-- whether or not they have an account. The clientname should
-- be made up of the ctitle, '', cfname, '' and clname concatenated together. 

CREATE OR REPLACE VIEW CLIENTHAS AS
Select client.clientid, ctitle || ' ' || cfname || ' ' || ' '|| clname as clientname, accno
from client
LEFT OUTER join hasaccount on hasaccount.clientid = client.clientid;

Select * from clienthas;

-- run a query to return every client name and number of accounts they hold.
select cfname, count(accno)
from client
LEFT OUTER join hasaccount on hasaccount.clientid = client.clientid
group by(cfname);

-- 2. Write a query to return every client's name and number of accounts they hold. 

Select clientname, count(accno) as "Number of Account"
from clienthas
group by(clientname);
Select * from clienthas;

-- or 

select ctitle||' '||cfname||' '||clname clientname, count(accno) 
from client 
left join hasaccount using (clientid)
group by ctitle, cfname, clname;

-- 3. Write a query to return the clientname of any client who has a joint account. 
select clientname
from clienthas
having count(accno) > 1
group by(clientname);

-- or
select clientname, accno "Joint Account" 
from clienthas where accno in (
select accno from clienthas group by accno having count(*)> 1
);

-- 4. Write a query to return the clientname of any client who has a deposit account but not a current account. 

create or replace view TypeOfAccount as
select *
from client 
join hasaccount using(clientid)
join account using(accno)
join accounttype using(actype);

select * from typeofaccount;

select cfname,clname
from typeofaccount
where lower(acctypedesc) like '%deposit%'

minus

select cfname, clname
from typeofaccount
where lower(acctypedesc) like '%current%';


-- or 
Select clientname 
from clienthas
join account using (accno)
join accounttype using (actype)
where lower(acctypedesc) like '%deposit%'

minus

select clientname
from clienthas
join account using (accno)
join accounttype using (actype)
where lower(acctypedesc) like '%current%'

select * from clienthas;

-- 5. Write a query to return the clientname and account number of any client who has a joint account.
select clientname, accno as "Account Number"
from clienthas
having count(accno) > 1
Group by(clientname);

-- 6 a. have a deposit account or a current account 
select ctitle || ' ' || cfname || ' ' || clname as "Deposit or Current"
from typeofaccount
where lower(acctypedesc) like '%deposit%'
union
select ctitle || ' ' || cfname || ' ' || clname as "Deposit or Current"
from typeofaccount
where lower(acctypedesc) like '%current%';

--or
create or replace view depositaccount as 
select * from account 
where actype in (
select actype from accounttype 
where lower (acctypedesc) like '%deposit%');

create or replace view currentaccount as 
select * from account 
where actype in (
select actype from accounttype 
where lower (acctypedesc) like '%current%');

select clientname "Deposit or Current" from clienthas join depositaccount using (accno)
union
select clientname from clienthas join currentaccount using (accno);

-- b. have both a deposit account and a current account 
select ctitle || ' ' || cfname || ' ' || clname as "Deposit and Current"
from typeofaccount
where lower(acctypedesc) like '%deposit%'

intersect

select ctitle || ' ' || cfname || ' ' || clname as "Deposit and Current"
from typeofaccount
where lower(acctypedesc) like '%current%';

-- or 
select clientname "Deposit and current" from clienthas join depositaccount using (accno)
intersect
select clientname from clienthas join currentaccount using (accno);

-- c. have a deposit account but not a current account --
select ctitle || ' ' || cfname || ' ' || clname as "Deposit but not Current"
from typeofaccount
where lower(acctypedesc) like '%deposit%'

minus

select ctitle || ' ' || cfname || ' ' || clname as "Deposit but not Current"
from typeofaccount
where lower(acctypedesc) like '%current%';

-- or 
select clientname "Deposit, no current" from clienthas join depositaccount using (accno)
minus
select clientname from clienthas join currentaccount using (accno);

-- d. have a current account but not a deposit account 


select ctitle || ' ' || cfname || ' ' || clname as "Current but not Deposit"
from typeofaccount
where lower(acctypedesc) like '%current%'

minus

select ctitle || ' ' || cfname || ' ' || clname as "Current but not Deposit"
from typeofaccount
where lower(acctypedesc) like '%deposit%';


-- or 
select clientname "Current, no deposit" from clienthas join currentaccount using (accno)
minus
select clientname from clienthas join depositaccount using (accno);



-- Week 3 

-- 2. Write a query to show each client’s name and the total sum of deposits (txtype = ‘D’) that have
--  been made into any of their accounts. (Hint: The first line is Sally Greene 500)

Select cfname, sum(balance)
from client
join hasaccount using(clientid)
join account using(accno)
join transaction using(accno)
where txtype = 'D'
group by (cfname);

-- testing to display all 
Select *
from client
join hasaccount using(clientid)
join account using(accno)
join transaction using(accno)
where txtype = 'D';


--3. Write a query to return a list of clients into whose account a deposit has been made (i.e. a
--  transaction with txtype = ‘D’).

create or replace view madeDeposit as
Select *
from client where clientid in 
(select clientid from
hasaccount
join account using(accno)
join transaction using(accno)
where txtype = 'D');

--4. Write a query to return a list of clients from whose account a withdrawal has been made (i.e. a
--  transaction with txtype = ‘W’).
create or replace view madeWithdrawl as
select * from client
where clientid in (select clientid
from hasaccount
join account using(accno)
join transaction using(accno)
where txtype = 'W');

--5. Write a query to list the clients who have had deposits made, but no withdrawals.
select * from madedeposit

minus

select * from madewithdrawl;

--6. To write a query to return a list of client names who hold every type of deposit account, using
--  the relational divide.
select * from accounttype;


create or replace view b as
Select *
from accounttype 
join account using(actype)
where lower(acctypedesc) like '%deposit%';

select * from b;

create or replace view x as
select * from hasaccount
join account using(accno);

select cfname || ' ' || clname clientname
from client a
where not exists
(select * from b
where not exists 
(select * 
from x
where  a.clientid = x.clientid 
and b.accno = x.accno
));

select * from accounttype;

select * from transaction;


