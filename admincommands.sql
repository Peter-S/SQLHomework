use MetroAlt

--1. Create a Schema called "ManagementSchema."
	go
	create schema ManagementSchema;
	go

--2 Create a view owned by the schema that shows the annual ridership.

	CREATE VIEW ManagementSchema.RidershipView  
	as select RidershipKey, BusScheduleAssigmentKey, Riders from [dbo].[Ridership]  --(i.e. what tables do you want those to have access?)

-- Create a view owned by the schema that shows the employee information 
--including their position and pay rate.
	Create view ManagementSchema.EmployeeView
	as select EmployeeKey, EmployeeLastName, EmployeeFirstName, 
EmployeeAddress, EmployeeCity, EmployeeZipCode, EmployeePhone, 
EmployeeEmail, EmployeeHireDate from Employee 


--3. Create a role ManagementRole.
	Create Role ManagementRole
	go

--4. Give the ManagementRole select permissions on the ManagementSchema 
--and Exec permissions on the new employee stored procedure we created earlier.

	Grant Select, insert, update on schema::ManagementSchema to ManagementRole --granting 3 permissons to whole scema

--5. Create a new login for one of the employees who holds the manager position.

	Create login Kedwards with password = 'W3lcome2p@ssword',
	default_database = metroAlt

--6.Create a new user for that login.
	Create User Kedwards for login Kedwards

--7. Add that user to the Role.
exec sp_addrolemember ManagementRole, Kedwards

--8. Login to the database as the new User, (Remember that SQL server authentication must be enabled for this to work.)
	--OK!
--9. Run the query to view the annual ridership. Does it work?
	
--10. Try to select from the table Employees. Can you do it?
	-
--11. Back up the database MetroAlt.
Backup database metroAlt to disk ='C:\Backup\backup.bak' --had a problem with this one. 
