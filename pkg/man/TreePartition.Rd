\name{TreePartition}
\alias{TreePartition}
\title{Convert the recursively defined partitions of a tree into a matrix containing just the leaf rectangles}
\description{We extract the leaf rectangles of a tree.}
\usage{TreePartition(TreeFit, label = "yval", add = FALSE, ordvars, 
    ndigits = 3, ScaleAREA = 1, verbose = 0, ...)}
\arguments{
  \item{TreeFit}{An object of class "tree".}
  \item{label}{A character string giving the column of the frame component of tree to be used to label the regions.}
  \item{add}{If true, add to existing plot, otherwise start a new plot.}
  \item{ordvars}{The ordering of the variables to be used in a 2D plot. Specify the names in a character string of length 2; the first will be used on the x axis.}
  \item{ndigits}{number of digits to display/keep}
  \item{ScaleAREA}{multiplier applied to simple area computations}
  \item{verbose}{level of verbosity}
  \item{\dots}{Graphical parameters passed to \code{line}}
}

\value{data.frame where each row describes a leaf rectangle of the tree. 
The first row pertains to the global bounding box, .i.e. the rectangle containing all data
The columns in detail are:
columns 1-4 (xleft,ybottom,xright,ytop) are the bounding box for the respective rectangle
columns 5-6 (yy1,yy2) contain the (x,y) coords of the center of the rectangle
area gives the rectangular area computed by $ScaleAREA * delta X * delta Y$
yval for factors: maximum class probability, for regression: conditional average of response inside rectangle
lab label used by \link{PlotPartition}
maxClass for factors only: majority class label inside rectangle}

\author{Markus Loecher}




\examples{
#examples to come
 print(1)
}
