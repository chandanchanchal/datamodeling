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
    hire_date DATE DEFAULT CURRENT_DATE -- DEFAULT Constraint
);
