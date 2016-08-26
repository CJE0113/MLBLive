
setwd("~/Documents/SportsbookPoC")
source("Initialize.R")
source("Scrape.R")

source("GetXML.R")

if (liveBetFlag != 0){
  source("gameMetadata.R")
  source("BetData.R")
  source("GetWinExpectancy.R")
  source("CurrentData.R")
  source("ExportData.R")
}

dbDisconnect(conn = connection)

##quit(save="no")
