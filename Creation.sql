--create database-- 
CREATE DATABASE Exam_System ON
(NAME = Exam_dat,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\examdat.mdf',
    SIZE = 20 MB,
	maxsize=unlimited,
    FILEGROWTH = 64 MB)
LOG ON
(NAME = Sales_log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\examlog.ldf',
    SIZE = 20 MB,
	maxsize=unlimited,
    FILEGROWTH = 64 MB);
--create fileGroup--
ALTER DATABASE Exam_System
ADD FILEGROUP [Secondary];
--create tables--

--Student Table
create table Student(
StudentID int identity (1,1),
[name] varchar(30),
constraint PK_ID_Student primary key (StudentID)
)
--Course Table
create table Course(
CourseID int identity (1,1),
[name] varchar(30),
[Description] varchar(max),
Max_Degree float,
Min_Degree float
constraint PK_ID_Course primary key (CourseID)
)
--Instructor table
create table Instructor(
InstructorID int identity (1,1),
[name] varchar(30),
email varchar(max)
constraint PK_ID_Instructor primary key (InstructorID)
)
--Exam table

create table Exam(
ExamID int identity (1,1),
[Name] varchar(30),
[Type] varchar(max),
[Year] date,
Start_Time time,
End_Time time,
Degree float,
InstructorID int,
constraint PK_ID_Exam primary key (ExamID),
constraint FK_InstructorID_Exam foreign key (InstructorID) REFERENCES dbo.Instructor(InstructorID)
)
--Question_Bank table

create table Question_Bank (
QuestionID int identity (1,1),
[Type] varchar(max),
Content varchar(max),
Degree float,
CourseID int,
constraint PK_ID_QuestionBank primary key (QuestionID),
constraint FK_Course_QuestionBank foreign key (CourseID) REFERENCES dbo.Course(CourseID)
)

create table Question_Answer_Text(
Right_Answer varchar(max),
Question_ID int
foreign key (Question_ID) references dbo.Question_Bank(QuestionID)
primary key (Question_ID)
)
create table Question_Answer_MCQ(
Right_Answer varchar(max),
Wrong_Answer1 varchar(max),
Wrong_Answer2 varchar(max),
Question_ID int
foreign key (Question_ID) references dbo.Question_Bank(QuestionID)
primary key (Question_ID)
)
create table Question_Answer_TF(
Right_Answer varchar(5),
Wrong_Answer varchar(5),
Question_ID int
foreign key (Question_ID) references dbo.Question_Bank(QuestionID)
primary key (Question_ID)
)

--many to many tables
--Instructor_Course table
create table Instructor_Course(
CourseID int,
InstructorID int,
foreign key (InstructorID) REFERENCES dbo.Instructor (InstructorID),
foreign key (CourseID) REFERENCES dbo.Course (CourseID),
primary key (CourseID,InstructorID)
)
--Student_Course table
create table Student_Course(
CourseID int,
StudentID int,
foreign key (StudentID) REFERENCES dbo.Student (StudentID),
foreign key (CourseID) REFERENCES dbo.Course (CourseID),
primary key (CourseID,StudentID)
)
-- Student_Exam table
create table Student_Exam(
ExamID int,
StudentID int,
foreign key (StudentID) REFERENCES dbo.Student (StudentID),
foreign key (ExamID) REFERENCES dbo.Exam (ExamID),
primary key (ExamID,StudentID)
)
--Exam_Question table
create table Exam_Question(
ExamID int,
QuestionID int,
foreign key (QuestionID) REFERENCES dbo.Question_Bank (QuestionID),
foreign key (ExamID) REFERENCES dbo.Exam (ExamID),
primary key (ExamID,QuestionID)
)
--Student_Solve_Exam

create table Solve(
	ExamID int,
	StudentID int,
	QuestionID int,
	student_answer varchar(max),
	correct_answer varchar(max),
	student_answer_degree float,
	primary key (ExamID,StudentID,QuestionID)
)