
CleanUpPolys = structure(function# apply various filters to polygon clusters
### The various data rotations inspected often lead to
### many overlapping polygons that show a high degree of redundancy
### We apply various filters to those candidates
(polys, ##<< cluster candidates, typically redundant and too many
 BoundBox, ##<< clip all clusters to this bounding box
 minAutonFrac = 0.7, ##<< only clusters that can hold their own survive
 maxOL=0.15, ##<< maximum overlap: if less than maxOL% overlap, count as a polygon on its own
 verbose=1 ##<< level of verbosity
 ){
NumPolys = nrow(polys)/5
  polys[,"PID"] = rep(1:NumPolys, each = 5)
  
  polyList = split(polys, polys[,"PID"])
  yvals = sapply(polyList, function(x) return(max(x$yval)))
  #sort them by yval:
  ix = order(yvals, decreasing=TRUE)
  polyList = polyList[ix]
  for (i in 1:length(polyList)) polyList[[i]][,"PID"] = i
  BoundBox[,"PID"] = i+1
  activePolys = c(1)
  if (verbose) {
    polysToPlot=rbind(BoundBox,polyList[[activePolys]][,colnames(BoundBox)])
    plotPolys(polysToPlot)
    title("top polygon")
    #browser()
  }
  for (i in 2:length(polyList)) {
    if ( (pOL = PolyOverlap(BoundBox,polyList[[i]])[2]) > minAutonFrac){ 
      pF=rep(NA,length(activePolys));k=1
      for (j in activePolys){
        pF[k]=PolyOverlap(polyList[[j]],polyList[[i]])[2]
        k=k+1
      }
      #if less than 15% overlap, count as a polygon on its own
      if (max(pF,na.rm=TRUE)<= maxOL) {
        activePolys = c(activePolys,i)
      } else {
        if (verbose) {
          cat("polygon ", i, "overlaps too heavily with existing ",length(activePolys),"polygons.\n")
          polysToPlot=rbind(polyList[[i]],do.call("rbind",polyList[activePolys]))
          polysToPlot=rbind(polysToPlot[,colnames(BoundBox)],BoundBox)
          cols=c(2,1,seq(3,by=1,length=length(activePolys)-1),0)
          plotPolys(polysToPlot, col = cols[order(unique(polysToPlot$PID))])
        }
      }
    } else {
      if (verbose) cat("polygon ", i, "fractional overlap with bounding box is only", round(pOL,3), ". Rejected.\n")
    }
  }
  polys = do.call("rbind", polyList[activePolys])
  return(polys)
### filtered clusters (if any)
}, ex = function(){
  #examples to come
  print(1)
})

PolyOverlap = structure(function#computes the relative overlap of two polygons
###computes the relative overlap of two polygons
(polysA, ##<< 1st polygon 
 polysB  ##<< 2nd polygon
){
  polysC = try(joinPolys(polysA,polysB,operation="INT"),silent=TRUE)#from PBSmapping
  if (is.null(polysC) | class(polysC)[1] =="try-error") return(c(0,0))
  areaIntersect = calcArea(polysC)[,"area"]
  OverlappolysA = areaIntersect/calcArea(polysA)[,"area"]
  OverlappolysB = areaIntersect/calcArea(polysB)[,"area"]
  return(c(OverlappolysA,OverlappolysB))
###relative polygon overlap measures
}, ex = function(){
  #examples to come
  print(1)
})


PlotPartition = structure(function#Plot the partitions of a tree model.
###Plot the partitions of a tree involving one or two variables.
( xy, ##<< object returned by \code{TreePartition}
  add = FALSE, ##<< If true, add to existing plot, otherwise start a new plot.
  col = NULL, ##<< color
  lab = NULL, ##<< axis label
  ... ##<< Graphical parameters
){
  if (!add) {
    rx = as.numeric(xy[1,c("xleft", "xright")])
    ry = as.numeric(xy[1,c("ybottom", "ytop")])
    plot(rx, ry, xlab = attr(xy, "vars")[1L], ylab = attr(xy, "vars")[2L],
     type = "n",  xaxs = "i", yaxs = "i", ...)
  }
  if (is.null(col)) {
    rn=matrix(runif(3*nrow(xy)),ncol=3)
    COL=rgb(rn[,1],rn[,2],rn[,3]);
  } else if (is.character(col)) {
    tmpCol= (xy[,col]+min(xy[,col]))
    tmpCol = tmpCol/max(tmpCol)
    COL = rgb(tmpCol,tmpCol,tmpCol, 0.4)
    #browser()
  } else {
    stopifnot(length(col)==nrow(xy))
    COL = col
  }
  
  for (i in 1:nrow(xy)) {  
    rect(xleft=xy[i,"xleft"], ybottom=xy[i,"ybottom"], xright=xy[i,"xright"], 
         ytop=xy[i,"ytop"], col = COL[i])
  }
  if (!is.null(lab)) {
    yy = t( xy[,c("yy1","yy2")])
    lab = as.character(xy[,"lab"])
    text(yy[1L, ], yy[2L, ], lab)
  }
}, ex = function(){
  #examples to come
  print(1)
})

Rect2PBSpolys = structure(function#simple utility function to convert object of rectangles into a PBSmapping type polygon
### convert stacked rectangles into a labeled matrix
(xy, ##<< object returned by \code{TreePartition}
 xcols=c("X","Y") ##<< column names for x and y coordinates
){
  N = nrow(xy)
  if (N==0) return(NULL)
  #browser()
  extraCols = setdiff(colnames(xy), c("xleft","ybottom","xright","ytop","yy1","yy2"))
  polys = cbind.data.frame(PID = rep(1:N, each=5), SID = rep(1,N*5), POS=rep(1:5, times=N), X= NA, Y=NA)
  for (cols in extraCols) polys[,cols] = NA
  for (i in 1:N){
    k = (i-1)*5+1;
    polys[k,xcols[1]]=xy[i,"xleft"];polys[k,xcols[2]]=xy[i,"ybottom"];
    polys[k+1,xcols[1]]=xy[i,"xright"];polys[k+1,xcols[2]]=xy[i,"ybottom"];
    polys[k+2,xcols[1]]=xy[i,"xright"];polys[k+2,xcols[2]]=xy[i,"ytop"];
    polys[k+3,xcols[1]]=xy[i,"xleft"];polys[k+3,xcols[2]]=xy[i,"ytop"];
    polys[k+4,xcols]=polys[k,xcols];
    for (cols in extraCols) polys[k:(k+4),cols] = xy[i,cols]
  }
  return(polys)
### PBSmapping type polygons
}, ex = function(){
  #examples to come
  print(1)
})

#Example code:
if (0){
  library(tree)
  data(cpus, package="MASS", envir = environment())
  cpus.ltr <- tree(log10(perf) ~ mmax+cach, cpus)
  cpus.tr <- tree(perf ~ mmax+cach, cpus)
  summary(lm(log10(perf) ~ 1, data=cpus))
  #cpus.ltr
  #summary(cpus.ltr)
  #plot(cpus.ltr);  text(cpus.ltr)
  
  xy=TreePartition(cpus.ltr,verbose=0)
  PlotPartition(xy)
  PlotPartition(xy,lab=TRUE)
  
  xy=TreePartition(cpus.tr,verbose=0)
  PlotPartition(xy,lab=TRUE)
  
  data(NYleukemia, envir = environment())
  population <- NYleukemia$data$population
  cases <- NYleukemia$data$cases
  mapNY <- GetMap(center=c(lat=42.67456,lon=-76.00365), destfile = "NYstate.png", zoom=8)
  mapNY <- ReadMapTile("NYstate.png")
  data = merge(NYleukemia$data,NYleukemia$geo,by="censustract.FIPS")
  polys = FindClusters(data,DENS=FALSE, OR2=0,OR1=1.2,minArea=10,maxArea=1000)
  
  LeukTree = tree(100*cases/population ~ x+y,data)
  
  xy=TreePartition(LeukTree,ordvars = c("x","y"), verbose=0)
  polys=Rect2PBSpolys(xy)
  ColorMap(100*data$cases/data$population, mapNY, polys, add = FALSE,
           alpha = 0.35, log = TRUE, location = "topleft")
  
  data(columbus, package="RgoogleMaps", envir = environment())
  crimeTree <- tree(CRIME ~ X+Y, columbus)
  xy=TreePartition(crimeTree,verbose=0)
  PlotPartition(xy,lab=TRUE)
  polys=Rect2PBSpolys(xy)
  mapOH <- GetMap(center=c(lat=mean(columbus$Y),lon=mean(columbus$X)), destfile = "OHcrime.png", 
                  maptype = "mobile", zoom=7)
  ColorMap(xy[,"yval"], mapOH, polys, add = FALSE,
           alpha = 0.35, log = TRUE, location = "topleft")
  
  help(columbus, package="spdep")
  slotNames(columbus)
  #columbus <- readShapePoly(system.file("etc/shapes/columbus.shp",                                 +                                       package="spdep")[1])
  plot(columbus)
  columbusPBS=SpatialToPBS(columbus)
  library("PBSmapping")
  plotPolys(columbusPBS$xy)
  plotPolys(columbusPBS$xy,col = rgb(columbus$CRIME/max(columbus$CRIME),0,0))
  PlotPolysOnStaticMap(mapOH, columbusPBS$xy)
}

