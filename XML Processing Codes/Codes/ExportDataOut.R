require(RODBC)
# write to sql server
dbhandle <- odbcDriverConnect('driver={SQL Server};
                              server=(local);
                              database=CreditReport;
                              trusted_connection=true')

# all tables names
tabName <- sqlTables(dbhandle,schema='dbo')$TABLE_NAME

# write to disk
require(readr)
setwd("C:/Users/yuanc/Google Drive/___FundingMetrics/Reports/20161127 XML Summary/Data")
for (nn in tabName){
  print(nn)
  write_delim(sqlFetch(dbhandle,nn,colnames=FALSE),
              paste0(nn,".dat"),
              delim="|")
  
}