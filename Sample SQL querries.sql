-- Create a sample database\CREATE DATABASE SampleDB;
USE SampleDB;

-- Create a table for employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert sample data into Employees table
INSERT INTO Employees (FirstName, LastName, Age, Department, Salary) VALUES
('John', 'Doe', 30, 'IT', 70000.00),
('Jane', 'Smith', 28, 'HR', 65000.00),
('Emily', 'Johnson', 35, 'Finance', 75000.00);

-- Retrieve all employees from the Employees table
SELECT * FROM Employees;

-- Retrieve employees whose age is greater than 30
SELECT * FROM Employees WHERE Age > 30;

-- Update salary of an employee
UPDATE Employees SET Salary = 80000.00 WHERE FirstName = 'John' AND LastName = 'Doe';

-- Delete an employee from the table
DELETE FROM Employees WHERE FirstName = 'Jane' AND LastName = 'Smith';

-- Count the number of employees in each department
SELECT Department, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department;

-- Find the average salary of employees in the IT department
SELECT AVG(Salary) AS AverageSalary FROM Employees WHERE Department = 'IT';

-- Add a new column for email addresses
ALTER TABLE Employees ADD Email VARCHAR(100);

-- Update email addresses for employees
UPDATE Employees SET Email = 'john.doe@example.com' WHERE FirstName = 'John' AND LastName = 'Doe';

-- Create an index on the LastName column for faster searches
CREATE INDEX idx_lastname ON Employees(LastName);

-- Drop the index from the LastName column
DROP INDEX idx_lastname ON Employees;

-- Drop the Employees table
DROP TABLE Employees;

-- Drop the SampleDB database
DROP DATABASE SampleDB;