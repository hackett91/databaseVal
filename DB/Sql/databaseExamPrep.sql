DROP TABLE Cover;
DROP TABLE Topic;
DROP TABLE Book;
CREATE TABLE Book
(
	book_code CHAR(10)   PRIMARY KEy,
  TITLE varCHAR (28)
);
insert into book values ('CBEGG','Connolly and Begg');
insert into book values ('Fowler','Refactoring in UML');
insert into book values ('Elmasri','Elmasri and Navathe');
insert into book values ('Flint','Java for Beginners');
CREATE TABLE Topic(	Topic_code	  CHAR(10) PRIMARY KEY,
	Topic_description  VARCHAR(28)
);
insert into topic values ('DB','Databases');
insert into topic values ('SE','Software Engineering');

CREATE TABLE Cover
(
	book_code		  CHAR(10)  NOT NULL ,
	Topic_code	  CHAR(10)  NOT NULL ,
PRIMARY KEY (book_code, Topic_code));
insert into cover values ('Elmasri','DB');
insert into cover values ('Elmasri','SE');
insert into cover values ('CBEGG','DB');
insert into cover values ('Fowler','SE');
commit;

-- Return the title of Books that cover Databases topics
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_code = 'DB';

-- Return the title of Books that only cover Databases topics
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description like '%Databases%'
minus
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description not like '%Databases%';

-- Return the title of Books that cover all types of topics.
select TITLE
FROM book a
where not exists (
select * 
from topic b
where not exists(
select * from 
cover x
where x.book_code = a.book_code 
AND x.topic_code = b.topic_code));

-- Return the title of Books who don't cover listed topics.
select TITLE 
FROM book
Left outer join cover using(book_code)
where topic_code = null;

--Return the title of Books that cover Databases topics and Software Engineering topics.
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description like '%Databases%'
union
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description  like '%Software Engineering%';


--6. Return the title of Books that cover Databases topics but not Software Engineering topics.
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description like '%Databases%'
minus
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description  like '%Software Engineering%';

--7. Return the title of Books that cover either Databases topics or Software Engineering topics.
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description like '%Databases%'
intersect
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description  like '%Software Engineering%';

--8. Return the title of Books that cover either Databases topics or Software Engineering topics, but not both.
(select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description like '%Databases%'
union
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description  like '%Software Engineering%')

minus

(select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description like '%Databases%'
intersect
select TITLE from 
BOOK 
join cover using (book_code)
join topic using (topic_code)
where topic_description  like '%Software Engineering%');

