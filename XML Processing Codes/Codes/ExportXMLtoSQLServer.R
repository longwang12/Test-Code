setwd("C:/Users/yuanc/Google Drive/___FundingMetrics/XML/1117_xml_to_db")

require(data.table)

# read data
xmlDT <- readRDS("C:/Users/yuanc/Google Drive/___FundingMetrics/XML/xmlDT4.RDS")
xmlDT <- data.table(xmlDT,key="ID")[,ID:=as.numeric(ID)][order(ID)]
setnames(xmlDT,c("Line","ID","XML"))

require(RODBC)
# write to sql server
dbhandle <- odbcDriverConnect('driver={SQL Server};
                              server=(local);
                              database=CreditReport;
                              trusted_connection=true')

# write to SQL Server database
varTypes  <- c(ID="int",ResponseXML="xml")
sqlSave(channel=dbhandle,
		dat=xmlDT[,.(ID,ResponseXML)],
		tablename="xmlRaw2",
		rownames=FALSE,
		varTypes = varTypes)