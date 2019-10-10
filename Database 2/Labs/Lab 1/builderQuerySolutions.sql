ALTER SESSION SET current_schema = builder2;

-- Get the sock codes and descrptions of all stock items that are selling at a loss. (unit price > unitCostPrice)
SELECT STOCK_CODE, STOCK_DESCRIPTION 
FROM STOCK 
WHERE UNIT_PRICE < UNITCOSTPRICE;


-- get the stock codes and descriptions of all stock items that need to be reordered. 
SELECT STOCK_CODE, STOCK_DESCRIPTION
FROM STOCK 
WHERE STOCK_LEVEL < REORDER_LEVEL;
--SELECT * FROM STOCK;
-- List the names of all customer who have no orders. 
select customer_name from customer where customer_id not in
(select customer_id from corder);
-- OR
select customer_name from customer left join corder using (customer_id)
where corderno is null;

-- get the description of all stock items that Handy Andy bought. 
SELECT STOCK.STOCK_DESCRIPTION
FROM STOCK
JOIN CORDERLINE ON CORDERLINE.STOCK_CODE = STOCK.STOCK_CODE
JOIN CORDER ON CORDER.CORDERNO = CORDERLINE.CORDERNO
JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = CORDER.CUSTOMER_ID
WHERE CUSTOMER.CUSTOMER_NAME = 'Handy Andy';

-- get the supplier name of any supplier who didn't supply any stock
SELECT SUPPLIER_NAME 
FROM SUPPLIER 
WHERE SUPPLIER.SUPPLIER_ID NOT IN 
(SELECT STOCK.SUPPLIER_ID FROM STOCK);

--  get customer_id from customers who bought stock code A101 or A111.
SELECT CUSTOMER.CUSTOMER_NAME
FROM CUSTOMER
JOIN CORDER ON CORDER.CUSTOMER_ID =  CUSTOMER.CUSTOMER_ID
JOIN CORDERLINE ON CORDERLINE.CORDERNO = CORDER.CORDERNO
JOIN STOCK ON STOCK.STOCK_CODE = CORDERLINE.STOCK_CODE
WHERE STOCK.STOCK_CODE = 'A101'
UNION 
SELECT CUSTOMER.CUSTOMER_NAME
FROM CUSTOMER
JOIN CORDER ON CORDER.CUSTOMER_ID =  CUSTOMER.CUSTOMER_ID
JOIN CORDERLINE ON CORDERLINE.CORDERNO = CORDER.CORDERNO
JOIN STOCK ON STOCK.STOCK_CODE = CORDERLINE.STOCK_CODE
WHERE STOCK.STOCK_CODE = 'A111';

select customer_name from customer where customer_id in  
(select customer_id from corder
join corderline using (corderno)
where stock_code in ('A101','A111'));

-- get the names of all staff member who took payment from Mary Martin
SELECT STAFF_NAME 
FROM STAFF
JOIN CORDER ON CORDER.STAFFPAID = STAFF.STAFF_NO
JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = CORDER.CUSTOMER_ID
WHERE CUSTOMER_NAME = 'Mary Martin';

-- OR 
select staff_name from staff where staff_no in
(select staffpaid from corder
join customer using (customer_id)
where customer_name like 'Mary Martin%');

-- get the names of all staff members who issued goods supplied by Buckleys
SELECT STAFF_NAME 
FROM STAFF
JOIN CORDER ON CORDER.STAFFISSUED = STAFF.STAFF_NO
JOIN CORDERLINE ON CORDERLINE.CORDERNO = CORDER.CORDERNO
JOIN STOCK ON STOCK.STOCK_CODE = CORDERLINE.STOCK_CODE
JOIN SUPPLIER ON SUPPLIER.SUPPLIER_ID = STOCK.SUPPLIER_ID
WHERE SUPPLIER_NAME = 'Buckleys';

-- OR -- get the names of all staff members who issued goods supplied by Buckleys

select staff_name from staff
where staff_no in
(select staffissued
from corder 
join corderline using (corderno)
join stock using (stock_code)
join supplier using (supplier_id)
where supplier_name like 'Buckleys%');

-- get the customer_id for the customer who bought A101 and A111.
SELECT CUSTOMER.CUSTOMER_NAME 
FROM CUSTOMER
JOIN CORDER ON CORDER.CUSTOMER_ID =  CUSTOMER.CUSTOMER_ID
JOIN CORDERLINE ON CORDERLINE.CORDERNO = CORDER.CORDERNO
JOIN STOCK ON STOCK.STOCK_CODE = CORDERLINE.STOCK_CODE
WHERE STOCK.STOCK_CODE = 'A101'
INTERSECT
SELECT CUSTOMER.CUSTOMER_NAME
FROM CUSTOMER
JOIN CORDER ON CORDER.CUSTOMER_ID =  CUSTOMER.CUSTOMER_ID
JOIN CORDERLINE ON CORDERLINE.CORDERNO = CORDER.CORDERNO
JOIN STOCK ON STOCK.STOCK_CODE = CORDERLINE.STOCK_CODE
WHERE STOCK.STOCK_CODE = 'A111';

SELECT customer_name
FROM customer
WHERE customer_id IN
  (SELECT customer_id
  FROM corder
  JOIN corderline USING (corderno)
  WHERE stock_code = 'A101'
INTERSECT
  SELECT customer_id
  FROM corder
  JOIN corderline USING (corderno)
  WHERE stock_code = 'A111'
  );

-- List the supplier_id and supplierorderno for all orders that were delivered late (5 days) or not at all. 
SELECT SUPPLIER_ID, SORDERNO
FROM SORDER
WHERE DELIVEREDDATE IS NULL OR DELIVEREDDATE > (SORDERDATE + 5);

-- OR 
select supplier_id, sorderno from sorder where (delivereddate > sorderdate + 5) or delivereddate is null;


