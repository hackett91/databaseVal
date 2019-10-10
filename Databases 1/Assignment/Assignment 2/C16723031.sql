-- C16723031
-- Cian Hackett
-- DT228 Year 2

-- Dropping tables because errors will occur if reloaded.
DROP TABLE SpecProd;
DROP TABLE Specification;
DROP TABLE Product;
DROP TABLE Client;
DROP TABLE Designer;
DROP TABLE ProdType;


-- Creating tables
--Client
-- As requested client was made the primary key. All contraint are named as specified.
-- Email is required so it can be NULL and also must have and @. 
CREATE TABLE Client(
                    clientID NUMBER(6),
                    fullName VARCHAR2(50),
                    emailAdr VARCHAR2(30) NOT NULL,
                    CONSTRAINT client_pk PRIMARY KEY(clientID),
                    CONSTRAINT clientemail_chk CHECK(emailAdr LIKE '%@%.%'),
                    CONSTRAINT clientemail_uniq UNIQUE(emailAdr)
                    );
--Designer
-- DesignerID is the primary key. The contraint are implemented and named as requested.
CREATE TABLE Designer(
                       designerID NUMBER(6),
                       dName VARCHAR2(50),
                       emailAdr VARCHAR2(30) NOT NULL,
                       dRateofPay NUMBER(4,2) NOT NULL,
                       CONSTRAINT designer_pk PRIMARY KEY (designerID),
                       CONSTRAINT designeremail_chk CHECK(emailAdr LIKE '%@%.%'),
                       CONSTRAINT designerdRateofPay_chk CHECK(dRateofPay < 75.99),
                       CONSTRAINT designeremail_uniq UNIQUE(emailAdr)
                       );
                       
 --ProdType
 -- The primary key is prodcat and name as requested.
CREATE TABLE ProdType(
                    prodCat CHAR(1),
                    catDesc VARCHAR2(50),
                    CONSTRAINT prodType_pk PRIMARY KEY (prodCat),
                    CONSTRAINT productCatType_ck CHECK(prodCat = 'G' OR prodCat = 'L' OR prodCat = 'C' OR prodCat = 'X' OR prodCat = 'S')
                    );

-- Appropriate contraints implemented for prodCat (NOTE: aware could of used IN and listed) and unit price.
-- the primary key is a composite key and is implement accordinaly 
CREATE TABLE Product(
                       prodCat CHAR(1),
                       prodID NUMBER(4),
                       prodDescription VARCHAR(50),
                       prodUnitPrice NUMBER(4,2) NOT NULL,
                       prodQtyInStock NUMBER(3) NOT NULL,
                       CONSTRAINT product_pk PRIMARY KEY(prodID,prodCat),
                       CONSTRAINT productUnitPrice_chk CHECK(prodUnitPrice BETWEEN 5.00 AND 45.50),
                       CONSTRAINT product_prodType_fk FOREIGN KEY (prodCat) REFERENCES ProdType(prodCat)                
                       );
                       
-- Contraint implemented correctly and proper used of constraint names.             
CREATE TABLE Specification(
                            specID NUMBER(6),
                            clientID NUMBER(6),
                            designerID NUMBER(6),
                            specDate DATE NOT NULL,
                            specDesc VARCHAR2(50),
                            specCommission NUMBER(7,2) NOT NULL,                     
                            designerHrsWorked NUMBER(4) NOT NULL,
                            CONSTRAINT specification_pk PRIMARY KEY(specID),
                            CONSTRAINT specification_client_fk FOREIGN KEY (clientID) REFERENCES Client(clientID),
                            CONSTRAINT specification_designer_fk FOREIGN KEY (designerID) REFERENCES Designer(designerID),
                            CONSTRAINT specCommission_chk CHECK(specCommission <= 16000),
                            CONSTRAINT designerHrsWorked_chk CHECK(designerHrsWorked <= 150)
                         );
-- Three primary keys implement as specified. Constraints named as specified                         
CREATE TABLE SpecProd(
                        specID NUMBER(6),
                        prodID NUMBER(4),
                        prodCat CHAR(1),
                        qtyUsed NUMBER(2),
                        CONSTRAINT specProd_pk PRIMARY KEY(specID,  prodID, prodCat),
                        CONSTRAINT specProd_specification_fk FOREIGN KEY(specID)  REFERENCES Specification(specID),
                        CONSTRAINT specProd_product_fk FOREIGN KEY(prodCat,prodID) REFERENCES Product(prodCat,prodID)
                            );
                            
                            
-- breaking constraint to ensure they are working as specified.

--CLIENT TABLE CONSTRAINT TESTING
--Client Table Primary Key Test 
--INSERT INTO Client(clientID, fullname, emailAdr) VALUES (101,'J.J. Abrams','jjab@sw.com');
--INSERT INTO Client(clientID, fullname, emailAdr) VALUES (101,'J.J. Abrams','jjab@sw.com');
--Client Table Email Check for @ Test
--INSERT INTO Client(clientID, fullname, emailAdr) VALUES (101,'J.J. Abrams','jjabsw.com');
--Client Table Email Unique Test
--INSERT INTO Client(clientID, fullname, emailAdr) VALUES (999,'J.J. Abrams','jjab@sw.com');
--INSERT INTO Client(clientID, fullname, emailAdr) VALUES (998,'J.J. Abrams','jjab@sw.com');

-- DESIGNER TABLE CONSTRAINT TESTING
--Designer Table Primary Key Test
--INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (101,'Kelly Hoppen','khop@gmail.com.uk',65.00);
--INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (101,'Kelly Hoppen','khop@gmail.com.uk',65.00);
--Designer Table Email Check for @ Test
--INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (555,'Kelly Hoppen','khopgmail.com.uk',65.00);
-- Designer Table Pay less than 75.99
--INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (555,'Kelly Hoppen','khopgmail.com.uk',90.00);
--Designer Table Email Unique Test
--INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (456,'Kelly Hoppen','khop@gmail.com.uk',65.00);
--INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (234,'Kelly Hoppen','khop@gmail.com.uk',65.00);

-- PRODTYPE TABLE CONSTRAINT TESTING
--ProdType Table Primary Key Test
--INSERT INTO ProdType(prodCat, catDesc) VALUES ('G','Garden Lighting');
--INSERT INTO ProdType(prodCat, catDesc) VALUES ('G','Garden Lighting');
-- ProdType Check for G,L,C,X or S Test
--INSERT INTO ProdType(prodCat, catDesc) VALUES ('R','Garden Lighting');

-- NOTE NEEDED TO MOVE BELOW TO TEST FOREIGN KEYS



-- Note: I realised that order of Inserting important you cannot create a child unless you have the parent created first.
-- i.e. primary key must be created before it becomes a foreign key in another table.

 --insert into client - order of colums and data must match for insert to work.
INSERT INTO Client(clientID, fullname, emailAdr) VALUES (101,'J.J. Abrams','jjab@sw.com');
INSERT INTO Client(clientID, fullname, emailAdr) VALUES (201,'Lawrence Kasdan','lkas@sw.com');
INSERT INTO Client(clientID, fullname, emailAdr) VALUES (301,'Daisy Ridley','drid@sw.com');
INSERT INTO Client(clientID, fullname, emailAdr) VALUES (401,'John Boyega','jboy@sw.com');

-- insert into designer
INSERT INTO Designer(designerID,dName,emailAdr,dRateofPay) VALUES (101,'Kelly Hoppen','khop@gmail.com.uk',65.00);
INSERT INTO Designer(designerID,dName, emailAdr,dRateofPay) VALUES (201,'Philippe Starck','pstark@stark.com',72.50);
INSERT INTO Designer(designerID, dName, emailAdr,dRateofPay) VALUES (301,'Victoria Hagan','vichag@gmail.com',75.00);
INSERT INTO Designer(designerID, dName, emailAdr,dRateofPay) VALUES (401,'Marmol Radziner','marmrad@gmail.com',45.50);

-- inserting into prodCat
INSERT INTO ProdType(prodCat, catDesc) VALUES ('G','Garden Lighting');
INSERT INTO ProdType(prodCat, catDesc) VALUES ('L','Lamps and Bulbs');
INSERT INTO ProdType(prodCat, catDesc) VALUES ('C','Cables');
INSERT INTO ProdType(prodCat, catDesc) VALUES ('X','Christmas');
INSERT INTO ProdType(prodCat, catDesc) VALUES ('S','Shades');

--inserting into product
INSERT INTO Product(prodCat, prodID, prodDescription,prodUnitPrice, prodQtyInStock) VALUES('G',101,'Outdoor Wall Light',40.00,26);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('G',102,'Patio Lights',41.00,27);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('L',101,'E14 Energy Saving Bulb',6.00,28);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('L',102,'E27 Led Bulb',9.00,30);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('C',101,'2-Core Black Braided Flexible Rubber Cable',10.00,50);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('C',102,'Southwire 250-Ft 2-Conductor Landscape',10.00,50);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('X',101,'Led string lights German Chirstmas 10-light',15.50,55);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('X',102,'Led heart string lights',20.00,12);
INSERT INTO Product(prodCat, prodID, prodDescription, prodUnitPrice, prodQtyInStock) VALUES('S',101,'Fabric Cylinder',30.00,100);


--PRODUCT TABLE CONSTRAINT TESTING
-- Product Table Primary Key Test
--INSERT INTO Product(prodCat, prodID, prodDescription,prodUnitPrice, prodQtyInStock) VALUES('G',101,'Outdoor Wall Light',40.00,26);
--INSERT INTO Product(prodCat, prodID, prodDescription,prodUnitPrice, prodQtyInStock) VALUES('G',101,'Outdoor Wall Light',40.00,26);
-- Product Table Unit Price check between 5 and 45.50 Test
--INSERT INTO Product(prodCat, prodID, prodDescription,prodUnitPrice, prodQtyInStock) VALUES('G',101,'Outdoor Wall Light',90,26);  
-- Product Table Foreign Key Test i.e parent key not found
--INSERT INTO Product(prodCat, prodID, prodDescription,prodUnitPrice, prodQtyInStock) VALUES('G',665,'Outdoor Wall Light',40.00,26);

-- inserting into specifications 
INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(101,101,101,'12 JUN 2017','Full House',10000,10);                                 
INSERT INTO Specification(specID,clientID,designerID,specDate,specDesc, specCommission,designerHrsWorked) VALUES(102,101,101,'14 JUL 2017','Garden Patio',12000,20);
INSERT INTO Specification(specID,clientID,designerID,specDate,specDesc, specCommission,designerHrsWorked) VALUES(103,201,301,'15 AUG 2017','Summerhouse',8000,5);
INSERT INTO Specification(specID,clientID,designerID, specDate,specDesc, specCommission, designerHrsWorked) VALUES(104,301,201,'10 SEP 2017','Christmas decorations',5000,5);

-- SPECIFICATION TABLE CONSTRAINT TESTING
-- Specification Primary Key Test
--INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(101,101,101,'12 JUN 2017','Full House',10000,10);                                 
--INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(101,101,101,'12 JUN 2017','Full House',10000,10);                                 
-- Specification/Client foreign key check
--INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(999,454,101,'12 JUN 2017','Full House',10000,10);                                 
-- Specification/Designer foreign key check
--INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(111,101,995,'12 JUN 2017','Full House',10000,10);                                 
-- Specification Table Spec commission less than or equals to 16000 Test
--INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(15,101,101,'12 JUN 2017','Full House',17000,10);                                 
-- Specification Table designerhours worked less than or equals to 150
--INSERT INTO Specification(specID,clientID, designerID,specDate,specDesc,specCommission,designerHrsWorked) VALUES(99,101,101,'12 JUN 2017','Full House',10000,160);                                 


-- inserting into product specifications
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(101,'L',101,20);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(101,'L',102,30);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(101,'C',101,10);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(102,'G',101,20);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(102,'G',102,25);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(103,'C',101,10);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(103,'C',102,3);
INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(104,'X',101,20);

-- SPEC PROD TABLE CONSTRAINT TESTING
-- SpecProd Table Testing primarykey
--INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(104,'X',101,20);
--INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(104,'X',101,20);
-- SpecProd Table specID foreign key test
--INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(700,'X',101,20);
-- SpecProd Table prodcat and prodID foreignkey test
--INSERT INTO SpecProd(specID,prodCat,prodID,qtyUsed) VALUES(104,'V',101,20);
commit;

--1
--      A listing for all designers of the specifications they have worked on including in the output
--      their name, email address and a 10 character description of the specification in uppercase sorted
--      in descending order of designer id and then specification description.

-- using nested functions to get a 10 char uppercase decscripton. using the JOIN and USING (foreign key) to join the two tables
-- using ORDER BY  (column, column) DESC to order both column is descending order
SELECT SUBSTR(UPPER(specDesc),1,10)As SpecDescription, dName, emailAdr,designerID
FROM Designer
JOIN Specification USING(designerID)
ORDER BY designerID,specDesc DESC; 

--2.
--      A listing of all products. Including one column which combines the product ID and the product
--      category code; the product category description (in uppercase);  product description (in uppercase)
--      product price (preceded by the Euro symbol). The listing should be sorted by product category description
--      in ascending order and descending order of product price within each category.

--using concat function to combine two column to make prodid, uppercase funciton and to_char function to get €symbol
-- joining prodtype with product through foreign key prodCat. Then ordering it by prodCat ascending order then productUnit Price decending order
SELECT CONCAT(prodCat,prodID)PRODID,UPPER(catDesc)CATEGORYDESC,UPPER(prodDescription)PRODDESC,TO_CHAR(prodUnitPrice,'U999,999.99')PRICE
FROM ProdType
JOIN Product USING(prodCat)
ORDER BY prodCat ASC, prodUnitPrice DESC; 

--3.
--    A listing of all specifications showing the specification ID, client ID, client name,
--      specification description, specification date (formatted as dd/mm/yyyy) and
--      specification commission(including the Euro symbol) sorted in descending order of commission.

-- using the to_char funciton to display the date in format needed and display commission with the euro symbol and format needed.
-- Client table and specification table joined through foreign key clientID and ordered by specCommision is descending order.
SELECT specID,clientID,fullname,specDesc,TO_CHAR(specDate,'DD/MM/YYY')SPECDATE, TO_CHAR(specCommission,'U999,999.99') AS "SPECCOMMISSION"
FROM Client
JOIN Specification USING(clientID)
ORDER BY specCommission DESC;

-- 4.
--A listing of all specifications showing the specification ID, client ID, client name, designer ID, 
--designer name, specification description, specification date (formatted as dd/mm/yyyy) and specification commission(including the Euro
--symbol) sorted in descending order of commission. 
--The following headers should be used SPECIFICATION ID CLIENT NAME DESIGNER NAME DESCRIPTION COMMISSION DATE COMMISSION AMT

-- using (AS) after column to change the name of the headers in output. Using the to_char function to dicate the output of the format of the 
-- date and commission. joining 3 tables together by the foreign key relationships. Finally ordering the out by specCommission in descending order.  
SELECT  specID AS "SPECIFICATION ID",clientID, fullname AS "CLIENT NAME",designerID,
dName AS "DESIGNER NAME",specDesc AS "DESCRIPTION", 
TO_CHAR(specDate,'DD/MM/YYYY') AS "COMMISSION DATE", TO_CHAR(specCommission,'U999,999.99') AS "COMMISSITION AMT"
FROM Specification
JOIN Client USING (clientID)  
JOIN Designer USING (designerID)
ORDER BY specCommission DESC;

-- 5. 
--A listing for each product used as part of a specification the specification ID, specification description, the product name,
--product price, number of each product used and a total price per product per specification (price x quantity used).

-- not specified but using LTRIM to trim back white space to the left and using to_char to format the output of the multiplication. Changing
-- the name of the column by using (AS). Joining 3 tables together and in product table there is a composite key so its very important 
-- to add both keys in the JOIN statment.
SELECT prodID, specID,specDesc, prodDescription, prodUnitPrice, qtyUsed, LTRIM(TO_CHAR(prodUnitPrice*qtyUsed,'U999,999.99')) AS "TOTAL PRICE"
FROM SpecProd
JOIN Specification USING(specID)
JOIN Product USING(prodID,prodCat);

-- 6. 
--    A listing for each specification including the specification ID, specification description and total cost of
--    the specification (commission + Sum of price x product price for all products used).
--    Hint: Involves a group 

-- using the ltrim function to get rid of the white spaces to the left of the column. using to_char function to format the output of column.
-- using the sum function to get the sum and enable it to be added to specComission. Joining 3 tables together and in product table
-- there is a composite key so its very important 
-- to add both keys in the JOIN statment.Because sum function is a group by function we need
-- group everything that isn't part of the function

SELECT specID, specDesc, LTRIM(TO_CHAR(specCommission + sum(prodUnitPrice*qtyUsed),'U999,999.99')) AS "TOTAL"
FROM SpecProd
JOIN Specification USING(specID)
JOIN Product USING(prodID,prodCat)
-- group everything that isn't part of the function (rule)
GROUP BY specID,specDesc, specCommission;

-- 7. 
--    A listing showing details required for report 6 but including an additional column in the output
--      which categorises the specification as ‘High Value’ if the total cost is > 10,000, ‘Medium Cost’
--      if the total cost is between 8,000 and 10,000 and ‘Low Cost’ otherwise.
--      Hint: Involves using a selection statement

--Joining 3 tables together and in product table there is a composite key so its very important 
-- to add both keys in the JOIN statment. Using CASE WHEN function to make the option conditional. i.e. controlling
-- different output depending on specifications.
--Because sum function is a group by function we need
-- group everything that isn't part of the function

SELECT specID, specDesc, LTRIM(TO_CHAR((specCommission + sum(prodUnitPrice*qtyUsed)),'U999,999.99')) AS "Total Cost",
CASE WHEN (specCommission + sum(prodUnitPrice*qtyUsed)) > 10000 THEN 'High Value'
WHEN  (specCommission + sum(prodUnitPrice*qtyUsed)) BETWEEN 8000 AND 10000 THEN 'Medium Value'
ELSE 'Lowcost'
END AS RANGE
FROM SpecProd
JOIN Specification USING(specID)
JOIN Product USING(prodID,prodCat)
-- group everything that isn't part of the function (rule)
GROUP BY specID,specDesc, specCommission;


--8 8.  

--A listing showing details required for report 6 but including only specifications with a total 
--cost more than 10000. Output should in the form of a sentence for each specification and the output 
--column should be called ‘High Value Specifications’. All numeric fields should be formatted 
--appropriately for numerical/monetary field and trimmed of leading spaces to give a consistent output. E.g.
--Specification 102 Garden Patio used a total of 45 products at a cost of €1825.00 and the total cost 
--including commission was €13825.00 Hint: involves a group but including only selected values in
--the output with all output concatenated. 

-- making column data into sentence by inverted comma key and bar key depending on where you want to insert he text. using LTRIM and sum to format column.
--Because sum function is a group by function we need
-- group everything that isn't part of the function. Joining 3 tables together and in product table there is a composite key so its very important 
-- to add both keys in the JOIN statment. Using the (having) statement to control the output to be greater than 10000. (having is similary to where but it 
  --effects the output not the input)


SELECT 'The ID is '|| specID || ' of the ' || specDesc ||' and the total cost is ' ||  LTRIM(TO_CHAR(specCommission + sum(prodUnitPrice*qtyUsed),'U999,999.99')) as "High Value Secification"
FROM SpecProd
JOIN Specification USING(specID)
JOIN Product USING(prodID,prodCat)
-- group everything that isn't part of the function (rule)
GROUP BY specID,specDesc, specCommission
HAVING (specCommission + sum(prodUnitPrice*qtyUsed)) > 10000;