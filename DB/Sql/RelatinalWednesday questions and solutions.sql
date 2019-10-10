/*1.	Write a query to return each attendee's name and the number of sessions they have attended,
for any attendee who has attended more than 2 sessions.
*/
SELECT coder_name,
  COUNT(*)
FROM cd_attendee
JOIN cd_attends USING (coder_id)
GROUP BY coder_name
HAVING COUNT(*)>2;
/*2.	Write a query to return the Organizer's name and location name of all sessions.
*/
SELECT organizer_name,
  loc_name
FROM cd_organizer
JOIN cd_coding_session USING (organizer_id)
JOIN cd_location USING (loc_id);
/*3.	Write a query to return a list of names of people who have either registered as facilitators 
or organizers.*/
-----------------------------------
SELECT organizer_name "organizer/facilitator" FROM cd_organizer
UNION
SELECT facilitator_name FROM cd_facilitator;
------------
/*4.	 Write a query to return a list of names and e-mail addresses of people who have registered as facilitators but who never registered as organizers. (You may assume that the e-mail addresses are unique to the person).
*/

SELECT facilitator_name, facilitator_email FROM cd_facilitator
MINUS
SELECT organizer_name, organizer_email FROM cd_organizer;
/*5.	Write a query that will return a list of names of all attendees that have earned badges (only those that have earned badges!), the badge they have earned and the name of the speciality for which they earned them.
*/
SELECT * FROM cd_attends;
SELECT coder_name,
  badge_earned,
  spec_name
FROM cd_attendee
JOIN cd_attends USING (coder_id)
JOIN cd_session_runs USING (s_start, loc_id, spec_code)
JOIN cd_speciality USING (spec_code)
WHERE badge_earned IS NOT NULL;
/*6.	Write SQL to list the names of any attendee that attended all session runs facilitated by Ken.
*/

CREATE VIEW kens_runs AS
  (SELECT s_start,
      loc_id,
      spec_code
    FROM cd_session_runs
    JOIN cd_facilitator USING (facilitator_id)
    WHERE facilitator_name LIKE 'Ken%'
  );
SELECT coder_name
FROM cd_attendee A
WHERE NOT EXISTS
  (SELECT *
  FROM kens_runs B
  WHERE NOT EXISTS
    (SELECT *
    FROM cd_attends X
    WHERE ( X.coder_id = A.coder_id
    AND X.s_start      = B.s_start
    AND X.loc_id       = B.loc_id
    AND X.Spec_code    = B.spec_code)
    )
  );