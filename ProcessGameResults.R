checkWinner <- function(WIN_EXPECT, Home, Away) 
{
  if (WIN_EXPECT == 1) 
  {return (as.character(Home))} 
  else if (WIN_EXPECT == 0) 
  {return(as.character(Away))} 
  else 
  {return ("In Progress")}
}

load("~/Documents/SportsbookPoC/gameIdList.rda")
library(RMySQL)
source("getCurrentWinExp.R")
source("getMascot.R")

current_date <- Sys.Date()

if (as.POSIXlt(Sys.time())$hour < 5){
  current_date <- Sys.Date() - 1
}

todaysGames <- gameIdList[which(gameIdList$Date == current_date),]
todaysGames$WinExp <- sapply(FUN = getCurrentWinExp, todaysGames$Home, todaysGames$Away, rep("0", length(teams$Home)))


todaysGames$Winner <- mapply(FUN = checkWinner, todaysGames$WinExp, todaysGames$HomeTeam, todaysGames$AwayTeam)


connection <- dbConnect(MySQL(), user="root",dbname="sys", host="localhost")

dbWriteTable(connection, name = "AllGames", value = todaysGames, row.names = F, append = T)  

dbDisconnect(conn = connection)



##To Do -- Updates ##
