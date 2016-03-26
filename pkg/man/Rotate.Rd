\name{Rotate}
\alias{Rotate}
\title{rotate data }
\description{rotate data by multiplying with rotation matrix}
\usage{Rotate(x, a = 45, center = colMeans(x), inverseRot = FALSE, verbose = 0)}
\arguments{
  \item{x}{data frame to be rotated}
  \item{a}{angle to rotate over}
  \item{center}{center of rotation; another possible choice would be colMeans(x[,c("X","Y")])}
  \item{inverseRot}{invert previously applied rotation ?}
  \item{verbose}{level of verbosity}
}



\author{Markus Loecher}




\examples{
#data(drugCrimes)
#PlotClusters()
#examples to come
print(1)
}
