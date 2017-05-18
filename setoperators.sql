

--1. Create a Union between Person and PersonAddress in Community assist and Employee in MetroAlt. 
--You will need to fully qualify the tables in the CommunityAssist part of the query:
--CommunityAssist.dbo.Person etc.
	USE CommunityAssist;

	SELECT [PersonLastName], [PersonFirstName],[PersonEntryDate] FROM Person
	INNER JOIN PersonAddress 
	ON Person.PersonKey = PersonAddress.PersonKey
	UNION 
	SELECT [EmployeeLastName],[EmployeeFirstName],[EmployeeHireDate] FROM
	MetroAlt.dbo.Employee



--2. Do an intersect between the PersonAddress and Employee that returns the cities that are in both.
	
	SELECT PersonAddress.City FROM PersonAddress
	INTERSECT
	SELECT EmployeeCity FROM MetroAlt.dbo.Employee

--3. Do an except between PersonAddress and Employee that returns the cities that are not in both.
		
	SELECT PersonAddress.City FROM PersonAddress
	EXCEPT
	SELECT EmployeeCity FROM MetroAlt.dbo.Employee


--4. For this we will use the Data Tables we made in Assignment

    -- 1. Insert the following services into BusService: 
	--General Maintenance, Brake service, hydraulic maintenance, and Mechanical Repair. 
	--You can add descriptions if you like. Next add entries into the Maintenance table for busses 12 and 24.
	-- You can use today’s date. For the details on 12 add General Maintenance and Brake Service, for 24 just
	-- General Maintenance. You can use employees 60 and 69 they are both mechanics.

	use MetroAlt;

		INSERT INTO BusService(BusServiceName)
		Values('General Maintenance'), ('Brake Service'), ('Hydraulic Maintenance'), ('Mechanical Repair')
		
		INSERT INTO Maintenance(MaintenanceDate, BusKey)
		VALUES(GETDATE(), 12)
		INSERT INTO [dbo].[MaintenanceDetail](Maintenancekey,EmployeeKey,BusServiceKey)
		values(IDENT_CURRENT('Maintenance'), 60, 1), (IDENT_CURRENT('Maintenance'), 60, 2)


--5. Create a table that has the same structure as Employee, name it Drivers. 
--Use the Select form of an insert to copy all the employees whose position is driver (1) into the new table.

	CREATE TABLE Drivers (
		DriverKey int identity (1,1),
		DriverLastName  nvarchar(255) not null,
		DriverFirstName nvarchar(255) not null,
		DriverAddress nvarchar(255) not null,
		DriverCity nvarchar(255) not null,
		DriverZipCode nchar(255) not null,
		DriverPhone nchar(10) null,
		DriverEmail nchar(255) not null,
		DriverHireDate Date not null,
	)

	INSERT INTO Drivers 
	SELECT [EmployeeLastName],[EmployeeFirstName], [EmployeeAddress], 
	[EmployeeCity], [EmployeeZipCode], [EmployeePhone], [EmployeeEmail],[EmployeeHireDate]
	FROM Employee
	Inner join EmployeePosition
	ON Employee.EmployeeKey = EmployeePosition.EmployeeKey
	WHERE EmployeePosition.PositionKey=1;

--6. Edit the record for Bob Carpenter (Key 3) so that his first name is Robert and is City is Bellevue
	SELECT * FROM Employee
	UPDATE Employee
	SET EmployeeFirstName='Robert', EmployeeCity='Bellevue'
	WHERE EmployeeKey=3
	

--7. Give everyone a 3% Cost of Living raise.

	BEGIN TRAN
	Update [dbo].[EmployeePosition]
	SET EmployeeHourlyPayRate= EmployeeHourlyPayRate * 1.03
	COMMIT TRAN

--8. Delete the position Detailer

	SELECT * FROM [dbo].[Position]
	DELETE FROM [dbo].[Position]
	WHERE PositionName = 'Detailer'
