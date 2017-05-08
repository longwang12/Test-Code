setwd('C:/Users/Long Wang/Desktop/Working Dir')
require(data.table)

# read data
XMLdt = readRDS('XMLdt.RDS')
setnames(XMLdt,c("ID","ResponseXML", 'Line'))

# stri_replace_all_regex(XMLdt[2, ResponseXML], '(\\sxmlns\\S*="\\S*?")|(\\sSource="\\S*?")|(\\sEffDt="\\S*?")',"")
# Start the clock!
ptm <- proc.time()

XMLdt = XMLdt[, ResponseXML := stri_replace_all_regex(ResponseXML, '\\sxmlns\\S*="\\S*?"', '')]
XMLdt = XMLdt[, ResponseXML := stri_replace_all_regex(ResponseXML, '\\sNA$', '')]
# ans = stri_detect_regex(XMLdt[, ResponseXML], '[^\x20-\x7E]')
# idx = which(ans == T)
# length(XMLdt[, idx])
XMLdt[,ResponseXML:=stri_replace_all_regex(ResponseXML,"[^\x20-\x7E]","")]

# Stop the clock
proc.time() - ptm

# Test
write(XMLdt[ID == 66, ResponseXML], 'ID_66.xml')
write(XMLdt[ID == 1584, ResponseXML], 'ID_1584.xml')

saveRDS(XMLdt, file = 'XMLdt_final.RDS')
XMLdt <- readRDS("./XMLdt_final.RDS")
XMLdt <- data.table(XMLdt,key="ID")[,ID:=as.numeric(ID)][order(ID)]

require(RODBC)
# write to sql server
dbhandle <- odbcDriverConnect('driver={SQL Server};
                              server=(local);
                              database=CreditReport;
                              trusted_connection=true')

# write to SQL Server database
varTypes  <- c(ID="int",ResponseXML="xml")
sqlSave(channel=dbhandle,
        dat=XMLdt[,.(ID,ResponseXML)],
        tablename="XMLdt",
        rownames=FALSE,
        verbose = F,
        varTypes = varTypes)

# close the ODBC connection
odbcClose(dbhandle)
remove(dbhandle)

####################################################################################################################
## Try Regex
require(stringi)

# stri_replace_all_regex(XMLdt[2, ResponseXML], '(\\sxmlns\\S*="\\S*?")|(\\sSource="\\S*?")|(\\sEffDt="\\S*?")',"")
XMLdt_test = XMLdt[1:100, ]
XMLdt_test = XMLdt_test[, ResponseXML := stri_replace_all_regex(ResponseXML, '\\sxmlns\\S*="\\S*?"', '')]
XMLdt_test = XMLdt_test[, ResponseXML := stri_replace_all_regex(ResponseXML, '\\sNA$', '')]

# Test
write(XMLdt_test[ID == 6, ResponseXML], 'ID_6.xml')
write(XMLdt_test[ID == 95, ResponseXML], 'ID_95.xml')

saveRDS(XMLdt_test, file = 'XMLdt_test.RDS')
XMLdt_test <- readRDS("./XMLdt_test.RDS")
XMLdt_test <- data.table(XMLdt_test,key="ID")[,ID:=as.numeric(ID)][order(ID)]

require(RODBC)
# write to sql server
dbhandle <- odbcDriverConnect('driver={SQL Server};
                              server=(local);
                              database=CreditReport;
                              trusted_connection=true')

# write to SQL Server database
varTypes  <- c(ID="int",ResponseXML="xml")
sqlSave(channel=dbhandle,
        dat=XMLdt_test[,.(ID,ResponseXML)],
        tablename="XMLdt_test",
        rownames=FALSE,
        varTypes = varTypes)

# close the ODBC connection
odbcClose(dbhandle)
remove(dbhandle)

## Try end

####################################################################################################################
write(XMLdt[ID == 1584, ResponseXML], 'ID_1584.xml')
ans = XMLdt[ID == 1584, ResponseXML]
stri_sub(ans, from = 56800, to = 56900)

# # strange char cause XML parsing fail in SQL Server,using regex replace
# # \x20-\x7E   :this is printable part of ASCII code
bb <- "nks � Non-Specific</D"
stri_replace_all_regex(bb,"[^\x20-\x7E]","")
# xmlDT[,ResponseXML:=stri_replace_all_regex(XML,"[^\x20-\x7E]","")]
# saveRDS(XMLdt,"xmlDT3.RDS")

####################################################################################################################
# Data Preparation

xmlDT <- readRDS("./R_format_xRaw.RDS")
xmlDT <- data.table(xmlDT,key="ID")[,ID:=as.numeric(ID)][order(ID)]
setnames(xmlDT,c('Line',"ID","ResponseXML"))

# Test
write(xmlDT[ID == 95, ResponseXML], 'ID_95.xml')

require(RODBC)
# write to sql server
dbhandle <- odbcDriverConnect('driver={SQL Server};
                              server=(local);
                              database=CreditReport;
                              trusted_connection=true')

# write to SQL Server database
varTypes  <- c(ID="int",ResponseXML="xml")
sqlSave(channel=dbhandle,
		dat=xmlDT[1:100,.(ID,ResponseXML)],
		tablename="xmlRaw",
		rownames=FALSE,
		varTypes = varTypes)

# close the ODBC connection
odbcClose(dbhandle)
remove(dbhandle)


