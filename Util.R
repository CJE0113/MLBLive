convert_ML <- function(ML){
  test <- "+"
  if (is.na(ML)){
    return (NA)
  }
  else if (grepl(test, ML, fixed = TRUE) ){
    return(as.numeric(as.character(substring(text = ML, first = 2))))
  }
  else if (grepl("even", ML, fixed = TRUE)){
    return (100)
  }
  else {
    return(as.numeric(as.character(ML)))
  }
}

calc_win_expect_odds <- function(win_expect){
  if (win_expect <= .5){
    ((1 - win_expect)/win_expect)*100
  }
  else {
    (-100 / ((1 - win_expect) / win_expect))
  }
}

calc_frac_odds <- function(ML){
 if (ML > 0 && !is.na(ML)){
   return (ML/100)
 } 
 else if(ML <= 0 && !is.na(ML)){
   return(abs(100/ML))
 }
 else {return (NA)}
}

calc_kelly <- function(fractional, win_expect){
  if (!is.na(fractional) & !is.na(win_expect)){
    return (((as.double(win_expect)*(fractional + 1)) - 1) / fractional)
  }
  else{
    return(NA)
  }
}

check_bet_debounce2 <- function (gameId, team, inning, half, ml, win_exp, kelly){
 if (is.na(kelly) | kelly < 0){
   return (as.double(0))
 }
 
 if (is.na(inning) | is.na(half)){
   return (as.double(0))
 }   
  
 query <- paste("select *  from last_bet where GAME_ID =", gameId, "and team ='", team, "'")
 res <- dbSendQuery(connection, query)
 res.data = fetch(res, n = -1)
 
 if (length(res.data$GAME_ID) == 0){
   dbWriteTable(connection, name = "last_bet", value = data.frame(GAME_ID = gameId, TEAM = team, INNING = INNING, HALF_INNING = half, ML = ml, WIN_EXP = win_exp, KELLY = kelly), append = TRUE)
   return (as.double(1))
 }
 else 
  {
  if (length(res.data$INNING) == 0)
  {
     update = "UPDATE LAST_BET SET INNING = '"
     update2 = "', HALF_INNING = '"
     update3 = "', ML = "
     update4 = ", WIN_EXPECT = "
     update5 = ", KELLY = "
     update6 = " WHERE GAME_ID = "
     update7 = " AND TEAM = '"
     update8 = "'"
     query <- paste(update, inning, update2, half, update3, ml, update4, win_exp, update5, kelly, update6, gameId, update7, team, update8, sep = '')
     return (as.double(1))
  }
  else if (res.data$INNING != inning | res.data$HALF_INNING != half & res.data$KELLY < kelly)
  {
     update = "UPDATE LAST_BET SET INNING = '"
     update2 = "', HALF_INNING = '"
     update3 = "', ML = "
     update4 = ", WIN_EXPECT = "
     update5 = ", KELLY = "
     update6 = " WHERE GAME_ID = "
     update7 = " AND TEAM = '"
     update8 = "'"
     query <- paste(update, inning, update2, half, update3, ml, update4, win_exp, update5, kelly, update6, gameId, update7, team, update8, sep = '')
     dbSendQuery(connection, query)
     return (as.double(1))
  }
   else if (timediff(Sys.time(),res.data$LAST_BET_TS, units = "secs") > 600 & res.data$KELLY < kelly)
   {
     return (as.double(0))
   }
   else {return (as.double(0))
}
 }
}


check_bet_debounce <- function (gameId, team, inning, half, ml, win_exp, kelly, sbId){
  if (is.na(kelly) | kelly < 0){
    return (as.double(0))
  }
  
  if (is.na(inning) | is.na(half)){
    return (as.double(0))
  }   
  
  query <- paste("select *  from placed_bets where GAME_ID = ", gameId, " and team = '", team, "' ORDER BY LAST_BET_TS DESC",sep = "")
  res <- dbSendQuery(connection, query)
  res.data = fetch(res, n = -1)
  
  if (length(res.data$GAME_ID) == 0){
    print(paste("Using new bet logic:", team))
    dbWriteTable(connection, name = "placed_bets", value = data.frame(GAME_ID = gameId, TEAM = team, INNING = inning, HALF_INNING = half, ML = ml, WIN_EXPECT = win_exp, KELLY = kelly, TOTAL_BET = kelly*50, ADD_FLAG = 0), row.names = F, append = TRUE)
    placeBetLive(sbId, round(kelly*30,2))
    return (as.double(1))
  }
  else 
  {
     if (kelly > res.data$KELLY[1])
     {
       add_kelly = round((kelly - res.data$KELLY[1]),2)
       print(paste("Using additional bet logic:", team, kelly, res.data$KELLY[1], add_kelly))
       dbWriteTable(connection, name = "placed_bets", value = data.frame(GAME_ID = gameId, TEAM = team, INNING = inning, HALF_INNING = half, ML = ml, WIN_EXPECT = win_exp, KELLY = kelly, TOTAL_BET = add_kelly*50, ADD_FLAG = 1), row.names = F, append = TRUE)
       ##placeBetLive(sbId, round(add_kelly*30,2))
       return(1)
    }
    else
    {
      return(0) 
    }
  }
}

placeBetLive <- function (sbId, totalBet){
  if (totalBet > 10)
  {totalBet <- 10.00}
  if (totalBet < 1)
  {totalBet<-1.00}
  
  ten <- floor(totalBet/10)
  dollar <- floor(totalBet %% 10)
  dime <- floor((totalBet %% 1)*10)
  penny <- floor((totalBet*100) %% 10)
  
  execCommand<- paste("osascript ClickButtonTest.scpt",sbId,ten,dollar,dime,penny)
  system(execCommand)
}
