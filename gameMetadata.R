## inning
inningXpath <- "/html/body/div[@class='body-row mlb-row']//div[@class='period']"
inning_value <- xpathSApply(liveBetTree, inningXpath, xmlValue)
if (length(inning_value) == 0){
  inning_value <- NA
}
##position
inningPosXpath <- "/html/body/div[@class='body-row mlb-row']//div[@class='period-time']" 

inning_pos_value <- xpathSApply(liveBetTree, inningPosXpath, xmlValue)

if (length(inning_pos_value) == 0){
  inning_pos_value <- NA
}

## teams
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='team-location']"
teamsList <- xpathSApply(liveBetTree, test , xmlValue)
teams <- split(teamsList, 1:length(teamsList) %% 2 == 0)
names(teams) <- c("Away", "Home")
away_teams <- teams$Away
home_teams <- teams$Home
currentGameIds <- mapply(FUN = getGameId, home_teams, away_teams)

##pitchers
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='team-player']"
pitchersList <- xpathSApply(liveBetTree, test , xmlValue)

pitchers <- split(pitchersList, 1:length(pitchersList) %% 2 == 0)
names(pitchers) <- c("Away", "Home")

## score
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='mod-score']"
scoresList <- xpathSApply(liveBetTree, test , xmlValue)

scores <- split(as.double(scoresList), 1:length(scoresList) %% 2 == 0)
names(scores) <- c("Away", "Home")

##Game ID
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='column money']/a/@id"
sbIdList <- xpathSApply(liveBetTree, test)

sbIdList<- sapply(FUN = sub, ".*\\[(.*)\\].*", "\\1", sbIdList, perl=TRUE)

sbIds <- split(sbIdList, 1:length(sbIdList) %% 2 == 0)
names(sbIds) <- c("Away", "Home")

