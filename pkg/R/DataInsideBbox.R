DataInsideBox = structure(function# returns subset of data within bounding box 
(
  PBSbox, ##<< rectangle in PBSmapping format, i.e. at least 4 rows!
  data, ##<< data to subset
  xycoords = c("X","Y"), ##<< spatial coordinates names
  verbose=0 ##<< level of verbosity
){
  xr = range(PBSbox[,xycoords[1]],na.rm=TRUE)
  yr = range(PBSbox[,xycoords[2]],na.rm=TRUE)

  xi = data[,xycoords[1]] >= xr[1] & data[,xycoords[1]] <= xr[2]
  yi = data[,xycoords[2]] >= yr[1] & data[,xycoords[2]] <= yr[2]
  
  return(data[xi&yi,])
}, ex = function(){
  #examples to come
  print(1)
})


Rect =  structure(function#wrapper for base R rect function
(x, ##<< vector of length 4 with order xleft, ybottom, xright, ytop
 ... ##<< further args to rect
 ){
  rect(x[1],x[2],x[3],x[4],...)
}, ex = function(){
  #examples to come
  print(1)
})

