

--OLYMPICS

--Outer Joins
/*1.	For all sports return the name of the sport and the name of all events in that sport. 
You should include all sports, whether they have events or not.
*/
select sportname, eventname from sport
left outer join event using (sportcode);

--2.	Amend the SQL for 1 so that rather than showing null in the output, for sports that have no events the statement returns ‘No events found’ (Hint: use NVL)
select sportname, nvl(eventname,'No event found') from sport
left outer join event using (sportcode);

/*3.	For all sports, find out how many events that sport has (Hint: use a group by statement). 
You should include all sports whether they have events or not.
*/
select sportname, count(eventname) from sport
left outer join event using (sportcode)
group by sportname;

--4.	Amend your SQL for 3 so that it will only show sports that do not have any events.
select sportname, count(eventname) from sport
left outer join event using (sportcode)
group by sportname
having count(eventname)=0;

/*5.	For all events, return the eventname and the number of competitors enrolled. 
You should include all events, whether they have competitors or not.
*/
select eventname, count(compid) from event
left outer join eventresult using (eventid)
group by eventname;

/*6.	For all competitors, find out how many events they are enrolled in. 
You should include competitors whether they are enrolled in events or not.
*/
select compname, count(eventid) from COMPETITOR
left outer join eventresult using (compid)
group by compid, compname;

--7.	Write the SQL to use a derived table and a left outer join to output the names of any events a competitor 
--is enrolled in or None if they are not enrolled in any events;
select  nvl(eventres.eventname,'None'),  compname
from  competitor
left outer join 
(
  select eventname, compid
  from eventresult 
  inner join event using (eventid)
) 
eventres on eventres.compid=competitor.compid;

--8.	Write the SQL to create a view called CurrentStandings which has columns called CompName and NumEvents.
 --Use the SQL you wrote for part 6 as a basis.
 -- Once the view is created, write a select statement to find the competitors who have not competed in any events.

Create view CurrentStandings as
select compname, count(eventid) as numevents from COMPETITOR
left outer join eventresult using (compid)
group by compid, compname;

select * from currentstandings where numevents=0;


--GAMES


--OUTER JOINS
/*1.	For all game rentals, list the customer ID of the person who rented them  
You should include the game ID in the output. You should include all games, whether they have been rented or not. 
*/
select game_ID, customer_id from mm_game
left outer join mm_rental using (game_id);

/*2.	For all games, find out how many times each game has been rented.  
You should include the game title in the output.  (Hint: use a group by statement). You should include all games, whether they have been rented or not. 
*/
select game_ID, count(customer_id) from mm_game
left outer join mm_rental using (game_id)
group by game_id;

/*3.	Write the SQL to create a view called gameStandings which has the columns gameName (title of the game) 
and NumRentals (which is the number of times a game has been rented.*/
Create view GameStandings as
select game_title as gamename, count(customer_id) as numrentals from mm_game
left outer join mm_rental using (game_id)
group by game_title;

/*4.	Find details of all games that have NEVER been rented. (Hint: use a left outer join and a WHERE CLAUSE)*/
select game_ID, count(customer_id) from mm_game
left outer join mm_rental using (game_id)
group by game_id
having count(customer_id)=0;
-- also correct
select game_ID, customer_id from mm_game
left outer join mm_rental using (game_id)
where customer_id is null;

--5.	Using a right outer join, find details of all customers who have never rented a game.
select game_id, customer_ID from mm_rental
right outer join mm_customer using (customer_ID)
where game_id is null;

 
   