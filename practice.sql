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

