strPage <- readLines("/Users/CJ/Documents/SportsbookPoC/sportsbook.html")
liveBetStartIndex<- grep("(body-row mlb-row)", strPage)
liveBetEndIndex <- grep("(#live-bet-mod panel)", strPage)
liveBetFlag <- 0
if (length(liveBetStartIndex) != 0){
  liveBetXML <-strPage[liveBetStartIndex[1]:liveBetEndIndex[length(liveBetEndIndex)]]
  liveBetTree <-htmlTreeParse(liveBetXML, useInternalNodes = T)
  liveBetFlag <- 1
}