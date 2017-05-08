/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[AccHeaderId]
      ,[TransactionDate]
      ,[Amount]
      ,[RunningBalance]
      ,[Description]
      ,[IsRefresh]
      ,[Status]
      ,[Category]
      ,[ActiveRec]
  FROM [DecisionLogic].[dbo].[DcsnLgcAccTrs]


--- select AccTrs into new table
SELECT *
INTO AccTrs2
FROM [DecisionLogic].[dbo].[DcsnLgcAccTrs]


ALTER TABLE DcsnLgcAccHeader
ADD InstitutionName2 text

Update DcsnLgcAccHeader
Set InstitutionName2 = refBankNames.cName
From refBankNames
Where  DcsnLgcAccHeader.InstitutionName = refBankNames.oName

ALTER TABLE AccTrs2
Add InstitutionName varchar(255), InstitutionName2 varchar(255)

Update AccTrs2
Set InstitutionName = DcsnLgcAccHeader.InstitutionName,
    InstitutionName2  = DcsnLgcAccHeader.InstitutionName2
From DcsnLgcAccHeader
Where  AccTrs2.AccHeaderId = DcsnLgcAccHeader.ID

-- take a look at Chase
Select * From AccTrs2
Where InstitutionName2 = 'Chase'
order by ID

-- take a look at Chase Category
Select  Category, count(*) as TotFreq, sum(Amount) as TotAmt
From AccTrs2
Where InstitutionName2 = 'Chase'
Group by Category
Order by Count(*) desc


--
-- take a look at Chase
Select * From AccTrs2
Where InstitutionName2 = 'Chase' and Category = 'Restaurants/Dining' and Amount < -200
Order by Description, ID