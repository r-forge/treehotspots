\name{data1}
\alias{data1}
\docType{data}
\title{
simulated data containing one symmetric bump
}
\description{
N = 500;
set.seed(50);
#spherical 
Bump1 <- cbind(x=rnorm(N,0,.45), y=rnorm(N,0,.45),l=1);#center at (0,0)

Bckgr <- cbind(x=runif(2*N,-4,4), y=runif(2*N,-4,4),l=0);#center at (0,0);
data1 <- as.data.frame(rbind(Bump1, Bckgr));
data1$l = factor(data1$l)
}
\usage{data(data1)}
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
#spherical 
Bump1 <- cbind(x=rnorm(N,0,.45), y=rnorm(N,0,.45),l=1);#center at (0,0)

Bckgr <- cbind(x=runif(2*N,-4,4), y=runif(2*N,-4,4),l=0);#center at (0,0);
data1 <- as.data.frame(rbind(Bump1, Bckgr));
data1$l = factor(data1$l)
}


\examples{
data(data1)
library(rpart)
library(partykit)
 rp = rpart(l ~ x + y, data = data1)
 #plot(rp)
 party_rp <- as.party(rp)
 plot(party_rp)
 
 plot(y ~ x, col = as.numeric(l), data = data1, cex = 0.5, pch=20,main="rpart")
 PartitionParty(party_rp,vars=c("x","y"), verbose=0)
}
\keyword{datasets}
