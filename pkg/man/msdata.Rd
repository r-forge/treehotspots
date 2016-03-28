\name{msdata}
\alias{msdata}
\docType{data}
\title{
simulated artifial data at multiple scales and angles
}
\description{
data generation see details
}
\usage{data(msdata)}
\format{
  A data frame with 600 observations on the following 3 variables.
  \describe{
    \item{lon}{spatial lon coordinate} 
    \item{lat}{spatial lat coordinate} 
    \item{clus}{binary flag indicating cluster membership} 
   }
}
\details{
set.seed(123)
  library(mvtnorm)
  cov1 = sigma = matrix(2*c(1,-0.9,-0.9,1),ncol=2)
  Clus1 = rmvnorm(100,mean=c(X=10,Y=10), sigma = cov1)
  #TestRotation(Clus1, center=colMeans(Clus1))
  cov2 = sigma = matrix(0.5*c(1,0.9,0.9,1),ncol=2)
  Clus2 = rmvnorm(100,mean=c(X=3,Y=3), sigma = cov2)
  cov3 = sigma = matrix(c(0.1,0,0,0.1),ncol=2)
  Clus3 = rmvnorm(100,mean=c(X=6,Y=8), sigma = cov3)
  msdata = rbind.data.frame(Clus1,Clus2,Clus3)
  #TestRotation(msdata, center=colMeans(msdata[,1:2]))
  colnames(msdata) = c("lon","lat")
  rx = range(msdata[,"lon"])
  ry = range(msdata[,"lat"])
  msdata[,"clus"] = rep(1:3,each=100)
  N=300
  Bckgr = cbind.data.frame(lon= runif(N,rx[1],rx[2]),
                           lat= runif(N,ry[1],ry[2]),
                           clus=0)
  #alternatively, regular grid:
  # N1=N2=N0 = round(sqrt(N))
  # Bckgr =expand.grid(lon= seq(rx[1],rx[2],length=N1),
  #                     lat= seq(ry[1],ry[2],length=N2),
  #                     clus=0)
  
  msdata=rbind.data.frame(msdata,Bckgr)
  msdata$clus = factor(msdata$clus)

}


\examples{
data(msdata)
library(rpart)
library(partykit)
 

  rp = rpart(clus ~ lon+lat,data = msdata, control=rpart.control(minbucket=40,cp=0.01))
 #plot(rp)
 party_rp <- as.party(rp)
 plot(lat ~ lon,data = msdata, col = clus, pch=20,cex=0.6,main="rpart")
PartitionParty(party_rp,vars=c("lon","lat"), verbose=0)
}
\keyword{datasets}
