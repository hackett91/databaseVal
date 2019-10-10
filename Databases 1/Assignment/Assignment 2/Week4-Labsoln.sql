-- Databases I
-- solutions to week 3


-- 2. Create your data structures
-- Drop tables to clear any existing structures with the same name
Drop table EventEnrollment;
Drop table Competitor;
Drop table Event;
Drop table Sport;


-- Create tables in order of dependency
Create table Sport (
sportCode Number(4),
sportName varchar2(30) NOT NULL,
constraint sport_pk PRIMARY KEY (sportCode),
constraint sport_name_uniq UNIQUE(sportName)
);

Create table Competitor(
compID NUMBER(4),
compName varchar2(30),
compEmail varchar2 (30),
constraint competitor_pk PRIMARY KEY (compID),
constraint compemail_chk CHECK(compemail like '%@%.com'),
constraint compemail_uniq UNIQUE(compemail)
);

Create table Event(
eventID Number(4),
eventName varchar2(30) NOT NULL,
eventDate Date NOT NULL,
sportCode Number(4), 
CONSTRAINT event_pk PRIMARY KEY (eventID),
Constraint event_sport_fk FOREIGN KEY (sportCode) REFERENCES Sport(sportCode));


Create table EventEnrollment(
eventID number(4),
compID  number(4),
Position number(4),
CONSTRAINT eventenrol_pk PRIMARY KEY (eventID, compID),
Constraint eventen_event_fk FOREIGN KEY (eventID) REFERENCES Event (eventID),
Constraint eventen_comp_fk FOREIGN KEY (compID) REFERENCES Competitor (compID),
CONSTRAINT position_chk CHECK (position between 1 and 8)

);
--3. Inserting your data
insert into sport (sportCode, sportName) values(1, 'Athletics');
insert into sport (sportCode, sportName) values (2, 'Swimming');


insert into event (eventID, eventName, eventDate, sportCode) values (1, '1000m Mens Final',  '14 AUG 2016',1);
insert into event (eventID, eventName, eventDate, sportCode)values (2, '100m Womens Final',  '13 AUG 2012',1);
insert into event (eventID, eventName, eventDate, sportCode)values (3, '100m Mens Freestyle Final',  '10 AUG 2016',1);

insert into competitor (compId, compName, compemail) values (1, 'Usain Bolt', 'UB@jam.com');
insert into competitor (compId, compName, compEmail) values (2, 'Justin Gatlin', 'JB@usa.com');
insert into competitor (compId, compName, compEmail) values (3, 'Andre De Grasse', 'ADG@can.com');

insert into competitor (compId, compName, compemail) values (4, 'Elaine Thompson', 'ET@jam.com');
insert into competitor (compId, compName, compEmail) values (5, 'Tori Bowie', 'TB@usa.com');
insert into competitor (compId, compName, compEmail) values (6, 'Shelly-Ann Fraser-Price', 'SAFP@jam.com');


insert into competitor (compId, compName, compemail) values (7, 'Kyle Chambers', 'KC@aus.com');
insert into competitor (compId, compName, compEmail) values (8, 'Peter Timmers', 'PT@bel.com');
insert into competitor (compId, compName, compEmail) values (9, 'Nathan Adrian', 'NA@usa.com');



insert into EventEnrollment (eventID, compID, position) values (1, 1, 1);
insert into EventEnrollment (eventID, compID, position) VALUES (1, 2, 2);
insert into EventEnrollment (eventID, compID, position) VALUES (1, 3, 3);
insert into EventEnrollment (eventID, compID, position) VALUES (2, 4, 1);
insert into EventEnrollment (eventID, compID, position) VALUES (2, 5, 2);
insert into EventEnrollment (eventID, compID, position) VALUES (2, 6, 3);
insert into EventEnrollment (eventID, compID, position) VALUES (3, 7, 1);
insert into EventEnrollment (eventID, compID, position)  values (3,8,2);
insert into EventEnrollment (eventID, compID, position)  values (3,9,3);
commit;

-- 	1. Find the details of all events.
select eventname from event;
--2.	Find the names of all competitors.
select compname from competitor;
--3.	Find the Competitor no of all competitors who finished in position 1 or position 3 in their events include the position in the output.
select compID, position from eventenrollment where position in (1, 3);
select compID, position from eventenrollment where position =1 or position =3;
--4.	Find the names of all competitors with usa in their email address. Include the email in the output.
select compname, compemail from competitor where compemail like '%usa%';

