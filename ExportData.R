load("/Users/CJ/Documents/SportsbookPoC/LiveBetData.rda")
allteams.df$BET_FLAG <- mapply (FUN = check_bet_debounce, allteams.df$GAME_ID, allteams.df$TEAM, allteams.df$INNING, allteams.df$HALF_INNING, allteams.df$ML, allteams.df$WIN_EXPECT, allteams.df$KELLY, row.names(allteams.df))
dbWriteTable(connection, value = allteams.df, name = "MLB_LIVE_BET_ALL", append = T)
allData.df <-rbind(allData.df, allteams.df)
save(allData.df, file = "LiveBetData.rda" )

