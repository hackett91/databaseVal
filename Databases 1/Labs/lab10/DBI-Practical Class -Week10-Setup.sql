-- Week 10 Solutions
-- This uses a set of tables for the olympics but slightly different to previous weeks
-- Major change is that event does not have a prizefund column - you are going to add it
Drop table EventResult;
Drop table Competitor;
Drop table Event;
Drop table Sport;

Create table Sport (
sportCode Number(4) PRIMARY KEY,
sportName varchar2(30));

Create table Event(
eventID Number(4) PRIMARY KEY,
eventName varchar2(30),
eventDate Date,
sportCode Number(4),
Constraint event_sport_fk FOREIGN KEY (sportCode) REFERENCES Sport(sportCode));

Create table Competitor(
compID NUMBER(4) PRIMARY KEY,
compName varchar2(30),
compDOB date);

Create table EventResult(
eventID number(4),
compID  number(4),
Position number(4),
PRIMARY KEY (eventID, compID),
Constraint eventen_event_fk FOREIGN KEY (eventID) REFERENCES Event (eventID),
Constraint eventen_comp_fk FOREIGN KEY (compID) REFERENCES Competitor (compID));

insert into sport (sportCode, sportName) values(1, 'Athletics');
insert into sport (sportCode, sportName) values (2, 'Cycling');
insert into sport (sportCode, sportName)  values (3, 'Aquatics');


insert into event (eventID, eventName, eventDate, sportCode) values (1, '100m Mens Final',  '12 Jun 2012',1);
insert into event (eventID, eventName, eventDate, sportCode)values (2, '100m Womens Final',  '13 June 2012',1);
insert into event (eventID, eventName, eventDate, sportCode)values (3, '200m Mens Final',  '12 Jun 2012',1);
insert into event (eventID, eventName, eventDate, sportCode)values (4, '200m Womens Final', '13 June 2012',1);

insert into event (eventID, eventName, eventDate, sportCode)values (5, 'Kerrin Men Final', '01 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (6, 'Omnium Men Final', '03 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (7, 'Kerrin Women Final',  '01 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (8, 'Omnium Women Final',  '03 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (9, 'Individual Men Final',  '21 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (10, 'Team Men Final', '23 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (11, 'Individual Women Final',  '14 Jun 2012',2);
insert into event (eventID, eventName, eventDate, sportCode)values (12, 'Team Women Final', '08 Jun 2012',2);

insert into event (eventID, eventName, eventDate, sportCode)values (13, '100m Backstroke Final','09 Jun 2012',3);
insert into event (eventID, eventName, eventDate, sportCode)values (14, '50m butterfly women Final','04 Jun 2012',3 );
insert into event (eventID, eventName, eventDate, sportCode)values (15, '800m freestyle men Final','06 Jun 2012',3 );

insert into event (eventID, eventName, eventDate, sportCode)values (16, 'Synchronised Duet Women Final', '09 Jun 2012',3 );
insert into event (eventID, eventName, eventDate, sportCode)values (17, 'Synchronised Team Women Final', '10 Jun 2012',3);

insert into competitor (compId, compName, compDOB) values (1, 'J Black', '12 DEC 1990');
insert into competitor (compId, compName, compDOB) values (2, 'K White', '04 APR 1984');
insert into competitor (compId, compName, compDOB) values (3, 'B Green', '01 MAY 1992');


insert into EventResult (eventID, compID, position) values (2, 1, 5);
insert into EventResult (eventID, compID, position) VALUES (4, 1, 3);
insert into EventResult (eventID, compID, position) VALUES (7, 1, 7);
insert into EventResult (eventID, compID, position) VALUES (5, 2, 1);
insert into EventResult (eventID, compID, position) VALUES (6, 2, 2);
insert into EventResult (eventID, compID, position) VALUES (12, 3, 8);
insert into EventResult (eventID, compID, position) VALUES (14, 3, 1);
insert into EventResult (eventID, compID, position)  values (5,3,8);
commit;
