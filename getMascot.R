getMascot <- function (homeCityName, awayCityName){
  cityMap <- read.csv("cityMap.csv", stringsAsFactors = FALSE)
  if (homeCityName != "Chicago" & homeCityName != "Los Angeles" & homeCityName != "New York"){
    return(cityMap$Mascot[which(cityMap$Team == homeCityName)])
  }
  else
  {
    ##return ("TODO - MULTIPLE CITY LOOKUP")
    if (homeCityName == "Chicago"){
      return ("White%20Sox")
    }
    else if (homeCityName == "Los Angeles")
    {
      return ("Dodgers")
    }
    else
    {
      return("Yankees")
    }
        }
  
}