\name{TestRotation}
\alias{TestRotation}
\title{utility function to test validity of rotation }
\description{utility function to test validity of rotation }
\usage{TestRotation(x, angles = c(0, 30, 45, 60), center = c(0, 0), 
    OVERLAY = FALSE)}
\arguments{
  \item{x}{data frame to be rotated}
  \item{angles}{angles to rotate over}
  \item{center}{center of rotation; another possible choice would be colMeans(x[,c("X","Y")])}
  \item{OVERLAY}{should the partition be overlaid graphically?}
}



\author{Markus Loecher}




\examples{
TestRotation()
 
TestRotation(center=c(2,2))
 
N= 250
x1 = cbind.data.frame(X=runif(N),Y=runif(N), violent = 0)
x2 = cbind.data.frame(X=runif(N),Y=runif(N,0.45,0.55), violent = 1)
x = rbind.data.frame(x1,x2)-c(0.5,0.5)
TestRotation(x, center=c(-0.5,-0.5))

cm=colMeans(x)
y1 = Rotate(x,a=0,center=cm)
y2 = Rotate(y1,a=0,center=cm,inverseRot=TRUE)
mean(abs(unlist(y2-x)))
}
