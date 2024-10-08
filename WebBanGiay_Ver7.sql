USE [master]
GO
/****** Object:  Database [WebBanGiay]    Script Date: 8/3/2024 10:13:33 PM ******/
CREATE DATABASE [WebBanGiay]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebBanGiay', FILENAME = N'/cloudclusters/mssql/data/WebBanGiay.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebBanGiay_log', FILENAME = N'/cloudclusters/mssql/data/WebBanGiay_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WebBanGiay] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebBanGiay].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebBanGiay] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebBanGiay] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebBanGiay] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebBanGiay] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebBanGiay] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebBanGiay] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebBanGiay] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebBanGiay] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebBanGiay] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebBanGiay] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebBanGiay] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebBanGiay] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebBanGiay] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebBanGiay] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebBanGiay] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WebBanGiay] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebBanGiay] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebBanGiay] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebBanGiay] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebBanGiay] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebBanGiay] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebBanGiay] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebBanGiay] SET RECOVERY FULL 
GO
ALTER DATABASE [WebBanGiay] SET  MULTI_USER 
GO
ALTER DATABASE [WebBanGiay] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebBanGiay] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebBanGiay] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebBanGiay] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebBanGiay] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebBanGiay] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [WebBanGiay] SET QUERY_STORE = ON
GO
ALTER DATABASE [WebBanGiay] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WebBanGiay]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 8/3/2024 10:13:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[Brand_Id] [int] IDENTITY(1,1) NOT NULL,
	[Brand_Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Brand_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[Cart_Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NULL,
	[Quantity] [int] NULL,
	[Product_Id] [int] NULL,
	[Size] [int] NULL,
 CONSTRAINT [PK_Cart_Detail] PRIMARY KEY CLUSTERED 
(
	[Cart_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Category_Id] [int] IDENTITY(1,1) NOT NULL,
	[Category_Name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[Discount_Id] [int] IDENTITY(1,1) NOT NULL,
	[Discount_Code] [varchar](50) NULL,
	[Discount_Quantity] [int] NULL,
	[Discount_Percent] [float] NULL,
	[Type] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Discount_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Order_Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[User_Id] [int] NULL,
	[Total_Amount] [int] NULL,
	[Discount_Id] [int] NULL,
	[Ship_Address] [nvarchar](100) NULL,
	[Ship_Email] [nvarchar](100) NULL,
	[Ship_PhoneNumber] [varchar](50) NULL,
	[Ship_Note] [nvarchar](200) NULL,
	[Status] [int] NULL,
	[Ship_Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Order_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrdDetail_Id] [int] IDENTITY(1,1) NOT NULL,
	[Order_Id] [int] NULL,
	[Product_Id] [int] NULL,
	[Quantity] [int] NULL,
	[Size] [int] NULL,
 CONSTRAINT [PK_OrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[OrdDetail_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Product_Id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Name] [nvarchar](50) NULL,
	[Product_Description] [nvarchar](255) NULL,
	[Product_Price] [int] NULL,
	[Product_Image] [nvarchar](255) NULL,
	[Product_Quantity] [int] NULL,
	[Category_Id] [int] NULL,
	[Brand_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[User_Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[User_Name] [nvarchar](50) NULL,
	[Pass_Word] [nvarchar](50) NULL,
	[Type] [int] NULL,
	[Amount_Spent] [int] NULL,
	[Email] [nvarchar](255) NULL,
	[Phone_Number] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WareHouse]    Script Date: 8/3/2024 10:13:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WareHouse](
	[ProWH_Id] [int] IDENTITY(1,1) NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Size] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_WareHouse] PRIMARY KEY CLUSTERED 
(
	[ProWH_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brand] ON 

INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name]) VALUES (1, N'Nike')
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name]) VALUES (2, N'Adidas')
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name]) VALUES (3, N'Gucci')
INSERT [dbo].[Brand] ([Brand_Id], [Brand_Name]) VALUES (4, N'Ananas')
SET IDENTITY_INSERT [dbo].[Brand] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([Cart_Id], [User_Id], [Quantity], [Product_Id], [Size]) VALUES (1, NULL, 2, 7, 36)
INSERT [dbo].[Cart] ([Cart_Id], [User_Id], [Quantity], [Product_Id], [Size]) VALUES (2, 2, 1, 4, 35)
INSERT [dbo].[Cart] ([Cart_Id], [User_Id], [Quantity], [Product_Id], [Size]) VALUES (10, 7, 2, 9, 39)
INSERT [dbo].[Cart] ([Cart_Id], [User_Id], [Quantity], [Product_Id], [Size]) VALUES (11, 7, 1, 6, 38)
INSERT [dbo].[Cart] ([Cart_Id], [User_Id], [Quantity], [Product_Id], [Size]) VALUES (1010, 4, 1, 15, 41)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Category_Id], [Category_Name]) VALUES (1, N'Sport')
INSERT [dbo].[Categories] ([Category_Id], [Category_Name]) VALUES (2, N'Fashion')
INSERT [dbo].[Categories] ([Category_Id], [Category_Name]) VALUES (3, N'Running')
INSERT [dbo].[Categories] ([Category_Id], [Category_Name]) VALUES (4, N'Football')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 

INSERT [dbo].[Discount] ([Discount_Id], [Discount_Code], [Discount_Quantity], [Discount_Percent], [Type]) VALUES (1, N'BINH100', 10, 50, 1)
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (9, CAST(N'2024-07-24T15:10:07.363' AS DateTime), 4, 2060000, NULL, NULL, N'abcd@gmail.com', N'0389892421', N'có đăng nhập', 0, N'Khách Hàng có đăng nhập')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (14, CAST(N'2024-07-24T15:22:40.343' AS DateTime), NULL, 720000, NULL, NULL, N'abcd@gmail.com', N'0389892421', N'ko', 0, N'Khách Hàng không đăng nhập')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (15, CAST(N'2024-06-25T00:00:00.000' AS DateTime), 7, 17840000, NULL, N'FF24E91E-F709-4307-9', N'C88F35FA-6@example.com', N'0871760371', N'4E7BDFBD-311D-4179-A608-AAA8C156FADB', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (16, CAST(N'2024-06-14T00:00:00.000' AS DateTime), 6, 3600000, NULL, N'BF64132E-D606-472E-8', N'015BCE34-7@example.com', N'03244654', N'63EF382F-8925-41C1-A018-5BFCD99A2477', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (17, CAST(N'2024-06-24T00:00:00.000' AS DateTime), 6, 16800000, NULL, N'A99EFD8E-83B7-4D53-A', N'FEF54F74-D@example.com', N'0901402854', N'CD757009-5981-4468-B650-62856143D291', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (18, CAST(N'2024-08-13T00:00:00.000' AS DateTime), 5, 10360000, NULL, N'D7516FEC-E282-4E82-A', N'5675F71A-4@example.com', N'0683369591', N'EDA24B50-D9B0-4862-A55B-A8D0432970C4', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (19, CAST(N'2024-08-08T00:00:00.000' AS DateTime), 4, 13500000, NULL, N'C434B6DB-441E-4455-8', N'D66387FF-A@example.com', N'0171238416', N'CA93A38F-D8BD-4B40-9BDC-3630FD93B538', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (20, CAST(N'2024-07-15T00:00:00.000' AS DateTime), 8, 2580000, NULL, N'123 Ðu?ng A, Qu?n 1, TP.HCM', N'user1@example.com', N'0901234567', N'Giao hàng nhanh', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (21, CAST(N'2024-08-05T00:00:00.000' AS DateTime), 9, 14578000, NULL, N'456 Ðu?ng B, Qu?n 2, TP.HCM', N'user2@example.com', N'0912345678', N'Giao hàng t?n noi', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (22, CAST(N'2024-08-20T00:00:00.000' AS DateTime), 10, 18597000, NULL, N'789 Ðu?ng C, Qu?n 3, TP.HCM', N'user3@example.com', N'0923456789', N'Giao hàng vào cu?i tu?n', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (23, CAST(N'2024-06-25T00:00:00.000' AS DateTime), 11, 14120000, NULL, N'101 Ðu?ng D, Qu?n 4, TP.HCM', N'user4@example.com', N'0934567890', N'Giao hàng trong ngày', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (24, CAST(N'2024-07-10T00:00:00.000' AS DateTime), 8, 1960000, NULL, N'202 Ðu?ng E, Qu?n 5, TP.HCM', N'user5@example.com', N'0945678901', N'Yêu c?u d?c bi?t', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (25, CAST(N'2024-08-12T00:00:00.000' AS DateTime), 9, 9178000, NULL, N'303 Ðu?ng F, Qu?n 6, TP.HCM', N'user6@example.com', N'0956789012', N'Giao hàng vào bu?i t?i', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (26, CAST(N'2024-07-22T00:00:00.000' AS DateTime), 10, 7437000, NULL, N'404 Ðu?ng G, Qu?n 7, TP.HCM', N'user7@example.com', N'0967890123', N'Giao hàng mi?n phí', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (27, CAST(N'2024-08-01T00:00:00.000' AS DateTime), 11, 7300000, NULL, N'505 Ðu?ng H, Qu?n 8, TP.HCM', N'user8@example.com', N'0978901234', N'Giao hàng vào cu?i tháng', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (28, CAST(N'2024-08-15T00:00:00.000' AS DateTime), 8, 9919000, NULL, N'606 Ðu?ng I, Qu?n 9, TP.HCM', N'user9@example.com', N'0989012345', N'Giao hàng vào sáng s?m', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (29, CAST(N'2024-07-30T00:00:00.000' AS DateTime), 9, 4500000, NULL, N'707 Ðu?ng J, Qu?n 10, TP.HCM', N'user10@example.com', N'0990123456', N'Giao hàng vào gi? hành chính', 0, N'Khách hàng')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (30, CAST(N'2024-07-26T23:23:49.370' AS DateTime), 6, 3300000, NULL, N'40 Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Ship trong vòng 1 tuần', 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (31, CAST(N'2024-07-27T13:01:06.393' AS DateTime), 6, 5880000, NULL, N'30 Mỹ An 25, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Ship cẩn thận giúp em', 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (32, CAST(N'2024-07-27T13:01:06.393' AS DateTime), 6, NULL, NULL, N'30 Mỹ An 25, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Ship cẩn thận giúp em', NULL, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (33, CAST(N'2024-07-27T13:03:40.263' AS DateTime), 6, 5880000, NULL, N'30 Mỹ An 25, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', NULL, 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (34, CAST(N'2024-07-27T13:03:40.263' AS DateTime), 6, NULL, NULL, N'30 Mỹ An 25, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', NULL, NULL, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (35, CAST(N'2024-07-27T13:14:48.567' AS DateTime), 6, 5880000, NULL, N'30 Mỹ An 25, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Check Total_Amount', 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (36, CAST(N'2024-07-27T13:14:48.567' AS DateTime), 6, 2060000, NULL, N'30 Mỹ An 25, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Check Total_Amount', NULL, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (37, CAST(N'2024-07-27T21:42:43.893' AS DateTime), 7, 6020000, NULL, N'144 Nguyễn Văn Thoại, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh4@gmail.com', N'0945485747', NULL, 0, N'Nguyễn Văn Phương')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (38, CAST(N'2024-07-27T21:42:43.893' AS DateTime), 7, 6020000, NULL, N'144 Nguyễn Văn Thoại, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh4@gmail.com', N'0945485747', NULL, NULL, N'Nguyễn Văn Phương')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (39, CAST(N'2024-07-27T22:11:52.393' AS DateTime), 7, 6020000, NULL, N'144 Nguyễn Văn Thoại, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh4@gmail.com', N'0945485747', NULL, 0, N'Nguyễn Văn Phương')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (40, CAST(N'2024-07-28T00:47:40.343' AS DateTime), 8, 5790000, NULL, N'255 Chương Dương, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh5@gmail.com', N'0974679574', N'Ship nhanh', 0, N'Nguyễn Thị Thanh Nga')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1037, CAST(N'2024-07-28T17:58:33.480' AS DateTime), 4, 2060000, NULL, N'123 abc', N'abcd@gmail.com', N'0389892421', N'oke', 0, N'Nguyễn Tất Bình ')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1038, CAST(N'2024-07-28T18:23:17.643' AS DateTime), NULL, 1290000, NULL, N'123 abc', N'abc@gmail.com', N'0123456', NULL, 0, N'hoang duc')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1039, CAST(N'2024-07-28T18:34:09.117' AS DateTime), 4, 1290000, NULL, N'123 abc', N'abc@gmail.com', N'0123456', NULL, 0, N'Tất Bình')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1040, CAST(N'2024-07-28T20:14:40.813' AS DateTime), NULL, 1290000, NULL, NULL, N'abc@gmail.com', N'0123456', NULL, 0, N'hoang duc')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1041, CAST(N'2024-07-28T22:00:41.137' AS DateTime), 8, 2580000, NULL, N'255 Chương Dương, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh5@gmail.com', N'0974679574', NULL, 0, N'Nguyễn Thị Thanh Nga')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1042, CAST(N'2024-07-28T22:25:06.397' AS DateTime), 6, 11700000, NULL, N'40 Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Giờ hành chính', 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1043, CAST(N'2024-07-28T22:49:53.237' AS DateTime), 6, 1240000, NULL, N'40 Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', NULL, 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1044, CAST(N'2024-07-28T23:21:05.777' AS DateTime), 9, 3959000, NULL, N'36 Bà Huyện Thanh Quan, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', N'kh5@gmail.com', N'0974679544', N'Đóng gói cẩn thận', 0, N'Hoàng Thị Thảo Yến')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1045, CAST(N'2024-07-29T01:27:50.570' AS DateTime), 6, 1290000, NULL, N'70/55 Bùi Tá Hán, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485781', N'Ship on Monday', 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1046, CAST(N'2024-07-29T01:42:31.373' AS DateTime), NULL, 3820000, NULL, N'70/55 Bùi Tá Hán, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng', N'tatsbinh@gmail.com', N'0942185799', NULL, 0, N'Nguyễn Tất Bình')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (1047, CAST(N'2024-07-29T01:51:30.550' AS DateTime), 6, 5120000, NULL, N'70/55 Bùi Tá Hán, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485747', N'Ship nhanh nhanh', 0, N'Nguyễn Như Đức Mạnh')
INSERT [dbo].[Order] ([Order_Id], [Date], [User_Id], [Total_Amount], [Discount_Id], [Ship_Address], [Ship_Email], [Ship_PhoneNumber], [Ship_Note], [Status], [Ship_Name]) VALUES (2037, CAST(N'2024-07-30T22:12:39.633' AS DateTime), 6, 5090000, NULL, N'70/55 Bùi Tá Hán, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng', N'kh3@gmail.com', N'0945485747', N'30/7/2024', 0, N'Nguyễn Như Đức Mạnh')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (6, 9, 7, 2, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (7, 9, 4, 1, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (9, 14, 7, 1, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (10, 15, 8, 5, 37)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (11, 15, 5, 3, 42)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (12, 15, 4, 4, 37)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (13, 16, 7, 5, 43)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (14, 17, 8, 5, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (15, 17, 7, 2, 37)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (16, 17, 6, 3, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (17, 18, 4, 5, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (18, 18, 5, 3, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (19, 18, 8, 2, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (20, 19, 9, 5, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (146, 20, 4, 2, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (147, 20, 5, 1, 40)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (148, 20, 7, 1, 42)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (149, 21, 8, 3, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (150, 21, 10, 2, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (151, 22, 11, 1, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (152, 22, 12, 2, 43)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (153, 23, 6, 1, 37)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (154, 23, 13, 3, 44)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (155, 24, 4, 2, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (156, 24, 7, 1, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (157, 25, 8, 1, 40)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (158, 25, 10, 2, 42)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (159, 26, 11, 3, 43)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (160, 27, 9, 1, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (161, 27, 14, 2, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (162, 28, 6, 3, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (163, 28, 12, 1, 42)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (164, 29, 13, 1, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (165, 30, 15, 2, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (166, 30, 7, 1, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (167, 31, 15, 4, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (168, 31, 7, 1, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (169, 33, 15, 4, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (170, 33, 7, 1, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (171, 35, 15, 4, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (172, 35, 7, 1, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (173, 37, 9, 2, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (174, 37, 6, 1, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (175, 39, 9, 2, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (176, 39, 6, 1, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (177, 40, 15, 1, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (178, 40, 13, 1, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1173, 1037, 7, 2, 36)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1174, 1037, 4, 1, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1175, 1038, 15, 1, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1176, 1039, 15, 1, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1177, 1040, 15, 1, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1178, 1041, 15, 2, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1179, 1042, 13, 2, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1180, 1042, 9, 1, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1181, 1043, 5, 2, NULL)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1182, 1044, 10, 1, 39)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1183, 1044, 7, 1, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1184, 1045, 15, 1, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1185, 1046, 15, 2, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1186, 1046, 6, 2, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1187, 1047, 13, 1, 41)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (1188, 1047, 6, 1, 38)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (2173, 2037, 16, 1, 35)
INSERT [dbo].[OrderDetail] ([OrdDetail_Id], [Order_Id], [Product_Id], [Quantity], [Size]) VALUES (2174, 2037, 7, 2, 35)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (4, N'VINTAS PUBLIC 2000S - LOW TOP - INSIGNIA BLUE', N'Gender: Unisex .Size run: 35 – 46 .Upper: Canvas .Outsole: Rubber', 620000, N'SP4.jpg', NULL, 2, 4)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (5, N'VINTAS PUBLIC 2000S - LOW TOP - BRINDLE', N'Gender: Unisex Size run: 35 – 46 Upper: Canvas Outsole: Rubber', 620000, N'SP5.jpg', NULL, 2, 4)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (6, N' VINTAS VIVU - LOW TOP - WARM SAND', N'Gender: Unisex Size run: 35 – 46 Upper: Canvas Outsole: Rubber', 620000, N'SP6.jpeg', NULL, 2, 4)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (7, N' VINTAS NAUDA EXT - HIGH TOP - MONK''S ROBE', N'Gender: Unisex Size run: 35 – 46 Upper: Canvas/Suede Outsole: Rubber', 720000, N'SP7.jpeg', NULL, 2, 4)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (8, N'SAMBA OG', N'Ra đời trên sân bóng, giày Samba là biểu tượng kinh điển của phong cách đường phố. ', 2700000, N'SP8.jpg', NULL, 2, 2)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (9, N'CONTINENTAL 80 STRIPES', N'Bắt đầu với thiết kế tennis thập niên 80. Thêm vào các gam màu tươi sáng. Cải biên họa tiết 3 Sọc adidas', 2700000, N'SP9.42.00.png', NULL, 1, 2)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (10, N'Nike Air Force 1 ''07', N'Comfortable, durable and timeless—it''s number 1 for a reason.', 3239000, N'SP10.png', NULL, 1, 1)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (11, N'Nike Mercurial Vapor 15 Academy', N'We make Academy boots for those looking to take their game to the next level', 2479000, N'SP11.png', NULL, 4, 1)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (12, N'Nike Mercurial Superfly 10 Elite Blueprint', N'Obsessed with speed? We engineered the Air Zoom unit in the Superfly 10 Elite to the exact specifications of championship athletes', 8059000, N'SP12.jfif', NULL, 4, 1)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (13, N'FREE HIKER 2.0 LOW GORE-TEX', N'UP HILL FACES, THROUGH STREAMS AND OVER ROCKS - SOAK UP THE MOMENT AND BE FREE OUT HERE. IN PREMIUM COMFORT, GO FURTHER WITH FREE HIKER LOW 2.0 GORE-TEX', 4500000, N'SP13.jpg', NULL, 3, 2)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (14, N'TERREX TRAILMAKER 2.0 HIKING SHOES', N'VERSATILE, LIGHTWEIGHT HIKING SHOES MADE IN PART WITH A BLEND OF RECYCLED AND RENEWABLE MATERIALS.', 2300000, N'SP14.jpg', NULL, 3, 2)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (15, N' TRACK 6 2.BLUES - LOW TOP - BLUEWASH', N'Gender: Unisex Size run: 35 – 46 Upper: Leather Outsole: Rubber', 1290000, N'SP15.jpeg', NULL, 2, 4)
INSERT [dbo].[Products] ([Product_Id], [Product_Name], [Product_Description], [Product_Price], [Product_Image], [Product_Quantity], [Category_Id], [Brand_Id]) VALUES (16, N'Adidas New Hammer ', N'Adidas New Hammer biểu tượng kinh điển của thể thao đường phố, thể hiện qua thân giày bằng da mềm, dáng thấp, nhã nhặn, các chi tiết phủ ngoài bằng da lộn và đế gum', 3650000, N'SP16.jpg', NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (1, N'Lê Uyên Phương', N'uyenphuong1806', N'1234', 0, NULL, N'leuyenphuongthd@gmail.com', N'0942185799')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (2, N'admin', N'admin', N'123', 0, 0, N'admin123@gmail.com', N'0123456790')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (3, N'Nhân Viên 1', N'nv', N'123', 1, NULL, N'abc@gmail.com', N'0123456   ')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (4, N'Nguyễn Tất Bình ', N'kh', N'123', 2, 0, N'tatbinh2024@gmail.com', N'0123456789')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (5, N'Hoàng Nghĩa Đức', N'kh2', N'123', 2, 0, N'kh2@gmail.com', N'0123456788')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (6, N'Nguyễn Như Đức Mạnh', N'kh3', N'123', 2, 0, N'kh3@gmail.com', N'0123556787')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (7, N'Nguyễn Văn Phương', N'kh4', N'123', 2, 0, N'kh4@gmail.com', N'0123456786')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (8, N'Nguyễn Thị Thanh Nga', N'kh5', N'123', 2, 0, N'kh5@gmail.com', N'0123356785')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (9, N'Hoàng Thị Thảo Yến', N'kh6', N'123', 2, 0, N'kh6@gmail.com', N'0124456784')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (10, N'Nguyễn Bảo Ngọc', N'kh7', N'123', 2, 0, N'kh7@gmail.com', N'0123456783')
INSERT [dbo].[User] ([User_Id], [Name], [User_Name], [Pass_Word], [Type], [Amount_Spent], [Email], [Phone_Number]) VALUES (11, N'Nguyễn Thị Mai Trang', N'kh8', N'123', 2, 0, N'kh8@gmail.com', N'0123456782')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[WareHouse] ON 

INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (1, 4, 35, 33)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (2, 7, 36, 47)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (3, 7, 35, 47)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (4, 11, 41, 47)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (5, 9, 39, 47)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (6, 8, 38, 40)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (7, 15, 35, 27)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (8, 15, 36, 12)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (9, 15, 37, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (10, 15, 38, 29)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (11, 15, 39, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (12, 15, 40, 25)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (13, 15, 41, 25)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (14, 15, 42, 25)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (15, 15, 43, 25)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (16, 15, 44, 25)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (17, 5, 38, 40)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (18, 10, 39, 34)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (19, 12, 40, 37)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (20, 13, 41, 21)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (21, 14, 41, 25)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (22, 6, 38, 20)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (23, 16, 35, 29)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (24, 16, 36, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (25, 16, 37, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (26, 16, 38, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (27, 16, 39, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (28, 16, 40, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (29, 16, 41, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (30, 16, 42, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (31, 16, 43, 30)
INSERT [dbo].[WareHouse] ([ProWH_Id], [Product_Id], [Size], [Quantity]) VALUES (32, 16, 44, 30)
SET IDENTITY_INSERT [dbo].[WareHouse] OFF
GO
/****** Object:  Index [UQ__Brand__AAB3214EDE0E0F65]    Script Date: 8/3/2024 10:13:43 PM ******/
ALTER TABLE [dbo].[Brand] ADD UNIQUE NONCLUSTERED 
(
	[Brand_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Categori__6DB38D6F2B73E47F]    Script Date: 8/3/2024 10:13:43 PM ******/
ALTER TABLE [dbo].[Categories] ADD UNIQUE NONCLUSTERED 
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Order__F1E4607A078A4C6E]    Script Date: 8/3/2024 10:13:43 PM ******/
ALTER TABLE [dbo].[Order] ADD UNIQUE NONCLUSTERED 
(
	[Order_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Products__9834FBBB33B963D6]    Script Date: 8/3/2024 10:13:43 PM ******/
ALTER TABLE [dbo].[Products] ADD UNIQUE NONCLUSTERED 
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__User__206D9171B8749E76]    Script Date: 8/3/2024 10:13:43 PM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [Amount_Spent]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Product_Id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Products]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_User] FOREIGN KEY([User_Id])
REFERENCES [dbo].[User] ([User_Id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_User]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([User_Id])
REFERENCES [dbo].[User] ([User_Id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Ord_Discount] FOREIGN KEY([Discount_Id])
REFERENCES [dbo].[Discount] ([Discount_Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Ord_Discount]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[Order] ([Order_Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Product_Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([Brand_Id])
REFERENCES [dbo].[Brand] ([Brand_Id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Categories] ([Category_Id])
GO
ALTER TABLE [dbo].[WareHouse]  WITH CHECK ADD  CONSTRAINT [FK_WareHouse_Products] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Products] ([Product_Id])
GO
ALTER TABLE [dbo].[WareHouse] CHECK CONSTRAINT [FK_WareHouse_Products]
GO
/****** Object:  StoredProcedure [dbo].[SP_NhapHang]    Script Date: 8/3/2024 10:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[SP_NhapHang] @IDSanPham  int, @KichThuoc float, @SoLuongNhap int
AS
BEGIN
	DECLARE @existingRecordCount INT;

    -- Kiểm tra xem đã có bản ghi nào với id_sanpham và size này chưa
    SELECT @existingRecordCount = COUNT(*)
    FROM WareHouse
    WHERE Product_Id = @IDSanPham AND Size = @KichThuoc;

    IF @existingRecordCount > 0
    BEGIN
        -- Nếu đã có bản ghi thì cập nhật số lượng
        UPDATE WareHouse
        SET Quantity = Quantity + @SoLuongNhap
        WHERE Product_Id = @IDSanPham AND size = @KichThuoc;
    END
    ELSE
	BEGIN
		insert WareHouse 
		values(@IDSanPham,@KichThuoc,@SoLuongNhap)
	END
End
GO
/****** Object:  StoredProcedure [dbo].[SP_XemKhoHangTuSanPham]    Script Date: 8/3/2024 10:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[SP_XemKhoHangTuSanPham] @IDSanPham int
AS
BEGIN
	IF (@IDSanPham=0)
	BEGIN
		SELECT 
		ProWH_Id,
        Product_Name,
        Size,
        Quantity

		FROM 
        WareHouse join Products on WareHouse.Product_Id= Products.Product_Id
		Order by Product_Name,Size 

	END
	ELSE
	BEGIN
		SELECT 
		ProWH_Id,
        Product_Name,
        Size,
        Quantity

		FROM 
			WareHouse join Products on WareHouse.Product_Id= Products.Product_Id
		WHERE 
			WareHouse.Product_Id = @IDSanPham
		Order by Product_Name,Size 
	END
    
END
GO
/****** Object:  StoredProcedure [dbo].[spAddOrder]    Script Date: 8/3/2024 10:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spAddOrder] @Date datetime, @User_Id int, @TotalAmount int , @discount_id int, @address nvarchar(100), @email nvarchar(100), @phone varchar(15),
						@note nvarchar(200), @name nvarchar(50) , @maxid int output
as
begin
	insert into [Order] ([Date],[User_Id],[Total_Amount],[Discount_Id],[Ship_Address],[Ship_Email],[Ship_PhoneNumber],[Ship_Note],[Status],[Ship_Name])
	values(@Date,@User_Id,@TotalAmount,@discount_id,@address,@email,@phone,@note,0,@name)
	select @maxid=MAX(Order_Id)
	from [Order]


end
GO
/****** Object:  StoredProcedure [dbo].[spAddOrderDetail]    Script Date: 8/3/2024 10:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spAddOrderDetail]  @order_Id int, @Product_Id int , @quantity int,  @size int 
as
begin
	insert into [dbo].[OrderDetail] ([Order_Id],[Product_Id],[Quantity],[Size])
	values(@order_Id , @Product_Id  , @quantity ,  @size )
end
GO
/****** Object:  StoredProcedure [dbo].[spDanhSachSanPham]    Script Date: 8/3/2024 10:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[spDanhSachSanPham] @filter nvarchar(100), @idCategory int, @idBrand int
AS
Begin
	select Products.Product_Id,Products.Product_Name,Products.Product_Description,Products.Product_Price,Products.Product_Image,Products.Product_Quantity,Products.Category_Id,Products.Brand_Id
	from Products
	inner join Categories on Products.Category_Id = Categories.Category_Id
	inner join Brand on Products.Brand_Id = Brand.Brand_Id	
	where (Product_Name like N'%'+ @filter +'%') and ((Categories.Category_Id = @idCategory or @idCategory is null) and (Brand.Brand_Id = @idBrand or @idCategory is null))
end
GO
/****** Object:  StoredProcedure [dbo].[spXoaSanPhamTrongKhoHang]    Script Date: 8/3/2024 10:13:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[spXoaSanPhamTrongKhoHang] @product_id int
as
begin
	delete from WareHouse 
	where Product_Id = @product_id
end

GO
USE [master]
GO
ALTER DATABASE [WebBanGiay] SET  READ_WRITE 
GO
