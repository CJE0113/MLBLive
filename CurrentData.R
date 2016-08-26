##current live bets data frame

away.df <- data.frame(cbind(Sys.Date(), currentGameIds,teams$Away, pitchers$Away, "Away", inning_value, inning_pos_value, scores$Away, away_ml, away_spread, 1 - we.list))

names(away.df) <- c("DATE","GAME_ID", "TEAM", "PITCHER", "LOCATION", "INNING", "HALF_INNING", "SCORE", "ML", "SPREAD", "WIN_EXPECT")
row.names(away.df) <- sbIds$Away
home.df <- data.frame(cbind(Sys.Date(),currentGameIds,teams$Home, pitchers$Home, "Home", inning_value, inning_pos_value, scores$Home, home_ml, home_spread, we.list))
row.names(home.df) <- sbIds$Home

names(home.df) <- c("DATE", "GAME_ID", "TEAM", "PITCHER", "LOCATION", "INNING", "HALF_INNING", "SCORE", "ML", "SPREAD", "WIN_EXPECT")

allteams.df <- rbind(away.df, home.df) 
allteams.df$WIN_EXPECT <- as.double(as.character(allteams.df$WIN_EXPECT))
if (length(which(abs(allteams.df$WIN_EXPECT) >1))){
  allteams.df <- allteams.df[-which(abs(allteams.df$WIN_EXPECT) >1),]
}

allteams.df$ML <- sapply(FUN = convert_ML, X = allteams.df$ML)
allteams.df$FRACTIONAL <- sapply(FUN = calc_frac_odds, X = allteams.df$ML)
allteams.df$KELLY <- mapply(FUN = calc_kelly, allteams.df$FRACTIONAL, as.double(as.character(allteams.df$WIN_EXPECT)))
