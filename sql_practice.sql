-- Create the employees table with columns for id, name, department, salary, and joining date
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE
);

-- Insert data into the employees table
INSERT INTO employees (id, name, department, salary, joining_date) VALUES 
(1, 'Alice', 'HR', 55000, '2022-03-01'),
(2, 'Bob', 'IT', 72000, '2021-06-15'),
(3, 'Charlie', 'Finance', 65000, '2020-09-23'),
(4, 'David', 'IT', 80000, '2019-12-11'),
(5, 'Emma', 'Marketing', 60000, '2023-01-20');

-- Query 1: Retrieve all employees from the IT department
SELECT *
FROM employees
WHERE department = 'IT';

-- Query 2: Find the average salary of all employees
SELECT AVG(salary) AS avg_sal
FROM employees;

-- Query 3: Get the highest-paid employee
SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;

-- Query 4: Count employees in each department
SELECT department, COUNT(*) AS Total_emp
FROM employees
GROUP BY department;

-- Query 5: Get employees who joined after Jan 1, 2021
SELECT *
FROM employees
WHERE joining_date > '2021-01-01';
