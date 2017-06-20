use MetroAlt
--Create a trigger to fire when an employee is assigned to a second shift in a day. 
--Have it write to an overtime table. the Trigger should create the overtime table 
--if it doesn't exist. Add an employee for two shifts to test the trigger.

GO
Create Trigger trigger_overtime on [dbo].[BusScheduleAssignment]
for insert
As
Declare @EmployeeKey int
Declare @Date Date
Declare @count int
Select @EmployeeKey=@EmployeeKey, @Date = BusScheduleAssignmentDate
from inserted

Select @count=Count (EmployeeKey) from BusScheduleAssignment
where [BusScheduleAssignmentDate] =@Date and EmployeeKey = @EmployeeKey
if @count > 1
Begin
	if not exists (select Name from sys.tables
		where Name = 'Overtime')
		Begin
			Create table Overtime(
			BusScheduleAssignmentKey int, 
			BusDriverShiftKey int, 
			EmployeeKey int, 
			BusRouteKey int, 
			BusScheduleAssignmentDate Date,
			BusKey int
			)
		End
		insert into Overtime (
		BusScheduleAssignmentKey, 
		BusDriverShiftKey,
		EmployeeKey, 
		BusRouteKey, 
		BusScheduleAssignmentDate, 
		BusKey	)
		select BusScheduleAssignmentKey, 
		BusDriverShiftKey,
		EmployeeKey, 
		BusRouteKey, 
		BusScheduleAssignmentDate, 
		BusKey from inserted
End

Insert into BusScheduleAssignment(
 BusDriverShiftKey, 
 EmployeeKey,
 BusRouteKey, 
 BusScheduleAssignmentDate, 
 BusKey
)
Values (1,4,23,GetDate(),4)

Insert into BusScheduleAssignment(
 BusDriverShiftKey, 
 EmployeeKey,
 BusRouteKey, 
 BusScheduleAssignmentDate, 
 BusKey
)
Values (2,4,23,GetDate(),4)

Select * from Overtime;
