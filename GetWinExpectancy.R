## Win Expectancy Data
we.list <- rep(.5, length(teamsList))
we.list <- sapply(FUN = getCurrentWinExp, teams$Home, teams$Away, rep("0", length(teams$Home)))
