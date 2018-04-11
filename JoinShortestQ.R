

joinShortQ <- function(lambda, seed){
  set.seed(seed)
  t <- c(0)
  d <- c(0)
  s <- c(0)
  mu <- 1
  m <- 10
  
  X <- c(0)
  X1 <- c(0)
  X2 <- c(0)
  X3 <- c(0)
  X4 <- c(0)
  X5 <- c(0)
  X6 <- c(0)
  X7 <- c(0)
  X8 <- c(0)
  X9 <- c(0)
  X10 <- c(0)
  S1 <- c()
  S2 <- c()
  S3 <- c()
  S4 <- c()
  S5 <- c()
  S6 <- c()
  S7 <- c()
  S8 <- c()
  S9 <- c()
  S10 <- c()
  enter1 <- c()
  enter2 <- c()
  enter3 <- c()
  enter4 <- c()
  enter5 <- c()
  enter6 <- c()
  enter7 <- c()
  enter8 <- c()
  enter9 <- c()
  enter10 <- c()
  depart1 <- c(0)
  depart2 <- c(0)
  depart3 <- c(0)
  depart4 <- c(0)
  depart5 <- c(0)
  depart6 <- c(0)
  depart7 <- c(0)
  depart8 <- c(0)
  depart9 <- c(0)
  depart10 <- c(0)
  
  enter_list <- list(enter1, enter2, enter3, enter4, enter5, enter6, enter7, enter8, enter9, enter10)
  depart_list <- list(depart1, depart2, depart3, depart4, depart5, depart6, depart7, depart8, depart9, depart10)
  S_list <- list(S1, S2, S3, S4, S5, S6, S7, S8, S9, S10)
  X_list <- list(X1, X2, X3, X4, X5, X6, X7, X8, X9, X10)
  
  arrive_time <- rexp(1, lambda)
  t[1] <- arrive_time
  enter1[1] <- arrive_time
  enter_list[1] <- list(enter1)
  u <- runif(1, 0, 1)
  server_time <- qexp(u, mu)
  d[1] <- arrive_time + server_time
  S1[1] <- server_time
  S_list[1] <- list(S1)
  depart1[1] <- arrive_time + server_time
  depart_list[1] <- list(depart1)
  
  
  
  for(j in 2:50000){
    arrive_time <- rexp(1,lambda)
    t[j] <- t[j-1] + arrive_time
    
    Q <- c()
    for(h in 1:m){
      Q[h] <- findQX(j, t[j], depart_list[h])
    }
    
    choose <- which.min(Q)
    
    for(i in 1:m){
      if(choose == i){
        ###record enter time###
        queue <- enter_list[i]
        enter_array <- unlist(queue)
        enter_array <- append(enter_array, t[j])
        enter_list[i] <- list(enter_array)
        ######choose a server########
        Si_list <- S_list[i]
        Si <- unlist(Si_list)
        ######given a server time
        u <- runif(1,0,1)
        serve_time <- qexp(u, mu)
        ####record the server time####
        Si <- append(Si, serve_time)
        S_list[i] <- list(Si)
        depart_array <- unlist(depart_list[i])
        d[j] <- max(depart_array[length(depart_array)], t[j]) + serve_time
        depart_array[length(depart_array)+1] <- max(depart_array[length(depart_array)], t[j]) + serve_time
        depart_list[i] <- list(depart_array)
        
      }
    }
    
  }
  result <- list(t,d,enter_list, S_list, depart_list)
  cat("The arriving time is list[1];\n The departure time is list[2];\n The enter queue list is list[3];\n Then server list is list[4];\n Then depart list is list[5]\n")
  return(result)
}


findQX <- function(index, arrtime, d_list){
  depart_array <- unlist(d_list)
  if(arrtime > tail(depart_array, 1)){
    return(0)
  }else{
    len <- length(depart_array)
    for(l in len:1){
      if(arrtime > depart_array[l]){
        X <- len - l
        return(X)
      }
      if(arrtime <= depart_array[1]){
        X <- len
        return(X)
      }
    }
  }
}


creat_ccdf <- function(data_set){
  ecdf_x <- ecdf(data_set)
  dfr <- data.frame(ecdf = ecdf_x(data_set), log = log10(1-ecdf_x(data_set)))
  p_ccdf <- ggplot(dfr, aes(x=data_set)) + geom_line(aes(y=log)) + xlim(0,10)
  return(p_ccdf)
}


waiting_time <- function(t, d){
  w <- c()
  for(i in 1:50000){
    w[i] <- d[i]-t[i]
  }
  return(w)
}

ava_wait <- function(lambda){
  result <- joinShortQ(lambda, 1)
  arrive_time <- unlist(result[1])
  depart_time <- unlist(result[2])
  wait_time <- waiting_time(arrive_time, depart_time)
  
  for(k in 2:10){
    result <- joinShortQ(lambda, k)
    arrive_time <- unlist(result[1])
    depart_time <- unlist(result[2])
    temp_wait <- waiting_time(arrive_time, depart_time)
    wait_time <- wait_time + temp_wait
  }
  wait_ava <- wait_time/10
  return(wait_ava)
}


creat_plot <- function(lambda){
  wait_ava <- ava_wait(lambda)
  plot <- creat_ccdf(wait_ava)
  plot
}
