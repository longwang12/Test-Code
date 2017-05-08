SELECT 
	   AccTrs.[ID] as TrsId
      ,AccTrs.[AccHeaderId]
      ,AccTrs.[TransactionDate]
      ,AccTrs.[Amount]
      ,AccTrs.[RunningBalance]
      ,AccTrs.[Description]
      ,AccTrs.[IsRefresh]
      ,AccTrs.[Status]
      ,AccTrs.[Category]
      ,AccTrs.[ActiveRec] as TrsActiveRec
						  -- all columns from AccTrs
	  ,AccHeader.*        -- all columns from AccHeqader
  INTO [DecisionLogic].[dbo].[WorkTable]
  FROM [DecisionLogic].[dbo].[DcsnLgcAccTrs] AS AccTrs
  INNER JOIN [DecisionLogic].[dbo].[DcsnLgcAccHeader] AS AccHeader
  ON AccTrs.AccHeaderId = AccHeader.ID