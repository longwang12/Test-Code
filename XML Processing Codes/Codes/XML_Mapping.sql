-- Mappping XML file to relational database
-- Created: 11/18/2016
-- Last Updated: 11/26/2016


-- Table Name: xMain
-- Include personal info, credit rating and credit summary
SELECT ID,
       -- XML Source & Date to be done
       persons.person.value('(@EffDt)[1]','Date') as ReportEffDt,
	   persons.person.value('(@Source)[1]','varchar(20)') as ReportSource
       -- XML Request Status
       stat.stat.value('(RqUID)[1]','varchar(40)') as RqUID,
       stat.stat.value('./Status[1]/StatusCode[1][text()]','int') as StatusCode,
       stat.stat.value('./Status[1]/Severity[1][text()]','varchar(10)') as Severity,
       stat.stat.value('./Status[1]/StatusDesc[1][text()]','varchar(10)') as StatusDesc,
       -- Personal Information
       persons.person.value('./PersonName[1]/FullName[1][text()]','nvarchar(50)') as FullName,
       persons.person.value('(BirthYear)[1]','int') as BirthYear,
       -- Credit Score from Credit Agency
       credits.credit.value('(Value)[1]','int') as CScore,
       -- Summary of Credit Status
       ---- Amount Data
       summary.summary.value('./BalanceAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as BalTotAmt,
       summary.summary.value('./BalanceAmt[1]/InstAmt[1]/Amt[1][text()]','decimal(19,2)') as BalInstAmt,
       summary.summary.value('./BalanceAmt[1]/RevAmt[1]/Amt[1][text()]','decimal(19,2)') as BalRevAmt,
       summary.summary.value('./BalanceAmt[1]/ClosedWithBalAmt[1]/Amt[1][text()]','decimal(19,2)') as BalClsdBalAmt,
       summary.summary.value('./BalanceAmt[1]/AvailableAmt[1]/Amt[1][text()]','decimal(19,2)') as BalAvaiAmt,
       summary.summary.value('./HighCreditAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as HighCrTotAmt,
       summary.summary.value('./PastDueBalAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as PDBalTotAmt,
       summary.summary.value('./PastDueBalAmt[1]/InstAmt[1]/Amt[1][text()]','decimal(19,2)') as PDBalInstAmt,
       summary.summary.value('./PastDueBalAmt[1]/RevAmt[1]/Amt[1][text()]','decimal(19,2)') as PDBalRecAmt,
       summary.summary.value('./PaymentAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as PaymentAmt,
       summary.summary.value('./RealEstateBalAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as REBalTotAmt,
       summary.summary.value('./RealEstatePmtAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as REPmtTotAmt,
       summary.summary.value('./TotalCreditLimitAmt[1]/TotalAmt[1]/Amt[1][text()]','decimal(19,2)') as TotCrLtAmt,
       summary.summary.value('./AverageMonthlyPmtAmt[1]/Amt[1][text()]','decimal(19,2)') as AvgMPmtAmt,
       ---- Dates
       summary.summary.value('(MostRecentTradeDt)[1]','date') as MostRecentTradeDt,
       summary.summary.value('(OldestTradeDt)[1]','date') as OldestTradeDt,       
       ---- Count Data
       summary.summary.value('(ClosedAccts)[1]','int') as ClsdAcctCt,
       summary.summary.value('(CollCount)[1]','int') as CollCt,
       summary.summary.value('(CollTransferred)[1]','int') as CollTrsfCt,
       summary.summary.value('(InqCount)[1]','int') as InqCt,
       summary.summary.value('(InstAccts)[1]','int') as InstAcctCt,
       summary.summary.value('(OpenAccts)[1]','int') as OpenAcctCt,
       summary.summary.value('(PaidAccts)[1]','int') as PaidAcctCt,
       summary.summary.value('(RevAccts)[1]','int') as RevAcctCt,
       summary.summary.value('(PublicRecs)[1]','int') as PubRecCt,
       summary.summary.value('(OtherTrades)[1]','int') as OtTradeCt,
       summary.summary.value('(NowDelinqDerog)[1]','int') as NowDelinqDerogCt,
       summary.summary.value('(WasDelinqDerog)[1]','int') as WasDelinqDerogCt,
       summary.summary.value('(DisputedTrades)[1]','int') as DisputedTradeCt,
       summary.summary.value('(TotalTrades)[1]','int') as TotTradeCt,
       summary.summary.value('(CurrentTrades)[1]','int') as CurrentTradeCt,
       summary.summary.value('(LateCount30)[1]','int') as Late30Ct,
       summary.summary.value('(LateCount60)[1]','int') as Late60Ct,
       summary.summary.value('(LateCount90)[1]','int') as Late90Ct,
       summary.summary.value('(InqWithin6Months)[1]','int') as Inq6MthCt,
       summary.summary.value('(PastDueCount)[1]','int') as PastDueCt,  
       summary.summary.value('(UnratedCount)[1]','int') as UnratedCt,  
       summary.summary.value('(DerogCount)[1]','int') as DerogCt,
       ---- credit bureau modeling information
       credits.credit.value('(Model)[1]','int') as CModel,
       credits.credit.value('(ModelNumber)[1]','varchar(10)') as CModelNum,
       credits.credit.value('(ScoreNumberInd)[1]','varchar(50)') as CScoreNumInd,
       credits.credit.value('./Message[1]/MsgClass[1][text()]','varchar(20)') as CMsgCls,
       credits.credit.value('./Message[1]/Text[1][text()]','varchar(5)') as CMsgTxt,
       credits.credit.value('(ModelDesc)[1]','varchar(50)') as CModelDesc,
       credits.credit.value('./ModelRange[1]/MinRange[1][text()]','int') as CRangeMin,
       credits.credit.value('./ModelRange[1]/MaxRange[1][text()]','int') as CRangeMax,
       ---- Amount Data Currency Type
       summary.summary.value('./BalanceAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as BalTotAmtCd,
       summary.summary.value('./BalanceAmt[1]/InstAmt[1]/CurCode[1][text()]','varchar(4)') as BalInstAmtCd,
       summary.summary.value('./BalanceAmt[1]/RevAmt[1]/CurCode[1][text()]','varchar(4)') as BalRevAmtCd,
       summary.summary.value('./BalanceAmt[1]/ClosedWithBalAmt[1]/CurCode[1][text()]','varchar(4)') as BalClsdBalAmtCd,
       summary.summary.value('./BalanceAmt[1]/AvailableAmt[1]/CurCode[1][text()]','varchar(4)') as BalAvaiAmtCd,
       summary.summary.value('./HighCreditAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as HighCrTotAmtCd,
       summary.summary.value('./PastDueBalAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as PDBalTotAmtCd,
       summary.summary.value('./PastDueBalAmt[1]/InstAmt[1]/CurCode[1][text()]','varchar(4)') as PDBalInstAmtCd,
       summary.summary.value('./PastDueBalAmt[1]/RevAmt[1]/CurCode[1][text()]','varchar(4)') as PDBalRecAmtCd,
       summary.summary.value('./PaymentAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as PaymentAmtCd,
       summary.summary.value('./RealEstateBalAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as REBalTotAmtCd,
       summary.summary.value('./RealEstatePmtAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as REPmtTotAmtCd,
       summary.summary.value('./TotalCreditLimitAmt[1]/TotalAmt[1]/CurCode[1][text()]','varchar(4)') as TotCrLtAmtCd,
       summary.summary.value('./AverageMonthlyPmtAmt[1]/CurCode[1][text()]','varchar(4)') as AvgMPmtAmtCd       
INTO xMain
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/MsgRsHdr') AS stat(stat)
	OUTER APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo') AS persons(person)
	OUTER APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Score') AS credits(credit)
	OUTER APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Summary') AS summary(summary)
ORDER BY ID



-- Table Name: xTradeLine
-- TradeLine
SELECT ID as RID,
       -- Org Info
       sub.liability.value('(AcctId)[1]','varchar(30)') as AcctID,
       t10.OrgInfo.value('(Name)[1]','varchar(50)') as OrgName,
       t11.OrgId.value('(KOB)[1]','int') as KOB,
       t11.OrgId.value('(SubscriberNum)[1]','int') as SubNum,
       -- Overview
       sub.liability.value('(OpenedDt)[1]','date') as OpenDt,
       sub.liability.value('(Closed)[1]','int') as Closed,
       sub.liability.value('(ReportedDt)[1]','date') as ReportDt,
       sub.liability.value('(OwnershipType)[1]','varchar(10)') as OwnType,
       sub.liability.value('(AcctStatus)[1]','varchar(10)') as AccStatus,
       sub.liability.value('(StatusDt)[1]','date') as StatusDt,
       sub.liability.value('(AcctType)[1]','varchar(10)') as AccType,
       sub.liability.value('(BalanceDt)[1]','date') as BalDt,
       
       -- Credit Limit Amount
       t20.CreditLimitAmt.value('(Amt)[1]','decimal(19,2)') as CrLtAmt,
       t20.CreditLimitAmt.value('(CurCode)[1]','varchar(4)') as CrLtAmtCd,
       
       sub.liability.value('(LoanType)[1]','varchar(10)') as LoanType,
       sub.liability.value('(CollateralDesc)[1]','varchar(255)') as CollateralDesc,
        
       -- Current Rating Info     
       t30.CurrentRating.value('(Code)[1]','varchar(4)') as CurRatingCode,
       t30.CurrentRating.value('(RatingType)[1]','varchar(255)') as CurRatingType,
       t30.CurrentRating.value('(MsgClass)[1]','varchar(255)') as CurRatingMsgCls,
       
       -- High Balance Amount
       t40.HighBalanceAmt.value('(Amt)[1]','decimal(19,2)') as HighBalAmt,
       t40.HighBalanceAmt.value('(CurCode)[1]','varchar(4)') as HighBalCd,
       
       sub.liability.value('(LateCount30)[1]','int') as Late30Ct,
       sub.liability.value('(LateCount60)[1]','int') as Late60Ct,
       sub.liability.value('(LateCount90)[1]','int') as Late90Ct,
       sub.liability.value('(PmtPattern)[1]','varchar(50)') as PmtPattern,
       
       -- Unpaid Balance
       t50.UnpaidBalanceAmt.value('(Amt)[1]','decimal(19,2)') as UpBalAmt,
       t50.UnpaidBalanceAmt.value('(CurCode)[1]','varchar(4)') as UpBalCd,
       
       sub.liability.value('(MonthsReviewed)[1]','int') as MonReviewCt,
       sub.liability.value('(PmtStatus)[1]','varchar(255)') as PmtStatus,
       sub.liability.value('(Terms)[1]','varchar(20)') as Terms,
           
       sub.liability.value('(DerogCount)[1]','int') as DerogCt,
       
       -- new found
       sub.liability.value('(OrigCreditor)[1]','varchar(10)') as OrigCreditor,
       sub.liability.value('(SoldToCreditor)[1]','varchar(10)') as SoldToCreditor,
       sub.liability.value('./ConsumerStatement[1]/Text[1][text()]','varchar(max)') as ConsumerStatementText,
       sub.liability.value('(LastActivityDt)[1]','date') as LastActivityDt,
       
       t60.PastDueAmt.value('(Amt)[1]','decimal(19,2)') as PastDueAmt,
       t60.PastDueAmt.value('(CurCode)[1]','varchar(4)') as PastDueCd,
       t70.ScheduledPmtAmt.value('(Amt)[1]','decimal(19,2)') as ScheduledPmtAmt,
       t70.ScheduledPmtAmt.value('(CurCode)[1]','varchar(4)') as ScheduledPmtCd,
       t80.BalloonPmtAmt.value('(Amt)[1]','decimal(19,2)') as BalloonPmtAmt,
       t80.BalloonPmtAmt.value('(CurCode)[1]','varchar(4)') as BalloonPmtCd,
       t90.ChargeOffAmt.value('(Amt)[1]','decimal(19,2)') as ChargeOffAmt,
       t90.ChargeOffAmt.value('(CurCode)[1]','varchar(4)') as ChargeOffCd,
       t100.OrigLoanAmt.value('(Amt)[1]','decimal(19,2)') as OrigLoanAmt,
       t100.OrigLoanAmt.value('(CurCode)[1]','varchar(4)') as OrigLoanCd,
       -- Max Delinq Rating Rating
       t110.MaxDelinqRating.value('(Code)[1]','varchar(4)') as MaxDelinqRatingCode,
       t110.MaxDelinqRating.value('(MsgClass)[1]','varchar(256)') as MaxDelinqRatingMsgCls,
       t110.MaxDelinqRating.value('(RatingType)[1]','varchar(256)') as MaxDelinqRatingRatingType
INTO xTradeLine
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Liability') AS sub(liability)
	OUTER APPLY sub.liability.nodes('./OrgInfo') AS t10(OrgInfo)
	OUTER APPLY t10.OrgInfo.nodes('./OrgId') AS t11(OrgId)
	OUTER APPLY sub.liability.nodes('./CreditLimitAmt') AS t20(CreditLimitAmt)
	OUTER APPLY sub.liability.nodes('./CurrentRating') AS t30(CurrentRating)
	OUTER APPLY sub.liability.nodes('./HighBalanceAmt') AS t40(HighBalanceAmt)
	OUTER APPLY sub.liability.nodes('./UnpaidBalanceAmt') AS t50(UnpaidBalanceAmt)
	OUTER APPLY sub.liability.nodes('./PastDueAmt') AS t60(PastDueAmt)
	OUTER APPLY sub.liability.nodes('./ScheduledPmtAmt') AS t70(ScheduledPmtAmt)
	OUTER APPLY sub.liability.nodes('./BalloonPmtAmt') AS t80(BalloonPmtAmt)
	OUTER APPLY sub.liability.nodes('./ChargeOffAmt') AS t90(ChargeOffAmt)
	OUTER APPLY sub.liability.nodes('./OrigLoanAmt') AS t100(OrigLoanAmt)
    OUTER APPLY sub.liability.nodes('./MaxDelinqRating') AS t110(MaxDelinqRating)
ORDER BY RID, AcctId, SubNum, OpenDt, ReportDt



-- Table Name: xTradeLineMsg
-- TradeLine/Message
SELECT ID as RID,
       -- Org Info
       t10.OrgInfo.value('(Name)[1]','varchar(50)') as OrgName,
       t11.OrgId.value('(SubscriberNum)[1]','int') as SubNum,
       sub.liability.value('(OpenedDt)[1]','date') as OpenDt,
       sub.liability.value('(ReportedDt)[1]','date') as ReportDt,
       -- Message
       t20.msg.value('(MsgClass)[1]','varchar(80)') as MsgClass,
       t20.msg.value('(MsgCode)[1]','varchar(80)') as MsgCode,
       t20.msg.value('(Text)[1]','varchar(max)') as MsgTxt
INTO xTradeLineMsg
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Liability') AS sub(liability)
	OUTER APPLY sub.liability.nodes('./OrgInfo') AS t10(OrgInfo)
	OUTER APPLY t10.OrgInfo.nodes('./OrgId') AS t11(OrgId)
	OUTER APPLY sub.liability.nodes('./Message') as t20(msg)
ORDER BY RID, OpenDt, SubNum, MsgCode



-- Table Name: xTradeLinePmtInfo
-- TradeLine/PaymentInfo
SELECT ID as RID,
       -- Org Info Used for Primary key (w/ ID)
       t10.OrgInfo.value('(Name)[1]','varchar(50)') as OrgName,
       t11.OrgId.value('(SubscriberNum)[1]','int') as SubNum,
       sub.liability.value('(OpenedDt)[1]','date') as OpenDt,
       sub.liability.value('(ReportedDt)[1]','date') as ReportDt,
       
       -- Payment Info (MULTIPLE ENTRIES)
       t60.PaymentInfo.value('(MsgClass)[1]','varchar(255)') as PmtInfoMsgCls,
       t61.CategoryInfo.value('(MsgClass)[1]','varchar(255)') as PmtInfoCatMsgCls,
       t61.CategoryInfo.value('(CategoryDt)[1]','date') as PmtInfoCatDt,
       
       -- Payment Info 
       t62.PEI.value('(MsgClass)[1]','varchar(256)') as PmtInfoElemMsgCls,
       t63.Elem.value('(Amt)[1]','decimal(19,2)') as PmtInfoElemAmt,
       t63.Elem.value('(CurCode)[1]','varchar(4)') as PmtInfoElemCd
INTO xTradeLinePmtInfo
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Liability') AS sub(liability)
	OUTER APPLY sub.liability.nodes('./OrgInfo') AS t10(OrgInfo)
	OUTER APPLY t10.OrgInfo.nodes('./OrgId') AS t11(OrgId)
	OUTER APPLY sub.liability.nodes('./PaymentInfo') AS t60(PaymentInfo)
	OUTER APPLY t60.PaymentInfo.nodes('./CategoryInfo') AS t61(CategoryInfo)
	OUTER APPLY t60.PaymentInfo.nodes('./PaymentElementsInfo') AS t62(PEI)
	OUTER APPLY t62.PEI.nodes('./AccountingAmtItems/ElementAmt') AS t63(Elem)
ORDER BY RID, OpenDt, SubNum, PmtInfoMsgCls



-- Table Name: xCollection
-- Collection
SELECT ID as RID,
       -- Basic Info
       sub.col.value('(AcctType)[1]','varchar(5)') as AcctType,
       sub.col.value('(BalanceDt)[1]','date') as BalDt,
       sub.col.value('(ReportedDt)[1]','date') as ReportDt,
       sub.col.value('(StatusDt)[1]','date') as StatusDt,
       sub.col.value('(LastActivityDt)[1]','date') as LastActivityDt,
       sub.col.value('(OwnershipType)[1]','varchar(5)') as OwnershipType,       
       sub.col.value('(OrigAcctNumber)[1]','varchar(10)') as OrigAcctNum, 
       sub.col.value('(OrigCreditor)[1]','varchar(40)') as OrigCreditor, 

       -- Current Amount
       t10.cur.value('(Amt)[1]','decimal(19,2)') as  CurrentAmt,
       t10.cur.value('(CurCode)[1]','varchar(4)') as CurrentCd,  
       
       -- Original Amount
       t20.orig.value('(Amt)[1]','decimal(19,2)') as OriginalAmt,
       t20.orig.value('(CurCode)[1]','varchar(4)') as OriginalCd,

       -- Collection Agency
       t30.ca.value('(Name)[1]','varchar(50)') as AgencyName,
       t40.org.value('(Description)[1]','varchar(60)') as AgencyDesc,
       t40.org.value('(KOB)[1]','varchar(4)') as AgencyKOB,
       t40.org.value('(SubscriberNum)[1]','varchar(20)') as AgencySubNum
INTO xCollection
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Collection') AS sub(col)
	OUTER APPLY sub.col.nodes('./CurrentAmt') AS t10(cur)
	OUTER APPLY sub.col.nodes('./OriginalAmt') AS t20(orig)
	OUTER APPLY sub.col.nodes('./CollectionAgency') AS t30(ca)
	OUTER APPLY t30.ca.nodes('./OrgId') AS t40(org)
ORDER BY RID, BalDt, ReportDt, StatusDt



-- Table Name: xPubRecord
-- Public Records Information
SELECT ID as RID,
       sub.pub.value('(CaseId)[1]','varchar(20)') as CaseID,
       sub.pub.value('(PRType)[1]','int') as PRType,
       sub.pub.value('(OwnershipType)[1]','int') as OwnType,
       sub.pub.value('(BankruptcyType)[1]','int') as BankruptcyType,
       sub.pub.value('(CourtName)[1]','varchar(256)') as CourtName,
       sub.pub.value('(CourtNum)[1]','int') as CourtNum,
       sub.pub.value('(DerogInd)[1]','int') as DerogInd,
       
       -- Legal Obligation
       pub.legal.value('(Amt)[1]','decimal(19,2)') as LegalObligationAmt,
       pub.legal.value('(CurCode)[1]','varchar(4)') as LegalObligationCd,
       
       sub.pub.value('(StatusDt)[1]','date') as StatusDt,
       sub.pub.value('(Plaintiff)[1]','varchar(256)') as Plaintiff,
       sub.pub.value('(PRStatus)[1]','varchar(40)') as PRStatus,
       sub.pub.value('(OrigDtFiled)[1]','date') as OrigFiledDt,
       sub.pub.value('(Chapter)[1]','int') as Chapter,
       
       sub.pub.value('(FilingDt)[1]','date') as FilingDt,
       sub.pub.value('./ConsumerStatement[1][text()]','varchar(max)') as ConsumerStatementText
INTO xPubRecord
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PublicRecord') AS sub(pub)
	OUTER APPLY sub.pub.nodes('./LegalObligationAmt') AS pub(legal)
ORDER BY RID, OrigFiledDt, CaseID



-- Table Name: xEmployment
-- Employment Info
SELECT ID as RID,
       -- Basic Info
       sub.emp.value('(StartDt)[1]','date') as StartDt,
       sub.emp.value('(EndDt)[1]','date') as EndDt,
       -- Current Amount
       t10.Org.value('(Name)[1]','varchar(60)') as  OrgName,
       t11.PostAddr.value('(Addr1)[1]','varchar(60)') as Addr1,  
       t11.PostAddr.value('(Addr2)[1]','varchar(60)') as Addr2,
       t11.PostAddr.value('(Addr3)[1]','varchar(60)') as Addr3,
       t11.PostAddr.value('(PostalCode)[1]','varchar(12)') as ZIP
INTO xEmployment
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/EmploymentHistory') AS sub(emp)
	OUTER APPLY sub.emp.nodes('./OrgInfo') AS t10(Org)
	OUTER APPLY t10.org.nodes('./ContactInfo/PostAddr') AS t11(PostAddr)
ORDER BY RID



-- Table Name: xContact
-- Address and GEO info
SELECT ID as RID,
       -- PostAddr
       t10.postAddr.value('(StartDt)[1]','date') as StartDt,
	   t10.postAddr.value('(ReportedDt)[1]','date') as ReportDt,
	   t10.postAddr.value('(Addr1)[1]','varchar(60)') as Addr1,
	   t10.postAddr.value('(Addr2)[1]','varchar(60)') as Addr2,
	   t10.postAddr.value('(AddrType)[1]','varchar(60)') as AddrType,
	   t10.postAddr.value('(AddrSource)[1]','varchar(60)') as AddrSource,	
	   t11.GEO.value('(CountyCode)[1]','varchar(10)') as GEOCountyCode,
	   t11.GEO.value('(CensusTrackCode)[1]','varchar(10)') as GEOTrkCode,
	   t11.GEO.value('(BlockCode)[1]','varchar(10)') as GEOBlockCode,
	   t20.msg.value('(MsgCode)[1]','varchar(100)') as MsgCode,
	   t20.msg.value('(Text)[1]','varchar(100)') as MsgText
INTO xContact
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/ContactInfo') AS sub(contacts)
	OUTER APPLY sub.contacts.nodes('./PostAddr') AS	t10(postAddr)
	OUTER APPLY t10.postAddr.nodes('./GEOCode') AS t11(GEO)
	OUTER APPLY sub.contacts.nodes('./Message') AS t20(msg)
ORDER BY RID, StartDt, ReportDt, Addr1



-- Table Name: xFraud
-- Fraud Information
-- May be not unique
SELECT ID as RID,
       -- Fraud Counter
       t10.FC.value('(MsgClass)[1]','varchar(256)') as FraudCtMsgCls,
       t10.FC.value('(MsgCode)[1]','varchar(256)') as FraudCtMsgCode,
       t10.FC.value('(Text)[1]','varchar(256)') as FraudCtText,
       
       -- FraudValidations.SSNValidation
       t20.SSN.value('(MsgClass)[1]','varchar(256)') as  FraudSSNMsgCls,
       t20.SSN.value('(Text)[1]','varchar(256)') as FraudSSNText,  
       
       -- Warning
       t30.Warn.value('(MsgClass)[1]','varchar(256)') as FraudWarnMsgCls,
       t30.Warn.value('(MsgCode)[1]','varchar(256)') as FraudWarnMsgCode,
       t30.Warn.value('(Text)[1]','varchar(256)') as FraudWarnText
--INTO xFraud
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Fraud') AS sub(fraud)
	OUTER APPLY sub.fraud.nodes('./FraudCounters') AS t10(FC)
	OUTER APPLY sub.fraud.nodes('./FraudValidations/SSNValidation') AS t20(SSN)
	OUTER APPLY sub.fraud.nodes('./FraudWarnings') AS t30(Warn)
ORDER BY RID




-- Table Name: xMessage
	 --Message
	 --Personal_Message
	 --Personal_Address_Validation
	 --Personal_Deceased_Validation
	 --Personal_SSN_Validation
	 --Personal_OtherValidation
SELECT a.*
INTO xMessage
From
(
-- Message
	SELECT ID as RID,
	       MsgCategory = 'Message',
		   sub1.val.value('(MsgClass)[1]','varchar(100)') as MsgClass,
		   sub1.val.value('(MsgCode)[1]','varchar(255)') as MsgCode,
		   sub1.val.value('(Text)[1]','varchar(255)') as Text
	FROM xRaw
		CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Message') AS sub1(val)
UNION
-- Personal Message
	SELECT ID as RID,
		   MsgCategory = 'Personal_Message',
		   sub1.val.value('(MsgClass)[1]','varchar(100)') as MsgClass,
		   sub1.val.value('(MsgCode)[1]','varchar(255)') as MsgCode,
		   sub1.val.value('(Text)[1]','varchar(255)') as Text
	FROM xRaw
		CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/Message') AS sub1(val)
UNION
-- Personal_Address_Validation
	SELECT ID as RID,
		   MsgCategory = 'Personal_Address_Validation',
		   sub1.val.value('(MsgClass)[1]','varchar(100)') as MsgClass,
		   sub1.val.value('(MsgCode)[1]','varchar(255)') as MsgCode,
		   sub1.val.value('(Text)[1]','varchar(255)') as Text
	FROM xRaw
		CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/ValidationInfo/AddressValidation') AS sub1(val)
UNION
-- Personal_Deceased_Validation
	SELECT ID as RID,
		   MsgCategory = 'Personal_Deceased_Validation',
		   sub1.val.value('(MsgClass)[1]','varchar(100)') as MsgClass,
		   sub1.val.value('(MsgCode)[1]','varchar(255)') as MsgCode,
		   sub1.val.value('(Text)[1]','varchar(255)') as Text
	FROM xRaw
		CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/ValidationInfo/DeceasedValidation') AS sub1(val)
UNION
-- Personal_SSN_Validation
	SELECT ID as RID,
		   MsgCategory = 'Personal_SSN_Validation',
		   sub1.val.value('(MsgClass)[1]','varchar(100)') as MsgClass,
		   sub1.val.value('(MsgCode)[1]','varchar(255)') as MsgCode,
		   sub1.val.value('(Text)[1]','varchar(255)') as Text
	FROM xRaw
		CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/ValidationInfo/SSNValidation') AS sub1(val)
UNION
-- Personal_OtherValidation
	SELECT ID as RID,
		   MsgCategory = 'Personal_OtherValidation',
		   sub1.val.value('(MsgClass)[1]','varchar(100)') as MsgClass,
		   sub1.val.value('(MsgCode)[1]','varchar(255)') as MsgCode,
		   sub1.val.value('(Text)[1]','varchar(255)') as Text
	FROM xRaw
		CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/ValidationInfo/OtherValidation') AS sub1(val)
) a
ORDER BY RID, MsgCategory, MsgCode



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
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Score/Factor') AS score(factor)
UNION

SELECT ID as RID,
       Category = 'Alert',
       score.alert.value('(Code)[1]','varchar(3)') as Code,
       score.alert.value('(Description)[1]','varchar(255)') as CSDesc
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Score/Alert') AS score(alert)
) a
ORDER BY RID, Category, Code



-- Table Name: xAlias
-- Alias Names
SELECT ID as RID,
	   t10.msg.value('(MsgClass)[1]','varchar(100)') as MsgClass,
	   t10.msg.value('(Text)[1]','varchar(255)') as MsgCode,
	   t20.name.value('(FullName)[1]','varchar(40)') as FullName,
	   t20.name.value('(NickName)[1]','varchar(40)') as Nickname
INTO xAlias
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/Alias') AS sub1(val)
	OUTER APPLY sub1.val.nodes('./Message') AS t10(msg)
	OUTER APPLY sub1.val.nodes('./PersonName') AS t20(name)
ORDER BY RID



-- Table Name: TINInfo
-- Date and TaxID
SELECT ID as RID,
	   sub1.val.value('(TaxId)[1]','varchar(100)') as TaxId,
	   sub1.val.value('(TINType)[1]','varchar(255)') as TINType,
	   t10.val.value('(StartDt)[1]','date') as StartDt,
	   t10.val.value('(EndDt)[1]','date') as EndDt
INTO xTINinfo
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/PersonInfo/TINInfo') AS sub1(val)
	OUTER APPLY sub1.val.nodes('./DateRange') AS t10(val)
ORDER BY RID



-- Table Name: xStatement
--  GetReportResult.Subject.ConsumerStatement.StatementDt
--  GetReportResult.Subject.ConsumerStatement.Text
SELECT ID as RID,
	sub1.val.value('(StatementDt)[1]','date') as StatementDt,
	sub1.val.value('(Text)[1]','varchar(255)') as Text
INTO xStatement
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/ConsumerStatement') AS sub1(val)
ORDER BY RID, StatementDt



-- Table Name: xConsumerReferral
-- ConsumerReferral
-- All entries are the same 
SELECT ID as RID,
	sub.val.value('(Name)[1]','varchar(40)') as Name,
	t10.PostAddr.value('(Addr1)[1]','varchar(40)') as Addr1,
	t10.PostAddr.value('(Addr2)[1]','varchar(40)') as Addr2,
	t10.PostAddr.value('(City)[1]','varchar(40)') as City,
	t10.PostAddr.value('(StateProv)[1]','varchar(40)') as StateProv,
	t10.PostAddr.value('(PostalCode)[1]','varchar(12)') as PostalCode,
	t20.PhoneNum.value('(Phone)[1]','varchar(14)') as Phone,
	t20.PhoneNum.value('(PhoneType)[1]','varchar(20)') as PhoneType
INTO xConsumerReferral
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/Subject/ConsumerReferral') AS sub(val)
	OUTER APPLY sub.val.nodes('./ContactInfo/PostAddr') AS t10(PostAddr)
	OUTER APPLY sub.val.nodes('./ContactInfo/PhoneNum') AS t20(PhoneNum)
ORDER BY RID


-- Table Name: xFileStatus
-- XML Status
-- if the XML file are good or not?
SELECT ID as RID,
	sub.val.value('(RqUID)[1]','varchar(40)') as RqUID,
	t10.val.value('(StatusCode)[1]','varchar(40)') as StatusCode,
	t10.val.value('(Severity)[1]','varchar(40)') as Severity,
	t10.val.value('(StatusDesc)[1]','varchar(40)') as StatusDesc,
	t20.val.value('(ServerStatusCode)[1]','varchar(40)') as aServerStatusCode,
	t20.val.value('(Severity)[1]','varchar(12)') as aSeverity,
	t20.val.value('(StatusCode)[1]','varchar(14)') as aStatusCode,
	t20.val.value('(StatusDesc)[1]','varchar(20)') as aStatusDesc
INTO xFileStatus
FROM xRaw
	CROSS APPLY ResponseXML.nodes('/GetReportResponse/GetReportResult/MsgRsHdr') AS sub(val)
	OUTER APPLY sub.val.nodes('./Status') AS t10(val)
	OUTER APPLY t10.val.nodes('./AdditionalStatus') AS t20(val)
ORDER BY RID