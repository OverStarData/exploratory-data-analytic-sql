USE [master]
GO
/****** Object:  Database [DataWareHouseAnalytic]    Script Date: 2025-06-22 8:57:00 PM ******/
CREATE DATABASE [DataWareHouseAnalytic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataWareHouseAnalytic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DataWareHouseAnalytic.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DataWareHouseAnalytic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DataWareHouseAnalytic_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DataWareHouseAnalytic] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataWareHouseAnalytic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET  MULTI_USER 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataWareHouseAnalytic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DataWareHouseAnalytic] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DataWareHouseAnalytic] SET QUERY_STORE = ON
GO
ALTER DATABASE [DataWareHouseAnalytic] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DataWareHouseAnalytic]
GO
/****** Object:  Table [dbo].[gold.dim_customers]    Script Date: 2025-06-22 8:57:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gold.dim_customers](
	[customer_key] [smallint] NULL,
	[customer_id] [smallint] NULL,
	[customer_number] [nvarchar](50) NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[marital_status] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
	[birthdate] [date] NULL,
	[create_date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gold.dim_products]    Script Date: 2025-06-22 8:57:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gold.dim_products](
	[product_key] [smallint] NOT NULL,
	[product_id] [smallint] NOT NULL,
	[product_number] [nvarchar](50) NOT NULL,
	[product_name] [nvarchar](50) NOT NULL,
	[category_id] [nvarchar](50) NOT NULL,
	[category] [nvarchar](50) NULL,
	[subcategory] [nvarchar](50) NULL,
	[maintenance] [bit] NULL,
	[cost] [smallint] NOT NULL,
	[product_line] [nvarchar](50) NOT NULL,
	[start_date] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gold.fact_sales]    Script Date: 2025-06-22 8:57:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gold.fact_sales](
	[order_number] [nvarchar](50) NULL,
	[product_key] [smallint] NULL,
	[customer_key] [smallint] NULL,
	[order_date] [date] NULL,
	[shipping_date] [date] NULL,
	[due_date] [date] NULL,
	[sales_amount] [smallint] NULL,
	[quantity] [tinyint] NULL,
	[price] [smallint] NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [DataWareHouseAnalytic] SET  READ_WRITE 
GO
