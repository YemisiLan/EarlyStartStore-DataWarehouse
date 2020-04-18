--Author:  Yemisi Adeoluwa
--Script Title: Create OLAP (Datawarehouse, Star Schema) Dimensional and Fact tables for EarlyStartStoreLtdDW
--Date: 27/08/2018

ALTER TABLE dbo.DimProducts
ALTER COLUMN  ExpiryDate DateTime NULL
GO

CREATE TABLE dbo.DimProducts
(ProductKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
[Description] nvarchar(90) NOT NULL,
ManifacturerName nvarchar(50) NULL,
Barcode Int NULL,
Price money NOT NULL,
Colour NVARCHAR(20) NULL,
StartDate DateTime NOT NULL,
ExpiryDate DateTime NULL)
GO



CREATE TABLE dbo.DimCustomer
(CustomerKey int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(30) nOT NULL,
Address nvarchar(50) NOT NULL,
Postcode varchar(10) NOT NULL,
CityID nvarchar(20) NOT NULL,
Telephone nvarchar(30) NULL,
Mobile nvarchar(30) NULL,
Email nvarchar(30) NULL)
GO



CREATE TABLE dbo.DimEmployee
(EmployeeKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(30) NOT NULL,
JobTitle nvarchar(30) NOT NULL,
Street nvarchar(50) NOT NULL,
Postcode varchar(10) NOT NULL,
City nvarchar(20) NOT NULL,
StartDate DATETIME NULL,
EndDate DATETIME NOT NULL,
Telephone nvarchar(50) NULL,
Email nvarchar(30) NULL)
GO
ALTER TABLE dbo.DimEmployee
ALTER COLUMN Telephone nvarchar(50) NULL
GO

CREATE TABLE dbo.DimDate
(DateKey Int NOT NULL PRIMARY KEY NONCLUSTERED,
 CalendarYear Int NOT NULL,
 CalendarQuarter Int NOT NULL,
 MonthOfYear Int NOT NULL,
 [MonthName] nvarchar(25) NOT NULL,
 [DayOfMonth] Int NOT NULL,
 [DayOfWeek] Int NOT NULL,
 [DayName] nvarchar(15) NOT NULL,
 FiscalYear int NOT NULL,
 FiscalQuarter int NOT NULL)
 GO



 CREATE TABLE dbo.DimCity
 (CityKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
 City nvarchar(20) NOT NULL,
 Country nvarchar(20) NOT NULL)
 GO


 CREATE TABLE dbo.DimSalesPerson
 (SalesPersonKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
 FirstName nvarchar(30) NOT NULL,
 LastName nvarchar(30) NOT NULL)
 GO

ALTER TABLE dbo.FactSalesQuota
ALTER COLUMN SalesAmountQuarter MONEY NULL
GO

 

 CREATE TABLE dbo.FactSalesQuota
 (SalesQuotaKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
  EmployeeKey Int NOT NULL REFERENCES DimEmployee(EmployeeKey),
  DateKey Int NOT NULL REFERENCES DimDate(DateKey),
  CalendarYear DateTime NOT NULL,
  CalendarQuarter DateTime NOT NULL,
  SalesAmountQuarter MONEY NULL)
  GO



  CREATE TABLE dbo.FactOrder
(OrderKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
 CityKey Int NOT NULL REFERENCES DimCity(CityKey),
 CustomerKey Int NOT NULL REFERENCES DimCustomer(CustomerKey),
 SalesPersonKey Int NOT NULL REFERENCES DimSalesPerson(SalesPersonKey),
 [Description] nvarchar(50) NOT NULL,
 Quantity Int NOT NULL,
 UnitPrice Money NOT NULL,
 VAT Money NOT NULL,
 TotalExclVAT Money NOT NULL,
 TotalInclVAT Money NOT NULL,
 OrderDate DATETIME NOT NULL,
 DateKey DATETIME NOT NULL)
 GO


 CREATE TABLE dbo.FactSales
 (SalesKey Int IDENTITY NOT NULL PRIMARY KEY NONCLUSTERED,
 SalesPersonKey Int NOT NULL REFERENCES DimSalesPerson(SalesPersonKey),
 ProductKey Int NOT NULL REFERENCES DimProducts(ProductKey),
 CustomerKey Int NOT NULL REFERENCES DimCustomer(CustomerKey),
 CityKey Int NOT NULL REFERENCES DimCity(CityKey),
 SalesLocation nvarchar(30) NOT NULL,
 OrderQty Int NULL,
 UnitPrice Money Null, 
 UnitPriceDiscountPct Money NULL,
 DiscountAmount Money NULL,
 ProductStandardCost Money NULL,
 TotProductCost Money NULL,
 SalesAmount Money NULL,
 OrderDate DATETIME NULL,
 DateKey DATETIME NULL)
 GO














 


 






