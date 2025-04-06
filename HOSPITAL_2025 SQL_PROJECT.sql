--------------SQL PROJECT 01------------------------
---------HOSPITAL HEALTHCARE PROJECT-----------

--CREATE A DATABASE HOSPITAL

CREATE DATABASE HOSPITAL_25 ;

--TO ACTIVATE DATABASE
USE HOSPITAL_25 ;


--CREATE TABLE query for the Physician table:
CREATE TABLE Physician (
    employeeid INT NOT NULL PRIMARY KEY, -- Unique ID for each physician
    name VARCHAR(100) NOT NULL,         -- Name of the physician
    position VARCHAR(50) NOT NULL,      -- Designation of the physician
    ssn CHAR(9) NOT NULL UNIQUE         -- Security number of the physician (unique)

);


--INSERT INTO query for inserting data into the Physician table:

INSERT INTO Physician (employeeid, name, position, ssn)
VALUES
(1, 'John Dorian', 'Staff Internist', '111111111'),
(2, 'Elliot Reid', 'Attending Physician', '222222222'),
(3, 'Christopher Turk', 'Surgical Attending Physician', '333333333'),
(4, 'Percival Cox', 'Senior Attending Physician', '444444444'),
(5, 'Bob Kelso', 'Head Chief of Medicine', '555555555'),
(6, 'Todd Quinlan', 'Surgical Attending Physician', '666666666'),
(7, 'John Wen', 'Surgical Attending Physician', '777777777'),
(8, 'Keith Dudemeister', 'MD Resident', '888888888'),
(9, 'Molly Clock', 'Attending Psychiatrist', '999999999');

--CREATE TABLE query for the department table:

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    name VARCHAR(17) NOT NULL,
    head INT NOT NULL,
    FOREIGN KEY (head)
	REFERENCES Physician(employeeid) -- References the employeeid from the Physician table
);

select * from Physician;
select * from department;
select * from affiliated_with;

--INSERT INTO query to insert data into the department table:

INSERT INTO department (department_id, name, head)
VALUES 
(1, 'General Medicine', 4),
(2, 'Surgery', 7),
(3, 'Psychiatry', 9);

--CREATE TABLE query for the affiliated_with table:

CREATE TABLE affiliated_with (
   physician INTEGER NOT NULL,
   department INTEGER NOT NULL,
   primaryaffiliation VARCHAR(1) NOT NULL,
   PRIMARY KEY (physician, department),
   FOREIGN KEY (physician) REFERENCES physician(employeeid),
   FOREIGN KEY (department) REFERENCES department(department_id)
);

--INSERT INTO query to add sample data into the affiliated_with table:

INSERT INTO affiliated_with (physician, department, primaryaffiliation)
VALUES
(1, 1, 't'),
(2, 1, 't'),
(3, 1, 'f'),
(3, 2, 't'),
(4, 1, 't'),
(5, 1, 't'),
(6, 2, 't'),
(7, 1, 'f'),
(7, 2, 't'),
(8, 1, 't'),
(9, 3, 't');

--CREATE TABLE query for the procedure1:

CREATE TABLE procedure1 (
    code INTEGER NOT NULL PRIMARY KEY,   -- Unique ID for the medical procedure
    name VARCHAR(30) NOT NULL,           -- Name of the medical procedure
    cost INTEGER NOT NULL               -- Cost of the procedure
);

--INSERT INTO query to add sample data into the procedure1:

INSERT INTO procedure1 (code, name, cost) 
VALUES 
(1, 'Reverse Rhinopodoplasty', 1500),
(2, 'Obtuse Pyloric Recombobulation', 3750),
(3, 'Folded Demiophtalmectomy', 4500),
(4, 'Complete Walletectomy', 10000),
(5, 'Obfuscated Dermogastrotomy', 4899),
(6, 'Reversible Pancreomyoplasty', 5600),
(7, 'Follicular Demiectomy', 25);

--CREATE TABLE query for the trained_in:

CREATE TABLE trained_in (
    physician INTEGER NOT NULL,             -- Physician ID (references employeeid of physician table)
    treatment INTEGER NOT NULL,             -- Treatment (medical procedure code, references code of procedure table)
    certificationdate VARCHAR(10) NOT NULL, -- Certification start date
    certificationexpires VARCHAR(10) NOT NULL, -- Certification expiry date
    PRIMARY KEY (physician, treatment),     -- Composite primary key for physician and treatment combination
    FOREIGN KEY (physician) REFERENCES physician(employeeid),  -- Foreign key to physician table
    FOREIGN KEY (treatment) REFERENCES procedure1(code)        -- Foreign key to procedure table
);

--INSERT INTO query to add sample data into the trained_in:

INSERT INTO trained_in (physician, treatment, certificationdate, certificationexpires)
VALUES 
(3, 1, '1/1/2008', '31/12/2008'),
(3, 2, '1/1/2008', '31/12/2008'),
(3, 5, '1/1/2008', '31/12/2008'),
(3, 6, '1/1/2008', '31/12/2008'),
(3, 7, '1/1/2008', '31/12/2008'),
(6, 2, '1/1/2008', '31/12/2008'),
(6, 5, '1/1/2007', '31/12/2007'),
(6, 6, '1/1/2008', '31/12/2008'),
(7, 1, '1/1/2008', '31/12/2008'),
(7, 2, '1/1/2008', '31/12/2008'),
(7, 3, '1/1/2008', '31/12/2008'),
(7, 4, '1/1/2008', '31/12/2008'),
(7, 5, '1/1/2008', '31/12/2008'),
(7, 6, '1/1/2008', '31/12/2008'),
(7, 7, '1/1/2008', '31/12/2008');

--CREATE TABLE query for the patient:

CREATE TABLE patient (
    ssn INTEGER NOT NULL,                     -- Unique ID for the patient
    name VARCHAR(17) NOT NULL,                 -- Name of the patient
    address VARCHAR(18) NOT NULL,              -- Address of the patient
    phone VARCHAR(9) NOT NULL,                 -- Phone number of the patient
    insuranceid INTEGER NOT NULL,              -- Insurance ID of the patient
    pcp INTEGER NOT NULL,                      -- Physician ID who primarily checked the patient (references employeeid of physician table)
    PRIMARY KEY (ssn),                         -- Primary key for the patient table using ssn
    FOREIGN KEY (pcp) REFERENCES physician(employeeid) -- Foreign key referencing physician table
);

--INSERT INTO query to add sample data into the patient :

INSERT INTO patient (ssn, name, address, phone, insuranceid, pcp)
VALUES 
(100000001, 'John Smith', '42 Foobar Lane', '555-0256', 68476213, 1),
(100000002, 'Grace Ritchie', '37 Snafu Drive', '555-0512', 36546321, 2),
(100000003, 'Random J. Patient', '101 Omgbbq Street', '555-1204', 65465421, 2),
(100000004, 'Dennis Doe', '1100 Foobaz Avenue', '555-2048', 68421879, 3);

--CREATE TABLE query for the nurse:

CREATE TABLE nurse (
    employeeid INTEGER NOT NULL,          -- Unique ID for the nurse
    name VARCHAR(15) NOT NULL,            -- Name of the nurse
    position VARCHAR(10) NOT NULL,        -- Designation/position of the nurse
    registered VARCHAR(1) NOT NULL,       -- Indicates whether the nurse is registered ('t' for yes, 'f' for no)
    ssn INTEGER NOT NULL,                 -- Security number of the nurse
    PRIMARY KEY (employeeid)              -- Primary key for the nurse table using employeeid
);
--INSERT INTO query to add sample data into the  nurse:

INSERT INTO nurse (employeeid, name, position, registered, ssn)
VALUES 
(101, 'Carla Espinosa', 'Head Nurse', 't', 111111110),
(102, 'Laverne Roberts', 'Nurse', 't', 222222220),
(103, 'Paul Flowers', 'Nurse', 'f', 333333330);

--CREATE TABLE query for the appointment:

CREATE TABLE appointment (
    appointmentid INTEGER NOT NULL,       -- Unique ID for the appointment
    patient INTEGER NOT NULL,             -- ID of the patient (referencing ssn column of the patient table)
    prepnurse INTEGER,                    -- ID of the nurse (referencing employeeid column of the nurse table)
    physician INTEGER NOT NULL,           -- ID of the physician (referencing employeeid column of the physician table)
    start_dt_time VARCHAR(20) NOT NULL,   -- Start date and time of the appointment
    end_dt_time VARCHAR(20) NOT NULL,     -- End date and time of the appointment
    examinationroom VARCHAR(10) NOT NULL, -- Room where the patient will meet the physician
    PRIMARY KEY (appointmentid),          -- Primary key for the appointment table using appointmentid
    FOREIGN KEY (patient) REFERENCES patient(ssn),    -- Foreign key referencing patient table
    FOREIGN KEY (prepnurse) REFERENCES nurse(employeeid), -- Foreign key referencing nurse table
    FOREIGN KEY (physician) REFERENCES physician(employeeid)  -- Foreign key referencing physician table
);

--INSERT INTO query to add sample data into the appointment:

INSERT INTO appointment (appointmentid, patient, prepnurse, physician, start_dt_time, end_dt_time, examinationroom)
VALUES 
  (13216584,100000001,101,1,'24/4/2008','24/4/2008','A'),
  (26548913,100000002,101,2,'24/4/2008','24/4/2008','B'),
  (36549879,100000001,102,1,'25/4/2008','25/4/2008','A'),
  (46846589,100000004,103,4,'25/4/2008','25/4/2008','B'),
  (59871321,100000004,NULL,4,'26/4/2008','26/4/2008','C'),
  (69879231,100000003,103,2,'26/4/2008','26/4/2008','C'),
  (76983231,100000001,NULL,3,'26/4/2008','26/4/2008','C'),
  (86213939,100000004,102,9,'27/4/2008','21/4/2008','A'),
  (93216548,100000002,101,2,'27/4/2008','27/4/2008','B');

  
  --CREATE TABLE query for the medication:

  CREATE TABLE medication (
    code INTEGER NOT NULL,          -- Unique ID for the medication
    name VARCHAR(50) NOT NULL,      -- Name of the medication
    brand VARCHAR(50) ,     -- Brand of the medication
    description VARCHAR (50)NOT NULL,               -- Description of the medication
   -- PRIMARY KEY (code)              -- Primary key for the table using the code column
);


--INSERT INTO query to add sample data into the medication:

INSERT INTO medication(code, name, brand, description)
VALUES
 (1,'Procrastin-X',NULL,'N/A'),
 (2,'Thesisin','Foo Labs','N/A'),
 (3,'Awakin','Bar Laboratories','N/A'),
 (4,'Crescavitin','Baz Industries','N/A'),
 (5,'Melioraurin','Snafu Pharmaceuticals','N/A');


 --CREATE TABLE query for the prescribes:

 CREATE TABLE prescribes (
    physician INTEGER NOT NULL,               -- ID of the physician
    patient CHAR(11) NOT NULL,                -- ID of the patient
    medication INTEGER NOT NULL,              -- ID of the medicine
    date VARCHAR(50) NOT NULL,                   -- Date and time of the prescription
    appointment INTEGER,                      -- ID of the appointment
    dose VARCHAR(50) NOT NULL,                -- Dose prescribed by the physician
   -- PRIMARY KEY (physician, patient, medication, date), -- Composite primary key
   --FOREIGN KEY (physician) REFERENCES physician(employeeid) ON DELETE CASCADE,
    --FOREIGN KEY (patient) REFERENCES patient(ssn) ON DELETE CASCADE,
    --FOREIGN KEY (medication) REFERENCES medication(code) ON DELETE CASCADE,
   -- FOREIGN KEY (appointment) REFERENCES appointment(appointmentid) ON DELETE CASCADE
   --date DATETIME NOT NULL,                   -- Date and time of the prescription
);
--DROP TABLE prescribes

--INSERT INTO query to add sample data into the prescribes:

--INSERT INTO prescribes (physician, patient, medication, date, appointment, dose)VALUES
--(1001, '12345678901', 101, '2025-01-05 10:30:00', 2001, '500 mg twice daily'),
--(1002, '12345678902', 102, '2025-01-05 11:00:00', 2002, '250 mg three times daily'),
--(1003, '12345678903', 103, '2025-01-05 12:00:00', 2003, '1000 mg once daily');

INSERT INTO prescribes(physician,patient,medication,date,appointment,dose) 
VALUES 
(1,100000001,1,'24/4/2008',13216584,5),
(9,100000004,2,'27/4/2008',86213939,10),
(9,100000004,2,'30/4/2008',NULL,5);


--CREATE TABLE query for the block:

CREATE TABLE block (
    blockfloor INTEGER NOT NULL,  -- ID of the floor
    blockcode INTEGER NOT NULL,  -- ID of the block
   -- PRIMARY KEY (blockfloor, blockcode)  -- Composite primary key
);

--INSERT INTO query to add sample data into the block:

--INSERT INTO block (blockfloor, blockcode)VALUES
--(1, 101),
--(1, 102),
--(2, 201),
--(2, 202);

INSERT INTO block (blockfloor, blockcode)VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3),
(4,1),
(4,2),
(4,3);

--CREATE TABLE query for the room:

CREATE TABLE room (
    roomnumber INTEGER NOT NULL,         -- Unique ID of the room
    roomtype VARCHAR(50) NOT NULL,      -- Type of the room
    blockfloor INTEGER NOT NULL,        -- Floor ID where the room is located
    blockcode INTEGER NOT NULL,         -- Block ID where the room is located
    unavailable VARCHAR(1) NOT NULL,       -- Indicates whether the room is unavailable
   -- PRIMARY KEY (roomnumber),           -- Ensures unique room numbers
    --FOREIGN KEY (blockfloor, blockcode) -- References block table's composite key
       -- REFERENCES block (blockfloor, blockcode)
        --ON DELETE CASCADE
        --ON UPDATE CASCADE
		--unavailable BOOLEAN NOT NULL,       -- Indicates whether the room is unavailable
);

--INSERT INTO query to add sample data into the room:

--INSERT INTO room (roomnumber, roomtype, blockfloor, blockcode, unavailable)VALUES
--(101, 'Single', 1, 101, FALSE),
--(102, 'Double', 1, 101, TRUE),
--(201, 'ICU', 2, 202, FALSE),
--(202, 'Suite', 2, 202, TRUE);

INSERT INTO room(roomnumber,roomtype,blockfloor,blockcode,unavailable) VALUES 
 (101,'Single',1,1,'f'),
 (102,'Single',1,1,'f'),
 (103,'Single',1,1,'f'),
 (111,'Single',1,2,'f'),
 (112,'Single',1,2,'t'),
 (113,'Single',1,2,'f'),
 (121,'Single',1,3,'f'),
 (122,'Single',1,3,'f'),
 (123,'Single',1,3,'f'),
 (201,'Single',2,1,'t'),
 (202,'Single',2,1,'f'),
 (203,'Single',2,1,'f'),
 (211,'Single',2,2,'f'),
 (212,'Single',2,2,'f'),
 (213,'Single',2,2,'t'),
 (221,'Single',2,3,'f'),
 (222,'Single',2,3,'f'),
 (223,'Single',2,3,'f'),
 (301,'Single',3,1,'f'),
 (302,'Single',3,1,'t'),
 (303,'Single',3,1,'f'),
 (311,'Single',3,2,'f'),
 (312,'Single',3,2,'f'),
 (313,'Single',3,2,'f'),
 (321,'Single',3,3,'t'),
 (322,'Single',3,3,'f'),
 (323,'Single',3,3,'f'),
 (401,'Single',4,1,'f'),
 (402,'Single',4,1,'t'),
 (403,'Single',4,1,'f'),
 (411,'Single',4,2,'f'),
 (412,'Single',4,2,'f'),
 (413,'Single',4,2,'f'),
 (421,'Single',4,3,'t'),
 (422,'Single',4,3,'f'),
 (423,'Single',4,3,'f');

 --CREATE TABLE query for the on_call:

 CREATE TABLE on_call (
    nurse INTEGER NOT NULL,              -- ID of the nurse
    blockfloor INTEGER NOT NULL,         -- ID of the floor
    blockcode INTEGER NOT NULL,          -- ID of the block
	oncall      DATE  NOT NULL,
    oncallend   DATE
    --oncallstart DATETIME NOT NULL,       -- Starting date and time of on-call duration
    --oncallend DATETIME NOT NULL,         -- Ending date and time of on-call duration
    --PRIMARY KEY (nurse, blockfloor, blockcode, oncallstart, oncallend), -- Composite key
    --FOREIGN KEY (nurse)                  -- References the nurse table
    -- REFERENCES nurse (employeeid)
    -- ON DELETE CASCADE
     --ON UPDATE CASCADE,
    --FOREIGN KEY (blockfloor, blockcode)  -- References the block table's composite key
     --REFERENCES block (blockfloor, blockcode)
     --ON DELETE CASCADE
     -- ON UPDATE CASCADE
);

--INSERT INTO query to add sample data into the on_call:

--INSERT INTO on_call (nurse, blockfloor, blockcode, oncallstart, oncallend)VALUES
--(101, 1, 101, '2025-01-05 08:00:00', '2025-01-05 16:00:00'),
--(102, 1, 102, '2025-01-05 16:00:00', '2025-01-06 00:00:00'),
--(103, 2, 201, '2025-01-06 08:00:00', '2025-01-06 16:00:00'),
--(104, 2, 202, '2025-01-06 16:00:00', '2025-01-07 00:00:00');

INSERT INTO on_call(nurse,blockfloor,blockcode,oncall,ONCALLEND) 
VALUES (101,1,1,'4/11/2008','4/11/2008'),
 (101,1,2,'4/11/2008','4/11/2008'),
 (102,1,3,'4/11/2008','4/11/2008'),
 (103,1,1,'4/11/2008','4/11/2008'),
 (103,1,2,'4/11/2008','4/11/2008'),
 (103,1,3,'4/11/2008','4/11/2008');

 --CREATE TABLE query for the stay:

/* CREATE TABLE stay (
    stayid INTEGER NOT NULL PRIMARY KEY,  -- Unique ID for the admission
    patient CHAR(11) NOT NULL,            -- ID of the patient
    room INTEGER NOT NULL,                -- ID of the room where the patient is admitted
    start_time DATETIME NOT NULL,         -- Admission start time
    end_time DATETIME,                    -- Discharge/end time of the stay
    FOREIGN KEY (patient)                 -- References the patient table
        REFERENCES patient (ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (room)                    -- References the room table
        REFERENCES room (roomnumber)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);*/

CREATE TABLE stay(
  stayid       INTEGER  NOT NULL,  
  patient_room VARCHAR(16) NOT NULL,
  start_time   VARCHAR(10)  NOT NULL,
  end_time     VARCHAR(10)  NOT NULL
);

--INSERT INTO query to add sample data into the stay:

/*INSERT INTO stay (stayid, patient, room, start_time, end_time)
VALUES
(1, '12345678901', 101, '2025-01-04 14:00:00', '2025-01-05 10:00:00'),
(2, '12345678902', 102, '2025-01-05 11:00:00', '2025-01-07 15:00:00'),
(3, '12345678903', 103, '2025-01-06 09:00:00', NULL),
(4, '12345678904', 104, '2025-01-06 18:00:00', '2025-01-08 08:00:00');
*/


INSERT INTO stay(stayid,patient_room,start_time,end_time) VALUES
(3215,'100000001   111','1/5/2008','4/5/2008'),
(3216,'100000003   123','3/5/2008','14/5/2008'),
(3217,'100000004   112','2/5/2008','3/5/2008');


--CREATE TABLE query for the undergoes:

/*CREATE TABLE undergoes (
    patient CHAR(11) NOT NULL,              -- ID of the patient
    procedure INTEGER NOT NULL,             -- ID of the medical procedure
    stay INTEGER,                           -- ID of the admission (optional for outpatient procedures)
    date DATE NOT NULL,                     -- Date of the procedure
    physician INTEGER NOT NULL,             -- ID of the physician performing the procedure
    assistingnurse INTEGER,                 -- ID of the nurse assisting the procedure
    PRIMARY KEY (patient, procedure, stay, date),  -- Unique combination for each undergoes record
    FOREIGN KEY (patient)                   -- References the patient table
        REFERENCES patient (ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (procedure)                 -- References the procedure table
        REFERENCES procedure (code)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (stay)                      -- References the stay table
        REFERENCES stay (stayid)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (physician)                 -- References the physician table
        REFERENCES physician (employeeid)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (assistingnurse)            -- References the nurse table
        REFERENCES nurse (employeeid)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
*/

CREATE TABLE Undergoes(
   patient        INTEGER  NOT NULL,  
  procedure1     INTEGER  NOT NULL,
  stay           INTEGER  NOT NULL,
  date           VARCHAR(9) NOT NULL,
  physicianassit INTEGER  NOT NULL,
  ingnurse       INTEGER 
);

--INSERT INTO query to add sample data into the undergoes:

/*INSERT INTO undergoes (patient, procedure, stay, date, physician, assistingnurse)
VALUES
('12345678901', 1001, 1, '2025-01-04', 201, 301),
('12345678902', 1002, 2, '2025-01-05', 202, NULL),
('12345678903', 1003, NULL, '2025-01-06', 203, 302),
('12345678904', 1004, 4, '2025-01-07', 204, 303);
*/

INSERT INTO Undergoes(patient,procedure1,stay,date,physicianassit,ingnurse) 
VALUES 
(100000001,6,3215,'2/5/2008',3,101),
(100000001,2,3215,'3/5/2008',7,101),
(100000004,1,3217,'7/5/2008',3,102),
(100000004,5,3217,'9/5/2008',6,NULL),
(100000001,7,3217,'10/5/2008',7,101),
(100000004,4,3217,'13/5/2008',3,103);

SELECT * FROM physician;
SELECT * FROM department;
SELECT * FROM affiliated_with;
SELECT * FROM procedure1;
SELECT * FROM trained_in;
SELECT * FROM patient;
SELECT * FROM nurse;
SELECT * FROM appointment;
SELECT * FROM medication;
SELECT * FROM prescribes;
SELECT * FROM block;
SELECT * FROM room;
SELECT * FROM on_call;
SELECT * FROM stay;
SELECT * FROM undergoes;

----PROBLEM STATEMENTS----

--Q1) Write a query in SQL to find all the information of the nurses who are yet to be registered. 
select * from nurse
where registered='f';

--Q2)Write a query in SQL to find the name of the nurse who are the head of their department.
select * from nurse
select name
from nurse
where position='Head Nurse';

--Q3) Write a query in SQL to obtain the name of the physicians who are the head of each department.
select * from Physician;
select * from department;

SELECT P.NAME,D.NAME  
FROM 
Physician P
INNER JOIN
department D
ON P.employeeid=D.head;

--Q.4)Write a query in SQL to count the number of patients who taken appointment with at least one physician.
select * from patient;
select * from appointment;
select * from Physician;

select COUNT(distinct( patient)) as total_count_p
from appointment;

SELECT COUNT(DISTINCT patient) 
FROM appointment 
WHERE physician IS NOT NULL;

--Q.5)Write a query in SQL to find the floor and block where the room number 212 belongs to.
select * from room;

select blockfloor,blockcode,roomnumber 
from room
where roomnumber=212;

--Q.6)Write a query in SQL to count the number available rooms
select * from room;
select count (unavailable)
from room
where unavailable='f';

SELECT COUNT(*) AS available_rooms
FROM room
WHERE unavailable = 'f';

/*Assumptions:
The unavailable column likely uses a boolean or text value to indicate the availability of a room:
'f' = False (room is available).
't' = True (room is unavailable).
This query assumes that 'f' represents a room being available.*/

--Q.7)Write a query in SQL to count the number of unavailable rooms.
SELECT COUNT(*) AS available_rooms
FROM room
WHERE unavailable = 't';


--Q.8)Write a query in SQL to obtain the name of the physician and the departments they are affiliated with. 
select * from Physician;
select * from department;
select * from affiliated_with;

select p.employeeid,p.name,d.name,aw.department
from
Physician as p
inner join
affiliated_with as aw
on p.employeeid=aw.physician
inner join 
department as d
on d.department_id=aw.department
where primaryaffiliation='f';

--Q.9)Write a query in SQL to obtain the name of the physicians who are trained for a special treatement.
select * from Physician;
select * from trained_in;
select employeeid,name
from Physician
where employeeid in (select distinct(physician)
from trained_in);

--Q.10)Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.
select * from Physician;
select * from department;
select * from affiliated_with;

select p.employeeid,p.name,d.name,aw.department
from
Physician as p
inner join
affiliated_with as aw
on p.employeeid=aw.physician
inner join 
department as d
on d.department_id=aw.department
where primaryaffiliation='t';

--Q.11)Write a query in SQL to obtain the name of the physicians who are not a specialized physician.
select * from Physician;
select * from trained_in;
select employeeid,name
from Physician
where employeeid not in (select distinct(physician)
from trained_in);


--Q.12)Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement. 
select * from patient;
select * from physician;

SELECT pt.name AS patient_name, ph.name AS physician_name
FROM Patient pt
INNER JOIN Physician ph
ON pt.pcp = ph.employeeid;

--Q.13)Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.
select * from patient;
select * from appointment;
select * from Physician;

select pt.name AS patient_name, 
COUNT(DISTINCT ap.physician) AS physician_count
from
Patient pt
INNER JOIN 
Appointment ap
ON 
pt.ssn = ap.patient
GROUP BY 
pt.name;

--Q.14)Write a query in SQL to count number of unique patients who got an appointment for examination room C. 
select * from appointment;
select * from room;
select 
COUNT(DISTINCT ap.patient) AS unique_patient_count
FROM 
appointment ap
INNER JOIN 
room r
ON 
ap.prepnurse= r.roomnumber
WHERE ap.examinationroom ='c';


select count(distinct(patient))
from appointment
where examinationroom='c';


/* select * from appointment;
select 
COUNT(DISTINCT ap.patient) AS unique_patient_count
FROM 
appointment ap
WHERE ap.examinationroom = 'C';

select count (prepnurse)
from appointment;*/


--Q.15)Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.
select * from patient;
select * from appointment;

SELECT 
p.name AS patient_name, 
ap.examinationroom AS room_number
FROM 
patient p
INNER JOIN 
appointment ap
ON 
p.ssn = ap.patient;

/*select * from patient;
select * from appointment;
select * from room;
select
p.name AS patient_name,
r.roomnumber AS treatment_room
from
Appointment ap
INNER JOIN 
Patient p
ON 
ap.patient = p.ssn
INNER JOIN 
room r
ON 
ap.prepnurse = r.roomnumber;*/




--Q.16)Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.
select * from room;
select * from nurse;

SELECT 
n.name AS nurse_name, 
r.roomnumber AS scheduled_room
FROM 
nurse n
INNER JOIN 
room r
ON 
n.employeeid = r.roomnumber;

--Q.17)Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no.
select * from patient;
select * from physician;
select * from nurse;
select * from room;
select * from appointment;

select 
    p.name AS patient_name,
    phy.name AS physician_name,
    n.name AS nurse_name,
    r.roomnumber AS room_number
FROM 
    appointment ap
INNER JOIN 
    patient p ON ap.patient = p.ssn
INNER JOIN 
    physician phy ON ap.physician = phy.employeeid
INNER JOIN 
    nurse n ON ap.prepnurse = n.employeeid
INNER JOIN 
    room r ON ap.examinationroom = r.roomnumber
WHERE 
    ap.start_dt_time = '2023-04-25' 
    AND ap.end_dt_time = '10:00:00';

--Q.18)Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.
select * from patient;
select * from physician;
select * from appointment;

select
p.name AS patient_name,
phy.name AS physician_name
FROM 
appointment ap
INNER JOIN 
patient p ON ap.patient = p.ssn
INNER JOIN 
physician phy ON ap.physician = phy.employeeid
WHERE 
ap.prepnurse IS NULL;

--Q.19)Write a query in SQL to find the name of the patients, their treating physicians and medication
select * from patient;
select * from Physician;
select * from medication;
select * from prescribes;

select 
p.name AS patient_name,
phy.name AS physician_name,
m.name AS medication_name
FROM 
prescribes pr
INNER JOIN 
patient p ON pr.patient = p.ssn
INNER JOIN 
physician phy ON pr.physician = phy.employeeid
INNER JOIN 
medication m ON pr.medication = m.code;

--Q.20)Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.
select * from patient;
select * from Physician;
select * from prescribes;
select * from medication;
select * from appointment;

/*select 
p.name AS patient_name,
phy.name AS physician_name,
m.name AS medication_name
FROM 
patien p
LEFT OUTER JOIN 
appointment ap ON p.name = ap.patient
INNER JOIN 
physician phy ON ap.physician = phy.employeeid
INNER JOIN 
prescribes pr ON p.ssn = pr.patient AND phy.employeeid = pr.physician
INNER JOIN 
medication m ON pr.medication = m.code
WHERE 
ap.prepnurse=;*/



select p.ssn, p.name as patient_name,m.name as medicine_name
from patient p
left outer join 
appointment a on p.ssn = a.patient
left outer join
prescribes pr on a.patient = pr.patient 
left outer join 
physician ph on pr.physician = ph.employeeid
left outer join medication m on pr.medication = m.code ;

--Q.21)Write a query in SQL to find the name and medication for those patients who did not take any appointment.
select * from patient;
select * from appointment;


select
    p.name AS PatientName, 
    a.patient AS PaientId
FROM 
    patient p
LEFT JOIN 
    appointment  a 
ON 
    p.ssn = a.patient
WHERE 
    a.prepnurse IS NULL;

	
--Q.22)Write a query in SQL to count the number of available rooms in each block.  
select * from room;
select * from block;

select blockcode,
COUNT(*) AS available_rooms
FROM room
WHERE  unavailable = 'f'
GROUP BY 
blockcode;

--Q.23)Write a query in SQL to count the number of available rooms in each floor.
select * from room;
select * from block;

select blockfloor,
COUNT(*) AS available_rooms
FROM 
room
WHERE unavailable = 'f'
GROUP BY 
blockfloor;

--Q.24)Write a query in SQL to count the number of available rooms for each block in each floor. 
select * from room;
select * from block;
SELECT 
    blockfloor,
    blockcode,
    COUNT(*) AS available_rooms
FROM 
    room
WHERE 
    unavailable = 'f'
GROUP BY 
    blockfloor,
    blockcode
ORDER BY 
    blockfloor,
    blockcode;

--Q.25)Write a query in SQL to count the number of unavailable rooms for each block in each floor. 

select * from room;
select * from block;
SELECT 
    blockfloor,
    blockcode,
    COUNT(*) AS available_rooms
FROM 
    room
WHERE 
    unavailable = 't'
GROUP BY 
    blockfloor,
    blockcode
ORDER BY 
    blockfloor,
    blockcode;


--Q.26)Write a query in SQL to find out the floor where the maximum no of rooms are available. 
select * from room;
select * from block;

select 
blockfloor,
COUNT(*) AS available_rooms
FROM 
room
WHERE unavailable = 'f'
GROUP BY 
blockfloor
ORDER BY 
available_rooms DESC;


--Q.27)Write a query in SQL to find out the floor where the minimum no of rooms are available
select * from room;
select * from block;

select  blockfloor,
COUNT(*) AS available_rooms
FROM 
room
WHERE 
unavailable = 'f'
GROUP BY 
blockfloor
ORDER BY 
available_rooms ASC;


--Q.28)Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted. 
select * from patient
select * from room
select * from stay

select p.name as patients, r.blockfloor as floor, r.blockcode as block, r.roomnumber
from stay s
inner join patient p
on p.ssn=s.patient_room
inner join room r
on r.roomnumber=s.patient_room;



--Q.29)Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.

select n.name as nurse_name, o.blockcode as block
from Nurse n
inner join on_call o
on n.employeeid=o.nurse;


--Q.30)Write a query in SQL to make a report which will show -
--a) name of the patient,
--b) name of the physician who is treating him or her,
--c) name of the nurse who is attending him or her,
--d) which treatement is going on to the patient,
--e) the date of release,
--f) in which room the patient has admitted and which floor and block the room belongs to respectively.  

select * from undergoes
select * from patient
select * from physician
select * from nurse
select * from Stay
select * from room
select * from procedure1

select p.name as patient, d.name as physician, n.name as nurse, pr.name as treatment, 
r.roomnumber, r.blockfloor as floor, r.blockcode as code, s.end_time as release_date
from undergoes u
inner join patient p
on p.ssn=u.patient
inner join physician d
on d.employeeid=u.physicianassit
left join nurse n
on u.ingnurse=n.employeeid
inner join procedure1 pr
on pr.code=u.procedure1
inner join Stay s
on s.stayid=u.stay
inner join room r
on r.roomnumber=s.patient_room;




--Q.31) Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform. 

select * from physician;
select * from undergoes
select * from trained_in

select name as physician
from physician
where employeeid in
(select u.physicianassit as physician
from undergoes u
left join trained_in t
on t.physician=u.physicianassit
and t.treatment=u.procedure1
where treatment is null);

--Q.32)Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure.

select * from physician;
select * from undergoes
select * from trained_in
select * from patient
select * from undergoes

select p.name as 'physician', pr.name as 'procdure', u.date, pt.name as 'patient'
from physician p, procedure1 pr, undergoes u, patient pt
where u.patient=pt.ssn
and u.procedure1=pr.code
and u.physicianassit=p.employeeid
and not exists
(select * from trained_in t
where t.physician=u.physicianassit
and t.treatment=u.procedure1);


--Q.33) Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with certification after the date of expiration of their certificate. 

select * from trained_in
select * from undergoes
select * from physician

select name as physician, position
from physician
where employeeid in
(select physicianassit from undergoes u
where date>
(select certificationexpires from trained_in t
where t.physician=u.physicianassit
and t.treatment=u.procedure1));

--Q.34) Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after the date of expiration of their certificate, their position, procedure they have done, date of procedure, name of the patient on which the procedure had been applied and the date when the certification expired.

select * from physician
select * from patient
select * from trained_in
select * from undergoes
select * from procedure1

select d.name as physician, d.position as position, p.name as patient, 
pr.name as procedure_name, u.date as procedure_date, 
t.certificationexpires as expiry_certification_date
from physician d, patient p, procedure1 pr, trained_in t, undergoes u
where u.patient=p.ssn
and u.physicianassit=d.employeeid
and u.procedure1=pr.code
and pr.code=t.treatment
and d.employeeid=t.physician
and u.date>t.certificationexpires;


--Q.35) Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122. 
select * from nurse
select * from on_call
select * from room

select n.name as nurse 
from nurse n
where employeeid in
(select oc.nurse
from on_call oc, room r
where oc.blockfloor=r.blockfloor
and oc.blockcode=r.blockcode
and r.roomnumber=122);

--Q.36) Write a query in SQL to Obtain the names of all patients who has been prescribed some medication by his/her physician who has carried out primary care and the name of that physician.  
select * from patient
select *from physician
select * from prescribes

select p.name as patient, d.name as physician
from patient p
inner join prescribes r
on r.patient=p.ssn
inner join physician d
on p.pcp=d.employeeid
where p.pcp=r.physician
and p.pcp=d.employeeid;

--Q.37) Write a query in SQL to obtain the names of all patients who has been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care.

select * from physician 
select * from patient
select * from procedure1
select * from undergoes


select p.name as patient, d.name as physician, pr.cost as procedure_cost
from undergoes u
inner join patient p
on u.patient=p.ssn
inner join physician d
on p.pcp=d.employeeid
inner join procedure1 pr
on u.procedure1=pr.code
where pr.cost>5000;

--Q.38)Write a query in SQL to Obtain the names of all patients who had at least two appointment where the nurse who prepped the appointment was a registered nurse and the physician who has carried out primary care. 

select * from patient
select * from physician
select * from nurse
select * from appointment

select p.name as patient, d.name as primary_physician, n.name as nurse
from appointment a
inner join patient p
on p.ssn=a.patient
inner join nurse n
on n.employeeid=a.prepnurse
inner join physician d
on d.employeeid=p.pcp
where n.registered='t'
group by p.name, d.name, n.name
having count(start_dt_time)>=2;

--Q.39) Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician who is not the head of any department and name of that physician along with their primary care physician.

select * from physician
select * from patient
select * from department

select p.name as physician, d.name as primary_care
from physician d
inner join patient p
on p.pcp=d.employeeid
where p.pcp not in (select head from department);



