\name{getHotspots}
\alias{getHotspots}
\title{find spatial clusters using supervised learning methods}
\description{Here we consider one fixed rotation of the data and 
seek hot spots using a classification tree}
\usage{getHotspots(formula = violent ~ X + Y, rotX, NullClass = "0", 
    minsize = 200, minArea = 20, maxArea = 250, ORfilter = list(OR = TRUE, 
        OR1 = 1.8, OR2 = 0.1), TreeAlgorithm = c("rpart", "ctree")[1], 
    verbose = 1, ...)}
\arguments{
  \item{formula}{A formula expression. The left-hand-side (response) should be either a numerical vector when a regression tree will be fitted or a factor, when a classification tree is produced. The right-hand-side should be a series of numeric or factor variables separated by +; there should be no interaction terms. Both . and - are allowed: regression trees can have offset terms.}
  \item{rotX}{data, possibly already rotated}
  \item{NullClass}{if y is a factor, this is the category used for the background}
  \item{minsize}{minimum number of points inside a cluster}
  \item{minArea}{minimum area of a cluster, units: lat*lon}
  \item{maxArea}{maximum area of a cluster, units: lat*lon}
  \item{ORfilter}{filter on minimum and maximum odds ratios (OR)}
  \item{TreeAlgorithm}{which tree algorithm to choose}
  \item{verbose}{level of verbosity}
  \item{\dots}{further arguments to \code{tree}}
}

\value{identified clusters (if any)}

\author{Markus Loecher}




\examples{
#examples to come
data("drugCrimes", envir = environment())
drugCrimes$MATCH = factor(drugCrimes$MATCH)
spot1 = getHotspots(MATCH ~ X+Y,drugCrimes, minArea=20/10^6,maxArea=250/10^6, 
                    ORfilter=list(OR=FALSE,OR1=0.8,OR2=0.1))
suppressWarnings(suppressMessages(library("PBSmapping")))
PBSmapping::plotPolys(spot1[1:5,],density=NULL,xlim=range(drugCrimes$X),ylim=range(drugCrimes$Y),
          border="blue",lwd=2)
ranRows=sample(1:nrow(drugCrimes), 5000)
points(Y~X,data=drugCrimes[ranRows,],col=RgoogleMaps::AddAlpha(4-as.numeric(MATCH)),pch=20,cex=0.6)

}
