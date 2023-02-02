# Data-Analyst-Project

This **dynamic dashboard** I created according .

## Business Request & User Stories

The business request for this data analyst project was an executive sales report for sales managers. Based on the request that was made from the business we following user stories were defined to fulfill delivery and ensure that acceptance criteria’s were maintained throughout the project.




![Screenshot (143)](https://user-images.githubusercontent.com/91732450/216251217-c4061e82-6590-48ef-8761-25196ba09c2f.png)

## Data Cleansing & Transformation with SQL

To create the necessary data model for doing analysis and fulfilling the business needs defined in the user stories the following tables were extracted using SQL.

One data source (sales budgets) were provided in Excel format and were connected in the data model in a later step of the process.

Below are the SQL statements for cleansing and transforming necessary data.

*DIM_Calendar:*

```
-- Cleansed DimDateTable --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date,
  --[DayNumberOfWeek], 
  [EnglishDayNameOfWeek] AS Day	,
  --,[SpanishDayNameOfWeek]
  --,[FrenchDayNameOfWeek]
  --,[DayNumberOfMonth]
  --,[DayNumberOfYear]
  [WeekNumberOfYear] AS WeekNo, 
  [EnglishMonthName] AS Month,
  LEFT([EnglishMonthName],3) AS MonthShort,
  --,[SpanishMonthName],
  --,[FrenchMonthName],
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year
  --,[CalendarSemester]
  --,[FiscalQuarter]
  --,[FiscalYear]
  --,[FiscalSemester]
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]
Where 
  CalendarYear >= 2019
```

*DIM_Customer:*

```
-- Cleansed DimCustomer --
SELECT 
	  c.customerKey AS CustomerKey,
      --,[GeographyKey]
      --,[CustomerAlternateKey]
      --,[Title]
       c.FirstName AS [First Name]
      --,[MiddleName]
      ,c.LastName AS [Last Name]
	  ,c.FirstName + ' ' + c.LastName AS [Full Name]
      ,--[NameStyle]
      --[BirthDate]
      --[MaritalStatus]
      --[Suffix]
       CASE c.Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender,
      --[EmailAddress]
      --,[YearlyIncome]
      --,[TotalChildren]
      --,[NumberChildrenAtHome]
      --,[EnglishEducation]
      --,[SpanishEducation]
      --,[FrenchEducation]
      --,[EnglishOccupation]
      --,[SpanishOccupation]
      --,[FrenchOccupation]
      --,[HouseOwnerFlag]
      --,[NumberCarsOwned]
      --,[AddressLine1]
      --,[AddressLine2]
      --,[Phone]
      c.DateFirstPurchase AS DateFirstPurchase
      --,[CommuteDistance]
	  ,g.City AS [Customer City] --Joined Georgraphy Table to get the city--
  FROM 
	AdventureWorksDW2019.dbo.DimCustomer AS c
	LEFT JOIN AdventureWorksDW2019.dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey
  ORDER BY
    CustomerKey ASC
```

*DIM_Product:*
```
--Cleaned DIM_Products Table--
SELECT 
       p.[ProductKey] 
      ,P.[ProductAlternateKey] AS ProductItemCode
      ,--[ProductSubcategoryKey]
      --[WeightUnitMeasureCode]
      --[SizeUnitMeasureCode]
      p.[EnglishProductName] AS [Product Name],
	  pc.[EnglishProductCategoryName] AS [Product Category],
	  ps.[EnglishProductSubcategoryName] AS [Product Sub Category]
      ,--[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      p.[Color] AS [Product Color]
      ,--[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      p.[Size] AS [Product Size],
      --[SizeRange]
      --[Weight]
      --[DaysToManufacture]
      p.[ProductLine] AS [Product Line]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,p.[ModelName] AS [Product Model Name]
      --,[LargePhoto]
      ,p.[EnglishDescription] AS [Product Description]
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,ISNULL (P.Status, 'Outdated') AS [Product Status]
  FROM 
    AdventureWorksDW2019.dbo.DimProduct AS p
	LEFT JOIN AdventureWorksDW2019.dbo.DimProductSubcategory as ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
	LEFT JOIN AdventureWorksDW2019.dbo.DimProductCategory as pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
  ORDER BY
	p.ProductKey ASC
```

*FACT_InternetSales:*
```
-- Cleansed FACT_InternetSales Table --
SELECT 
       [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      ,--[PromotionKey]
      --,[CurrencyKey]
      --,[SalesTerritoryKey]
      [SalesOrderNumber]
      --,[SalesOrderLineNumber]
      --,[RevisionNumber]
      --,[OrderQuantity]
      --,[UnitPrice]
      --,[ExtendedAmount]
      --,[UnitPriceDiscountPct]
      --,[DiscountAmount]
      --,[ProductStandardCost]
      --,[TotalProductCost]
      ,[SalesAmount]
      --,[TaxAmt]
      --,[Freight]
      --,[CarrierTrackingNumber]
      --,[CustomerPONumber]
      --,[OrderDate]
      --,[DueDate]
      --,[ShipDate]
  FROM 
    [AdventureWorksDW2019].[dbo].[FactInternetSales]
  WHERE
    LEFT (OrderDateKey, 4) >= YEAR(GETDATE())-3 --For getting only 2 years from the date of Extration
  ORDER BY
    OrderDateKey ASC
```

## Data Model ##

Below is a screenshot of the data model after cleansed and prepared tables were read into Power BI.

This data model also shows how Budget(Client provided data) has been connected to FACT_InternetSales and other necessary DIM tables.

![Screenshot (144)](https://user-images.githubusercontent.com/91732450/216254382-bb0e755f-3767-4f2a-a57c-5615e3cba84f.png)


## Sales Management Dashboard ##

The finished sales management dashboard with one page which works as a dashboard and overview.

![Screenshot (145)](https://user-images.githubusercontent.com/91732450/216255288-157da010-fb85-450a-919e-ddcfd1ea0377.png)

## Link To The Live Dashboard ##

https://app.powerbi.com/groups/me/reports/0ae7de10-9760-492c-b426-61e49564f0f8/ReportSection
