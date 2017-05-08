setwd('C:/Users/Long/Desktop/working dir')

# read data
require(data.table)
xmlDT <- readRDS("C:/Users/yuanc/Google Drive/___FundingMetrics/XML/xmlDT4.RDS")
xmlDT <- data.table(xmlDT,key="ID")[,ID:=as.numeric(ID)][order(ID)]

# Get Path
require(doParallel)
require(XML)

cl <- makeCluster(4)
registerDoParallel(cl)

# Y is a list
?parLapply
Y = parLapply(cl,
          xmlDT[,XML],
          function(XML) unique(names(unlist(XML::xmlToList(XML::xmlRoot(XML::xmlParse(XML,useInternalNodes = TRUE)))))))
saveRDS(Y,"uniquePath.RDS")

# Get Unique Path
Z <- unique(unlist(Y))

