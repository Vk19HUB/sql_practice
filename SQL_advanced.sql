## 1. Stored Procedure Examples
### 1.1 Stored Procedure with Input and Output Parameters
#### This stored procedure calculates the total number of employees in a department and returns the count.

CREATE PROCEDURE GetEmployeeCountByDept
    @DeptName VARCHAR(50),
    @EmpCount INT OUTPUT
AS
BEGIN
    SELECT @EmpCount = COUNT(*) 
    FROM Employees 
    WHERE Department = @DeptName;
END;

### Executing the Procedure
DECLARE @TotalEmployees INT;
EXEC GetEmployeeCountByDept @DeptName = 'IT', @EmpCount = @TotalEmployees OUTPUT;
PRINT 'Total Employees in IT Department: ' + CAST(@TotalEmployees AS VARCHAR);


## 1.2 Stored Procedure with Transactions (Insert Employees)
### A stored procedure to insert an employee record with error handling.### ## 

CREATE PROCEDURE InsertEmployee
    @Name VARCHAR(100),
    @Department VARCHAR(50),
    @Salary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Employees (Name, Department, Salary)
        VALUES (@Name, @Department, @Salary);
        
        COMMIT TRANSACTION;
        PRINT 'Employee inserted successfully';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;

### Executing the Procedure
EXEC InsertEmployee @Name = 'John Doe', @Department = 'HR', @Salary = 60000;

##2. WITH Statement (Common Table Expression - CTE) Examples
###2.1 Recursive CTE for Hierarchical Data (Employee Manager Hierarchy)

WITH EmployeeHierarchy AS (
    SELECT EmployeeID, Name, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.Name, e.ManagerID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy ORDER BY Level;

### Use case: Fetch hierarchical relationships (e.g., employees under managers).

## 2.2 Using CTE to Get Top 3 Salaries per Department

WITH RankedEmployees AS (
    SELECT EmployeeID, Name, Department, Salary, 
           RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RankNum
    FROM Employees
)
SELECT * FROM RankedEmployees WHERE RankNum <= 3;

### Use case: Find the top N highest-paid employees per department.


## 3. Ranking Functions Examples
### 3.1 Using ROW_NUMBER() to Paginate Results
### Fetching records in batches for pagination (page 2 with 5 records per page).

WITH PaginatedResults AS (
    SELECT EmployeeID, Name, Department, Salary,
           ROW_NUMBER() OVER (ORDER BY EmployeeID) AS RowNum
    FROM Employees
)
SELECT * FROM PaginatedResults WHERE RowNum BETWEEN 6 AND 10;
### Use case: Used for pagination (e.g., displaying records on different pages).

### 3.2 Using RANK() to Find Employees with the Same Salary Rank

SELECT EmployeeID, Name, Salary, 
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;
## Use case: If two employees have the same salary, they get the same rank, but the next rank is skipped.

### 3.3 Using DENSE_RANK() to Ensure Consecutive Ranking
SELECT EmployeeID, Name, Salary, 
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
FROM Employees;

###3.4 Using NTILE() to Divide Employees into Salary Groups
SELECT EmployeeID, Name, Salary, 
       NTILE(4) OVER (ORDER BY Salary DESC) AS SalaryQuartile
FROM Employees;
###Use case: Divide employees into 4 equal salary groups (quartiles).