
DROP TABLE CD_ATTENDS CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_SESSION_RUNS CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_FACILITATOR CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_SPECIALITY CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_CODING_SESSION CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_ORGANIZER CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_LOCATION CASCADE CONSTRAINTS PURGE;

DROP TABLE CD_ATTENDEE CASCADE CONSTRAINTS PURGE;

CREATE TABLE CD_ATTENDEE
(
	Coder_Id             number(6) primary key,
	Coder_Name           VARCHAR2(50) not NULL ,
	Coder_Phone          CHAR(14) NULL ,
	Coder_Email          VARCHAR2(30) NULL ,
	Coder_Date_Of_Birth  DATE not NULL 
);
insert into CD_ATTENDEE (Coder_id, Coder_Name, Coder_Email, coder_date_of_Birth) values 
(4000,'Barry Keenan','barry@hmail.com', '10-Feb-2000');
insert into CD_ATTENDEE (Coder_id, Coder_Name, Coder_Email, coder_date_of_Birth) values 
(4001,'Pauline Brennan','pbrennan33@hmail.com', '31-Aug-1998');
insert into CD_ATTENDEE (Coder_id, Coder_Name, Coder_Email, coder_date_of_Birth) values 
(4002,'Ryan Kelleher','ryank55@hmail.com', '24-Apr-2000');
CREATE TABLE CD_LOCATION
(
	loc_id               CHAR(6) NOT NULL ,
	loc_name             VARCHAR2(30) NULL ,
	Loc_Contact_Name     VARCHAR2(50) NULL ,
	Loc_Phone            CHAR(14) NULL ,
	Loc_email            VARCHAR2(30) not NULL ,
 PRIMARY KEY (loc_id)
);
insert into CD_LOCATION values ('UNIV01','University','Professor','9999999','prof@univ.com');
insert into CD_LOCATION values ('HALL01','Community Hall','Joe Bloggs','9999998','joe@hall.com');
insert into CD_LOCATION values ('SCH001','Local School','Teacher','9989999','teacher@school.com');
CREATE TABLE CD_ORGANIZER
(
	Organizer_Id         number(6) primary key,
	Organizer_Name       VARCHAR2(50) not NULL ,
	Organizer_phone      CHAR(14) NULL ,
	Organizer_email      VARCHAR2(30) not NULL 
);
insert into CD_ORGANIZER (organizer_id, organizer_name, organizer_email) 
values (1,'Peter','peter@home.org');
insert into CD_ORGANIZER (organizer_id, organizer_name, organizer_email) 
values (2,'Jane','Jane@home.org');
insert into CD_ORGANIZER (organizer_id, organizer_name, organizer_email) 
values (3,'Brian','Brian@home.org');
insert into CD_ORGANIZER (organizer_id, organizer_name, organizer_email) 
values (4,'Sandra','Sandra@home.org');
insert into CD_ORGANIZER (organizer_id, organizer_name, organizer_email)
values (5, 'Mark','mark@coder.com');
CREATE TABLE CD_CODING_SESSION
(
	S_start              TIMESTAMP NOT NULL ,
	loc_id               CHAR(6) NOT NULL references CD_LOCATION,
	S_end                TIMESTAMP NULL ,
	Organizer_Id         number(6) NULL references CD_ORGANIZER,
 PRIMARY KEY (S_start,loc_id));
insert into CD_CODING_SESSION 
values (to_timestamp('10-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
to_timestamp('10-Feb-2013 12:00:00','DD-Mon-YYYY HH24:Mi:SS'),1);
insert into CD_CODING_SESSION 
values (to_timestamp('17-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
to_timestamp('17-Feb-2013 12:00:00','DD-Mon-YYYY HH24:Mi:SS'),1);
insert into CD_CODING_SESSION 
values (to_timestamp('10-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
to_timestamp('10-Feb-2013 16:00:00','DD-Mon-YYYY HH24:Mi:SS'),2);
insert into CD_CODING_SESSION 
values (to_timestamp('17-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
to_timestamp('17-Feb-2013 16:00:00','DD-Mon-YYYY HH24:Mi:SS'),2);
insert into CD_CODING_SESSION 
values (to_timestamp('24-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
to_timestamp('24-Feb-2013 16:00:00','DD-Mon-YYYY HH24:Mi:SS'),2);

CREATE TABLE CD_SPECIALITY
(
	Spec_code            varchar2(6) NOT NULL ,
	Spec_name            VARCHAR2(30) NULL ,
	Spec_Equipment       VARCHAR2(50) NULL ,
	Spec_Software        varchar2(30) NULL ,
 PRIMARY KEY (Spec_code)
);
insert into CD_SPECIALITY (spec_code, spec_name) values
('HTML','HTML');
insert into CD_SPECIALITY (spec_code, spec_name) values
('SCRTCH','Scratch Programming');
insert into CD_SPECIALITY (spec_code, spec_name) values
('GENG','Games Engines');
insert into CD_SPECIALITY (spec_code, spec_name) values
('ROBOT','Robot programming');
CREATE TABLE CD_FACILITATOR
(
	Facilitator_Id       number(6) primary key,
	Facilitator_name    varchar2(50) not NULL ,
	Facilitator_phone    CHAR(14) NULL ,
	Facilitator_email    VARCHAR2(30) not NULL
);
insert into CD_FACILITATOR (facilitator_id, facilitator_name, Facilitator_email)
values (405, 'Mark Gladstone','markg@coder.com');
insert into CD_FACILITATOR (facilitator_id, facilitator_name, Facilitator_email)
values (410, 'Mark','mark@coder.com');
insert into CD_FACILITATOR (facilitator_id, facilitator_name, Facilitator_email)
values (415, 'Ken','ken@coder.com');
insert into CD_FACILITATOR (facilitator_id, facilitator_name, Facilitator_email)
values (420, 'Deirdre','deirdre@coder.com');
CREATE TABLE CD_SESSION_RUNS
(
	S_start              TIMESTAMP NOT NULL ,
	loc_id               CHAR(6) NOT NULL ,
	Spec_code            VARCHAR2(6) NOT NULL references CD_SPECIALITY,
	Facilitator_Id       number(6) NULL references CD_FACILITATOR,
 PRIMARY KEY (S_start,loc_id,Spec_code),
FOREIGN KEY (S_start, loc_id) REFERENCES CD_CODING_SESSION (S_start, loc_id));

insert into CD_SESSION_RUNS
values (to_timestamp('10-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'HTML',405);
insert into CD_SESSION_RUNS
values (to_timestamp('17-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'HTML',405);
insert into CD_SESSION_RUNS
values (to_timestamp('10-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'ROBOT',415);
insert into CD_SESSION_RUNS
values (to_timestamp('17-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'ROBOT',415);
insert into CD_SESSION_RUNS
values (to_timestamp('17-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
'HTML',405);
insert into CD_SESSION_RUNS
values (to_timestamp('10-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
'HTML',405);
insert into CD_SESSION_RUNS
values (to_timestamp('24-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
'HTML',405);
CREATE TABLE CD_ATTENDS
(
	Coder_Id             NUMBER NOT NULL references CD_ATTENDEE,
	S_start              TIMESTAMP NOT NULL ,
	loc_id               CHAR(6) NOT NULL ,
	Spec_code            VARCHAR2(6) NOT NULL ,
	Badge_Earned         VARCHAR2(6) NULL check(badge_earned in ('Basic','Junior','Senior','Master')),
	Belt_Earned          VARCHAR2(6) NULL check (belt_earned in ('Blue','Yellow','White')),
 PRIMARY KEY (Coder_Id,S_start,loc_id,Spec_code),
FOREIGN KEY (S_start, loc_id, Spec_code) REFERENCES CD_SESSION_RUNS (S_start, loc_id, Spec_code)
);
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4000,to_timestamp('10-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'ROBOT');

insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4001,to_timestamp('10-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'HTML');
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4001,to_timestamp('17-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'HTML');
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4001,to_timestamp('10-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
'HTML');
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4001,to_timestamp('17-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
'HTML');
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code,badge_earned)
values (4001,to_timestamp('24-Feb-2013 14:00:00','DD-Mon-YYYY HH24:Mi:SS'),'HALL01',
'HTML','Basic');
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4002,to_timestamp('10-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'ROBOT');
insert into CD_ATTENDS (coder_id, s_start, loc_id, spec_code)
values (4002,to_timestamp('17-Feb-2013 10:00:00','DD-Mon-YYYY HH24:Mi:SS'),'UNIV01',
'ROBOT');
commit;

--1. Write a query to return each attendee's name and the number of sessions they have
--attended, for any attendee who has attended more than 2 sessions.
select coder_name, count(cd_attends.coder_id) "Number of Session"
from cd_attendee
join cd_attends on cd_attends.coder_id = cd_attendee.coder_id
having count(cd_attends.coder_id) > 2
group by(coder_name);


--2. Write a query to return the Organizer's name and location name of all sessions.
select organizer_name, loc_name
from cd_organizer
join cd_coding_session using(organizer_id)
join cd_location using(loc_id);

--3. Write a query to return a list of names of people who have either registered as
--facilitators or organizers.
select organizer_name "List of Names"
from cd_organizer
union
select facilitator_name
from cd_facilitator;

--4. Write a query to return a list of names and e-mail addresses of people who have
--registered as facilitators but who never registered as organizers. (You may assume
--that the e-mail addresses are unique to the person).
select facilitator_name, facilitator_email
from cd_facilitator

minus

select organizer_name, organizer_email
from cd_organizer;




--5. Write a query that will return a list of names of all attendees that have earned
--badges (only those that have earned badges!), the badge they have earned and the
--name of the speciality for which they earned them.




--6. Write SQL to list the names of any attendee that attended all session runs facilitated
--by Ken.