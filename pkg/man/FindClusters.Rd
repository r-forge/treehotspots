\name{FindClusters}
\alias{FindClusters}
\title{find spatial clusters using supervised learning methods}
\description{We exploit classification trees to efficiently identify clusters in our data
The power to detect such rectangular clusters is greatly enhanced by 
inspecting various rotations of the data}
\usage{FindClusters(formula, data, NullClass = "0", model = FALSE, angles = c(0, 
    30, 45, 60), minsize = 200, minArea = 20, maxArea = 250, 
    ORfilter = list(OR = TRUE, OR1 = 1.8, OR2 = 0.1), DENS = FALSE, 
    joinIntersect = TRUE, method = "recursive.partition", split = c("deviance", 
        "gini"), PLOT = 0, prunePolys = TRUE, verbose = 0, ...)}
\arguments{
  \item{formula}{A formula expression. The left-hand-side (response) should be either a numerical vector when a regression tree will be fitted or a factor, when a classification tree is produced. The right-hand-side should be a series of numeric or factor variables separated by +; there should be no interaction terms. Both . and - are allowed: regression trees can have offset terms.}
  \item{data}{A data frame in which to preferentially interpret formula, weights and subset.}
  \item{NullClass}{if y is a factor, this is the category used for the background}
  \item{model}{If this argument is itself a model frame, then the formula and data arguments are ignored, and model is used to define the model. If the argument is logical and true, the model frame is stored as component model in the result.}
  \item{angles}{angles to explore}
  \item{minsize}{minimum number of points inside a cluster}
  \item{minArea}{minimum area of a cluster}
  \item{maxArea}{maximum area of a cluster}
  \item{ORfilter}{filter on minimum and maximum odds ratios (OR)}
  \item{DENS}{logical; if TRUE seek overdensities}
  \item{joinIntersect}{merge overlapping clusters}
  \item{method}{character string giving the method to use. The only other useful value is "model.frame".}
  \item{split}{Splitting criterion to use.}
  \item{PLOT}{plot the top PLOT clusters in each rotation}
  \item{prunePolys}{remove polygons due to overlap}
  \item{verbose}{level of verbosity}
  \item{\dots}{further arguments to \code{tree}}
}

\value{identified polygon clusters}

\author{Markus Loecher}




\examples{
#examples to come
print(1)
}
