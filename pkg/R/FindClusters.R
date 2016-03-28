FindClusters = structure(function# find spatial clusters using supervised learning methods
### We exploit classification trees to efficiently identify clusters in our data
### The power to detect such rectangular clusters is greatly enhanced by 
### inspecting various rotations of the data
( formula, ##<< A formula expression. The left-hand-side (response) should be either a numerical vector when a regression tree will be fitted or a factor, when a classification tree is produced. The right-hand-side should be a series of numeric or factor variables separated by +; there should be no interaction terms. Both . and - are allowed: regression trees can have offset terms.
 data, ##<< A data frame in which to preferentially interpret formula, weights and subset.
 NullClass="0", ##<< if y is a factor, this is the category used for the background
 model=FALSE, ##<< If this argument is itself a model frame, then the formula and data arguments are ignored, and model is used to define the model. If the argument is logical and true, the model frame is stored as component model in the result.
 angles = c(0,30,45,60), ##<< angles to explore
 minsize = 200,##<< minimum number of points inside a cluster
 minArea=20,##<< minimum area of a cluster
 maxArea=250,##<< maximum area of a cluster
 ORfilter=list(OR=TRUE,OR1=1.8,OR2=0.1), ##<< filter on minimum and maximum odds ratios (OR) 
 DENS = FALSE,##<< logical; if TRUE seek overdensities
 joinIntersect = TRUE,##<< merge overlapping clusters
 method = "recursive.partition",##<< character string giving the method to use. The only other useful value is "model.frame".
 split = c("deviance", "gini"),##<< Splitting criterion to use.
 PLOT = 0, ##<< plot the top PLOT clusters in each rotation 
 prunePolys = TRUE, ##<< remove polygons due to overlap
 verbose=0, ##<< level of verbosity
 ... ##<< further arguments to \code{tree}
){

 x = model.frame(formula,data)
 ycol = colnames(x)[1]
 xcols = colnames(x)[-1]
 #browser()
 N = nrow(x)
 if (DENS) {#find density clusters!
   rX = range(x$X)
   rY = range(x$Y)
   xBckg = cbind.data.frame(X=runif(3*N, rX[1], rX[2]), Y=runif(3*N, rY[1], rY[2]), violent=FALSE)
   x[,ycol]=TRUE
   x = rbind(x[,c(xcols,ycol)],xBckg)
   x[,ycol]= as.logical(x[,ycol])
 }
 polys = list()
 #if (theta ==0) BoundBox = Rect2PBSpolys(xy[1,,drop=F])
 Xr=range(x[,xcols[1]])
 Yr=range(x[,xcols[2]])
 yv = mean(as.numeric(x[,ycol]),na.rm=T)
 BoundBox = Rect2PBSpolys(matrix(c(Xr[1],Yr[1], Xr[2],Yr[2], yv),nrow=1, 
                                 dimnames=list(NULL,c("xleft","ybottom", "xright","ytop", "yval"))))
 
 #browser()
 cm=colMeans(x[,xcols])
 for (a in angles) {
   if (verbose) cat("angle: ", a, "\n")
   rotX <- cbind.data.frame(Rotate(x[,xcols],a,center=cm),x[,ycol])
   colnames(rotX)[3]=ycol
   #This is a bug in tree.model.frame which seems to search for the data in the global environment
   rotX <<- rotX
   rotPolys=NULL
   try({rotPolys = getHotspots(formula,rotX,NullClass,minsize, minArea, maxArea,ORfilter=ORfilter, verbose=verbose, ...)})
   #browser()
   #rotate them back:
   if (!is.null(rotPolys)) {
     #if (theta!=0) rotPolys[,c("X","Y")] = t(t(R) %*% t(as.matrix(rotPolys[,c("X","Y")])))
     rotPolys[,c("X","Y")]=Rotate(rotPolys[,c("X","Y")],a,center=cm,inverseRot=TRUE)
     polys[[as.character(a)]] = rotPolys
     if (verbose) cat("Num polys found: ", nrow(rotPolys)/5, "\n")
     if (PLOT) {
       #require(PBSmapping)
       #browser()
       topPolys = unique(subset(rotPolys, rotPolys$maxClass != 0)[,c("PID","yval")])
       topPolys = topPolys[order(topPolys$yval),]
       topPolys=subset(rotPolys, rotPolys$PID %in% tail(topPolys$PID,PLOT))
       PBSmapping::plotPolys(topPolys,xlim = Xr, ylim = Yr, col = rgb((1:PLOT)/PLOT,0.2,0.3), main = paste("angle:", a))
       coords = PBSmapping::calcCentroid(topPolys)
       for (i in 1:nrow(coords))
         text(coords[i,"X"],coords[i,"Y"],subset(topPolys, topPolys$PID==coords[i,"PID"])[1,"lab"] )
       
       #points(formula, data = data)
       
       #PlotPartition(rotPolys[ii,])
     }
   }
 }
 #add the column means back:
 polys = do.call("rbind", polys)
 #polys[,xcols] = sweep(polys[,xcols],2, xM, "+")
 #correct the PIDs:
 NumPolys = nrow(polys)/5
 polys[,"PID"] = rep(1:NumPolys, each = 5)
 
 if (verbose>1) {
   browser()
 } 
 if (PLOT){
   plotPolys(polys)
 } 
 
 if (verbose) print("now pruning polygons") 
 if (prunePolys) polys=CleanUpPolys(polys, BoundBox, verbose=verbose);
 
 return(polys)
 ### identified polygon clusters
}, ex = function(){
 #examples to come
 print(1)
})
