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
    dbo.DimProduct AS p
	LEFT JOIN dbo.DimProductSubcategory as ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
	LEFT JOIN dbo.DimProductCategory as pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
  ORDER BY
	p.ProductKey ASC