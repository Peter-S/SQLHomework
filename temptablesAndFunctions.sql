use MetroAlt;

--1 .Create a temp table to show how many stops each route has. the table should
-- have fields for the route number and the number of stops. Insert into it from 
--BusRouteStops and then select from the temp table.

Create table #Bustemptable
(
	BusRouteNumber int,
	NumberofStops int
)

INSERT INTO #Bustemptable (BusRouteNumber, NumberofStops)
SELECT BusRouteNumber, NumberofStops FROM BusRouteStops

--2. Do the same but using a global temp table.
		--need help with this one.


--3. Create a function to create an employee email address. 
--Every employee Email follows the pattern of "firstName.lastName@metroalt.com"
	GO
	CREATE Function Email (@email nvarchar(50))
	returns nvarchar(50)
	AS
	BEGIN
		DECLARE @firstname nvarchar(10)
		DECLARE @lastname nvarchar(10)

		SET @firstname = ''
		SET @lastname = ''
		SET @email = @firstname + @lastname + '@metroalt.com'
		return @email
		End
	GO

--4. Create a function to determine a two week pay check of an individual employee.

	GO 
	CREATE Function Paycheck(
	@personspay money,
	@biweeklytime int
	)
	returns money
	AS BEGIN
	declare @payrate as money;
	SET @biweeklytime = 80
	SET @total = @payrate * @biweeklytime;
	SELECT @payrate=EmployeePosition.EmployeeHourlyPayRate from EmployeePosition
	where EmployeePosition.EmployeeKey = 1
	return @total
	end
	GO

	
--5. Create a function to determine a hourly rate for a new employee. 
--Take difference between top and bottom pay for the new employees 
--position (say driver) and then subtract the difference from the maximum pay. 
--(and yes this is very arbitrary).

create function  fx_PayNewEmployee(
@highestpay money,
@lowestpay money,
@driver varchar(50)
)
returns money
as begin

select @highestpay=max(EmployeePosition.EmployeeHourlyPayRate),
@lowestpay min(EmployeePosition.EmployeeHourlyPayRate) from EmployeePosition
inner join Position.PositionKey = employeeposition.positionkey
Select Position.PositionName, EmployeePosition.EmployeeHourlyPayRate
where position.positionname = 'driver'
set @difference  = @highestpay - @lowestpay
return @difference
end


