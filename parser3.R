#------------------------------------------------------
#                   try R
#------------------------------------------------------
require(readr)
require(stringi)
require(stringr)
require(data.table)
setwd('C:/Users/Long Wang/Desktop/Working Dir')

XMLfull <- "./MBExerianExport.txt"
inputLines = read_lines(XMLfull,skip=1)
head(inputLines, 2)
inputLines[12]
length(inputLines) # number of input lines == 35244

####################################################################################################################
# Strings and regex practice
str_locate_all('a,b,c,d', ',')
str_locate_all(inputLines[12], ',')

####################################################################################################################
#require(parallel)
#inputLines = ALL_Lines
#rm(ALL_Lines)

# stri_detect from {stringi} package 
isNewXML = sapply(inputLines,function(x) stri_detect_regex(x,"^\\d+,<.*"),USE.NAMES = FALSE)
NewLineIdx = which(isNewXML==TRUE)
length(NewLineIdx) # number of unique records in the XML file
ContLineIdx = which(isNewXML==FALSE)

# stri_split from {stringi} Package
XMLNewLine = stri_split_fixed(inputLines[NewLineIdx],",",n=2,simplify = TRUE) # simplify = F, then list is returned
class(XMLNewLine) # matrix
dim(XMLNewLine) # 31820, 2
XMLNewLine[1, ]

# put XML beginning line into data.table
XMLdt = data.table(ID=numeric(length(NewLineIdx)),XML=character(length(NewLineIdx)))
XMLdt[,c("ID","XML"):=list(XMLNewLine[,1],XMLNewLine[,2])]
XMLdt[,Row:=NewLineIdx]
rm(XMLNewLine)

# put XML continuing line into a data.table
XMLcontDt = data.table(Row=ContLineIdx,XML=inputLines[ContLineIdx],key="Row")
MappingRow = numeric(length(ContLineIdx))

for (i in 1:length(ContLineIdx)){
  if(1==i || ContLineIdx[i]-ContLineIdx[i-1]>1) {
     MappingRow[i] = ContLineIdx[i] - 1
  } else {
     MappingRow[i] = MappingRow[i-1]
  }
}

XMLcontDt[,MappingRow:=MappingRow]
XMLcontDtAggr <- XMLcontDt[,
                           .(RowChain=paste(Row, collapse=","), XMLChain=paste(XML, collapse=" ")),
                           by=MappingRow]

####################################################################################################################
# data.table practice
ans = data.table(id = seq(20), char = seq(10, 200, 10))
ans[, 'key' := c(rep(0, 10), rep(1, 10))]
ans1 = ans[, .(id_chain = paste(id, collapse = ','), char_chain = paste(char, collapse = ' ')), by = key]
remove(ans)
remove(ans1)

####################################################################################################################
# match by MappingRow and Row
setkey(XMLdt,Row)
setkey(XMLcontDtAggr,MappingRow)
XMLdt <- merge(XMLdt,XMLcontDtAggr, all.x=TRUE,by.x="Row",by.y="MappingRow")
rm(XMLcontDtAggr,XMLcontDt)
XMLdt[,XML1:=paste(XML,XMLChain,sep=" ")]
XMLdt[,':='(XML=NULL,RowChain=NULL,XMLChain=NULL)]
XMLdt[, ':='(Row = NULL, number = seq(dim(XMLdt)[1]))]
saveRDS(XMLdt, 'XMLdt.RDS')
XMLdt = readRDS('XMLdt.RDS')
# fwrite(XMLdt[1:100, ], 'long_test.csv', sep = '?')

write(XMLdt[ID == 6, XML1], 'check6.xml')
write(XMLdt[ID==59,XML1],"Check12.XML")
write(XMLdt[number==28,XML1],"Check81.XML")

####################################################################################################################









