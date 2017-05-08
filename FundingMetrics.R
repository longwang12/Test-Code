setwd('C:/Users/Long/Desktop/working dir')

require(RODBC)
require(data.table)
dbhandle <- odbcDriverConnect('driver={SQL Server};
                              server=(local);
                              database=DecisionLogic;
                              trusted_connection=true')
dbhandle

# list all tables
sql_tbl = sqlTables(dbhandle,schema = "dbo")
class(sql_tbl)
sql_tbl$TABLE_NAME
class(sql_tbl$TABLE_NAME)

# Fetch whole table
num_idx = seq(1, 11, 1)

for(i in 1:(length(sql_tbl$TABLE_NAME) - 1)){
  tmp <- sqlFetch(dbhandle,sqtable=sql_tbl$TABLE_NAME[i])
  output_name = paste('t', num_idx[i], ' - ', sql_tbl$TABLE_NAME[i], '.csv', sep = '')
  write.csv(tmp, output_name)
}

#######################################################################################################3

tmp <- sqlFetch(dbhandle,sqtable=sql_tbl$TABLE_NAME[1])
tmp = data.table(tmp)
dim(tmp)
class(tmp)
names(tmp)
remove(tmp)

# SQL 
sql_tbl$TABLE_NAME
DcsnLgcAccConfidence <- sqlQuery(dbhandle, 'select * from dbo.DcsnLgcAccConfidence')
DcsnLgcAccConfidence = data.table(DcsnLgcAccConfidence)
class(DcsnLgcAccConfidence)

# close the ODBC connection
odbcClose(dbhandle)
remove(dbhandle)
