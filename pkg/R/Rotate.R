Rotate = structure(function#rotate data 
### rotate data by multiplying with rotation matrix
( 
 x, ##<< data frame to be rotated
 a = 45, ##<< angle to rotate over
 center = colMeans(x), ##<< center of rotation; another possible choice would be colMeans(x[,c("X","Y")])
 inverseRot=FALSE, ##<< invert previously applied rotation ?
 verbose=0 ##<< level of verbosity
){
 theta = pi*(a/180)
 rotX=x
 #rotation matrix:
 R = rbind(c(cos(theta), -sin(theta)),c(sin(theta), cos(theta)));
 
 if (inverseRot){
   if (theta!=0) rotX = as.data.frame(t(t(R) %*% t(as.matrix(x))))
   #rotX = rotX+center
   rotX = sweep(rotX,2,center, FUN = "+")
 } else {
   #rotX = x-center
   rotX = sweep(rotX,2,center, FUN = "-")
   if (theta!=0) rotX = as.data.frame(t(R %*% t(as.matrix(rotX))))
 }
 #browser()
 colnames(rotX) = colnames(x)
 return(rotX)
 
}, ex = function(){
 #data(drugCrimes)
 #PlotClusters()
 #examples to come
 print(1)
})

TestRotation = structure(function#utility function to test validity of rotation 
###utility function to test validity of rotation 
(x, ##<< data frame to be rotated
angles = c(0,30,45,60), ##<< angles to rotate over
center = c(0,0), ##<< center of rotation; another possible choice would be colMeans(x[,c("X","Y")])
OVERLAY=FALSE ##<< should the partition be overlaid graphically?
){
 
 if (missing(x)){
   N= 250
   x1 = cbind.data.frame(X=runif(N),Y=runif(N), violent = 0)
   x2 = cbind.data.frame(X=runif(N),Y=runif(N,0.45,0.55), violent = 1)
   x = rbind.data.frame(x1,x2)-c(0.5,0.5)
   x = rbind.data.frame(c(0,0),c(4,0),c(4,4),c(0,4),c(1,1.5),c(3,1.5),c(3,2.5),c(1,2.5))
 }
 N = nrow(x)
 if (!all(colnames(x) %in% c("X","Y"))) colnames(x)[1:2]= c("X","Y")
 #xM = colMeans(x[,c("X","Y")])
 #x[,c("X","Y")] = as.data.frame(sweep(x[,c("X","Y")],2, xM))
 
 for (a in angles) {
   
   #browser()
   rotX=Rotate(x[,c("X","Y")],a,center)
   plot(Y~X,data=rotX,pch=20,col=rgb(0,0,1,0.5),cex=0.75, main = paste("angle ", a))
   lines(rotX[c(1:4,1),"X"],rotX[c(1:4,1),"Y"])
   lines(rotX[c(5:8,5),"X"],rotX[c(5:8,5),"Y"],col=2)
   
   #rotate them back:
   rotX2=Rotate(rotX,a,center,inverseRot=TRUE)
   cat("angle ", a, ", mse:", round(mean((rotX2[,c("X","Y")]-x[,c("X","Y")])^2),3),"\n")
   plot(Y~X,data=rotX2,pch=20,col=rgb(0,0,1,0.5),cex=0.75, main = paste("reverting angle ", a))
   
 }
}, ex = function(){
 TestRotation()
  
 TestRotation(center=c(2,2))
  
 N= 250
 x1 = cbind.data.frame(X=runif(N),Y=runif(N), violent = 0)
 x2 = cbind.data.frame(X=runif(N),Y=runif(N,0.45,0.55), violent = 1)
 x = rbind.data.frame(x1,x2)-c(0.5,0.5)
 TestRotation(x)
 
 cm=colMeans(x)
 y1 = Rotate(x,a=0,center=cm)
 y2 = Rotate(y1,a=0,center=cm,inverseRot=TRUE)
 mean(abs(unlist(y2-x)))
})

if (0){
  x = matrix(1:9,ncol=3)
  x - colMeans(x)#WRONG !!!!
  (xc=sweep(x,2,colMeans(x)))#CORRECT!
  colMeans(xc)
}
