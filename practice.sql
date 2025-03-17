Step 1: Create a Database
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

Step 2: Create a Table with Integrity Constraints

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,          -- Primary Key Constraint
    name VARCHAR(100) NOT NULL,       -- NOT NULL Constraint
    email VARCHAR(100) UNIQUE,        -- UNIQUE Constraint
    department_id INT,                -- Foreign Key Constraint
    salary DECIMAL(10,2) CHECK (salary > 0),  -- CHECK Constraint
    hire_date DATE DEFAULT (CURRENT_DATE) -- DEFAULT Constraint (Corrected)
);

Step 3: Insert Valid Data

INSERT INTO Employees (emp_id, name, email, department_id, salary, hire_date)
VALUES (1, 'Alice Johnson', 'alice@example.com', 101, 60000, '2024-01-15');

Step 4: Test NOT NULL Constraint
INSERT INTO Employees (emp_id, name, email, department_id, salary, hire_date)
VALUES (2, NULL, 'bob@example.com', 102, 50000, '2024-02-01');
-- This will fail as 'name' column does not allow NULL values

Step 7: Create a Foreign Key Constraint

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

ALTER TABLE Employees
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments(dept_id);

Step 8: Insert Data into Departments and Validate Foreign Key
INSERT INTO Departments (dept_id, dept_name) VALUES (101, 'HR');
INSERT INTO Employees (emp_id, name, email, department_id, salary, hire_date)
VALUES (5, 'Eve Adams', 'eve@example.com', 101, 65000, '2024-05-10');

SELECT * FROM Employees;
SELECT * FROM Departments;


-----------------------------------Exercise-------------------------For 1NF-to-2NF-----Starts-------------
Exercise: Normalize the Student_Courses Table to 1NF and 2NF
Given Unnormalized Table (UNF)
#A university stores student enrollment details in the following table:

Student_Courses
+-----------+---------+----------------------+------------+
| StudentID | Name    | Courses              | Instructors|
+-----------+---------+----------------------+------------+
| 201       | Alice   | Math, Physics        | Dr. A, Dr. B|
| 202       | Bob     | Chemistry            | Dr. C      |
| 203       | Charlie | Math, Biology        | Dr. A, Dr. D|
+-----------+---------+----------------------+------------+
Issues:
The Courses column contains multiple values (not atomic).
The Instructors column also contains multiple values.
It violates the First Normal Form (1NF) rule.

Step 1: Convert to First Normal Form (1NF)
Definition of 1NF: A table is in 1NF if:
It has a primary key.
All columns contain atomic (indivisible) values.
There are no repeating groups or arrays.

######--Solution-----##########################################
Converting the table to 1NF
To bring the table into 1NF, we separate each course into a new row:
CREATE TABLE Students_1NF (
    StudentID INT,
    StudentName VARCHAR(50),
    Course VARCHAR(50),
    Marks INT,
    PRIMARY KEY (StudentID, Course)
);

1NF Table:
StudentID	StudentName	Course	Marks
1	        Alice	    Math	85
1	        Alice	    Science	90
2	        Bob	        Math	78
3	        Charlie	    Science	92
3	        Charlie	    Art	88

#Definition of 2NF: A table is in 2NF if:
It is in 1NF.
All non-key columns are fully dependent on the whole primary key (No partial dependencies).

#Solution:
Separate Students and StudentCourses into different tables.
CREATE TABLE Students_2NF (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE StudentCourses_2NF (
    StudentID INT,
    Course VARCHAR(50),
    Marks INT,
    PRIMARY KEY (StudentID, Course),
    FOREIGN KEY (StudentID) REFERENCES Students_2NF(StudentID)
);

1. Understanding 2NF Issues
From our 2NF tables:

Students_2NF Table:
StudentID	StudentName
1	        Alice
2	        Bob
3	        Charlie
StudentCourses_2NF Table:
StudentID	Course	Marks
1	        Math	85
1	        Science	90
2	        Math	78
3	        Science	92
3	        Art	88
Issues in 2NF Table:
Suppose we introduce a Teacher column in the StudentCourses_2NF table:
StudentID	Course	Marks	Teacher
1	        Math	    85	Mr. Smith
1	        Science	    90	Mrs. Davis
2	        Math	    78	Mr. Smith
3	        Science	    92	Mrs. Davis
3	        Art        	88	Mr. Lee
Problem:
Teacher depends on Course, not on StudentID.
This creates a transitive dependency, violating 3NF.

3. Solution: Breaking Transitive Dependency
Separate courses and teachers into a new table (Courses table).
CREATE TABLE Students_3NF (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50)
);

CREATE TABLE Courses_3NF (
    Course VARCHAR(50) PRIMARY KEY,
    Teacher VARCHAR(50)
);

CREATE TABLE StudentCourses_3NF (
    StudentID INT,
    Course VARCHAR(50),
    Marks INT,
    PRIMARY KEY (StudentID, Course),
    FOREIGN KEY (StudentID) REFERENCES Students_3NF(StudentID),
    FOREIGN KEY (Course) REFERENCES Courses_3NF(Course)
);

