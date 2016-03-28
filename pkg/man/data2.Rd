\name{data2}
\alias{data2}
\docType{data}
\title{
simulated data containing one elliptical bump
}
\description{
data generation see details
}
\usage{data(data2)}
\format{
  A data frame with 1500 observations on the following 3 variables.
  \describe{
    \item{x}{spatial x coordinate} 
    \item{y}{spatial y coordinate} 
    \item{l}{binary flag} 
   }
}
\details{
N = 500;
set.seed(50);
Bckgr <- cbind(x=runif(2*N,-4,4), y=runif(2*N,-4,4),l=0);#center at (0,0);
library(MASS)
(Sigma <- matrix(c(1,0.85,0.85,1),2,2))
Bump2 = cbind(mvrnorm(n = N, rep(0, 2), Sigma),l=1)
colnames(Bump2)[1:2] = c("x","y")
#Bump2 <- cbind(x=rnorm(N/2,0,.75), y=rnorm(N/2,0,.75),l=0);#center at (0,0)
data2 <- as.data.frame(rbind(Bump2, Bckgr));
data2$l = factor(data2$l)

}


\examples{
data(data2)
library(rpart)
library(partykit)
 COLS = rgb(0:1,rep(0,2),1:0, 0.5);

 rp = rpart(l ~ x + y, data = data2)
 #plot(rp)
 party_rp <- as.party(rp)
 plot(party_rp)
 
 plot(y ~ x, col = as.numeric(l), data = data2, cex = 0.5, pch=20,main="rpart")
 PartitionParty(party_rp,vars=c("x","y"), verbose=0) 
}
\keyword{datasets}
