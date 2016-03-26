\name{CleanUpPolys}
\alias{CleanUpPolys}
\title{apply various filters to polygon clusters}
\description{The various data rotations inspected often lead to
many overlapping polygons that show a high degree of redundancy
We apply various filters to those candidates}
\usage{CleanUpPolys(polys, BoundBox, minAutonFrac = 0.7, maxOL = 0.15, 
    verbose = 1)}
\arguments{
  \item{polys}{cluster candidates, typically redundant and too many}
  \item{BoundBox}{clip all clusters to this bounding box}
  \item{minAutonFrac}{only clusters that can hold their own survive}
  \item{maxOL}{maximum overlap: if less than maxOL\% overlap, count as a polygon on its own}
  \item{verbose}{level of verbosity}
}

\value{filtered clusters (if any)}

\author{Markus Loecher}




\examples{
#examples to come
print(1)
}
