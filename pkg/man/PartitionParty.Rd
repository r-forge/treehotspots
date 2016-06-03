\name{PartitionParty}
\alias{PartitionParty}
\title{Plot the partitions of a partykit tree model}
\description{COmputes and plots the partitions of a partykit tree model in 2 dimensions.                           }
\usage{PartitionParty(ct, vars = c("lon", "lat"), BBOX, PLOT = TRUE, 
    labs = TRUE, verbose = 0)}
\arguments{
  \item{ct}{object of class partykit}
  \item{vars}{variable names in 2D}
  \item{BBOX}{bounding box}
  \item{PLOT}{overlay retangles?}
  \item{labs}{add node ID labels to plot ?}
  \item{verbose}{level of verbosity}
}



\author{Markus Loecher}




\examples{
if (0){
  
  library(partykit)
  library(rpart)
  #unimodal bump
  data(data1, envir = environment())
  rp = rpart(l ~ x + y, data = data1)
  #plot(rp)
  party_rp <- partykit::as.party(rp)
  plot(party_rp)
  
  plot(y ~ x, col = as.numeric(l), data = data1, cex = 0.5, pch=20)
  PartitionParty(party_rp,vars=c("x","y"), verbose=0)
  
  #elliptical bump:
  data(data2, envir = environment())
  rp = rpart(l ~ x + y, data = data2)
  #plot(rp)
  party_rp <- as.party(rp)
  plot(party_rp)
  
  plot(y ~ x, col = as.numeric(l)-1, data = data2, cex = 0.5, pch=20)
  PartitionParty(party_rp,vars=c("x","y"), verbose=0) 
  
  #Artifial data at multiple scales and angles:
  data(msdata, envir = environment())
  ct <- ctree(clus ~ lon+lat,data = msdata,
              control = ctree_control(multiway=TRUE))
  
  plot(ct)
  plot(lat ~ lon,data = msdata, col = clus, pch=20,cex=0.6)
  PartitionParty(ct,vars=c("lon","lat"), verbose=0)
}
print(1)
}
