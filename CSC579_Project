library(ggplot2)

t <- c(0) ### the time that the customer arrives to the system
w <- c(0) ### the waiting time for each customer
d <- c(0) ### the i-th customer depart time
s <- c(0)
k <- 0
mu = 1

buildRecord <- function(t, w, d, s, lambda, mu, Num, seed){
  
  set.seed(seed)
  
  X <- c(0) ### the number of customers in the system when the i-th customer arrives
  D <- c(0) ### the number of customers in the system when the i-th customer depart
  B <- c()
  
  arrive_time <- rexp(1, lambda)
  t[1] <- arrive_time
  w[1] <- 0
  u <- runif(1,0,1)
  s[1] <- qexp(u, mu)
  d[1] <- t[1] + s[1]
  X[1] <- 0
  
  for(i in 2 : Num){
    u <- runif(1, 0, 1)
    arrive_time <- rexp(1, lambda)
    t[i] <- t[i-1] + arrive_time
    s[i] <- qexp(u, mu)
    start_serve <- max(t[i], tail(d,1))
    d[i] <- start_serve + s[i]
    w[i] <- d[i] - t[i]
  }
  
  N <- 10000
  X<- build_X(t, d, X, N)
  D <- build_D(t, d, D, N)
  B <- busy(t, d, X, B, N)
  B <- round(B,3)
  
  Ns <- pro_N(X)
  
  plot_X <- creat_ccdf(X)
  plot_D <- creat_ccdf(D)
  
  plot_X
  plot_D

  # hist(X)
  # print(X)
  # hist(D)
  # print(D)
  # print(t)
  # print(s)
  # print(w)
  # print(d)
  # print(X)
  # print(D)
  # return(c(X, D))
  # print(B)
  cat("The result list[1] is arriving time t;\n", "list[2] is waiting time w;\n", "list[3] is serve time s;\n", "list[4] is departure time d;\n", "list[5] is X;\n", "list[6] is D;\n", "list[7] is busy B\n", "list[8] is Ns;\n")
  result <- list(t[1:10000],w[1:10000],s[1:10000],d[1:10000],X,D[1:10000],B, Ns)
  
  return(result)
  
}


build_X <- function(t, d, X, N){
  X[1] <- 0
  for(i in 2:N){
    for(j in (i-1):1){
      if(d[j] < t[i]){
        X[i] <- (i-j-1)
        break
      }
      if(d[1] > t[i]){
        X[i] <- (i-1)
        break
      }
      else{
        next
      }
    }
  }
  return(X)
}

build_D <- function(t,d,D,N){
  for(i in 1:(N+49)){
    for(j in (i+1):(N+49)){
      if(t[j] >= d[i]){
        D[i] <- (j-i-1)
        break
      }else{
        next
      }
    }
  }
  return(D)
}


busy <- function(t, d, X, B, n){
  for(i in 1:(n-1)){
    if(X[i] == 0){
      for(j in (i+1):n){
        if(X[j] == 0){
          B <- append(B, d[j-1]-t[i])
          k <- j
          break
        }
        if(j == n){
          B <- append(B, d[n]-t[i])
          break
        }
      }
      next(k)
    }
  }
  return(B)
}

pro_N <- function(X){
  Ns <- c(0)
  for(i in 1:10000){
    if(X[i]>0){
      Ns[i] <- 1
    }else{
      Ns[i] <- 0
    }
  }
  return(Ns)
}

compare <- function(lambda){
  for(i in 1:10){
    result <- buildRecord(t,w,d,s,lambda,mu,10050,i)
    busy <- unlist(result[7])
    sum_busy <- sum(busy)
    depart <- unlist(result[4])
    p_busy <- sum_busy/(depart[10000])
    Ns <- unlist(result[8])
    p_Ns <- cal_Ns(Ns)
    cat("The probability of busy time is ", p_busy, "the probability of Ns = 1 is ", p_Ns,"\n")
  }
}


cal_Ns <- function(Ns){
  sum <- sum(Ns)
  p_Ns1 <- sum/10000
}

creat_ccdf <- function(data_set){
  ecdf_x <- ecdf(data_set)
  dfr <- data.frame(ecdf = ecdf_x(data_set), log = log10(1-ecdf_x(data_set)))
  p_ccdf <- ggplot(dfr, aes(x=data_set)) + geom_line(aes(y=log))
  return(p_ccdf)
}

plotX <- function(lambda){
  X_set <- c(0)
  result <- buildRecord(t,w,d,s,lambda,mu,10050,1)
  X_array <- unlist(result[5])
  X_set <- X_array
  for(i in 2:10){
    result <- buildRecord(t,w,d,s,lambda,mu,10050,i)
    X_array <- unlist(result[5])
    for(j in 1:10000){
      X_set[j] <- X_set[j]+X_array[j]
    }
  }
  X_ava <- X_set/10
  plotX <- creat_ccdf(X_ava)
  plotX
}

plotD <- function(lambda){
  D_set <- c(0)
  result <- buildRecord(t,w,d,s,lambda,mu,10050,1)
  D_array <- unlist(result[6])
  D_set <- D_array
  for(i in 2:10){
    result <- buildRecord(t,w,d,s,lambda,mu, 10050,i)
    D_array <- unlist(result[6])
    for(j in 1:10000){
      D_set[j] <- D_set[j]+D_array[j]
    }
  }
  D_ava <- D_set/10
  plotY <- creat_ccdf(D_ava)
  plotY
}

plotB <- function(lambda){
  B_set <- c(0)
  result <- buildRecord(t,w,d,s,lambda,mu,10050,1)
  B_array <- unlist(result[7])
  B_set <- B_array
  for(i in 2:10){
    result <- buildRecord(t,w,d,s,lambda,mu,10050,i)
    B_array <- unlist(result[7])
    min_len <- min(length(B_set), length(B_array))
    for(j in 1:min_len){
      B_set[j] <- B_set[j] + B_array[j]
    }
  }
  B_ava <- B_set/10
  plotB <- creat_ccdf(B_ava)
  plotB
}

plotX(0.7)
plotD(0.7)
plotX(0.8)
plotD(0.8)
plotX(0.9)
plotD(0.9)
plotX(0.95)
plotD(0.95)
plotB(0.7)
plotB(0.8)
plotB(0.9)
plotB(0.95)
compare(0.7)
compare(0.8)
compare(0.9)
compare(0.95)
