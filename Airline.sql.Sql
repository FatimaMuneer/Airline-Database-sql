CREATE DATABASE AIRLINES;
CREATE TABLE Airplane_type(
 A_ID INT,
 Capacity INT,
 A_weight INT,
 Company VARCHAR(15),
 PRIMARY KEY(A_ID)
);
INSERT INTO Airplane_type VALUES (738,853,394,'Indigo’);
INSERT INTO Airplane_type VALUES (777,800,380,'Vistara');
INSERT INTO Airplane_type VALUES (745,770,405,'GoAir’);
SELECT * FROM Airplane_type;

CREATE TABLE Route(
 Route_ID INT,
 Take_Off_point VARCHAR(15),
 Destination VARCHAR(15),
 R_type VARCHAR(15),
 PRIMARY KEY(Route_ID)
);
INSERT INTO Route VALUES(168806,'London','Delhi','Direct');
INSERT INTO Route VALUES(157306,'NewJersey','Mumbai','2Hr Break');
INSERT INTO Route VALUES(178916,'Washington','Jodhpur','3Hr Break');
SELECT * FROM Route;

CREATE TABLE Flight(
 Flight_ID VARCHAR(15),
 Departure VARCHAR(30),
 Arrival VARCHAR(30),
 Flight_date DATE,
 A_ID INT,
 PRIMARY KEY(Flight_ID),
 FOREIGN KEY (A_ID) REFERENCES Airplane_type(A_ID)
);
INSERT INTO Flight VALUES('AI2014','2021-01-12 08:45am','2021-01-
12 10:25pm','2021-01-12',738);
INSERT INTO Flight VALUES('QR2305','2020-12-26 12:05pm','2020-12-
27 12:25pm','2020-12-26',777);
INSERT INTO Flight VALUES('EY1234','2021-02-10 05:00am','2021-02-
SELECT * FROM Flight;

CREATE TABLE AirFare(
 Fare_ID INT,
 Charge_Amount INT,
 Description VARCHAR(25),
 Flight_ID VARCHAR(15),
 PRIMARY KEY(Fare_ID),
 FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);
INSERT INTO AirFare VALUES(1,27341,'Standard Single','AI2014');
INSERT INTO AirFare VALUES(4,34837,'Standard Return','QR2305');
INSERT INTO AirFare VALUES(2,42176,'Key Fare Single','EY1234');
SELECT * FROM AirFare;

CREATE TABLE Passengers(
 Ps_ID INT,
 Ps_Name VARCHAR(20),
 Address VARCHAR(50),
 Age INT,
 Sex VARCHAR(1),
 Contacts VARCHAR(10),
 Flight_ID VARCHAR(15),
 PRIMARY KEY(Ps_ID),
 FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID)
);
INSERT INTO Passengers VALUES(1,'Steve Smith','2230 Northside,Apt 11,London'
,30,'M','8080367290','AI2014');
INSERT INTO Passengers VALUES(2,'Ankita Ahir','3456 Vikas Apts,Apt 102,New
Jersey',26,'F','8080367280','QR2305');
INSERT INTO Passengers VALUES(4,'Akhilesh Joshi','345 Chatam courts,Apt 678,
Chennai',29,'M','9080369290','EY1234');
select * from Passengers

CREATE TABLE Countries(
 Country_code INT,
 Country_Name VARCHAR(20),
 PRIMARY KEY(Country_code)
);
INSERT INTO Countries VALUES (+44,'England');
INSERT INTO Countries VALUES (+1,'USA');
INSERT INTO Countries VALUES (+91,'India');
SELECT * FROM Countries;

CREATE TABLE Airport(
 Air_code VARCHAR(10),
 Air_Name VARCHAR(50),
 City VARCHAR(20),
 State VARCHAR(20),
 Country_code INT,
 PRIMARY KEY(Air_code),
 FOREIGN KEY (Country_code) REFERENCES Countries(Country_code)
);
INSERT INTO Airport VALUES('DEL','Indira Gandhi International Airport','Delhi','
UP',+91);
INSERT INTO Airport VALUES('BOM','Chhatrapati Shivaji Maharaj International A
irport','Mumbai','Maharashtra',+91);
INSERT INTO Airport VALUES('LCY','London City Airport','Newham','London',+4
4);
SELECT * FROM Airport;

CREATE TABLE Employees(
 Emp_ID INT,
 E_Name VARCHAR(20),
 Address VARCHAR(50),
 Age INT,
 Email_ID VARCHAR(20),
 Contact VARCHAR(20),
 Air_code VARCHAR(10),
 PRIMARY KEY(Emp_ID),
 FOREIGN KEY (Air_code) REFERENCES Airport(Air_code)
);
INSERT INTO Employees VALUES(1234,'Rekha Tiwary','202-
Meeta Apt,Yogi Nagar,Mumbai‘
,30,‘rekha1234@gmail.com','+918530324018','DEL');
INSERT INTO Employees VALUES(3246,'John Dsouza','302-
Fountain Apt,ElizaBeth Street,
Newham',26,'john2346@gmail.com','+447911123456','BOM');
SELECT * FROM Employees;

CREATE TABLE Can_Land(
 Air_code VARCHAR(10),
 Flight_ID VARCHAR(15),
 PRIMARY KEY(Air_code,Flight_ID),
 FOREIGN KEY(Air_code) REFERENCES Airport(Air_code),
 FOREIGN KEY(Flight_ID) REFERENCES Flight(Flight_ID)
);
INSERT INTO Can_Land VALUES('DEL','AI2014');
INSERT INTO Can_Land VALUES('BOM','QR2305');
INSERT INTO Can_Land VALUES('LCY','EY1234');
SELECT * FROM Can_Land;


CREATE TABLE Transactions(
 TS_ID INT,
 Booking_Date DATE,
 Departure_Date DATE,
 TS_Type VARCHAR(20),
 Emp_ID INT,
 Ps_ID INT,
 Flight_ID VARCHAR(15),
 Charge_Amount INT,
 PRIMARY KEY(TS_ID),
 FOREIGN KEY (Emp_ID) REFERENCES Employees(Emp_ID) ,
 FOREIGN KEY (Ps_ID) REFERENCES Passengers(Ps_ID),
 FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID),
 FOREIGN KEY (Charge_Amount) REFERENCES AirFare(Fare_ID)
);
INSERT INTO Transactions VALUES(12345678,'2021-02-21','2021-02-
22','Google Pay',1234,1,'AI2014',27341);
INSERT INTO Transactions VALUES(45612789,'2021-01-12','2021-01-
14','Credit Card',3246,2,'QR2305',34837);
INSERT INTO Transactions VALUES(56987123,'2020-12-05','2020-12-
02','Paytm',9321,4,'EY1234',42176);
SELECT * FROM Transactions;

--Query to insert data into Airplane_type
INSERT INTO Airplane_type (A_ID, Capacity, A_weight, Company)
VALUES (1, 200, 45000.00, 'Boeing'), 
       (2, 150, 35000.00, 'Airbus');

--Query to select all flights and their airplane types
SELECT f.Flight_ID, f.Departure, f.Arrival, f.Flight_date, a.Company 
FROM Flight f
JOIN Airplane_type a ON f.A_ID = a.A_ID;

--Query to list all passengers on a specific flight
SELECT p.Name, p.Address, p.Age, p.Sex, p.Contacts
FROM Passengers p
WHERE p.Flight_ID = 1;

--Query to calculate the total charge amount for a specific flight
SELECT f.Flight_ID, SUM(a.Charge_Amount) as Total_Charge
FROM AirFare a
JOIN Flight f ON a.Flight_ID = f.Flight_ID
WHERE f.Flight_ID = 1
GROUP BY f.Flight_ID;

--Query to list all transactions made by a specific employee
SELECT t.TS_ID, t.Booking_Date, t.Departure_Date, t.Type, t.Charge_Amount
FROM Transactions t
WHERE t.Emp_ID = 1;