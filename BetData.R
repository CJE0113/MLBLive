##money line
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='column money']"
moneyLineList <- xpathSApply(liveBetTree, test , xmlValue)

moneyLine <- split(moneyLineList, 1:length(moneyLineList) %% 2 == 0)
away_ml <- sapply(X = moneyLine[1][], FUN = gsub, pattern = "[\n\t]", replacement = "")
home_ml <- sapply(X = moneyLine[2][], FUN = gsub, pattern = "[\n\t]", replacement = "")

## spread
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='column spread']"
spreadList <- xpathSApply(liveBetTree, test , xmlValue)
spread <- split(spreadList, 1:length(spreadList) %% 2 == 0)
away_spread <- sapply(X = spread[1][], FUN = gsub, pattern = "[\n\t]", replacement = "")
home_spread <- sapply(X = spread[2][], FUN = gsub, pattern = "[\n\t]", replacement = "")


##over/under
test <- "/html/body/div[@class='body-row mlb-row']//div[@class='column total']"
totalList <- xpathSApply(liveBetTree, test , xmlValue)
total <- split(totalList, 1:length(totalList) %% 2 == 0)
over_total <- sapply(X = total[1][], FUN = gsub, pattern = "[\n\t]", replacement = "")
under_total <- sapply(X = total[2][], FUN = gsub, pattern = "[\n\t]", replacement = "")