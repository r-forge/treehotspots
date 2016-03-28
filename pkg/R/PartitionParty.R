PartitionParty = structure(function#Plot the partitions of a partykit tree model
### COmputes and plots the partitions of a partykit tree model in 2 dimensions.                           
(
 ct, ##<< object of class partykit
 vars = c("lon","lat"), ##<< variable names in 2D
 BBOX, ##<< bounding box
 PLOT = TRUE, ##<< overlay retangles?
 labs = TRUE, ##<< add node ID labels to plot ?
 verbose=0 ##<< level of verbosity
){
 if (is.null(vars)){
   vars=attr(formula(ct),"term.labels")
   stopifnot(!is.null(vars), "variables cannot be extracted from model!")
 }
 if (missing(BBOX)){
   pb = par("usr")
   BBOX = list(lon=pb[1:2],lat= pb[3:4])
   names(BBOX) = vars
   if (verbose) print(BBOX)
 }
 Leafs = list()
 for (i in partykit::nodeids(ct, terminal = TRUE)){
   tmp = list.rules(ct,i,verbose=0)
   Leaf = Rules2BoundingBox(tmp$ruleMatrix,bbox=BBOX)
   if (verbose>1) browser()
   #gt=grep(">", colnames(Leaf));lt=grep("<", colnames(Leaf))
   #rect(xleft=Leaf[vars[1],gt], ybottom=Leaf[vars[2],gt], xright=Leaf[vars[1],lt], ytop=Leaf[vars[2],lt])
   Leafs[[as.character(i)]]= Leaf
 }
 #draw rectangles
 if (PLOT){
   for (i in partykit::nodeids(ct, terminal = TRUE)){
     Leaf=Leafs[[as.character(i)]]
     gt=grep(">", colnames(Leaf));lt=grep("<", colnames(Leaf))
     rect(xleft=Leaf[vars[1],gt], ybottom=Leaf[vars[2],gt], xright=Leaf[vars[1],lt], ytop=Leaf[vars[2],lt])
     if (labs) text(mean(Leaf[vars[1],]), mean(Leaf[vars[2],]), i, col = "purple")
   }
 }
 invisible(Leafs)
}, ex = function(){
 if (0){
   
   library(partykit)
   library(rpart)
   #unimodal bump
   data(data1, envir = environment())
   rp = rpart(l ~ x + y, data = data1)
   #plot(rp)
   party_rp <- partykit::as.party(rp)
   plot(party_rp)
   
   plot(y ~ x, col = as.numeric(l), data = data1, cex = 0.5, pch=20)
   PartitionParty(party_rp,vars=c("x","y"), verbose=0)
   
   #elliptical bump:
   data(data2, envir = environment())
   rp = rpart(l ~ x + y, data = data2)
   #plot(rp)
   party_rp <- as.party(rp)
   plot(party_rp)
   
   plot(y ~ x, col = as.numeric(l)-1, data = data2, cex = 0.5, pch=20)
   PartitionParty(party_rp,vars=c("x","y"), verbose=0) 
   
   #Artifial data at multiple scales and angles:
   data(msdata, envir = environment())
   ct <- ctree(clus ~ lon+lat,data = msdata,
               control = ctree_control(multiway=TRUE))
   
   plot(ct)
   plot(lat ~ lon,data = msdata, col = clus, pch=20,cex=0.6)
   PartitionParty(ct,vars=c("lon","lat"), verbose=0)
 }
 print(1)
})
