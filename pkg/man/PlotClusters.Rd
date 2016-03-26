\name{PlotClusters}
\alias{PlotClusters}
\title{plot clusters on a map}
\description{plot clusters on a static Google map}
\usage{PlotClusters(crimeFile = "data/drugCrimes.rda", DENS = FALSE, 
    polys, map, topClus = 10)}
\arguments{
  \item{crimeFile}{rda file containing point data}
  \item{DENS}{logical indicating density based clusters}
  \item{polys}{clusters/polygons to draw}
  \item{map}{map object}
  \item{topClus}{how many clusters to draw (ranked)}
}

\value{clusters found/passed}

\author{Markus Loecher}




\examples{
#data(drugCrimes)
#PlotClusters()
#examples to come
print(1)
}
