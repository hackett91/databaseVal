-- QUERIES (3 of 10) individual: Each student should write individual queries that show the following:
-- Selection, Projection, Aggregation with filters on aggregates, 
-- Union, Minus, Difference, Inner Join, Outer Join, Semi-join, Anti-join and Correlated sub-query.
-- Each query should be tested to ensure that there is data there to satisfy it and to show that it works – i.e. a 
-- query that shows the power of the technique being used (e.g. a left join that would return the same as 
-- an inner join will not get full marks). You may create views as required but show your code if you do.

-- selection turn a relation into a horizontal subset
select * from dt2283group_g.usage where chargetype_id = 3;

-- projection turn a relation into a vertical subset
select usage_name, provider from dt2283group_g.usage;

-- Aggregation with filters on aggregates (counting number of occurences of a voice calls
select dt2283group_g.chargetype.name, count(chargetype_id) As Occurences
from dt2283group_g.usage
join dt2283group_g.chargetype on dt2283group_g.chargetype.id = dt2283group_g.usage.chargetype_id
where dt2283group_g.chargetype.name = 'Voice Call'
Group by dt2283group_g.chargetype.name;

-- Union of all local and international call all voice calls made
select * from dt2283group_g.usage
join dt2283group_g.chargetype on dt2283group_g.chargetype.id = dt2283group_g.usage.chargetype_id
where dt2283group_g.chargetype.name = 'Voice Call'
AND dt2283group_g.usage.number_accessed like '+353%'
Union
select * from dt2283group_g.usage
join dt2283group_g.chargetype on dt2283group_g.chargetype.id = dt2283group_g.usage.chargetype_id
where dt2283group_g.chargetype.name = 'Voice Call'
AND dt2283group_g.usage.number_accessed not like '+353%';

select * from dt2283group_g.usage;
select * from dt2283group_g.chargetype;

-- MInus (we have all the voice call made minus the international calls which leaves us with just local calls.)
select *
from dt2283group_g.usage
join dt2283group_g.chargetype on dt2283group_g.chargetype.id = dt2283group_g.usage.chargetype_id
where dt2283group_g.chargetype.name = 'Voice Call'
Minus
select * from dt2283group_g.usage
join dt2283group_g.chargetype on dt2283group_g.chargetype.id = dt2283group_g.usage.chargetype_id
where dt2283group_g.chargetype.name = 'Voice Call'
AND dt2283group_g.usage.number_accessed not like '+353%';

-- Difference - semetric difference 
-- cian has one phone 1121 and valentin has two phones 6510 and 1121
-- the difference is 6510
select dt2283group_g.phone.PHONETYPE_TYPE_NAME from dt2283group_g.phone
join dt2283group_g.purchase on 
dt2283group_g.purchase.PURCHASE_ID = dt2283group_g.phone.PURCHASE_PURCHASE_ID
join dt2283group_g.customer on 
dt2283group_g.customer.customer_no = dt2283group_g.purchase.customer_customer_no 
where name = 'Valentin Ciceu'
union
select dt2283group_g.phone.PHONETYPE_TYPE_NAME from dt2283group_g.phone
join dt2283group_g.purchase on 
dt2283group_g.purchase.PURCHASE_ID = dt2283group_g.phone.PURCHASE_PURCHASE_ID
join dt2283group_g.customer on 
dt2283group_g.customer.customer_no = dt2283group_g.purchase.customer_customer_no 
where name = 'Cian Hackett'
minus
(
select  dt2283group_g.phone.PHONETYPE_TYPE_NAME from dt2283group_g.phone
join dt2283group_g.purchase on 
dt2283group_g.purchase.PURCHASE_ID = dt2283group_g.phone.PURCHASE_PURCHASE_ID
join dt2283group_g.customer on 
dt2283group_g.customer.customer_no = dt2283group_g.purchase.customer_customer_no 
where name = 'Valentin Ciceu'
intersect
select dt2283group_g.phone.PHONETYPE_TYPE_NAME from dt2283group_g.phone
join dt2283group_g.purchase on 
dt2283group_g.purchase.PURCHASE_ID = dt2283group_g.phone.PURCHASE_PURCHASE_ID
join dt2283group_g.customer on 
dt2283group_g.customer.customer_no = dt2283group_g.purchase.customer_customer_no 
where name = 'Cian Hackett'
);



-- using an inner join to find the number of purchases
-- Inner Join
select dt2283group_g.customer.name, count(*) NumberOfPurchases 
from dt2283group_g.purchase
inner join dt2283group_g.customer on 
dt2283group_g.customer.customer_no = dt2283group_g.purchase.customer_customer_no
where dt2283group_g.customer.name = 'Valentin Ciceu'
Group by dt2283group_g.customer.name;


-- using left outter to find all type of phones that are not nokia
-- Outer Join 
select dt2283group_g.phonemanufacturer.name, dt2283group_g.phonetype.type_name 
from dt2283group_g.phonetype
left outer join dt2283group_g.phonemanufacturer on 
dt2283group_g.phonemanufacturer.name = dt2283group_g.phonetype.phonemanufacturer_name
where dt2283group_g.phonemanufacturer.name != 'Nokia';

-- Semi-join 
-- A semijoin returns rows that match an EXISTS subquery 
-- without duplicating rows from the left side of the predicate 
-- when multiple rows on the right side satisfy the criteria of the subquery.
-- just checking to see did we sell any 6510 phones (where exist one or more)
SElECT * from dt2283group_g.purchase
where exists (
select * from dt2283group_g.phone
where dt2283group_g.purchase.purchase_id = dt2283group_g.phone.purchase_purchase_id
AND dt2283group_g.phone.phonetype_type_name = 6510 ); 

-- Anti-join - 
-- An antijoin returns rows from the left side of the predicate 
-- for which there are no corresponding rows on the right side 
-- of the predicate. It returns rows that fail to match (NOT IN) the subquery on the right side.
-- select all the phone that aren't in the purchase that has customerno with 1
SElECT * from dt2283group_g.phone
where purchase_purchase_id not in (
select purchase_id from dt2283group_g.purchase
where customer_customer_no = 1); 

-- using sub query to find all purchase that I made
-- correlated sub query
select * from dt2283group_g.purchase 
where dt2283group_g.purchase.customer_customer_no = (
select  customer_no from dt2283group_g.customer
where name = 'Cian Hackett');