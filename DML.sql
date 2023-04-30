--Proc to Insert Into Course

create proc Insert_Course (@name varchar(30),@description varchar(max),@max_degree float , @min_degree float)
as
begin
insert into Course (name ,Description,Max_Degree,Min_Degree)
values(@name,@description,@max_degree,@min_degree)
end

exec Insert_Course 'html','html description',100,50
exec Insert_Course 'css','css description',100,50
exec Insert_Course 'js','js description',100,50
exec Insert_Course 'sql','sql description',100,50
exec Insert_Course 'ajax','ajax description',100,50

--Alter Course Info
go
create proc Alter_Course (@ID int,@name varchar(30),@description varchar(max),@max_degree float , @min_degree float)
as
begin
	update Course
	set
	name = @name,
	Description = @description,
	Max_Degree = @max_degree,
	Min_Degree = @min_degree
	where CourseId = @ID
end
exec Alter_Course 1,'name','description',100,50 
--Delete Course
go
create proc Delete_Course(@ID int)
as
begin
	delete from Student_Course
	where CourseID = @ID

	delete from Instructor_Course
	where CourseID = @ID

	delete from Question_Bank
	where CourseID = @ID

	delete from Course
	where CourseID = @ID
end
--View To Show All Courses
go
create view Display_Courses
as 
(
select * from Course
)
go
select * from Display_Courses

--DML Course Trigger
--Insert
go
create trigger Trg_Course_Insert
on Course
After Insert
as
begin
Print'You Insert One'
select * from inserted
end

insert into Course (name ,Description,Max_Degree,Min_Degree)
values('HTML','HTML Description',100,50)
--Update
go
create trigger Trg_Course_Update
on Course
After Update
as
begin
Print'You Update From'
select * from deleted 
Print'To'
select * from inserted
end

update Course
set name='html2'
where CourseID =33

--Delete
go
create trigger Trg_Course_Delete
on Course
After Delete
as
begin
Print'You Delete One'
select * from deleted 
end

delete from Course
where CourseID = 33


-- Insert into Instructor
go
create proc Insert_Instructor (@name varchar(30),@email varchar(max))
as 
begin
insert into Instructor (name,email)
values (@name,@email)
end

exec Insert_Instructor 'nawal' , 'nawla@gmail.com'
exec Insert_Instructor 'ahmed' , 'ahmed@gmail.com'
exec Insert_Instructor 'sarah' , 'sarah@gmail.com'
exec Insert_Instructor 'marehan' , 'marehan@gmail.com'

--Alert Instructor Information
go
create proc Alter_Instructor (@ID int,@name varchar(30),@email varchar(max))
as
begin
	update Instructor
	set
	name = @name,
	email = @email
	where InstructorID = @ID
end

--Delete Instructor
go
create proc Delete_Instructor(@ID int)
as
begin
	delete from Instructor_Course
	where InstructorID = @ID
	
	delete from Exam
	where InstructorID = @ID

	delete from Instructor
	where InstructorID = @ID
end

--Function to show all Instructors
go
create function Display_Instructor()
returns table
as 
return
(
	select * from Instructor
)
go
select * from Display_Instructor()

--DML Instructor Trigger
--Insert
go
create trigger Trg_Instructor_Insert
on Instructor
After Insert
as
begin
Print'You Insert One'
select * from inserted
end
--Update
go
create trigger Trg_Instructor_Update
on Instructor
After Update
as
begin
Print'You Update From'
select * from deleted 
Print'To'
select * from inserted
end

--Delete
go
create trigger Trg_Instructor_Delete
on Instructor
After Delete
as
begin
Print'You Delete One'
select * from deleted 
end



-- Insert Relation Between Instructor and Course
go
create proc Insert_Instructor_Course(@CID int ,@IID int)
as
begin
insert into Instructor_Course(CourseID,InstructorID)
values (@CID , @IID)
end

exec Insert_Instructor_Course 1,1 
exec Insert_Instructor_Course 2,1 
exec Insert_Instructor_Course 3,2
exec Insert_Instructor_Course 4,3
exec Insert_Instructor_Course 5,4

-- View to show Instructor of Courses
go
create view Display_Instructor_Course
as 
(
	select i.name as instructor_name,c.name as course_name
	from Instructor i
	inner join Instructor_Course ic
	on ic.InstructorID = i.InstructorID
	inner join Course c
	on ic.CourseID = c.CourseID
)
go
select * from Display_Instructor_Course

--Insert Into Student
go
create proc Insert_Student (@name varchar(30))
as
begin
insert into Student(name)
values (@name)
end

exec Insert_Student 'Joseph'
exec Insert_Student 'AbdElrahman'
exec Insert_Student 'Osama'
exec Insert_Student 'Bola'

--Alter Student Info
go
create proc Alter_Student (@ID int,@name varchar(30))
as
begin
	update Student
	set
	name = @name
end

--Delete Student
go 
create proc Delete_Student(@ID int)
as
begin
	delete from Student_Course
	where StudentID = @ID

	delete from Student_Exam
	where StudentID = @ID

	delete from Student
	where StudentID = @ID
end
-- View to show all information about Student
go
create view Display_Students
as
(
	select * from Student
)
go
select * from Display_Students
--DML Student Trigger
--Insert
go
create trigger Trg_Student_Insert
on Student
After Insert
as
begin
Print'You Insert One'
select * from inserted
end
--Update
go
create trigger Trg_Student_Update
on Student
After Update
as
begin
Print'You Update From'
select * from deleted 
Print'To'
select * from inserted
end

--Delete
go
create trigger Trg_Student_Delete
on Student
After Delete
as
begin
Print'You Delete One'
select * from deleted
end



go
create proc Insert_Student_Course(@CID int,@SID int)
as
begin
insert into Student_Course(CourseID,StudentID)
values(@CID,@SID)
end

exec Insert_Student_Course 1,1
exec Insert_Student_Course 1,2
exec Insert_Student_Course 1,3
exec Insert_Student_Course 1,4

exec Insert_Student_Course 2,1
exec Insert_Student_Course 2,2
exec Insert_Student_Course 2,3
exec Insert_Student_Course 2,4

exec Insert_Student_Course 3,1
exec Insert_Student_Course 3,2
exec Insert_Student_Course 3,3
exec Insert_Student_Course 3,4

exec Insert_Student_Course 4,1
exec Insert_Student_Course 4,2
exec Insert_Student_Course 4,3
exec Insert_Student_Course 4,4

exec Insert_Student_Course 5,1
exec Insert_Student_Course 5,2
exec Insert_Student_Course 5,3
exec Insert_Student_Course 5,4


--View to show Students of Courses
go
create view Display_Student_Course
as
(
	select s.name as Student_name, c.name as Course_name
	from Student s
	inner join Student_Course sc
	on sc.StudentID = s.StudentID
	inner join Course c
	on sc.CourseID = c.CourseID
)
go
select * from Display_Student_Course

--Insert Into Exam and Instructo Who made the exam
go
create proc Insert_Exam(@name varchar(30),@type varchar(max),@year date ,@start_time time, @end_time time ,@degree float,@IID int)
as
begin
insert into Exam (Name,Type,Year,Start_Time,End_Time,Degree,InstructorID)
values(@name,@type,@year,@start_time,@end_time,@degree,@IID)
end

exec Insert_Exam 'html exam','exam','2023-02-12','09:00:00','11:00:00', 80 ,1
exec Insert_Exam 'css exam','corrective','2023-02-11','09:00:00','11:00:00', 70 ,1
exec Insert_Exam 'js exam','exam','2023-03-12','09:00:00','11:00:00', 80 ,2
exec Insert_Exam 'sql exam','corrective','2023-03-10','09:00:00','11:00:00', 90 ,3
exec Insert_Exam 'ajax exam','exam','2023-04-08','09:00:00','11:00:00', 80 ,4

--Alter Exam Info
go
create proc Alter_Exam(@ID int,@name varchar(30),@type varchar(max),@year date ,@start_time time, @end_time time ,@degree float,@IID int)
as
begin
	update Exam
	set
	Name = @name,
	Type = @type,
	Year = @year,
	Start_Time = @start_time,
	End_Time = @end_time,
	Degree = @degree,
	InstructorID = @IID
	where ExamID = @ID
end

--Delete Exam
go
create proc Delete_Exam(@ID int)
as
begin
	delete from Exam_Question
	where ExamID = @ID

	delete from Student_Exam
	where ExamID = @ID

	delete from Exam
	where ExamID = @ID
end
--View to show all Exams
go
create view Display_Exam
as
(
	select * from Exam
)
go
select * from Display_Exam

--DML Exam Trigger
--Insert
go
create trigger Trg_Exam_Insert
on Exam
After Insert
as
begin
Print'You Insert One'
select * from inserted
end
--Update
go
create trigger Trg_Exam_Update
on Exam
After Update
as
begin
Print'You Update From'
select * from deleted 
Print'To'
select * from inserted
end

--Delete
go
create trigger Trg_Exam_Delete
on Exam
After Delete
as
begin
Print'You Delete One'
select * from deleted 
end


--Insert Into Exam_Student
go
create proc Insert_Student_Exam(@EID int,@SID int)
as
begin
insert into Student_Exam(ExamID,StudentID)
values (@EID,@SID)
end

exec Insert_Student_Exam 1,1
exec Insert_Student_Exam 1,2
exec Insert_Student_Exam 1,3
exec Insert_Student_Exam 1,4

exec Insert_Student_Exam 2,1
exec Insert_Student_Exam 2,2
exec Insert_Student_Exam 2,3
exec Insert_Student_Exam 2,4

exec Insert_Student_Exam 3,1
exec Insert_Student_Exam 3,2
exec Insert_Student_Exam 3,3
exec Insert_Student_Exam 3,4

exec Insert_Student_Exam 4,1
exec Insert_Student_Exam 4,2
exec Insert_Student_Exam 4,3
exec Insert_Student_Exam 4,4

exec Insert_Student_Exam 5,1
exec Insert_Student_Exam 5,2
exec Insert_Student_Exam 5,3
exec Insert_Student_Exam 5,4

-- View to show all Student whoes Entered the Exam
go
create view Display_Student_Exam
as
(
	select s.name as Student_name,e.Name as Exam_name,e.Type as Exam_type
	from Student s
	inner join Student_Exam se
	on se.StudentID = s.StudentID
	inner join Exam e
	on e.ExamID = se.ExamID
)
go
select * from Display_Student_Exam

--Insert Into Question Bank
go
create proc Insert_Question_Bank(@type varchar(max),@content varchar(max),@degree float,@CID int)
as
begin
insert into Question_Bank(Type,Content,Degree,CourseID)
values(@type,@content,@degree,@CID)
end

exec Insert_Question_Bank 'MCQ','What does the abbreviation HTML stand for?',5,1
exec Insert_Question_Bank 'MCQ','The correct sequence of HTML tags for starting a webpage is?',5,2
exec Insert_Question_Bank 'MCQ','Which of the following element is responsible for making the text bold in HTML?',5,3
exec Insert_Question_Bank 'MCQ','Which of the following tag is used for inserting the largest heading in HTML?',5,4
exec Insert_Question_Bank 'MCQ','Which of the following tag is used to insert a line-break in HTML?',5,5
exec Insert_Question_Bank 'TF','State whether the given statement is true or false. !DOCTYPE is case sensitive',5,1
exec Insert_Question_Bank 'TF','State whether the given statement is true or false. “We can intermix XHTML and HTML 4.01 documents',5,2
exec Insert_Question_Bank 'TF','State true or false. Nexus is first graphical web browser.',5,3
exec Insert_Question_Bank 'TF','State true or false. Maqetta is an open source initiative of the Dojo Foundation to geared towards visual designers through a WYSIWYG user interface.',5,4
exec Insert_Question_Bank 'TF','State true or false. Tomcat is an open source web server that provides a servlet container allowing you to run Java code.',5,5
exec Insert_Question_Bank 'Text','Describe <header>',5,1
exec Insert_Question_Bank 'Text','Describe<footer>',5,2
exec Insert_Question_Bank 'Text','Describe<nav>',5,3
exec Insert_Question_Bank 'Text','Describe<article>',5,4
exec Insert_Question_Bank 'Text','Describe<section>',5,5

--Insert insto Question_Answer_Text
go
create proc Insert_Question_Answer_Text(@answer varchar(max),@QID int)
as
begin
	insert into Question_Answer_Text(Right_Answer,Question_ID)
	values(@answer,@QID)
end
exec Insert_Question_Answer_Text 'Stores the starting information about the web page.',11
exec Insert_Question_Answer_Text 'Represents the last section of the page.',12
exec Insert_Question_Answer_Text 'The navigation menu of the HTML page.',13
exec Insert_Question_Answer_Text 'It is a set of information.',14
exec Insert_Question_Answer_Text 'It is used inside the article block to define the basic structure of a page.',15

go
create proc Alter_Question_Answer_Text(@QID int,@answer varchar(max))
as
begin
	update Question_Answer_Text
	set Right_Answer = @answer
	where Question_ID = @QID
end

--Insert insto Question_Answer_MCQ
go
create proc Insert_Question_Answer_MCQ(@answer varchar(max),@wrong1 varchar(max),@wrong2 varchar(max),@QID int)
as
begin
	insert into Question_Answer_MCQ(Right_Answer,Wrong_Answer1,Wrong_Answer2,Question_ID)
	values(@answer,@wrong1,@wrong2,@QID)
end
exec Insert_Question_Answer_MCQ 'HyperText Markup Language','HyperText and links Markup Language','HighText Machine Language',1
exec Insert_Question_Answer_MCQ 'HTML, Head, Title, Body','mosalah','abutrika',2
exec Insert_Question_Answer_MCQ '<b>','mosalah','abutrika',3
exec Insert_Question_Answer_MCQ '<h1>','mosalah','abutrika',4
exec Insert_Question_Answer_MCQ '<br>','mosalah','abutrika',5

go
create proc Alter_Question_Answer_MCQ(@QID int,@answer varchar(max),@wrong1 varchar(max),@wrong2 varchar(max))
as
begin
	update Question_Answer_MCQ
	set
	Right_Answer = @answer,
	Wrong_Answer1 = @wrong1,
	Wrong_Answer2 = @wrong2
	where Question_ID = @QID
end

--Insert insto Question_Answer_MCQ
go
create proc Insert_Question_Answer_TF(@answer varchar(5),@wrong varchar(5),@QID int)
as
begin
	insert into Question_Answer_TF(Right_Answer,Wrong_Answer,Question_ID)
	values(@answer,@wrong,@QID)
end
exec Insert_Question_Answer_TF 'false','true',6
exec Insert_Question_Answer_TF 'false','true',7
exec Insert_Question_Answer_TF 'false','true',8
exec Insert_Question_Answer_TF 'true','false',9
exec Insert_Question_Answer_TF 'true','false',10

go
create proc Alter_Question_Answer_TF(@QID int,@answer varchar(5),@wrong varchar(5))
as
begin
	update Question_Answer_TF
	set
	Right_Answer = @answer,
	Wrong_Answer = @wrong
	where Question_ID = @QID
end
--Alter Question Information
go
create proc Alter_Question(@ID int,@type varchar(max),@content varchar(max),@degree float,@CID int)
as
begin
	update Question_Bank
	set Type = @type,
	Content = @content,
	Degree = @degree,
	CourseID = @CID
	where QuestionID = @ID

end

--Delete Question
go
alter proc Delete_Question(@ID int)
as
begin
	delete from Exam_Question
	where QuestionID = @ID

	delete from Question_Answer_Text
	where Question_ID = @ID

	delete from Question_Answer_MCQ
	where Question_ID = @ID

	delete from Question_Answer_TF
	where Question_ID = @ID

	delete from Question_Bank
	where QuestionID = @ID
end
--View to show all Questions
go
create view Display_Text_Question
as
(
	select q.Content , qt.Right_Answer
	from Question_Bank q
	inner join Question_Answer_Text qt
	on qt.Question_ID = q.QuestionID
)
go
select * from Display_Text_Question

go 
create view Diplay_MCQ_Question
as
(
	select q.Content,qm.Right_Answer,qm.Wrong_Answer1,qm.Wrong_Answer2
	from Question_Bank q
	inner join Question_Answer_MCQ qm
	on qm.Question_ID = q.QuestionID
)
go
select * from Diplay_MCQ_Question

go 
create view Display_TF_Question
as
(
	select q.Content,qt.Right_Answer,qt.Wrong_Answer
	from Question_Bank q
	inner join Question_Answer_TF qt
	on qt.Question_ID = q.QuestionID
)
go
select * from Display_TF_Question
--DML Question_Bank Trigger
--Insert
go
create trigger Trg_Question_Insert
on Question_Bank
After Insert
as
begin
Print'You Insert One'
select * from inserted
end
--Update
go
create trigger Trg_Question_Update
on Question_Bank
After Update
as
begin
Print'You Update From'
select * from deleted 
Print'To'
select * from inserted
end

--Delete
go
create trigger Trg_Question_Delete
on Question_Bank
After Delete
as
begin
Print'You Delete One'
select * from deleted 
end

--Create Exam_Question Automatically
go
create proc Create_Exam(@CourseID int,@ExamID int, @Exam_Degree float)
as
begin
	--Interator to loop
	declare @Iterator int
	set @Iterator = 0

	--Variable to Calculate Total Degree of Questions
	declare @Total_Degree float
	set @Total_Degree = 0

	while(@Iterator < (select count(*) from Question_Bank))
	begin
		if((select CourseID from Question_Bank where QuestionID = @Iterator)=@CourseID)
		begin
			declare @Question_Degree float
			set @Question_Degree = (select Degree from Question_Bank where CourseID = @CourseID and QuestionID = @Iterator)
			
			if(@Total_Degree + @Question_Degree > @Exam_Degree)
			begin
				break;
			end
			else
			begin
				set @Total_Degree += @Question_Degree
				insert into Exam_Question(ExamID,QuestionID)
				values(@ExamID,@Iterator)
			end
			set @Iterator+=1
		end
		else
		begin
			set @Iterator+=1
			continue;
		end
	end
end



--Insert into Exam_Question Bank Manually
go
create proc Insert_Exam_Question(@EID int,@QID int)
as
begin
insert into Exam_Question(ExamID,QuestionID)
values(@EID,@QID)
end

exec Insert_Exam_Question 1,1
exec Insert_Exam_Question 1,6
exec Insert_Exam_Question 1,11

exec Insert_Exam_Question 2,2
exec Insert_Exam_Question 2,7
exec Insert_Exam_Question 2,12

exec Insert_Exam_Question 3,3
exec Insert_Exam_Question 3,8
exec Insert_Exam_Question 3,13

exec Insert_Exam_Question 4,4
exec Insert_Exam_Question 4,9
exec Insert_Exam_Question 4,14

exec Insert_Exam_Question 5,5
exec Insert_Exam_Question 5,10
exec Insert_Exam_Question 5,15

-- View to show Questions of Exams

go
create proc Display_Exam_Questions(@EID int)
as
begin
	select q.QuestionID as Q_NO, q.Type, q.Content
	from Exam e
	inner join Exam_Question eq
	on e.ExamID = @EID and eq.ExamID = @EID
	inner join Question_Bank q
	on eq.QuestionID =q.QuestionID
	
	select qm.Question_ID as Q_NO,Right_Answer as a,qm.Wrong_Answer1 as b,qm.Wrong_Answer2 as c
	from Exam e
	inner join Exam_Question eq
	on e.ExamID = @EID and eq.ExamID = @EID
	inner join Question_Bank q
	on eq.QuestionID =q.QuestionID
	inner join Question_Answer_MCQ qm
	on qm.Question_ID = q.QuestionID
	
	select qt.Question_ID as Q_NO,Right_Answer as a,qt.Wrong_Answer as b
	from Exam e
	inner join Exam_Question eq
	on e.ExamID = @EID and eq.ExamID = @EID
	inner join Question_Bank q
	on eq.QuestionID =q.QuestionID
	inner join Question_Answer_TF qt
	on qt.Question_ID = q.QuestionID
end
	
exec Display_Exam_Questions 1


go
alter proc Student_Answer_Exam (@exam_ID int,@Student_ID int,@Question_ID int,@Question_Answer varchar(max))
as
begin
	declare @ans varchar(max)
	declare @Q_Type varchar(4)
	declare @total float
	set @Q_Type = (select [Type] from Question_Bank where QuestionID = @Question_ID)

	if(@Q_Type = 'MCQ')
	begin
		set @ans = (select Right_Answer from Question_Answer_MCQ where Question_ID = @Question_ID)
		
	 	if(@Question_Answer = @ans)
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,5)
		end
		else
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,0)
		end
	end
	else if(@Q_Type = 'TF')
	begin
		
		set @ans = (select Right_Answer from Question_Answer_TF where Question_ID = @Question_ID)
		
		
	 	if(@Question_Answer = @ans)
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,5)
		end
		else
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,0)
		end
	end
	else if(@Q_Type = 'Text')
	begin
		set @ans = (select Right_Answer from Question_Answer_Text where Question_ID = @Question_ID)

	 	if(@Question_Answer = @ans)
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,5)
		end
		else IF (@ans LIKE '%' + @Question_Answer + '%')
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,2.5)
		end
		else
		begin
			insert into Solve(ExamID,StudentID,QuestionID,student_answer,correct_answer,student_answer_degree)
			values(@exam_ID,@Student_ID,@Question_ID,@Question_Answer,@ans,0)
		end
	end
	
	select * from Solve where StudentID = @Student_ID
	select sum(student_answer_degree) as total from Solve where StudentID = @Student_ID
end

exec Student_Answer_Exam 1,1,11,'Stores the starting'

--Read From XML

INSERT INTO Student([name])
SELECT
        MY_XML.Student.query('Name').value('.','varchar(10)')
    FROM (select cast (MY_XML as xml)
	from openrowset (bulk 'E:\ITI\Projects\sql\SQL Project\SQL Project\Students.xml',SINGLE_BLOB) as T(MY_XML)) as T(MY_XML)
	cross apply MY_XML.nodes('StudentDetails/Student') as MY_XML(Student)