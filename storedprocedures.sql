use MetroAlt;

--1. Create a stored procedure to enter a new employee, position and pay rate which
-- uses the functions to create an email address and the one to determine initial pay.
-- Also make sure that the employee does not already exist. Use the stored procedure to 
--add a new employee.

GO
create procedure usp_EnterEmployee
--stuff added to a form that user needs to enter
@personlastname nvarchar(255),
@personfirstname nvarchar(255),
@personemail nvarchar(255),
@position nvarchar(255),
@payrate money
AS
--now insert into employee
Insert into Employee(
EmployeeLastName, 
EmployeeFirstName, 
EmployeeEmail
)values (@personlastname, @personfirstname, @personemail)
  Declare @Employeekey int = Ident_Current('Employee')

--insert into employeeposition for initialpay
insert into EmployeePosition(
EmployeeHourlyPayRate
) values (@payrate)

--insert into position

insert into Position (PositionName
) values (@position)
GO

exec usp_EnterNewEmployee
@position = 'paperpusher',
@payrate = $25,
@personfirstname = 'John',
@personlastname = 'Snow',
@personemail ='jsnow@got.com'

select * from Position

--2. Create a stored procedure that allows an employee to edit their own information name, 
--address, city, zip, not email etc.  The employee key should be one of its parameters. 
--Use the procedure to alter one of the employees information. Add error trapping to catch 
--any errors.
go
create procedure usp_EditownName
@address nvarchar(255),
@city nvarchar(255),
@zip nchar(5),
@employeekey int
AS
begin tran
update employee
set EmployeeAddress = @address,
EmployeeCity=@city,
EmployeeZipCode=@zip
where EmployeeKey = @employeekey
commit tran
end Try
begin catch
rollback tran
print Error_message()
end catch

select * from Employee

exec usp_EditownName
@address='100 maple ave',
@city='jacksonville',
@zip='32164',
@employeekey=2
