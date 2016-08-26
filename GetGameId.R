getGameId <- function(homeTeam, awayTeam){
  load("gameIdList.rda")
  curr_date <- Sys.Date()
  if (as.POSIXlt(Sys.time())$hour < 5){
    curr_date <- Sys.Date() - 1
  }
  gameIndex<- which(as.character(gameIdList$Date) == as.character(curr_date) & as.character(gameIdList$AwayTeam) == as.character(awayTeam) & as.character(gameIdList$HomeTeam) == as.character(homeTeam))
  if (length(gameIndex) > 0){
    todaysGame <- max(gameIndex)
    return (gameIdList[todaysGame,]$Id)
  }
  else{
    newId <- max(gameIdList$Id) + 1
    newGame <<- data.frame(Id = newId, Date = Sys.Date(), AwayTeam = awayTeam, HomeTeam = homeTeam )
    gameIdList <- rbind(gameIdList, newGame)
    save(gameIdList, file="gameIdList.rda")
    return(newId)
  }
}