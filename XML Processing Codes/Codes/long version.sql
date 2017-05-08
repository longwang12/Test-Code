-- Table Name: xCreditScoreMsg
-- Credit Score Factor and Alert
select a.*
into xScore
from
(
SELECT ID as RID,
       Category = 'Factor',
       score.factor.value('(Code)[1]','varchar(3)') as Code,
       score.factor.value('(Description)[1]','varchar(255)') as CSDesc
FROM XMLdt
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Score/Factor') AS score(factor)
UNION

SELECT ID as RID,
       Category = 'Alert',
       score.alert.value('(Code)[1]','varchar(3)') as Code,
       score.alert.value('(Description)[1]','varchar(255)') as CSDesc
FROM XMLdt
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Score/Alert') AS score(alert)
) a
ORDER BY RID, Category, Code


----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------


SELECT ID as RID,
	sub.val.query('.') as XMLsub
INTO rawtable
FROM XMLdt
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/MsgRsHdr') AS sub(val)
ORDER BY RID