USE [master]
GO
/****** Object:  Database [DB]    Script Date: 1/18/2021 12:09:04 AM ******/
CREATE DATABASE [DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB] SET RECOVERY FULL 
GO
ALTER DATABASE [DB] SET  MULTI_USER 
GO
ALTER DATABASE [DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB', N'ON'
GO
ALTER DATABASE [DB] SET QUERY_STORE = OFF
GO
USE [DB]
GO
USE [DB]
GO
/****** Object:  Sequence [dbo].[QuestionSequence]    Script Date: 1/18/2021 12:09:05 AM ******/
CREATE SEQUENCE [dbo].[QuestionSequence] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[udf_Account_Validate]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[udf_Account_Validate] (@username nvarchar(30), @password nvarchar(30), @role char(1))
returns int
as 
begin
	if (@role = 'S')
	begin
		if (@password = 
		(
			select [password] 
			from [dbo].[StudentAccount] 
			where [username] = @username
		))
			return -1
	end
	else if(@role = 'I')
	begin
		if (@password = 
		(
			select [password] 
			from [dbo].[InstructorAccount] 
			where [username] = @username
		))
			return -1
	end
	else if(@role = 'M')
	begin
		if (@password = 
		(
			select [password] 
			from [dbo].[InstructorAccount] 
			where [is_Manager] = 1 and [username] = @username
		))
			return -1
	end
	else if(@role = 'A')
	begin
		if (@password = 
		(
			select [password] 
			from [dbo].[AdminAccount]
			where [username] = @username
		))
			return -1
	end
	return -2
end
GO
/****** Object:  Table [dbo].[Active Courses]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Active Courses](
	[active_Course_ID] [int] IDENTITY(1,1) NOT NULL,
	[course_ID] [int] NOT NULL,
	[instructor_ID] [int] NOT NULL,
 CONSTRAINT [PK_Active Courses] PRIMARY KEY CLUSTERED 
(
	[active_Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminAccount](
	[admin_ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_AdminAccount] PRIMARY KEY CLUSTERED 
(
	[admin_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[branch_ID] [int] IDENTITY(1,1) NOT NULL,
	[branch_Name] [nvarchar](50) NOT NULL,
	[branch_Location] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[class_ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[intake_ID] [int] NOT NULL,
	[branch_ID] [int] NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[course_ID] [int] IDENTITY(1,1) NOT NULL,
	[course_Name] [nvarchar](50) NOT NULL,
	[course_Description] [nvarchar](50) NULL,
	[course_Max] [int] NOT NULL,
	[course_Min] [int] NOT NULL,
	[track_ID] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course Classes]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course Classes](
	[course_Class_ID] [int] IDENTITY(1,1) NOT NULL,
	[active_Course_ID] [int] NOT NULL,
	[class_ID] [int] NOT NULL,
 CONSTRAINT [PK_Course Classes] PRIMARY KEY CLUSTERED 
(
	[course_Class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseEnrollment]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseEnrollment](
	[enrollment_ID] [int] IDENTITY(1,1) NOT NULL,
	[student_ID] [int] NOT NULL,
	[active_Course_ID] [int] NOT NULL,
	[start_Date] [date] NOT NULL,
	[end_Date] [date] NOT NULL,
 CONSTRAINT [PK_CourseEnrollment] PRIMARY KEY CLUSTERED 
(
	[enrollment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[dept_ID] [int] IDENTITY(1,1) NOT NULL,
	[dept_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[dept_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[exam_ID] [int] IDENTITY(1,1) NOT NULL,
	[type_ID] [int] NULL,
	[exam_Max] [int] NOT NULL,
	[exam_Min] [int] NOT NULL,
	[instructor_ID] [int] NOT NULL,
	[active_Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam Questions]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam Questions](
	[exam_Question_ID] [int] IDENTITY(1,1) NOT NULL,
	[exam_ID] [int] NOT NULL,
	[question_ID] [int] NOT NULL,
	[degree] [int] NOT NULL,
 CONSTRAINT [PK_Exam Questions] PRIMARY KEY CLUSTERED 
(
	[exam_Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam Type]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam Type](
	[type_ID] [int] IDENTITY(1,1) NOT NULL,
	[type_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Exam Type] PRIMARY KEY CLUSTERED 
(
	[type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exams Taken]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exams Taken](
	[student_Exam_ID] [int] IDENTITY(1,1) NOT NULL,
	[student_ID] [int] NOT NULL,
	[exam_ID] [int] NOT NULL,
	[degree] [int] NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PK_Take Exam] PRIMARY KEY CLUSTERED 
(
	[student_Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[instructor_ID] [int] IDENTITY(1,1) NOT NULL,
	[first_Name] [nvarchar](50) NOT NULL,
	[last_Name] [nvarchar](50) NOT NULL,
	[account_ID] [int] NULL,
	[dept_ID] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorAccount](
	[account_ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NOT NULL,
	[is_Manager] [bit] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_InstructorAccount] PRIMARY KEY CLUSTERED 
(
	[account_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intake]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intake](
	[intake_ID] [int] IDENTITY(1,1) NOT NULL,
	[year] [date] NOT NULL,
 CONSTRAINT [PK_Intake] PRIMARY KEY CLUSTERED 
(
	[intake_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MCQ Answers]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MCQ Answers](
	[MCQ_Answer_ID] [int] IDENTITY(1,1) NOT NULL,
	[MCQ_ID] [int] NOT NULL,
	[choice_ID] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MCQ Answers] PRIMARY KEY CLUSTERED 
(
	[MCQ_Answer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MCQ Choices]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MCQ Choices](
	[choice_ID] [int] IDENTITY(1,1) NOT NULL,
	[MCQ_ID] [int] NOT NULL,
	[choice_body] [nvarchar](100) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MCQ Choices] PRIMARY KEY CLUSTERED 
(
	[choice_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MCQ Question]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MCQ Question](
	[MCQ_ID] [int] NOT NULL,
	[Body] [nvarchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MCQ Question] PRIMARY KEY CLUSTERED 
(
	[MCQ_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[student_ID] [int] IDENTITY(1,1) NOT NULL,
	[first_Name] [nvarchar](50) NOT NULL,
	[last_Name] [nvarchar](50) NOT NULL,
	[account_ID] [int] NOT NULL,
	[intake_ID] [int] NOT NULL,
	[class_ID] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student Answers]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student Answers](
	[student_Answer_ID] [int] IDENTITY(1,1) NOT NULL,
	[student_ID] [int] NOT NULL,
	[exam_Question_ID] [int] NOT NULL,
	[answer] [nvarchar](50) NULL,
 CONSTRAINT [PK_Student Answers_1] PRIMARY KEY CLUSTERED 
(
	[student_Answer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAccount](
	[account_ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_StudentAccount] PRIMARY KEY CLUSTERED 
(
	[account_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T&F Questions]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T&F Questions](
	[T&F_ID] [int] NOT NULL,
	[Body] [nvarchar](100) NOT NULL,
	[Answer] [char](5) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_T&F Questions] PRIMARY KEY CLUSTERED 
(
	[T&F_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Text Question]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Text Question](
	[text_question_ID] [int] NOT NULL,
	[body] [nvarchar](100) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Text Question] PRIMARY KEY CLUSTERED 
(
	[text_question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Text Questions Keywords]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Text Questions Keywords](
	[keyword_ID] [int] IDENTITY(1,1) NOT NULL,
	[text_question_ID] [int] NOT NULL,
	[keyword] [nvarchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Text Questions Keywords] PRIMARY KEY CLUSTERED 
(
	[keyword_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[track_ID] [int] IDENTITY(1,1) NOT NULL,
	[track_Name] [nvarchar](50) NOT NULL,
	[dept_ID] [int] NOT NULL,
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TracksInBranches]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TracksInBranches](
	[track_In_Branch_ID] [int] IDENTITY(1,1) NOT NULL,
	[branch_ID] [int] NOT NULL,
	[track_ID] [int] NOT NULL,
 CONSTRAINT [PK_TracksInBranches_1] PRIMARY KEY CLUSTERED 
(
	[track_In_Branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Active Courses] ON 
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (1, 3, 1)
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (2, 4, 2)
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (3, 3, 3)
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (4, 2, 4)
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (5, 1, 5)
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (6, 7, 6)
GO
INSERT [dbo].[Active Courses] ([active_Course_ID], [course_ID], [instructor_ID]) VALUES (7, 5, 7)
GO
SET IDENTITY_INSERT [dbo].[Active Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[AdminAccount] ON 
GO
INSERT [dbo].[AdminAccount] ([admin_ID], [username], [password]) VALUES (1, N'admin', N'admin')
GO
SET IDENTITY_INSERT [dbo].[AdminAccount] OFF
GO
SET IDENTITY_INSERT [dbo].[Branch] ON 
GO
INSERT [dbo].[Branch] ([branch_ID], [branch_Name], [branch_Location]) VALUES (1, N'Assuit Branch', N'Assuit GOV')
GO
INSERT [dbo].[Branch] ([branch_ID], [branch_Name], [branch_Location]) VALUES (2, N'Cairo Branch', N'Cairo GOV')
GO
INSERT [dbo].[Branch] ([branch_ID], [branch_Name], [branch_Location]) VALUES (3, N'Minya Branch', N'Minya GOV')
GO
INSERT [dbo].[Branch] ([branch_ID], [branch_Name], [branch_Location]) VALUES (4, N'Alexandria Branch', N'Alexandria GOV')
GO
INSERT [dbo].[Branch] ([branch_ID], [branch_Name], [branch_Location]) VALUES (5, N'Qena Branch', N'Qena GOV')
GO
SET IDENTITY_INSERT [dbo].[Branch] OFF
GO
SET IDENTITY_INSERT [dbo].[Class] ON 
GO
INSERT [dbo].[Class] ([class_ID], [name], [intake_ID], [branch_ID]) VALUES (11, N'G1', 3, 1)
GO
INSERT [dbo].[Class] ([class_ID], [name], [intake_ID], [branch_ID]) VALUES (12, N'G2', 3, 1)
GO
INSERT [dbo].[Class] ([class_ID], [name], [intake_ID], [branch_ID]) VALUES (13, N'G3', 3, 1)
GO
INSERT [dbo].[Class] ([class_ID], [name], [intake_ID], [branch_ID]) VALUES (14, N'G1', 2, 3)
GO
INSERT [dbo].[Class] ([class_ID], [name], [intake_ID], [branch_ID]) VALUES (15, N'G2', 2, 3)
GO
SET IDENTITY_INSERT [dbo].[Class] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (1, N'Linux', N'System', 100, 60, 1)
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (2, N'HTML', N'Language', 100, 60, 3)
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (3, N'TCP/IP', N'Protocol', 100, 60, 4)
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (4, N'CSS', N'Language', 100, 60, 3)
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (5, N'High Current', N'Physics', 100, 60, 5)
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (6, N'CCSCO', N'Certificate', 100, 60, 4)
GO
INSERT [dbo].[Course] ([course_ID], [course_Name], [course_Description], [course_Max], [course_Min], [track_ID]) VALUES (7, N'Kids Content', N'Media', 100, 60, 2)
GO
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Course Classes] ON 
GO
INSERT [dbo].[Course Classes] ([course_Class_ID], [active_Course_ID], [class_ID]) VALUES (1, 5, 11)
GO
INSERT [dbo].[Course Classes] ([course_Class_ID], [active_Course_ID], [class_ID]) VALUES (2, 4, 11)
GO
INSERT [dbo].[Course Classes] ([course_Class_ID], [active_Course_ID], [class_ID]) VALUES (3, 2, 14)
GO
INSERT [dbo].[Course Classes] ([course_Class_ID], [active_Course_ID], [class_ID]) VALUES (4, 7, 15)
GO
INSERT [dbo].[Course Classes] ([course_Class_ID], [active_Course_ID], [class_ID]) VALUES (5, 4, 15)
GO
SET IDENTITY_INSERT [dbo].[Course Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[CourseEnrollment] ON 
GO
INSERT [dbo].[CourseEnrollment] ([enrollment_ID], [student_ID], [active_Course_ID], [start_Date], [end_Date]) VALUES (5, 2, 2, CAST(N'2019-01-01' AS Date), CAST(N'2018-03-01' AS Date))
GO
INSERT [dbo].[CourseEnrollment] ([enrollment_ID], [student_ID], [active_Course_ID], [start_Date], [end_Date]) VALUES (6, 3, 5, CAST(N'2018-04-01' AS Date), CAST(N'2018-06-01' AS Date))
GO
INSERT [dbo].[CourseEnrollment] ([enrollment_ID], [student_ID], [active_Course_ID], [start_Date], [end_Date]) VALUES (7, 4, 7, CAST(N'2020-07-05' AS Date), CAST(N'2020-08-05' AS Date))
GO
INSERT [dbo].[CourseEnrollment] ([enrollment_ID], [student_ID], [active_Course_ID], [start_Date], [end_Date]) VALUES (8, 5, 4, CAST(N'2020-01-01' AS Date), CAST(N'2020-02-01' AS Date))
GO
SET IDENTITY_INSERT [dbo].[CourseEnrollment] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([dept_ID], [dept_Name]) VALUES (1, N'SWE and Developemnt')
GO
INSERT [dbo].[Department] ([dept_ID], [dept_Name]) VALUES (2, N'IndusDB Systems')
GO
INSERT [dbo].[Department] ([dept_ID], [dept_Name]) VALUES (3, N'Information Systems')
GO
INSERT [dbo].[Department] ([dept_ID], [dept_Name]) VALUES (4, N'Infrastructure')
GO
INSERT [dbo].[Department] ([dept_ID], [dept_Name]) VALUES (5, N'Content Developement')
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Exam] ON 
GO
INSERT [dbo].[Exam] ([exam_ID], [type_ID], [exam_Max], [exam_Min], [instructor_ID], [active_Course_ID]) VALUES (1, 1, 100, 50, 1, 4)
GO
INSERT [dbo].[Exam] ([exam_ID], [type_ID], [exam_Max], [exam_Min], [instructor_ID], [active_Course_ID]) VALUES (2, 2, 100, 50, 2, 4)
GO
INSERT [dbo].[Exam] ([exam_ID], [type_ID], [exam_Max], [exam_Min], [instructor_ID], [active_Course_ID]) VALUES (3, 2, 90, 45, 5, 2)
GO
INSERT [dbo].[Exam] ([exam_ID], [type_ID], [exam_Max], [exam_Min], [instructor_ID], [active_Course_ID]) VALUES (4, 1, 80, 40, 6, 5)
GO
SET IDENTITY_INSERT [dbo].[Exam] OFF
GO
SET IDENTITY_INSERT [dbo].[Exam Questions] ON 
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (1, 1, 2, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (2, 1, 13, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (3, 1, 5, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (4, 1, 7, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (5, 1, 8, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (6, 2, 2, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (7, 2, 13, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (8, 2, 5, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (9, 2, 7, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (10, 2, 8, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (11, 3, 3, 30)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (12, 3, 14, 30)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (13, 3, 1, 30)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (14, 4, 4, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (15, 4, 13, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (16, 4, 6, 20)
GO
INSERT [dbo].[Exam Questions] ([exam_Question_ID], [exam_ID], [question_ID], [degree]) VALUES (17, 4, 8, 20)
GO
SET IDENTITY_INSERT [dbo].[Exam Questions] OFF
GO
SET IDENTITY_INSERT [dbo].[Exam Type] ON 
GO
INSERT [dbo].[Exam Type] ([type_ID], [type_Name]) VALUES (1, N'Exam')
GO
INSERT [dbo].[Exam Type] ([type_ID], [type_Name]) VALUES (2, N'Corrective')
GO
SET IDENTITY_INSERT [dbo].[Exam Type] OFF
GO
SET IDENTITY_INSERT [dbo].[Exams Taken] ON 
GO
INSERT [dbo].[Exams Taken] ([student_Exam_ID], [student_ID], [exam_ID], [degree], [Date]) VALUES (1, 2, 1, 20, CAST(N'2020-09-05' AS Date))
GO
INSERT [dbo].[Exams Taken] ([student_Exam_ID], [student_ID], [exam_ID], [degree], [Date]) VALUES (2, 3, 2, 60, CAST(N'2020-08-21' AS Date))
GO
INSERT [dbo].[Exams Taken] ([student_Exam_ID], [student_ID], [exam_ID], [degree], [Date]) VALUES (3, 5, 3, 90, CAST(N'2020-04-23' AS Date))
GO
INSERT [dbo].[Exams Taken] ([student_Exam_ID], [student_ID], [exam_ID], [degree], [Date]) VALUES (4, 7, 4, 40, CAST(N'2020-06-07' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Exams Taken] OFF
GO
SET IDENTITY_INSERT [dbo].[Instructor] ON 
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (1, N'Ahmed', N'Kamal', 1, 3, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (2, N'Samy', N'Nabil', 2, 1, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (3, N'Ramy', N'Gamal', 3, 4, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (4, N'Maged', N'Samey', 4, 1, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (5, N'Mohamed', N'Ahmed', 5, 3, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (6, N'Karim', N'Mohamed', 6, 5, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (7, N'Mostafa', N'Youssef', 7, 2, 0)
GO
INSERT [dbo].[Instructor] ([instructor_ID], [first_Name], [last_Name], [account_ID], [dept_ID], [isDeleted]) VALUES (8, N'Abdallah', N'Fahmy', 8, 3, 1)
GO
SET IDENTITY_INSERT [dbo].[Instructor] OFF
GO
SET IDENTITY_INSERT [dbo].[InstructorAccount] ON 
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (1, N'ahmed97', N'irfngrwif', 0, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (2, N'samy64', N'poerkprf', 0, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (3, N'ramy86', N'5tuij4f', 0, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (4, N'maged86', N'irjfiwerjfoi', 1, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (5, N'mohamed88', N'oprekrpe', 0, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (6, N'karim90', N'riejgireofj', 0, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (7, N'mostafa', N'riojrfsc', 0, 0)
GO
INSERT [dbo].[InstructorAccount] ([account_ID], [username], [password], [is_Manager], [isDeleted]) VALUES (8, N'ahmad', N'iaasas2dwa', 0, 1)
GO
SET IDENTITY_INSERT [dbo].[InstructorAccount] OFF
GO
SET IDENTITY_INSERT [dbo].[Intake] ON 
GO
INSERT [dbo].[Intake] ([intake_ID], [year]) VALUES (1, CAST(N'2018-01-01' AS Date))
GO
INSERT [dbo].[Intake] ([intake_ID], [year]) VALUES (2, CAST(N'2019-01-01' AS Date))
GO
INSERT [dbo].[Intake] ([intake_ID], [year]) VALUES (3, CAST(N'2020-01-01' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Intake] OFF
GO
SET IDENTITY_INSERT [dbo].[MCQ Answers] ON 
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (1, 1, 1, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (2, 2, 7, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (3, 3, 9, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (4, 4, 14, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (5, 5, 20, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (6, 6, 23, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (7, 7, 25, 0)
GO
INSERT [dbo].[MCQ Answers] ([MCQ_Answer_ID], [MCQ_ID], [choice_ID], [isDeleted]) VALUES (9, 22, 33, 0)
GO
SET IDENTITY_INSERT [dbo].[MCQ Answers] OFF
GO
SET IDENTITY_INSERT [dbo].[MCQ Choices] ON 
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (1, 1, N'Paragraph', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (2, 1, N'Padding', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (3, 1, N'Parser', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (4, 1, N'Position', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (5, 2, N'Flex', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (6, 2, N'Inline', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (7, 2, N'Block', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (8, 2, N'Inline-Block', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (9, 3, N'Hypertext Markup Language', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (10, 3, N'Hugetext Markup Language', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (11, 3, N'Hypertext Madeup Language', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (12, 3, N'Hypertags Markup Language', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (13, 4, N'Transmited Control Programming', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (14, 4, N'Transmission Control Protocol', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (15, 4, N'Transmission Coded Protocol', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (16, 4, N'Transmission Centralized Protocol', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (17, 5, N'3', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (18, 5, N'6', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (19, 5, N'5', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (20, 5, N'4', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (21, 6, N'W', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (22, 6, N'T', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (23, 6, N'Z', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (24, 6, N'L', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (25, 7, N'Yes, all the time', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (26, 7, N'Not at all', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (27, 7, N'Depending on conditions', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (28, 7, N'Only in vaccum', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (33, 22, N'All of these options can be used with an anchor', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (34, 22, N'href=""', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (35, 22, N'style=""', 0)
GO
INSERT [dbo].[MCQ Choices] ([choice_ID], [MCQ_ID], [choice_body], [isDeleted]) VALUES (36, 22, N'display=""', 0)
GO
SET IDENTITY_INSERT [dbo].[MCQ Choices] OFF
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (1, N'What does <p> mean?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (2, N'What is the default display of a <div>?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (3, N'What does HTML stand for?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (4, N'What does TCP/IP stand for?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (5, N'How many layers are there in TCP/IP?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (6, N'What is the last letter in the alphabet?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (7, N'Does current affect voltage?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (22, N'Which of the following can be used with <a> tag?', 0)
GO
INSERT [dbo].[MCQ Question] ([MCQ_ID], [Body], [isDeleted]) VALUES (23, N'Which of the following can be used with <a> tag?', 0)
GO
SET IDENTITY_INSERT [dbo].[Student] ON 
GO
INSERT [dbo].[Student] ([student_ID], [first_Name], [last_Name], [account_ID], [intake_ID], [class_ID], [isDeleted]) VALUES (1, N'Amr', N'farag', 1, 1, 13, 0)
GO
INSERT [dbo].[Student] ([student_ID], [first_Name], [last_Name], [account_ID], [intake_ID], [class_ID], [isDeleted]) VALUES (2, N'serag', N'ramy', 2, 1, 13, 0)
GO
INSERT [dbo].[Student] ([student_ID], [first_Name], [last_Name], [account_ID], [intake_ID], [class_ID], [isDeleted]) VALUES (3, N'soha', N'hamid', 3, 3, 13, 0)
GO
INSERT [dbo].[Student] ([student_ID], [first_Name], [last_Name], [account_ID], [intake_ID], [class_ID], [isDeleted]) VALUES (4, N'samar', N'hassan', 4, 2, 13, 0)
GO
INSERT [dbo].[Student] ([student_ID], [first_Name], [last_Name], [account_ID], [intake_ID], [class_ID], [isDeleted]) VALUES (5, N'sarhan', N'samir', 5, 3, 13, 0)
GO
INSERT [dbo].[Student] ([student_ID], [first_Name], [last_Name], [account_ID], [intake_ID], [class_ID], [isDeleted]) VALUES (7, N'Ahmad', N'Salah', 8, 3, 12, 0)
GO
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Student Answers] ON 
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (1, 2, 1, N'False')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (2, 2, 2, N'Html')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (3, 2, 3, N'Block')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (4, 2, 4, N'False')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (5, 2, 5, N'False')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (6, 3, 6, N'Block')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (7, 3, 7, N'True')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (8, 3, 8, N'3')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (9, 3, 9, N'no')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (10, 3, 10, N'False')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (11, 5, 11, N'Hypertext Markup Language')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (12, 5, 12, N'False')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (13, 5, 13, N'Paragraph')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (14, 7, 14, N'Transmission Control Protocol')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (15, 7, 15, N'False')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (16, 7, 16, N'Paragraph')
GO
INSERT [dbo].[Student Answers] ([student_Answer_ID], [student_ID], [exam_Question_ID], [answer]) VALUES (17, 7, 17, N'False')
GO
SET IDENTITY_INSERT [dbo].[Student Answers] OFF
GO
SET IDENTITY_INSERT [dbo].[StudentAccount] ON 
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (1, N'Sfarag22', N'asubyat', 0)
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (2, N'Sramy92', N'pawegpawf', 0)
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (3, N'Snada81', N'asferghd', 0)
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (4, N'Samr57', N'fsdiufde', 0)
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (5, N'Ssamir28', N'fsgjyuky', 0)
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (6, N'Skamal92', N'zxcwdasz', 0)
GO
INSERT [dbo].[StudentAccount] ([account_ID], [username], [password], [isDeleted]) VALUES (8, N'Sahmad', N'ias7q27bda', 0)
GO
SET IDENTITY_INSERT [dbo].[StudentAccount] OFF
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (8, N'<img> tag should always have a closing tag', N'False', 0)
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (9, N'You can use inline CSS', N'True ', 0)
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (10, N'Using semantic tags in HTML is always preferable', N'True ', 0)
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (11, N'Current is proportional to Resistance', N'False', 0)
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (12, N'You get orange by mixing yellow and white', N'False', 0)
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (13, N'343 m/s is the speed of sound', N'True ', 0)
GO
INSERT [dbo].[T&F Questions] ([T&F_ID], [Body], [Answer], [isDeleted]) VALUES (14, N'You can not put a span inside another span', N'False', 0)
GO
INSERT [dbo].[Text Question] ([text_question_ID], [body], [isDeleted]) VALUES (15, N'What are some the style attributes you can use in CSS?', 0)
GO
INSERT [dbo].[Text Question] ([text_question_ID], [body], [isDeleted]) VALUES (16, N'What are meta tags in HTML?', 0)
GO
INSERT [dbo].[Text Question] ([text_question_ID], [body], [isDeleted]) VALUES (17, N'What are some the semantic tags in HTML', 0)
GO
INSERT [dbo].[Text Question] ([text_question_ID], [body], [isDeleted]) VALUES (18, N'What are the benefits of Linux?', 0)
GO
INSERT [dbo].[Text Question] ([text_question_ID], [body], [isDeleted]) VALUES (19, N'What are the colors of a rainbow?', 0)
GO
INSERT [dbo].[Text Question] ([text_question_ID], [body], [isDeleted]) VALUES (20, N'What is the relation between current and resistance?', 0)
GO
SET IDENTITY_INSERT [dbo].[Text Questions Keywords] ON 
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (1, 15, N'color', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (2, 15, N'padding', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (3, 15, N'border', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (4, 15, N'margin', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (5, 15, N'background', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (6, 15, N'position', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (7, 15, N'float', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (8, 15, N'top', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (9, 15, N'left', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (10, 15, N'width', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (11, 15, N'height', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (12, 15, N'font', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (13, 16, N'information', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (14, 16, N'describe', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (15, 16, N'search engine', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (16, 16, N'define', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (17, 16, N'head', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (18, 16, N'hidden', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (19, 17, N'article', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (20, 17, N'aside', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (21, 17, N'header', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (22, 17, N'footer', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (23, 17, N'main', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (24, 17, N'mark', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (25, 17, N'nav', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (26, 17, N'section', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (27, 17, N'summary', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (28, 17, N'details', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (29, 18, N'consistent', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (30, 18, N'Scalability', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (31, 18, N'open', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (32, 18, N'source', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (33, 18, N'management', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (34, 18, N'package', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (35, 19, N'red', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (36, 19, N'orange', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (37, 19, N'yellow', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (38, 19, N'green', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (39, 19, N'blue', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (40, 19, N'indigo', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (41, 19, N'violet', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (42, 20, N'rate', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (43, 20, N'flow', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (44, 20, N'tendency', 0)
GO
INSERT [dbo].[Text Questions Keywords] ([keyword_ID], [text_question_ID], [keyword], [isDeleted]) VALUES (45, 20, N'ohm', 0)
GO
SET IDENTITY_INSERT [dbo].[Text Questions Keywords] OFF
GO
SET IDENTITY_INSERT [dbo].[Track] ON 
GO
INSERT [dbo].[Track] ([track_ID], [track_Name], [dept_ID]) VALUES (1, N'Adminstration', 3)
GO
INSERT [dbo].[Track] ([track_ID], [track_Name], [dept_ID]) VALUES (2, N'E-learning', 5)
GO
INSERT [dbo].[Track] ([track_ID], [track_Name], [dept_ID]) VALUES (3, N'UI/UX Developemnt', 1)
GO
INSERT [dbo].[Track] ([track_ID], [track_Name], [dept_ID]) VALUES (4, N'Networks', 4)
GO
INSERT [dbo].[Track] ([track_ID], [track_Name], [dept_ID]) VALUES (5, N'Power Systems', 2)
GO
SET IDENTITY_INSERT [dbo].[Track] OFF
GO
SET IDENTITY_INSERT [dbo].[TracksInBranches] ON 
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (1, 1, 3)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (2, 2, 1)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (3, 3, 4)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (4, 4, 3)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (5, 5, 2)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (6, 1, 1)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (7, 2, 3)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (8, 3, 3)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (9, 4, 2)
GO
INSERT [dbo].[TracksInBranches] ([track_In_Branch_ID], [branch_ID], [track_ID]) VALUES (10, 5, 4)
GO
SET IDENTITY_INSERT [dbo].[TracksInBranches] OFF
GO
ALTER TABLE [dbo].[Instructor] ADD  CONSTRAINT [DF_Instructor_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[InstructorAccount] ADD  CONSTRAINT [DF_InstructorAccount_is_Manager]  DEFAULT ((0)) FOR [is_Manager]
GO
ALTER TABLE [dbo].[InstructorAccount] ADD  CONSTRAINT [DF_InstructorAccount_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[MCQ Answers] ADD  CONSTRAINT [DF_MCQ Answers_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[MCQ Choices] ADD  CONSTRAINT [DF_MCQ Choices_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[MCQ Question] ADD  CONSTRAINT [DF_MCQ Question_Body]  DEFAULT ((0)) FOR [Body]
GO
ALTER TABLE [dbo].[MCQ Question] ADD  CONSTRAINT [DF_MCQ Question_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[StudentAccount] ADD  CONSTRAINT [DF_StudentAccount_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[T&F Questions] ADD  CONSTRAINT [DF_T&F Questions_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Text Question] ADD  CONSTRAINT [DF_Text Question_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Text Questions Keywords] ADD  CONSTRAINT [DF_Text Questions Keywords_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Active Courses]  WITH CHECK ADD  CONSTRAINT [FK_Active Courses_Course] FOREIGN KEY([course_ID])
REFERENCES [dbo].[Course] ([course_ID])
GO
ALTER TABLE [dbo].[Active Courses] CHECK CONSTRAINT [FK_Active Courses_Course]
GO
ALTER TABLE [dbo].[Active Courses]  WITH CHECK ADD  CONSTRAINT [FK_Active Courses_Instructor] FOREIGN KEY([instructor_ID])
REFERENCES [dbo].[Instructor] ([instructor_ID])
GO
ALTER TABLE [dbo].[Active Courses] CHECK CONSTRAINT [FK_Active Courses_Instructor]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Branch] FOREIGN KEY([branch_ID])
REFERENCES [dbo].[Branch] ([branch_ID])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_Branch]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_Intake] FOREIGN KEY([intake_ID])
REFERENCES [dbo].[Intake] ([intake_ID])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_Intake]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Track] FOREIGN KEY([track_ID])
REFERENCES [dbo].[Track] ([track_ID])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Track]
GO
ALTER TABLE [dbo].[Course Classes]  WITH CHECK ADD  CONSTRAINT [FK_Course Classes_Active Courses] FOREIGN KEY([active_Course_ID])
REFERENCES [dbo].[Active Courses] ([active_Course_ID])
GO
ALTER TABLE [dbo].[Course Classes] CHECK CONSTRAINT [FK_Course Classes_Active Courses]
GO
ALTER TABLE [dbo].[Course Classes]  WITH CHECK ADD  CONSTRAINT [FK_Course Classes_Class] FOREIGN KEY([class_ID])
REFERENCES [dbo].[Class] ([class_ID])
GO
ALTER TABLE [dbo].[Course Classes] CHECK CONSTRAINT [FK_Course Classes_Class]
GO
ALTER TABLE [dbo].[CourseEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_CourseEnrollment_Active Courses] FOREIGN KEY([active_Course_ID])
REFERENCES [dbo].[Active Courses] ([active_Course_ID])
GO
ALTER TABLE [dbo].[CourseEnrollment] CHECK CONSTRAINT [FK_CourseEnrollment_Active Courses]
GO
ALTER TABLE [dbo].[CourseEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_CourseEnrollment_Student] FOREIGN KEY([student_ID])
REFERENCES [dbo].[Student] ([student_ID])
GO
ALTER TABLE [dbo].[CourseEnrollment] CHECK CONSTRAINT [FK_CourseEnrollment_Student]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Active Courses] FOREIGN KEY([active_Course_ID])
REFERENCES [dbo].[Active Courses] ([active_Course_ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Active Courses]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Exam Type] FOREIGN KEY([type_ID])
REFERENCES [dbo].[Exam Type] ([type_ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Exam Type]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Instructor] FOREIGN KEY([instructor_ID])
REFERENCES [dbo].[Instructor] ([instructor_ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Instructor]
GO
ALTER TABLE [dbo].[Exam Questions]  WITH CHECK ADD  CONSTRAINT [FK_Exam Questions_Exam] FOREIGN KEY([exam_ID])
REFERENCES [dbo].[Exam] ([exam_ID])
GO
ALTER TABLE [dbo].[Exam Questions] CHECK CONSTRAINT [FK_Exam Questions_Exam]
GO
ALTER TABLE [dbo].[Exams Taken]  WITH CHECK ADD  CONSTRAINT [FK_Take Exam_Exam] FOREIGN KEY([exam_ID])
REFERENCES [dbo].[Exam] ([exam_ID])
GO
ALTER TABLE [dbo].[Exams Taken] CHECK CONSTRAINT [FK_Take Exam_Exam]
GO
ALTER TABLE [dbo].[Exams Taken]  WITH CHECK ADD  CONSTRAINT [FK_Take Exam_Student] FOREIGN KEY([student_ID])
REFERENCES [dbo].[Student] ([student_ID])
GO
ALTER TABLE [dbo].[Exams Taken] CHECK CONSTRAINT [FK_Take Exam_Student]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Department] FOREIGN KEY([dept_ID])
REFERENCES [dbo].[Department] ([dept_ID])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [FK_Instructor_Department]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_InstructorAccount] FOREIGN KEY([account_ID])
REFERENCES [dbo].[InstructorAccount] ([account_ID])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [FK_Instructor_InstructorAccount]
GO
ALTER TABLE [dbo].[MCQ Answers]  WITH CHECK ADD  CONSTRAINT [FK_MCQ Answers_MCQ Choices] FOREIGN KEY([choice_ID])
REFERENCES [dbo].[MCQ Choices] ([choice_ID])
GO
ALTER TABLE [dbo].[MCQ Answers] CHECK CONSTRAINT [FK_MCQ Answers_MCQ Choices]
GO
ALTER TABLE [dbo].[MCQ Answers]  WITH CHECK ADD  CONSTRAINT [FK_MCQ Answers_MCQ Question] FOREIGN KEY([MCQ_ID])
REFERENCES [dbo].[MCQ Question] ([MCQ_ID])
GO
ALTER TABLE [dbo].[MCQ Answers] CHECK CONSTRAINT [FK_MCQ Answers_MCQ Question]
GO
ALTER TABLE [dbo].[MCQ Choices]  WITH CHECK ADD  CONSTRAINT [FK_MCQ Choices_MCQ Question] FOREIGN KEY([MCQ_ID])
REFERENCES [dbo].[MCQ Question] ([MCQ_ID])
GO
ALTER TABLE [dbo].[MCQ Choices] CHECK CONSTRAINT [FK_MCQ Choices_MCQ Question]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Class] FOREIGN KEY([class_ID])
REFERENCES [dbo].[Class] ([class_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Class]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Intake] FOREIGN KEY([intake_ID])
REFERENCES [dbo].[Intake] ([intake_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Intake]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_StudentAccount] FOREIGN KEY([account_ID])
REFERENCES [dbo].[StudentAccount] ([account_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_StudentAccount]
GO
ALTER TABLE [dbo].[Student Answers]  WITH CHECK ADD  CONSTRAINT [FK_Student Answers_Exam Questions1] FOREIGN KEY([exam_Question_ID])
REFERENCES [dbo].[Exam Questions] ([exam_Question_ID])
GO
ALTER TABLE [dbo].[Student Answers] CHECK CONSTRAINT [FK_Student Answers_Exam Questions1]
GO
ALTER TABLE [dbo].[Student Answers]  WITH CHECK ADD  CONSTRAINT [FK_Student Answers_Student] FOREIGN KEY([student_ID])
REFERENCES [dbo].[Student] ([student_ID])
GO
ALTER TABLE [dbo].[Student Answers] CHECK CONSTRAINT [FK_Student Answers_Student]
GO
ALTER TABLE [dbo].[Text Questions Keywords]  WITH CHECK ADD  CONSTRAINT [FK_Text Questions Keywords_Text Question] FOREIGN KEY([text_question_ID])
REFERENCES [dbo].[Text Question] ([text_question_ID])
GO
ALTER TABLE [dbo].[Text Questions Keywords] CHECK CONSTRAINT [FK_Text Questions Keywords_Text Question]
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD  CONSTRAINT [FK_Track_Department] FOREIGN KEY([dept_ID])
REFERENCES [dbo].[Department] ([dept_ID])
GO
ALTER TABLE [dbo].[Track] CHECK CONSTRAINT [FK_Track_Department]
GO
ALTER TABLE [dbo].[TracksInBranches]  WITH CHECK ADD  CONSTRAINT [FK_TracksInBranches_Branch] FOREIGN KEY([branch_ID])
REFERENCES [dbo].[Branch] ([branch_ID])
GO
ALTER TABLE [dbo].[TracksInBranches] CHECK CONSTRAINT [FK_TracksInBranches_Branch]
GO
ALTER TABLE [dbo].[TracksInBranches]  WITH CHECK ADD  CONSTRAINT [FK_TracksInBranches_Track] FOREIGN KEY([track_ID])
REFERENCES [dbo].[Track] ([track_ID])
GO
ALTER TABLE [dbo].[TracksInBranches] CHECK CONSTRAINT [FK_TracksInBranches_Track]
GO
/****** Object:  StoredProcedure [dbo].[usp_Add_Instructor]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Add_Instructor] (@instructorUsername nvarchar(50), @instructorPassword nvarchar(50), @ismanager int, @first_Name nvarchar(50), @last_Name nvarchar(50), @dept_Name nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'M')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	begin tran Add_Instructor_Tran
		begin try
			exec [dbo].[usp_Insert_InstructorAccount] @instructorUsername, @instructorPassword, @ismanager
			exec [dbo].[usp_Insert_Instructor] @first_Name, @last_Name, @instructorUsername, @dept_Name
				commit tran
		end try
		begin catch
			rollback tran
			return -3
		end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Add_MCQ]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Add_MCQ] (@questionBody nvarchar(100), @choiceBodyTrue nvarchar(100), @choiceBodyFalse1 nvarchar(100), @choiceBodyFalse2 nvarchar(100), @choiceBodyFalse3 nvarchar(100), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'I')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	begin tran Add_Instructor_Tran
		begin try
			exec [dbo].[usp_Insert_MCQQuestion] @questionBody
			exec [dbo].[usp_Insert_MCQChoice] @questionBody, @choiceBodyTrue
			exec [dbo].[usp_Insert_MCQChoice] @questionBody, @choiceBodyFalse1
			exec [dbo].[usp_Insert_MCQChoice] @questionBody, @choiceBodyFalse2
			exec [dbo].[usp_Insert_MCQChoice] @questionBody, @choiceBodyFalse3
			exec [dbo].[usp_Insert_MCQAnswers] @questionBody, @choiceBodyTrue
			commit tran
		end try
		begin catch
			rollback tran
			return -3
		end catch
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Add_Student]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Add_Student] (@studentUsername nvarchar(50), @studentPassword nvarchar(50), @studentFirstName nvarchar(50), @studentLastName nvarchar(50), @intakeYear date, @className nvarchar(50), @branchName nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'M')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	begin tran Add_Student_Tran
		begin try
			exec [dbo].[usp_Insert_StudentAccount] @studentUsername, @studentPassword
			exec [dbo].[usp_Insert_Student] @studentFirstName, @studentLastName, @studentUsername, @intakeYear, @className, @branchName
			commit tran
		end try
		begin catch
			rollback tran
			return -3
		end catch
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Add_TxtQuestion]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Add_TxtQuestion] (@questionBody nvarchar(100), @keywordBody1 nvarchar(100), @keywordBody2 nvarchar(100), @keywordBody3 nvarchar(100), @keywordBody4 nvarchar(100), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'I')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	begin tran Add_Instructor_Tran
		begin try
			exec [dbo].[usp_Insert_TextQuestion] @questionBody
			exec [dbo].[usp_Insert_TextQuestionKeyword] @questionBody, @keywordBody1, @username, @password
			exec [dbo].[usp_Insert_TextQuestionKeyword] @questionBody, @keywordBody2, @username, @password
			exec [dbo].[usp_Insert_TextQuestionKeyword] @questionBody, @keywordBody3, @username, @password
			exec [dbo].[usp_Insert_TextQuestionKeyword] @questionBody, @keywordBody4, @username, @password
			commit tran
		end try
		begin catch
			rollback tran
			return -3
		end catch
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_ActiveCourses]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Active Course Table


CREATE proc [dbo].[usp_Insert_ActiveCourses] (@course_Name nvarchar(50), @instructor_Username nvarchar(50), @username nvarchar(30), @password nvarchar(30))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'M')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
set @err1 = (
select ic.[isDeleted]
from [dbo].[InstructorAccount] ic
where [username] = @instructor_Username
)
if (@err1 = 1)
	return -3
insert into [Active Courses]
values ( 
(select course_ID
from Course
where course_Name = @course_Name),
(select i.instructor_ID
from InstructorAccount ic
join Instructor i
on ic.account_ID = i.account_ID
where ic.username = @instructor_Username
)) 
return @@error
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Admin]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Insert_Admin] (@username nvarchar(30), @password nvarchar(30))
as
begin
insert into [dbo].[AdminAccount]
values (@username, @password)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Branch]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Branch Table

CREATE proc [dbo].[usp_Insert_Branch] (@name nvarchar(50), @location nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'M')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into Branch
values (@name, @location)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Class]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_Class] (@name nvarchar(50), @intake date, @branch nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'M')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into [dbo].[Class]
values (@name, 
(select [intake_ID]
from [dbo].[Intake] I
where I.[year] = @intake),
(select [branch_ID]
from [dbo].[Branch] B
where B.[branch_Name] = @branch)) 
return @@error
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Course]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Cousre Table
CREATE proc [dbo].[usp_Insert_Course] (@course_Name nvarchar(50), @course_desc nvarchar(50), @max_deg int, @min_deg int, @track_Name nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'M')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into Course
values (@course_Name, @course_desc, @max_deg, @min_deg, 
(select track_ID 
from Track 
where track_Name = @track_Name))
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_courseClasses]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_courseClasses](@courseName nvarchar(50), @className nvarchar(50), @branchName nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'M')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into [dbo].[Course Classes] 
values (
(select A.[active_Course_ID] 
from [dbo].[Active Courses] A join [dbo].[Course] C
on A.[course_ID] = C.[course_ID]
where C.[course_Name] = @courseName),
	
(select [class_ID]
from [dbo].[Class] C join [dbo].[Branch] B
on C.[branch_ID] = B.[branch_ID] 
where B.[branch_Name] = @branchName and C.[name] = @className) )
return @@error	
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_CourseEnrollment]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_CourseEnrollment](@studentUsername nvarchar(50), @courseName nvarchar(50), @startDate date, @endDate date, @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'I')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
set @err1 = (
select A.[isDeleted]
from [dbo].[StudentAccount] A
where [username] = @studentUsername
)
if (@err1 = 1)
	return -3
insert into [dbo].[CourseEnrollment] 
values ( 
(select [student_ID] 
from [dbo].[Student] S JOIN [dbo].[StudentAccount] A
ON S.[account_ID] = A.[account_ID] WHERE A.[username] = @studentUsername),
(select A.[active_Course_ID] 
from [dbo].[Active Courses] A join [dbo].[Course] C
on A.[course_ID] = C.[course_ID] 
where C.[course_Name] = @courseName),
	  @startDate, @endDate)
return @@error	
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Department]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Department Table

CREATE proc [dbo].[usp_Insert_Department] (@name nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2)
	return -2
insert into Department
values (@name)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Exam]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Insert_Exam]
(@examTypeName nvarchar(50), @examMax int, @examMin int, @instructorUsername nvarchar(50), @activeCourseID int, @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'I')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	declare @course_Max int
	select @course_Max = c.course_Max from Course c
	join [Active Courses] ac
	on ac.course_ID = c.course_ID
	where ac.active_Course_ID = @activeCourseID
	declare @course_Max_Cumulative int
	select @course_Max_Cumulative  = sum(exam_Max) 
	from Exam e 
	where e.active_Course_ID = @activeCourseID
	if ( ISNULL(@course_Max_Cumulative, 0) < @course_Max)
	begin
		insert into [dbo].[Exam] 
		values (
		(select [type_ID] 
		from [dbo].[Exam Type] 
		where [type_Name] = @examTypeName),
			@examMax, @examMin,
		(select [instructor_ID] 
		from [dbo].[Instructor] i join [dbo].[InstructorAccount] ic
		on i.[account_ID] = ic.[account_ID] 
		where ic.[username] = @instructorUsername),
		@activeCourseID)
		return @@error	
	end
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_ExamQS]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_ExamQS](@exam_ID int, @question_ID int, @question_Degree int, @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'I')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	declare @check1 int
	declare @check2 int 
	declare @check3 int

	if exists (select text_question_ID from [Text Question] where text_question_ID=@question_ID)
	set @check1 = 1
	if exists (select [T&F_ID] from [T&F Questions] where [T&F_ID] = @question_ID)
	set @check2 = 1
	if exists (select MCQ_ID from [MCQ Question] where MCQ_ID = @question_ID )
	set @check3 = 1

	declare @max int
	select @max =  exam_Max from Exam where exam_ID = @exam_ID

	declare @sum int
	select @sum = ISNULL((select sum(degree) from [Exam Questions] group by (exam_ID) having exam_ID = @exam_ID ), 0)


	if(@check1 = 1 or @check2 = 1 or @check3 = 1) 
	begin
		if(@sum < @max)
			insert into [dbo].[Exam Questions] 
			values (@exam_ID,@question_ID,@question_Degree)
		
	end
return @@error
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_ExamTaken]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_ExamTaken](@studentUsername nvarchar(50), @exam_ID int,@Date date, @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'I')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	declare @degree int = 0

	declare @numberOfQuestions int 
	select @numberOfQuestions =  COUNT(*) from [Exam Questions]where exam_ID = @exam_ID
	declare @start int  
	select @start = Min(exam_Question_ID) FROM [Exam Questions] where exam_ID = @exam_ID

	declare @end int  
	select @end = Max(exam_Question_ID) FROM [Exam Questions] where exam_ID = @exam_ID
 


	while(@start <= @end)
	begin
		declare @rightAnswer nvarchar(50)
		declare @studentAnswer nvarchar(50)
		declare @questionID nvarchar(10)
		select @questionID = question_ID from [Exam Questions] where exam_Question_ID = @start
		declare @questionType nvarchar(10)
		if exists (select * from [MCQ Question] where MCQ_ID = @questionID)
			set @questionType = 'MCQ'

		if exists (select * from [T&F Questions] where [T&F_ID] = @questionID)
			set @questionType = 'T&F'

		if(@questionType = 'MCQ')
		begin
			select @rightAnswer = c.choice_body from [MCQ Answers] a 
			join [MCQ Choices] c on a.choice_ID = c.choice_ID
			where a.MCQ_ID = (select question_ID from [Exam Questions] where exam_Question_ID = @start)
		
			select @studentAnswer = answer from [Student Answers] where exam_Question_ID = @start

			if(@studentAnswer = @rightAnswer)
			begin
				set @degree = @degree + (select degree from [Exam Questions] 
				where exam_Question_ID = @start)
			
			end
		end

		if(@questionType = 'T&F')
		begin
			select @rightAnswer = Answer from [T&F Questions] 
			where [T&F_ID] = (select question_ID from [Exam Questions] where exam_Question_ID = @start)

			select @studentAnswer = answer from [Student Answers] where exam_Question_ID = @start

			if(@studentAnswer = @rightAnswer)
			begin
				set @degree = @degree + (select degree from [Exam Questions] 
				where exam_Question_ID = @start)
			
			end
		end
		set @start  = @start + 1
	end

insert into [Exams Taken]
values(
(select s.student_ID from StudentAccount ac
join Student s
on ac.account_ID = s.account_ID
where ac.username = @studentUsername),
@exam_ID,
@degree,
@Date
)


return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_ExamType]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_ExamType](@examType nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
		select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2)
		return -2
	insert into [dbo].[Exam Type]
	values (@examType)
	return @@error
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Instructor]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Instructor Table

CREATE proc [dbo].[usp_Insert_Instructor] (@first_Name nvarchar(50), @last_Name nvarchar(50), @instructorUsername nvarchar(50), @dept_Name nvarchar(50))
as
begin
insert into Instructor
values (@first_Name, @last_Name, 
(select account_ID
from InstructorAccount
where username = @instructorUsername),
(select dept_ID
from Department
where dept_Name = @dept_Name
)) 
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_InstructorAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--Instructor Account

CREATE proc [dbo].[usp_Insert_InstructorAccount] (@instructorUsername nvarchar(50), @instructorPassword nvarchar(50), @ismanager int)
as
begin
insert into InstructorAccount
values (@instructorUsername, @instructorPassword, @ismanager) 
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Intake]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_Intake] (@year date, @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'M')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into [dbo].[Intake]
values (@year)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_MCQAnswers]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--MCQ Answers Table
CREATE proc [dbo].[usp_Insert_MCQAnswers] (@body nvarchar(100),@correct_Choice nvarchar(100))
as
begin
insert into [dbo].[MCQ Answers]
values (
(select [MCQ_ID]
from [dbo].[MCQ Question] Q
where Q.[Body] = @body)
,(select [choice_ID]
from [dbo].[MCQ Choices] C
where C.[choice_body] = @correct_Choice))
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_MCQChoice]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--MCQ Choices Table
CREATE proc [dbo].[usp_Insert_MCQChoice] (@body nvarchar(100),@choiceBody nvarchar(100))
as
begin
insert into [dbo].[MCQ Choices]
values (
(select [MCQ_ID]
from [dbo].[MCQ Question] Q
where Q.[Body] = @body)
,@choiceBody)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_MCQQuestion]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--MCQ Question Table
CREATE proc [dbo].[usp_Insert_MCQQuestion] (@body nvarchar(100))
as
begin
insert into [dbo].[MCQ Question]
values (next value for QuestionSequence ,@body)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Student]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Insert_Student]
(@studentFirstName nvarchar(50), @studentLastName nvarchar(50), @studentUsername nvarchar(50), @intakeYear date, @className nvarchar(50), @branchName nvarchar(50))
as
begin
insert into [dbo].[Student] 
values (@studentFirstName, @studentLastName,
(select [account_ID] 
from [dbo].[StudentAccount] 
where [username] = @studentUsername),
(select [intake_ID] 
from [dbo].[Intake] 
where [year] = @intakeYear),
(select [class_ID] 
from [dbo].[Class] 
where [name] = @className
AND [intake_ID] = 
(select [intake_ID] 
from [dbo].[Intake] 
where [year] = @intakeYear)
AND [branch_ID] = 
(select [branch_ID]
from [dbo].[Branch]
where [branch_Name] = @branchName)))
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_StudentAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Student Account table

CREATE proc [dbo].[usp_Insert_StudentAccount] (@studentUsername nvarchar(50), @studentPassword nvarchar(50))
as
begin
insert into [dbo].[StudentAccount]
values (@studentUsername, @studentPassword) 
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_StudentAnswers]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Insert_StudentAnswers]
(@studentUsername NVARCHAR(50), @EQ_ID int, @Answer NVARCHAR(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
	select dbo.udf_Account_Validate(@username, @password,'S')
)
declare @err2 int = 
(
	select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into [dbo].[Student Answers] 
values ( 
(select S.[student_ID] 
from [dbo].[Student] S JOIN  [dbo].[StudentAccount] A
on S.[account_ID] = A.[account_ID] 
where A.[username] = @studentUsername),
@EQ_ID, @Answer)
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_TextQuestion]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Text Question Table
CREATE proc [dbo].[usp_Insert_TextQuestion] (@body nvarchar(100))
as
begin
insert into [dbo].[Text Question]
values (next value for QuestionSequence ,@body)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_TextQuestionKeyword]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--Text Question Keywords Table
CREATE proc [dbo].[usp_Insert_TextQuestionKeyword] (@body nvarchar(100) ,@keyword Nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'I')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
insert into [dbo].[Text Questions Keywords]
values (
(select [text_question_ID]
from [dbo].[Text Question] Q
where Q.[body] = @body)
,@keyword)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_TFQuestion]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--T&F Questions Table
CREATE proc [dbo].[usp_Insert_TFQuestion] (@body nvarchar(100),@answer char(5), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'I')
)
declare @err2 int = 
(
 select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2 AND @err2 = -2)
	return -2
if not(@answer = 'T' OR @answer = 'True')
	set @answer = 'False'
else set @answer = 'True'
insert into [dbo].[T&F Questions]
values (next value for QuestionSequence ,@body ,@answer)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Track]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Track Table

CREATE proc [dbo].[usp_Insert_Track] (@track_Name nvarchar(50),@department_Name nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
	select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2)
	return -2
insert into Track
values (@track_Name,
(select dept_ID 
from Department 
where dept_Name = @department_Name))
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_TracksInBranches]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tracks in Branches table


CREATE proc [dbo].[usp_Insert_TracksInBranches] (@branch_Name nvarchar(50), @track_Name nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
declare @err1 int = 
(
	select dbo.udf_Account_Validate(@username, @password,'A')
)
if(@err1 = -2)
	return -2
insert into TracksInBranches
values (
(select branch_ID 
from Branch 
where branch_Name = @branch_Name),
(select track_ID 
from Track
where track_Name = @track_Name)
)
return @@error
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Show_Question_Pool]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_Show_Question_Pool] (@question_Type nvarchar(30), @username nvarchar(30), @password nvarchar(30))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'I')
	)
	declare @err2 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2 AND @err2 = -2)
		return -2
	if(@question_Type = 'TF')
		select [Body] 'Question Body', [Answer]
		from [dbo].[T&F Questions]
		where [isDeleted] <> 1
	else if(@question_Type = 'MCQ')
		select Q.[Body] 'Question Body', C.[choice_body] 'Correct Answer'
		from [dbo].[MCQ Question] Q inner join [dbo].[MCQ Answers] A
		on Q.[MCQ_ID] = A.[MCQ_ID]
		inner join [dbo].[MCQ Choices] C
		on C.[choice_ID] = A.[choice_ID]
		where Q.[isDeleted] <> 1
	else if(@question_Type = 'Text')
	begin
		DECLARE @Textq TABLE
		(
		  body nvarchar(100),
		  keywords nvarchar(200)
		)

		declare @start int
		select @start = min(text_question_ID)from [Text Question] where [isDeleted] <> 1

		declare @end int
		select @end = max(text_question_ID)from [Text Question] where [isDeleted] <> 1 

		declare @keyowrds nvarchar(200) = ''
		while(@start <= @end)
		begin
			declare @innerstart int
			select @innerstart = min(keyword_ID)from [Text Questions Keywords] where text_question_ID = @start

			declare @innerend int
			select @innerend = max(keyword_ID)from [Text Questions Keywords] where text_question_ID = @start
			while(@innerstart <= @innerend)
			begin
				if(@innerstart = @innerend)
					set @keyowrds = @keyowrds +(select keyword from [Text Questions Keywords] where keyword_ID = @innerstart) 
				else
					set @keyowrds = @keyowrds +(select keyword from [Text Questions Keywords] where keyword_ID = @innerstart)+', '
				set @innerstart = @innerstart +1
			end
			if exists(select * from [Text Questions Keywords] TKW where TKW.text_question_ID = @start) 
			insert into @Textq
			values((select body from [Text Question] where text_question_ID = @start and [isDeleted] <> 1),@keyowrds)
			set @keyowrds = ''
			set @start = @start+1
		end
		select * from @Textq
	end
end
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentAnswers]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_StudentAnswers]
as
begin
	select s.[student_ID] "@StudentID",
	       s.[first_Name] "StudentName/FirstName",
           s.[last_Name] "StudentName/LastName",
		   sa.[answer]
	from Student s , [Student Answers] sa
	where s.[student_ID] = sa.[student_ID]
	for xml path('Students'), Root('Students')
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Update_InstructorAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_Update_InstructorAccount] (@oldUsername nvarchar(50), @oldPassword nvarchar(50), @newUsername nvarchar(50), @newPassword nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2)
		return -2
	update [dbo].[InstructorAccount]
	set [username] = @newUsername, [password] = @newPassword
	where [username] = @oldUsername and [password] = @oldPassword
end

GO
/****** Object:  StoredProcedure [dbo].[usp_Update_StudentAccount]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[usp_Update_StudentAccount] (@oldUsername nvarchar(50), @oldPassword nvarchar(50), @newUsername nvarchar(50), @newPassword nvarchar(50), @username nvarchar(50), @password nvarchar(50))
as
begin
	declare @err1 int = 
	(
	 select dbo.udf_Account_Validate(@username, @password,'A')
	)
	if(@err1 = -2)
		return -2
	update [dbo].[StudentAccount]
	set [username] = @newUsername, [password] = @newPassword
	where [username] = @oldUsername and [password] = @oldPassword
end

GO
/****** Object:  StoredProcedure [dbo].[usp_XMLreport_MCQ]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_XMLreport_MCQ]
as
begin
	select  q.[Body] "Question",
		    c.[choice_body] "Answer"
	from  [dbo].[MCQ Question] q, [dbo].[MCQ Choices] c
	where q.[MCQ_ID] = c.[MCQ_ID]
	for xml path('MCQ_Question')
end

GO
/****** Object:  StoredProcedure [dbo].[usp_XMLreport_Student_Info]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_XMLreport_Student_Info]
as
begin
	select   s.[student_ID]"@ID",
	         s.[first_Name] "Name/FirstName",
		     s.[last_Name] "Name/LasttName",
             c.[name] "Class",
             b.[branch_Name] "Branch"
	from  [dbo].[Student] s, [dbo].[Class] c, [dbo].[Branch] b
	where s.[class_ID] = c.[class_ID] and
		  c.[branch_ID] = b.[branch_ID]
	for xml path('Student'), Root('Students')
end

GO
/****** Object:  StoredProcedure [dbo].[usp_XMLreport_StudentAnswers]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XMLreport_StudentAnswers]
as
begin
	select s.[student_ID] "@StudentID",
	       s.[first_Name] "StudentName/FirstName",
           s.[last_Name] "StudentName/LastName",
		   (select sa.[answer]
		   from [dbo].[Student Answers] sa
		   where s.[student_ID] = sa.[student_ID])
	from Student s , [Student Answers] sa
	where s.[student_ID] = sa.[student_ID]
	for xml path('Students'), Root('Students')
end

GO
/****** Object:  StoredProcedure [dbo].[usp_XMLreport_TFQuestion]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_XMLreport_TFQuestion]
as
begin
	select  [Body] "Question",
		    [Answer]
	from  [dbo].[T&F Questions]
	for xml path('TF_Question')
end

GO
/****** Object:  StoredProcedure [dbo].[usp_XMLreport_TxtQWithKeywords]    Script Date: 1/18/2021 12:09:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_XMLreport_TxtQWithKeywords]
as
begin
	select  tq.[body] "Question",
		    k.[keyword] "Valid_Answer"
	from  [dbo].[Text Question] tq, [dbo].[Text Questions Keywords] k
	where tq.[text_question_ID] = k.[text_question_ID]
	for xml path('Text_QS')
end

GO
USE [master]
GO
ALTER DATABASE [DB] SET  READ_WRITE 
GO
