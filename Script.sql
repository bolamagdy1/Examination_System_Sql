USE [master]
GO
/****** Object:  Database [Exam_System]    Script Date: 4/26/2023 3:47:28 PM ******/
CREATE DATABASE [Exam_System]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Exam_dat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\examdat.mdf' , SIZE = 20480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Sales_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\examlog.ldf' , SIZE = 20480KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Exam_System] ADD FILEGROUP [Secondary]
GO
ALTER DATABASE [Exam_System] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Exam_System].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Exam_System] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Exam_System] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Exam_System] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Exam_System] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Exam_System] SET ARITHABORT OFF 
GO
ALTER DATABASE [Exam_System] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Exam_System] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Exam_System] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Exam_System] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Exam_System] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Exam_System] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Exam_System] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Exam_System] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Exam_System] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Exam_System] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Exam_System] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Exam_System] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Exam_System] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Exam_System] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Exam_System] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Exam_System] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Exam_System] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Exam_System] SET RECOVERY FULL 
GO
ALTER DATABASE [Exam_System] SET  MULTI_USER 
GO
ALTER DATABASE [Exam_System] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Exam_System] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Exam_System] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Exam_System] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Exam_System] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Exam_System] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Exam_System', N'ON'
GO
ALTER DATABASE [Exam_System] SET QUERY_STORE = OFF
GO
USE [Exam_System]
GO
/****** Object:  User [training_manager]    Script Date: 4/26/2023 3:47:29 PM ******/
CREATE USER [training_manager] FOR LOGIN [training_manager] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [student]    Script Date: 4/26/2023 3:47:29 PM ******/
CREATE USER [student] FOR LOGIN [student] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [instructor]    Script Date: 4/26/2023 3:47:29 PM ******/
CREATE USER [instructor] FOR LOGIN [instructor] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [admin]    Script Date: 4/26/2023 3:47:29 PM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Question_Bank]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Bank](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](max) NULL,
	[Content] [varchar](max) NULL,
	[Degree] [float] NULL,
	[CourseID] [int] NULL,
 CONSTRAINT [PK_ID_QuestionBank] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question_Answer_Text]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Answer_Text](
	[Right_Answer] [varchar](max) NULL,
	[Question_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_Text_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Text_Question]
as
(
	select q.Content , qt.Right_Answer
	from Question_Bank q
	inner join Question_Answer_Text qt
	on qt.Question_ID = q.QuestionID
)
GO
/****** Object:  Table [dbo].[Question_Answer_MCQ]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Answer_MCQ](
	[Right_Answer] [varchar](max) NULL,
	[Wrong_Answer1] [varchar](max) NULL,
	[Wrong_Answer2] [varchar](max) NULL,
	[Question_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Diplay_MCQ_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Diplay_MCQ_Question]
as
(
	select q.Content,qm.Right_Answer,qm.Wrong_Answer1,qm.Wrong_Answer2
	from Question_Bank q
	inner join Question_Answer_MCQ qm
	on qm.Question_ID = q.QuestionID
)
GO
/****** Object:  Table [dbo].[Question_Answer_TF]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question_Answer_TF](
	[Right_Answer] [varchar](5) NULL,
	[Wrong_Answer] [varchar](5) NULL,
	[Question_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_TF_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_TF_Question]
as
(
	select q.Content,qt.Right_Answer,qt.Wrong_Answer
	from Question_Bank q
	inner join Question_Answer_TF qt
	on qt.Question_ID = q.QuestionID
)
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ExamID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NULL,
	[Type] [varchar](max) NULL,
	[Year] [date] NULL,
	[Degree] [float] NULL,
	[InstructorID] [int] NULL,
	[Start_Time] [time](7) NULL,
	[End_Time] [time](7) NULL,
 CONSTRAINT [PK_ID_Exam] PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam_Question](
	[ExamID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC,
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Display_Exam_Question_MCQ]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Display_Exam_Question_MCQ] (@EID int)
returns table
as
return
	select qm.Question_ID as Q_NO,Right_Answer as a,qm.Wrong_Answer1 as b,qm.Wrong_Answer2 as c
	from Exam e
	inner join Exam_Question eq
	on e.ExamID = @EID and eq.ExamID = @EID
	inner join Question_Bank q
	on eq.QuestionID =q.QuestionID
	inner join Question_Answer_MCQ qm
	on qm.Question_ID = q.QuestionID
GO
/****** Object:  UserDefinedFunction [dbo].[Display_Exam_Question_TF]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Display_Exam_Question_TF] (@EID int)
returns table
as
return
	select qt.Question_ID as Q_NO,Right_Answer as a,qt.Wrong_Answer as b
	from Exam e
	inner join Exam_Question eq
	on e.ExamID = @EID and eq.ExamID = @EID
	inner join Question_Bank q
	on eq.QuestionID =q.QuestionID
	inner join Question_Answer_TF qt
	on qt.Question_ID = q.QuestionID
GO
/****** Object:  Table [dbo].[Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NULL,
	[Description] [varchar](max) NULL,
	[Max_Degree] [float] NULL,
	[Min_Degree] [float] NULL,
 CONSTRAINT [PK_ID_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_Courses]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Courses]
as 
(
select * from Course
)
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NULL,
	[email] [varchar](max) NULL,
 CONSTRAINT [PK_ID_Instructor] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Display_Instructor]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Display_Instructor]()
returns table
as 
return
(
	select * from Instructor
)
GO
/****** Object:  Table [dbo].[Instructor_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor_Course](
	[CourseID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_Instructor_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Instructor_Course]
as 
(
	select i.name as instructor_name,c.name as course_name
	from Instructor i
	inner join Instructor_Course ic
	on ic.InstructorID = i.InstructorID
	inner join Course c
	on ic.CourseID = c.CourseID
)
GO
/****** Object:  Table [dbo].[Student]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NULL,
 CONSTRAINT [PK_ID_Student] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_Students]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Students]
as
(
	select * from Student
)
GO
/****** Object:  Table [dbo].[Student_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Course](
	[CourseID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_Student_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Student_Course]
as
(
	select s.name as Student_name, c.name as Course_name
	from Student s
	inner join Student_Course sc
	on sc.StudentID = s.StudentID
	inner join Course c
	on sc.CourseID = c.CourseID
)
GO
/****** Object:  View [dbo].[Display_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Exam]
as
(
	select * from Exam
)
GO
/****** Object:  Table [dbo].[Student_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Exam](
	[ExamID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Display_Student_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Display_Student_Exam]
as
(
	select s.name as Student_name,e.Name as Exam_name,e.Type as Exam_type
	from Student s
	inner join Student_Exam se
	on se.StudentID = s.StudentID
	inner join Exam e
	on e.ExamID = se.ExamID
)
GO
/****** Object:  Table [dbo].[Solve]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solve](
	[ExamID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
	[student_answer] [varchar](max) NULL,
	[correct_answer] [varchar](max) NULL,
	[student_answer_degree] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC,
	[StudentID] ASC,
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_InstructorID_Exam] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_InstructorID_Exam]
GO
ALTER TABLE [dbo].[Exam_Question]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
GO
ALTER TABLE [dbo].[Exam_Question]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question_Bank] ([QuestionID])
GO
ALTER TABLE [dbo].[Instructor_Course]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Instructor_Course]  WITH CHECK ADD FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[Question_Answer_MCQ]  WITH CHECK ADD FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question_Bank] ([QuestionID])
GO
ALTER TABLE [dbo].[Question_Answer_Text]  WITH CHECK ADD FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question_Bank] ([QuestionID])
GO
ALTER TABLE [dbo].[Question_Answer_TF]  WITH CHECK ADD FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question_Bank] ([QuestionID])
GO
ALTER TABLE [dbo].[Question_Bank]  WITH CHECK ADD  CONSTRAINT [FK_Course_QuestionBank] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Question_Bank] CHECK CONSTRAINT [FK_Course_QuestionBank]
GO
ALTER TABLE [dbo].[Student_Course]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Student_Course]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
ALTER TABLE [dbo].[Student_Exam]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
GO
ALTER TABLE [dbo].[Student_Exam]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
GO
/****** Object:  StoredProcedure [dbo].[Alter_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Course] (@ID int,@name varchar(30),@description varchar(max),@max_degree float , @min_degree float)
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
GO
/****** Object:  StoredProcedure [dbo].[Alter_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Exam](@ID int,@name varchar(30),@type varchar(max),@year date ,@start_time time, @end_time time ,@degree float,@IID int)
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
GO
/****** Object:  StoredProcedure [dbo].[Alter_Instructor]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Instructor] (@ID int,@name varchar(30),@email varchar(max))
as
begin
	update Instructor
	set
	name = @name,
	email = @email
	where InstructorID = @ID
end
GO
/****** Object:  StoredProcedure [dbo].[Alter_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Question](@ID int,@type varchar(max),@content varchar(max),@answer varchar(max),@degree float,@CID int)
as
begin
	update Question_Bank
	set Type = @type,
	Content = @content,
	Answer = @answer,
	Degree = @degree,
	CourseID = @CID
	where QuestionID = @ID

end
GO
/****** Object:  StoredProcedure [dbo].[Alter_Question_Answer_MCQ]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Question_Answer_MCQ](@QID int,@answer varchar(max),@wrong1 varchar(max),@wrong2 varchar(max))
as
begin
	update Question_Answer_MCQ
	set
	Right_Answer = @answer,
	Wrong_Answer1 = @wrong1,
	Wrong_Answer2 = @wrong2
	where Question_ID = @QID
end
GO
/****** Object:  StoredProcedure [dbo].[Alter_Question_Answer_Text]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Question_Answer_Text](@QID int,@answer varchar(max))
as
begin
	update Question_Answer_Text
	set Right_Answer = @answer
	where Question_ID = @QID
end
GO
/****** Object:  StoredProcedure [dbo].[Alter_Question_Answer_TF]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Question_Answer_TF](@QID int,@answer varchar(5),@wrong varchar(5))
as
begin
	update Question_Answer_TF
	set
	Right_Answer = @answer,
	Wrong_Answer = @wrong
	where Question_ID = @QID
end
GO
/****** Object:  StoredProcedure [dbo].[Alter_Student]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Alter_Student] (@ID int,@name varchar(30))
as
begin
	update Student
	set
	name = @name
end
GO
/****** Object:  StoredProcedure [dbo].[Create_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Create_Exam](@CourseID int,@ExamID int, @Exam_Degree float)
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
GO
/****** Object:  StoredProcedure [dbo].[Delete_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Delete_Course](@ID int)
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
GO
/****** Object:  StoredProcedure [dbo].[Delete_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Delete_Exam](@ID int)
as
begin
	delete from Exam_Question
	where ExamID = @ID

	delete from Student_Exam
	where ExamID = @ID

	delete from Exam
	where ExamID = @ID
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_Instructor]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Delete_Instructor](@ID int)
as
begin
	delete from Instructor_Course
	where InstructorID = @ID
	
	delete from Exam
	where InstructorID = @ID

	delete from Instructor
	where InstructorID = @ID
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Delete_Question](@ID int)
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
GO
/****** Object:  StoredProcedure [dbo].[Delete_Student]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Delete_Student](@ID int)
as
begin
	delete from Student_Course
	where StudentID = @ID

	delete from Student_Exam
	where StudentID = @ID

	delete from Student
	where StudentID = @ID
end
GO
/****** Object:  StoredProcedure [dbo].[Display_Exam_Questions]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Display_Exam_Questions](@EID int)
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
GO
/****** Object:  StoredProcedure [dbo].[Insert_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Insert_Course] (@name varchar(30),@description varchar(max),@max_degree float , @min_degree float)
as
begin
insert into Course (name ,Description,Max_Degree,Min_Degree)
values(@name,@description,@max_degree,@min_degree)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Insert_Exam](@name varchar(30),@type varchar(max),@year date ,@start_time time, @end_time time ,@degree float,@IID int)
as
begin
insert into Exam (Name,Type,Year,Start_Time,End_Time,Degree,InstructorID)
values(@name,@type,@year,@start_time,@end_time,@degree,@IID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Exam_Question]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Exam_Question](@EID int,@QID int)
as
begin
insert into Exam_Question(ExamID,QuestionID)
values(@EID,@QID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Instructor]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Instructor] (@name varchar(30),@email varchar(max))
as 
begin
insert into Instructor (name,email)
values (@name,@email)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Instructor_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Instructor_Course](@CID int ,@IID int)
as
begin
insert into Instructor_Course(CourseID,InstructorID)
values (@CID , @IID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Question_Answer_MCQ]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Question_Answer_MCQ](@answer varchar(max),@wrong1 varchar(max),@wrong2 varchar(max),@QID int)
as
begin
	insert into Question_Answer_MCQ(Right_Answer,Wrong_Answer1,Wrong_Answer2,Question_ID)
	values(@answer,@wrong1,@wrong2,@QID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Question_Answer_Text]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Question_Answer_Text](@answer varchar(max),@QID int)
as
begin
	insert into Question_Answer_Text(Right_Answer,Question_ID)
	values(@answer,@QID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Question_Answer_TF]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Question_Answer_TF](@answer varchar(5),@wrong varchar(5),@QID int)
as
begin
	insert into Question_Answer_TF(Right_Answer,Wrong_Answer,Question_ID)
	values(@answer,@wrong,@QID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Question_Bank]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Insert_Question_Bank](@type varchar(max),@content varchar(max),@degree float,@CID int)
as
begin
insert into Question_Bank(Type,Content,Degree,CourseID)
values(@type,@content,@degree,@CID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Student]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Student] (@name varchar(30))
as
begin
insert into Student(name)
values (@name)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Student_Course]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Student_Course](@CID int,@SID int)
as
begin
insert into Student_Course(CourseID,StudentID)
values(@CID,@SID)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Student_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Insert_Student_Exam](@EID int,@SID int)
as
begin
insert into Student_Exam(ExamID,StudentID)
values (@EID,@SID)
end
GO
/****** Object:  StoredProcedure [dbo].[Student_Answer_Exam]    Script Date: 4/26/2023 3:47:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Student_Answer_Exam] (@exam_ID int,@Student_ID int,@Question_ID int,@Question_Answer varchar(max))
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
	select sum(student_answer_degree) from Solve where StudentID = @Student_ID
end
GO
USE [master]
GO
ALTER DATABASE [Exam_System] SET  READ_WRITE 
GO
