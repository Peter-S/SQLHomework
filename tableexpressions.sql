USE MetroAlt;
--1.Create a derived table that returns the position name as 
--position and count of employees at that position.
-- (I know that this can be done as a simple join, but do it in the format of a derived table. 
--There still will be a join in the subquery portion).

	SELECT * FROM (
	SELECT Position.PositionName  from Position		
	) AS Position(Position)

--2. Create a derived table that returns a column HireYear and the count of 
--employees who were hired that year. (Same comment as above).

	SELECT * FROM (
		SELECT Employee.EmployeeHireDate from Employee
	) AS Employee (HireYear)


--3. Redo problem 1 as a Common Table Expression (CTE).
	WITH PositionInfo AS (
	SELECT * FROM (
	SELECT Position.PositionName  from Position		
	) AS Position(Position)
	) SELECT * from PositionInfo
--4. Redo problem 2 as a CTE.
	
	WITH EmployeeHire AS (
	SELECT * FROM (
		SELECT Employee.EmployeeHireDate from Employee
	) AS Employee (HireYear)
	) 
	SELECT * from EmployeeHire


--5. Create a CTE that takes a variable argument called @BusBarn 
--and returns the count of busses grouped by the description of 
--that bus type at a particular Bus barn. Set @BusBarn to 3.
	
	DECLARE @Busbarn INT
	SET @Busbarn = 3;

	WITH SomeInfo as (
	SELECT COUNT (Bus.BusKey) from [dbo].[Bus]
	INNER JOIN Bus.BusTypekey ON Bustype.BusTypeKey
	WHERE Bustype.BusTypeCapacity=@Busbarn
	) SELECT * FROM SomeInfo
	

--6. Create a View of Employees for Human Resources it 
--should contain all the information in the Employee table 
--plus their position and hourly pay rate

	CREATE VIEW V_HREmployeeInfo
	 AS SELECT * FROM Employee
	 INNER JOIN POSITION ON Position.PositionDescription = Employee.EmployeeKey
	 SELECT * FROM V_HREmployeeInfo;
	 --DROP View V_HREmployeeInfo 

--7. Alter the view in 6 to bind the schema
	ALTER VIEW V_HREmployeeInfo WITH SCHEMABINDING 
	AS SELECT [EmployeeLastName],[EmployeeFirstName],[EmployeeAddress], [EmployeeCity],[EmployeeZipCode],[EmployeePhone],
	[EmployeeEmail],[EmployeeHireDate]
	 FROM Employee
	 INNER JOIN POSITION ON Position.PositionDescription = Employee.EmployeeKey
	 SELECT [EmployeeLastName],[EmployeeFirstName],[EmployeeAddress], [EmployeeCity],[EmployeeZipCode],[EmployeePhone],
	[EmployeeEmail],[EmployeeHireDate]  FROM V_HREmployeeInfo;


--8. Create a view of the Bus Schedule assignment that returns the Shift times, 
--The Employee first and last name, the bus route (key) and the Bus (key). 
--Use the view to list the shifts for Neil Pangle in October of 2014

	CREATE VIEW V_BUSInfo AS SELECT
	BusScheduleAssignment.BusScheduleAssignmentDate,
	BusDriverShift.BusDriverShiftStartTime, BusDriverShift.BusDriverShiftStopTime,
	Employee.EmployeeFirstName, Employee.EmployeeLastName, BusRoute.BusRouteKey,
	Bus.BusKey FROM [dbo].[BusScheduleAssignment]
	INNER JOIN Employee ON BusScheduleAssignment.EmployeeKey = Employee.EmployeeKey
	INNER JOIN BusDriverShift ON BusScheduleAssignment.BusDriverShiftKey = BusDriverShift.BusDriverShiftKey
	INNER JOIN BusRoute ON BusScheduleAssignment.BusRouteKey = BusRoute.BusRouteKey
	INNER JOIN Bus ON BusScheduleAssignment.BusKey = Bus.BusKey
	WHERE Employee.EmployeeLastName = 'Pangle' AND Employee.EmployeeFirstName ='Neil'
	AND BusScheduleAssignment.BusScheduleAssignmentDate BETWEEN '2014-10-01' AND '2014-10-31';
	Select * from V_BUSInfo
	--DROP View V_BUSInfo


--9. Create a table valued function that takes a parameter of city and returns all the employees who live in that city
	
	SELECT * FROM V_HREmployeeInfo
	
	CREATE FUNCTION firstfunction
		
		(@EmployeeCity nvarchar)	
		RETURNS TABLE 
	RETURN
		SELECT * FROM V_HREmployeeInfo
		WHERE EmployeeCity = @EmployeeCity

		SELECT * FROM firstfunction(COUNT(@EmployeeCity))



--10. Use the cross apply operator to return the last 3 routes driven by each driver
		--A little ambigous
