getCurrentWinExp<- function (homeTeam, awayTeam, doubleHeader){
baseURL <- "http://www.fangraphs.com/liveplays.aspx?date="
season <- "2016" 
dh <- "0"

current_date <- Sys.Date()
if (as.POSIXlt(Sys.time())$hour < 5){
  current_date <- Sys.Date() - 1
}
homeTeam_mascot <- getMascot(homeTeam, awayTeam)
WinExpLink <- paste(baseURL, current_date, "&team=", homeTeam_mascot, "&dh=", dh, "&season=", season, sep = "")

gameData<- tryCatch({readHTMLTable(WinExpLink)$PlayLive1_dgPlay_ctl00}, error = function (err){return (data.frame(WE = 500))})
currentWE <- as.numeric(sub("%", "", gameData$WE[length(gameData$WE)]))/100
if (length(currentWE) > 0){  return (currentWE) }
else {return (500)}

}