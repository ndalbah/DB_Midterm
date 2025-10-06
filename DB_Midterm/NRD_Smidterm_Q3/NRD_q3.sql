-- connect to SQL PLUS
connect sys/sys as sysdba

-- Drop user
DROP USER c##NRD_Smidterm_Q3 CASCADE;

-- Create user
CREATE USER c##NRD_Smidterm_Q3 IDENTIFIED BY 7856;

-- Grant access to resources
GRANT connect, resource TO c##NRD_Smidterm_Q3;

-- Provide space for user
ALTER USER c##NRD_Smidterm_Q3 QUOTA 100M ON users;

-- Connect to user
connect c##NRD_Smidterm_Q3/7856;

-- Create spool file
SPOOL C:\NRD_Smidterm_Q3\NRD_q3.txt

-- Create tables with constraints
CREATE TABLE ADVISOR(AdvisorID NUMBER, AdvisorName VARCHAR2(50) CONSTRAINT advisor_advisorname_NN NOT NULL, CONSTRAINT advisor_advisorid_PK PRIMARY KEY(AdvisorID));

CREATE TABLE STUDENT(StudentID NUMBER, StudentName VARCHAR2(50) CONSTRAINT student_studentname_NN NOT NULL, BirthDate DATE, AdvisorID NUMBER, GENDER CHAR(1) CONSTRAINT student_gender_CK CHECK (GENDER in ('M', 'F', 'm', 'f')), CONSTRAINT student_studentid_PK PRIMARY KEY(StudentID), CONSTRAINT student_advisorid_FK FOREIGN KEY(AdvisorID) REFERENCES ADVISOR(AdvisorID));

CREATE TABLE COURSE(CourseID NUMBER, CourseTitle VARCHAR2(50) CONSTRAINT course_coursetitle_UK UNIQUE, Credits NUMBER CONSTRAINT course_credits_CK CHECK (Credits>0), CONSTRAINT course_courseid_PK PRIMARY KEY(CourseID));

CREATE TABLE ENROLLMENT(StudentID NUMBER, CourseID NUMBER, GRADE NUMBER, CONSTRAINT enrollment_stud_course_PK PRIMARY KEY(StudentID, CourseID), CONSTRAINT enrollment_studentid_FK1 FOREIGN KEY(StudentID) REFERENCES STUDENT(StudentID), CONSTRAINT enrollment_courseid_FK2 FOREIGN KEY(CourseID) REFERENCES COURSE(CourseID));

-- Insert data
INSERT INTO ADVISOR VALUES (1,'John');
INSERT INTO STUDENT VALUES(10, 'Catherine', DATE '2001-02-11', 1, 'F');
INSERT INTO ENROLLMENT VALUES(10, 3, 98);
INSERT INTO COURSE VALUES(3, 'Databases I', 3);

-- Display table names
SELECT table_name FROM user_tables;

-- Display structure of tables
DESC ADVISOR
DESC STUDENT
DESC ENROLLMENT
DESC COURSE

-- Display constraints
SELECT constraint_name, table_name, constraint_type FROM user_constraints;

-- Save spool
SPOOL OFF;