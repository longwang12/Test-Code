setwd('C:/Users/Long/Desktop/working dir')

doc = xmlRoot(xmlTreeParse('./generic_file.xml'))
doc[[1]]


report = xmlRoot(xmlTreeParse('./ResponseID_17.XML'))
report[1]
report[[1]]
xmlSApply(report[[1]], xmlValue)


function(node)
  xmlSApply(node, xmlValue)

xmlSApply(doc[[1]], xmlValue)


tmp = xmlSApply(report, function(x) xmlSApply(x, xmlValue))
class(tmp)
dim(tmp)


tmp = t(tmp)
grades = as.data.frame(matrix(as.numeric(tmp[,-1]), 2))
names(grades)
names(grades) = names(doc[[1]])[-1]
grades$Student = tmp[,1]

#############################################################################################
doc = xmlTreeParse('./MBExerianExport.txt')

myconn <-odbcConnect("decisionlogic3.cx74vmzvh2m2.us-east-1.rds.amazonaws.com", uid="readonly", pwd="72$t0ny_Br00k")

