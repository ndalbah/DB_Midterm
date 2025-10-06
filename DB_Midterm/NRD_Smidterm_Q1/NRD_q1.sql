-- connect to SQL PLUS
connect sys/sys as sysdba

-- Drop user
DROP USER c##NRD_Smidterm_Q1 CASCADE;

-- Create user
CREATE USER c##NRD_Smidterm_Q1 IDENTIFIED BY 7856;

-- Grant access to resources
GRANT connect, resource TO c##NRD_Smidterm_Q1;

-- Provide space for user
ALTER USER c##NRD_Smidterm_Q1 QUOTA 100M ON users;

-- Connect to user
connect c##NRD_Smidterm_Q1/7856;

-- Create spool file
SPOOL C:\NRD_Smidterm_Q1\NRD_q1.txt

-- Create tables
CREATE TABLE ADVISOR(AdvisorID NUMBER, AdvisorName VARCHAR2(50));
CREATE TABLE STUDENT(StudentID NUMBER, StudentName VARCHAR2(50), BirthDate DATE, AdvisorID NUMBER);
CREATE TABLE ENROLLMENT(StudentID NUMBER, CourseID NUMBER, Grade NUMBER);
CREATE TABLE COURSE(CourseID NUMBER, CourseTitle VARCHAR2(50), Credits NUMBER);

-- Create primary keys
ALTER TABLE ADVISOR ADD CONSTRAINT advisor_advisorid_PK PRIMARY KEY(AdvisorID);

ALTER TABLE STUDENT ADD CONSTRAINT student_studentid_PK PRIMARY KEY(StudentID);

ALTER TABLE ENROLLMENT ADD CONSTRAINT enrollment_stud_course_PK PRIMARY KEY(StudentID, CourseID);

ALTER TABLE COURSE ADD CONSTRAINT course_courseid_PK PRIMARY KEY(CourseID);

-- Create foreign keys
ALTER TABLE STUDENT ADD CONSTRAINT student_advisorid_FK FOREIGN KEY(AdvisorID) REFERENCES ADVISOR(AdvisorID);

ALTER TABLE ENROLLMENT ADD CONSTRAINT enrollment_studentid_FK1 FOREIGN KEY(StudentID) REFERENCES STUDENT(StudentID);

ALTER TABLE ENROLLMENT ADD CONSTRAINT enrollment_courseid_FK2 FOREIGN KEY(CourseID) REFERENCES COURSE(CourseID);

-- Add NOT NULL constraint
ALTER TABLE ADVISOR MODIFY (AdvisorName CONSTRAINT advisor_advisorname_NN NOT NULL);

ALTER TABLE STUDENT MODIFY (StudentName CONSTRAINT student_studentname_NN NOT NULL);

-- Adding column to table
ALTER TABLE STUDENT ADD (GENDER CHAR(1));

-- Adding check constraints
ALTER TABLE STUDENT ADD CONSTRAINT student_gender_CK CHECK (GENDER IN ('M', 'F', 'm', 'f'));

ALTER TABLE COURSE ADD CONSTRAINT course_credits_CK CHECK (Credits>0);

-- Adding unique constraint
ALTER TABLE COURSE ADD CONSTRAINT course_coursetitle_UK UNIQUE(CourseTitle);

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