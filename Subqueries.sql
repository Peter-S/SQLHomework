USE metroalt

--1. Return the employee key, last name and first name, position name and 
--hourly rate for those employees receiving the maximum pay rate

SELECT Employee.EmployeeKey, Employee.EmployeeLastName, Employee.EmployeeFirstName,
Position.PositionName,[dbo].[EmployeePosition].EmployeeHourlyPayRate
FROM Employee
INNER JOIN EmployeePosition
ON EmployeePosition.EmployeeKey= Employee.EmployeeKey
INNER JOIN POSITION
ON EMPLOYEEPOSITION.POSITIONKEY = POSITION.POSITIONKEY
WHERE EmployeeHourlyPayRate>(SELECT MAX(EmployeeHourlyPayRate) FROM Position)

--2.Use only subqueries to do this. Return the key, last name and first name 
--of every employee who has the position name “manager.”

SELECT Employee.EmployeeKey, Employee.EmployeeLastName, Employee.EmployeeFirstName,
Position.PositionName FROM Employee 
WHERE Position.PositionName > (SELECT * FROM Position where PositionName='manager')


--4. Create a new table called EmployeeZ. It should have the following structure:
--EmployeeKey int,EmployeeLastName nvarchar(255),EmployeeFirstName nvarchar(255),
--EmployeeEmail Nvarchar(255)
--Use an insert with a subquery to copy all the employees 
--from the employee table whose last name starts with “Z.”

CREATE TABLE EMPLOYEEZ (
	EmployeeKey int,
	EmployeeLastName nvarchar(255),
	EmployeeFirstName nvarchar(255),
	EmployeeEmail Nvarchar(255),
	Primary key (EmployeeKey)
)

INSERT into EMPLOYEEZ (EmployeeKey, EmployeeLastName, EmployeeFirstName, EmployeeEmail)
select Employee.EmployeeKey, Employee.EmployeeLastName, Employee.EmployeeFirstName, Employee.EmployeeEmail
FROM [dbo].[Employee] where EmployeeLastName LIKE 'Z%'

--5.This is a correlated subquery. Return the position key, the employee key and the hourly pay rate 
--for those employees who are receiving the highest pay in their positions. Order it by position key. 

SELECT EmployeePosition.EmployeeKey, [PositionKey],[EmployeeHourlyPayRate] FROM [dbo].[EmployeePosition]
WHERE Employee.EmployeeKey >  (SELECT MAX(EmployeePosition.EmployeeHourlyPayRate) FROM Position)
ORDER BY EmployeePosition.PositionKey
