/************************************************************************************************************
**    DT228/DT282 Year 2 Databases I CA Part III Week 11 Questions                                         **
**    This will be marked out of 100 but will constitue 30% of the marks allocated to this part of the CA. **
**    Submit this with the questions for Week 10 and Week 12 by the deadline set.                          **
**    Your submission should be called <studentno>CAPart3-Week11.sql                                       **
**    You are expected to include comments to explain what your SQL for your answer is doing               **
*************************************************************************************************************/
-- Drop the tables 
DROP TABLE PrescriptionItem CASCADE CONSTRAINTS PURGE;
DROP TABLE Prescription CASCADE CONSTRAINTS PURGE;
DROP TABLE Doctor CASCADE CONSTRAINTS PURGE;
DROP TABLE Customer CASCADE CONSTRAINTS PURGE;
DROP TABLE NonDrugSale CASCADE CONSTRAINTS PURGE;
DROP TABLE Product CASCADE CONSTRAINTS PURGE;
DROP TABLE Supplier CASCADE CONSTRAINTS PURGE;
DROP TABLE Staff CASCADE CONSTRAINTS PURGE;
DROP TABLE Role CASCADE CONSTRAINTS PURGE;

-- Create the tables
CREATE TABLE Role
(
roleID NUMBER(6) NOT NULL ,
roleName VARCHAR2(50) NOT NULL ,

CONSTRAINT role_pk PRIMARY KEY (roleID)
);

CREATE TABLE Staff
(
staffID NUMBER(6) NOT NULL , 

staffName VARCHAR2(50) NOT NULL ,
staffAddress VARCHAR2(50) NOT NULL ,
staffPhoneNo VARCHAR2(10) NOT NULL ,
staffEmail VARCHAR2(50) ,
staffPPS VARCHAR2(9) NOT NULL ,
roleID NUMBER(6) NOT NULL ,

CONSTRAINT staffEmail_chk CHECK (staffEmail Like '%@%'),
CONSTRAINT staff_pk PRIMARY KEY (staffID),
CONSTRAINT staff_role_fk FOREIGN KEY (roleID) REFERENCES Role (roleID)
);





CREATE TABLE Supplier
(
supplierID NUMBER(6) NOT NULL ,
supplierName VARCHAR2(50) NOT NULL ,
supplierAddress VARCHAR2(50) NOT NULL ,
supplierContactNo VARCHAR2(10) NOT NULL ,

CONSTRAINT supplier_pk PRIMARY KEY (supplierID)
);

CREATE TABLE Product
(
stockCode NUMBER(6) NOT NULL ,
stockDescription VARCHAR2(50) NOT NULL ,
costPrice NUMBER(6,2) NOT NULL ,
retailPrice NUMBER(6,2) NOT NULL ,
drugnondrug NUMBER(1) DEFAULT 0,--A product is shown to be a drug if this value is 1 and not a drug if this value is 0
supplierID NUMBER(6) NOT NULL ,
CONSTRAINT costPrice_chk CHECK (costPrice < 1000),
CONSTRAINT product_pk PRIMARY KEY (stockCode),
CONSTRAINT product_supplier_fk FOREIGN KEY (supplierID) REFERENCES Supplier (supplierID)
);

CREATE TABLE NonDrugSale
(
ndsDate TIMESTAMP NOT NULL ,
staffID NUMBER(6) NOT NULL ,
stockCode NUMBER(6) NOT NULL ,
amountSold NUMBER(3) NOT NULL ,

CONSTRAINT nonDrugSale_pk PRIMARY KEY (ndsDate,staffID,stockCode),
CONSTRAINT nonDrugSale_staff_fk FOREIGN KEY (staffID) REFERENCES Staff (staffID),
CONSTRAINT nonDrugSale_product_fk FOREIGN KEY (stockCode) REFERENCES Product (stockCode)
);

CREATE TABLE Customer
(
custID NUMBER(6) NOT NULL ,
custName VARCHAR2(50) NOT NULL ,
custAddress VARCHAR2(50) NOT NULL ,
custPhone NUMBER(10) NOT NULL ,
medCard NUMBER(8) NULL ,

CONSTRAINT customer_pk PRIMARY KEY (custID)
);

CREATE TABLE Doctor
(
docID NUMBER(6) NOT NULL ,
docName VARCHAR2(50) NOT NULL ,
surgName VARCHAR2(50) NOT NULL ,
surgAddress VARCHAR2(50) NOT NULL ,

CONSTRAINT doctor_pk PRIMARY KEY (docID)
);

CREATE TABLE Prescription
(
prescriptionID NUMBER(6) NOT NULL ,
custID NUMBER(6) NOT NULL ,
docID NUMBER(6) NOT NULL ,
staffID NUMBER(6) DEFAULT 2 ,--Default is Kevin as it says he is the one who normally does it

CONSTRAINT prescription_pk PRIMARY KEY (prescriptionID),
CONSTRAINT prescription_customer_fk FOREIGN KEY (custID) REFERENCES Customer (custID),
CONSTRAINT prescription_doctor_fk FOREIGN KEY (docID) REFERENCES Doctor (docID),
CONSTRAINT prescription_staff_fk FOREIGN KEY (staffID) REFERENCES Staff (staffID)
);



CREATE TABLE PrescriptionItem
(
prescriptionID NUMBER(6) NOT NULL ,
stockCode NUMBER(6) NOT NULL ,
staffID NUMBER(6),
preDosage NUMBER(6,2) NOT NULL ,
preInstructions VARCHAR2(100) NOT NULL ,

CONSTRAINT prescriptionItem_pk PRIMARY KEY (prescriptionID,stockCode),
CONSTRAINT preItem_staff_fk FOREIGN KEY (staffID) REFERENCES Staff (staffID),
CONSTRAINT preItem_prescription_fk FOREIGN KEY (prescriptionID) REFERENCES Prescription (prescriptionID),
CONSTRAINT preItem_product_fk FOREIGN KEY (stockCode) REFERENCES Product (stockCode)
); 


--Inserting data into tables--
-- each set of inserts is followed  by a select you can uncomment to view the data
INSERT INTO Role( roleID, roleName) 
VALUES( 1, 'Dispensing Pharmicist' );
INSERT INTO Role( roleID, roleName) 
VALUES( 2, 'Counter Staff' );
INSERT INTO Role( roleID, roleName) 
VALUES( 3, 'Pharmacy Technician' );
INSERT INTO Role( roleID, roleName) 
VALUES( 4, 'Consulting Pharmicist' );
INSERT INTO Role( roleID, roleName) 
VALUES( 5, 'Chemist' );
INSERT INTO Role( roleID, roleName) 
VALUES( 6, 'Security' );
--SELECT * FROM ROLE;

INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo, staffEmail,staffPPS,roleID ) 
VALUES( 1, 'George', 'House 1','0883333111', 'george@mail.com', '3333331AA', 1 );
INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo, staffEmail,staffPPS,roleID ) 
VALUES( 2, 'Steven', 'House 2','0883333222', 'steven@mail.com', '3333332BB', 2 );
INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo, staffEmail,staffPPS,roleID ) 
VALUES( 3, 'Ann','House 3','0883333333', 'ann@mail.com','3333333CC', 3 );
INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo, staffEmail,staffPPS,roleID ) 
VALUES( 4, 'Beth', 'House 4','0883333444', 'beth@mail.com', '3333334DD', 4 );
INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo, staffEmail,staffPPS,roleID ) 
VALUES( 5, 'Jim','House 5','0883333555', 'jim@mail.com','3333335EE', 5 );
INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo,staffPPS,roleID ) 
VALUES( 6, 'Sue','House 6','0883333666','3333336FF', 3 );
INSERT INTO Staff ( staffID,staffName,staffAddress, staffPhoneNo,staffPPS,roleID ) 
VALUES( 7, 'Kyle', 'House 7','0883333777','3333337GG', 5 );
--SELECT * FROM STAFF;



INSERT INTO Supplier ( supplierID, supplierName,supplierAddress, supplierContactNo ) 
VALUES ( 1, 'StuffAndThings','Building 1','0887777111');
INSERT INTO Supplier ( supplierID, supplierName,supplierAddress, supplierContactNo ) 
VALUES ( 2, 'ThingsAndStuff','Building 2','0887777222');
INSERT INTO Supplier ( supplierID, supplierName,supplierAddress, supplierContactNo ) 
VALUES ( 3, 'MoreStuff','Building 3','0887777333');
INSERT INTO Supplier ( supplierID, supplierName,supplierAddress, supplierContactNo ) 
VALUES ( 4, 'MoreThings','Building 4','0887777444');
INSERT INTO Supplier ( supplierID, supplierName,supplierAddress, supplierContactNo ) 
VALUES ( 5, 'Nothing','Building 5','0887777555');
--SELECT * FROM SUPPLIER;

INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 1,'Aspirin', 0.99,2.99,1,1);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 2,'Panadol Actifast',01.00,5.00,1,2);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 3,'Morphine',10.00,14.99,1,3);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 4,'Calpol', 09.99,10.00,1,4);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 5,'Prednisone',1.11,8.88,1,2);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice,  supplierID) 
VALUES( 6,'Barley Sugar Lolly',1.00,2.00,1);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice,  supplierID) 
VALUES( 7,'Umbrella',10.00,20.00,4);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 8,'Insulin',5.00,150.99,1,5);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice, drugnondrug,  supplierID) 
VALUES( 9,'Plavix',3.00,5.00,1,2);
INSERT INTO Product ( stockCode, stockDescription,costPrice, retailPrice,  supplierID) 
VALUES(10,'Lynx',1.00,4.00,3);
--SELECT * FROM PRODUCT;

INSERT INTO NonDrugSale ( staffID,stockCode,amountSold, ndsDate ) 
VALUES ( 1,6,1,TO_TIMESTAMP('2016-03-20 9:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO NonDrugSale ( staffID,stockCode,amountSold, ndsDate ) 
VALUES ( 1,7,3,TO_TIMESTAMP('2016-01-02 ', 'YYYY-MM-DD '));
INSERT INTO NonDrugSale ( staffID,stockCode,amountSold, ndsDate ) 
VALUES ( 4,6,5,TO_TIMESTAMP('2016-05-29 ', 'YYYY-MM-DD '));
INSERT INTO NonDrugSale ( staffID,stockCode,amountSold, ndsDate ) 
VALUES ( 6,7,7,TO_TIMESTAMP('2015-11-17 ', 'YYYY-MM-DD '));
INSERT INTO NonDrugSale ( staffID,stockCode,amountSold, ndsDate ) 
VALUES ( 2,7,9,TO_TIMESTAMP('2015-09-05 ', 'YYYY-MM-DD '));
--SELECT * FROM NONDRUGSALE;

INSERT INTO Customer ( custID, custName,custAddress, custPhone) 
VALUES( 1, 'Danny', 'Apartment 1', '0897777111');
INSERT INTO Customer ( custID, custName,custAddress, custPhone, medCard ) 
VALUES( 2, 'Suzy','Apartment 2','0897777222', 99992222 );
INSERT INTO Customer ( custID, custName,custAddress, custPhone ) 
VALUES( 3, 'Ross','Apartment 3','0897777333');
INSERT INTO Customer ( custID, custName,custAddress, custPhone, medCard ) 
VALUES( 4, 'Brian', 'Apartment 4','0897777444', 99994444 );
INSERT INTO Customer ( custID, custName,custAddress, custPhone ) 
VALUES( 5, 'Arin','Apartment 5','0897777555' );
INSERT INTO Customer ( custID, custName,custAddress, custPhone ) 
VALUES( 6, 'Another','Another apt',0876737373 );
--SELECT * FROM CUSTOMER;

INSERT INTO Doctor ( docID,docName,surgName,surgAddress) 
VALUES( 1, 'Geoff', 'Clinic 1', 'Office 1' );
INSERT INTO Doctor ( docID,docName,surgName,surgAddress) 
VALUES( 2, 'Lindsey', 'Clinic 2', 'Office 2' );
INSERT INTO Doctor ( docID,docName,surgName,surgAddress) 
VALUES( 3, 'Micheal', 'Clinic 3', 'Office 3' );
INSERT INTO Doctor ( docID,docName,surgName,surgAddress) 
VALUES( 4, 'Griffin', 'Clinic 4', 'Office 4' );
INSERT INTO Doctor ( docID,docName,surgName,surgAddress) 
VALUES( 5, 'Jack', 'Clinic 5', 'Office 5' );
--SELECT * FROM DOCTOR;




INSERT INTO Prescription( prescriptionID, custID, docID,staffID ) 
VALUES ( 1, 1, 1, 3);
INSERT INTO Prescription( prescriptionID, custID, docID ) 
VALUES ( 2, 2, 2);
INSERT INTO Prescription( prescriptionID, custID, docID ) 
VALUES ( 3, 3, 3);
INSERT INTO Prescription( prescriptionID, custID, docID,staffID ) 
VALUES ( 4, 4, 4, 6);
INSERT INTO Prescription( prescriptionID, custID, docID ) 
VALUES ( 5, 5, 5);
--SELECT * FROM PRESCRIPTION;

INSERT INTO PrescriptionItem( prescriptionID, stockCode, staffID, preDosage, preInstructions ) 
VALUES( 1, 4,5,20,'5ml every 2 hours');
INSERT INTO PrescriptionItem( prescriptionID, stockCode, staffID, preDosage, preInstructions ) 
VALUES( 1, 2,5,20,'Take with food');
INSERT INTO PrescriptionItem( prescriptionID, stockCode, staffID, preDosage, preInstructions ) 
VALUES( 1, 1,5,20,'2 every 4 hours for 24 hrs');
INSERT INTO PrescriptionItem( prescriptionID, stockCode,preDosage, preInstructions ) 
VALUES( 2, 2, 20,'2 every 4 hours. Do not exceed 12 in any 24 hour period' );
INSERT INTO PrescriptionItem( prescriptionID, stockCode,preDosage, preInstructions ) 
VALUES( 3, 1, 20,'Take as required' );
INSERT INTO PrescriptionItem( prescriptionID, stockCode, staffID, preDosage, preInstructions ) 
VALUES( 4, 1,3,20, ' 2 every 3 hrs' );
INSERT INTO PrescriptionItem( prescriptionID, stockCode,preDosage, preInstructions ) 
VALUES( 5, 4, 50,'10ml every 4 hours');
--SELECT * FROM PRESCRIPTIONITEM;
COMMIT;

--QUESTIONS for CA Part 3 Week 11
-- This will be marked out of 100 but will constitue 30% of the marks allocated to this part of the CA.
--1. Write the SQL to find the names (stockdescription) of all drug products that have not been used as part of a prescription.
--Note: You are only looking for products that are drugs that do not appear on prescription item. You need only output the product name
--Drugnondrug is set to 1 if the product is a drug, 0 otherwise
-- 10 marks 


--2. Change your SQL so that it outputs for all products the number of times it has been prescribed.
--If a product has not been used on a prescription item, None should be output
-- Hint: group and decode
-- 15 marks


--3. Change your SQL so that it outputs only drug products that have never been prescribed. 
-- 10 marks
-- You need to think about your where clause and how to restrict the output from a group



--4. Write the sql to output for each customer the ids of any prescriptions George's pharmacy has processed for them.
-- If a customer has not produced an prescription 0 should be output.
-- The columns in the output should be called Customer Name and PrescriptionID
-- 10 marks



--5. Write the SQL to output the customer name, doctors name and prescription id for all prescriptions and for 
-- customers that do not have prescriptions NA is output for doctors name and prescription ID.
-- You need to use a right outer join and an inner join in the SQL
-- Columns in the output should be called Customer Name, Doctor's Name and Prescription ID
-- You need to use functions to achieve the output required
-- 20 marks


--6. Write the SQL to create a View called CustomerPrescription using the SQL for part 5
-- but also including columns Customer Address, Customer Phone NOA
-- Write SQL to verify that the view has been successfully created and contains the data you expect
--10 marks



--7. Change the SQL for part 5 to use a derived table and a left outer join
-- 15 marks


--8. Create a view called PrescriptionDetail that includes information for every prescription item
-- Only inner joins are required
-- The view should have the following columns:
--PrescriptionID, StockDescription,  DispensedBy
-- (Dispensed By is the name of the staff member who dispensed the prescription item)
-- 10 marks

CREATE VIEW PrescriptionDetail as
											-- if clause = 0 then comment else do
select prescriptionID,stockDescription, staffName From prescriptionItem
inner JOIN Product USING(stockCode)
inner JOIN Staff USING(staffID);