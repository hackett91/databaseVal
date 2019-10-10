-- Week 10 Practical Class
-- The questions are included as comments in this SQL file
-- You should write the SQL and save it in this file 


--*****************************************************************************************
--* BEFORE ATTEMPTING TO WRITE THE SQL TO ANSWER THE QUESTIONS IN THIS PRACTICAL CLASS    *
--* YOU NEED TO DOWNLOAD THE FILE DBI-PRACTICAL CLASS-WEEK10-SETUP.SQL AND RUN IT IN      *
--* SQL DEVELOPER TO CREATE THE TABLES AND INSERT THE DATA NEEDED.                        *
--*****************************************************************************************

-- This uses a set of tables for the olympics but slightly different to previous weeks
-- Major change is that event does not have a prizefund column - you are going to add it

--****Revision****
/*Q1.	
For all sports return the name of the sport and the name of all events in that sport. 
Format your output so that it matches the table below. (Hint: use concatenate to change the output 
and an alias to change the name of the column displayed 
You will have 17 rows in your output as there are 17 events setup in this example*/



/*Q2.	
Amend the previous SQL statement so that for each sport return the name of the sport and 
the number of events in that sport. (Hint: use a group function) e.g.  ATHLETICS has 4 events*/


/*Q3. 
For each COMPETITOR output their max, min and averge position achieved*/


--****NEW MATERIAL FROM WEEK 10****
/*Q4.	
Add a column PRIZE to the event table which can accept values up to 99999.99.
Use an alter table statement, add */


/*Q5.	
Set the value of the PRIZE column to be SPORTCODE * 1000.
Use an update statement*/


/*Q6.	
Modify this column so that it is not null.
use an alter table statement, modify*/


/*Q7.	
Add a constraint to the table so that it can accept values between 1000.00 and 3500.00.
 Use an alter table, add constraint*/


/*Q8.	
Add a constraint to the EVENTResult table so that the value of position will be unique for each event
(Hint: Think about what is unique - it is not position on its own).
-- use alter table, add constraint*/




/*Q9.	
Athletics prize money is being increased by 25%. 
Write the SQL to update the prize columns of all Athletics events. Use a sub-query in your wqhere clause.*/
-- Hint: What would the SQL be to find the name of each sport? This is your sub-query
-- Remeber that sub-queries are enclosed in ()*/


  




   /*10.	Modify the column on the EVENT table called PRIZEFUND so it can accept values up to 999999999.99. 
  You need to drop the constraint on event also.
Populate this column with a value 1,000,000 if the event is ATHLETICS; 900,000 if CYCLING; 500,000 otherwise 
--use an update statement
Use the sportcode in a case statement as part of the set in the update
*/
  

/*Q11.	
Delete all results for all CYCLING events 
--Hint: Think about this. What table references the event table?
-- So do you need to delete records from that first? 
-- How would would you structure your delete so that it uses the sportname - you need to use a subquery.
-- then you need to delete the event itself*/

  
  
/*Q12.
Delete all cycling events; 
use a subquery*/
 
  
/*Q13.	
Add a column to the EVENTResult table called PRIZE which can accept values up to 99,999.99;
*/





/*Q14.	Delete the column Prizefund from the event table. 
-- Use alter table, drop column*/



