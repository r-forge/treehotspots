list.rules = structure(function#compute rules for terminal nodes
### extract rules for leaf nodes in both string and numeric form
(
  x, ##<< object of class partykit
  i = NULL, ##<< node number; if missing all nodes
  verbose=0 ##<< level of verbosity
){
    if (is.null(i)) 
        i <- nodeids(x, terminal = TRUE)
    if (length(i) > 1) {
        ret <- sapply(i, list.rules, x = x, verbose=verbose)
        names(ret) <- if (is.character(i)) 
            i
        else names(x)[i]
        return(ret)
    }
    if (is.character(i) && !is.null(names(x))) 
        i <- which(names(x) %in% i)
    stopifnot(length(i) == 1 & is.numeric(i))
    stopifnot(i <= length(x) & i >= 1)
    i <- as.integer(i)
    if (verbose) cat("working on node ", i, "....\n")
    dat <- data_party(x, i)
    if (!is.null(x$fitted)) {
        findx <- which("(fitted)" == names(dat))[1]
        fit <- dat[, findx:ncol(dat), drop = FALSE]
        dat <- dat[, -(findx:ncol(dat)), drop = FALSE]
        if (ncol(dat) == 0) 
            dat <- x$data
    } else {
        fit <- NULL
        dat <- x$data
    }
    rule <- c()
    ruleMatrix = NULL#numerical version of rules
    ruleMatrix = matrix(NA,nrow=ncol(dat),ncol=4,
                   dimnames=list(colnames(dat),c(">","<=", ">=","<")))#numerical version of rules
    
    #NumRule = list()
    recFun <- function(node) {
        if (id_node(node) == i) 
            return(NULL)
        kid <- sapply(kids_node(node), id_node)
        whichkid <- max(which(kid <= i))
        split <- split_node(node)
        ivar <- varid_split(split)
        svar <- names(dat)[ivar]
        index <- index_split(split)
        if (is.factor(dat[, svar])) {
            slevels <- levels(dat[, svar])[index == whichkid]
            srule <- paste(svar, " %in% c(\"", paste(slevels, 
                collapse = "\", \"", sep = ""), "\")", sep = "")
        }
        else {
            if (is.null(index)) 
                index <- 1:length(kid)
            breaks <- cbind(c(-Inf, breaks_split(split)), c(breaks_split(split), 
                Inf))
            sbreak <- breaks[index == whichkid, ]
            right <- right_split(split)
            srule <- c()
            #nrule = matrix(c(-Inf,Inf,-Inf,Inf),nrow=1,
            #               dimnames=list(svar,c(">","<=", ">=","<")))#numerical version of rules
            
            if (is.finite(sbreak[1])) {
                gs = ifelse(right, ">", ">=")
                srule <- c(srule, paste(svar, gs, sbreak[1]))
                #nrule[1,gs] = sbreak[1]
                ruleMatrix[svar,gs] = max(ruleMatrix[svar,gs], sbreak[1], na.rm=TRUE)
                
            }
            if (is.finite(sbreak[2])) {
              gs = ifelse(right, "<=", "<")
                srule <- c(srule, paste(svar, gs, sbreak[2]))
                #nrule[1,gs] = sbreak[2]
                ruleMatrix[svar,gs] = min(ruleMatrix[svar,gs], sbreak[2], na.rm=TRUE)
            }
            srule <- paste(srule, collapse = " & ")
            
        }
        rule <<- c(rule, srule)
        ruleMatrix <<- ruleMatrix
        # if (is.null(ruleMatrix)) {
        #   ruleMatrix <<- nrule
        # } else {
        #   ruleMatrix <<- rbind(ruleMatrix, nrule)
        # }
        
        return(recFun(node[[whichkid]]))
    }
    node <- recFun(node_party(x))
    #NumRule[[as.character(i)]] = ruleMatrix
    if (verbose) {
      print(NumRule[[i]])
    }
    #ruleMatrix = ruleMatrix[rowSums(is.na(ruleMatrix))<4,,drop=FALSE]
    #ruleMatrix = ruleMatrix[,colSums(is.na(ruleMatrix))<nrow(ruleMatrix)]
    #return(paste(rule, collapse = " & "))
    return(list(CharRule=paste(rule, collapse = " & "),ruleMatrix=ruleMatrix))
}, ex = function(){
  #examples to come
  print(1)
})

Rules2BoundingBox = structure(function#return bounding box of leaf node
  (
  ruleMatrix, ##<< object returned by list.rules
  bbox = list(lon=c(40,60), lat=c(20,30)), ##<<replace Inf values with the corresponding bounding box limits
  verbose=0 ##<< level of verbosity
){
  #first eliminate the pair of columns that is all NA:
  Left=colSums(is.na(ruleMatrix[,1:2]))
  Right=colSums(is.na(ruleMatrix[,3:4]))
  if (all(Right == nrow(ruleMatrix))){
    ruleMatrix=ruleMatrix[,1:2]
  } else if (all(Left == nrow(ruleMatrix))){
    ruleMatrix=ruleMatrix[,3:4]
  } else {
    stop("Unexpected mixing of right/left rules!")
    #return()
  }
  for (var in names(bbox)){
    j = which(is.na(ruleMatrix[var,]))
    ruleMatrix[var,j] = bbox[[var]][j]
  }
  return(ruleMatrix)
}, ex = function(){
  #examples to come
  print(1)
})


#########################################
if (0){
  tmp=list.rules(ct,11, verbose=0)
  tmp$ruleMatrix
  rownames(tmp$ruleMatrix)
  
  dat <- data_party(ct, 1)
  colnames(dat)[1] ="clus"
  BBOX = list(lon=range(dat$lon,na.rm=TRUE),lat=range(dat$lat,na.rm=TRUE))
  #or with a buffer:
  pb = par("usr")
  BBOX = list(lon=pb[1:2],lat= pb[3:4])
  Leaf = Rules2BoundingBox(tmp$ruleMatrix,bbox=BBOX)
  rect(xleft=Leaf["lon",">"], ybottom=Leaf["lat",">"], xright=Leaf["lon","<="], ytop=Leaf["lat","<="])
  
  plot(lat~lon, data=dat, col = clus, pch = 20,cex=0.75)
  
  Leafs = list()
  for (i in nodeids(ct, terminal = TRUE)){
     tmp = list.rules(ct,i,verbose=0)
     Leaf = Rules2BoundingBox(tmp$ruleMatrix,bbox=BBOX)
     rect(xleft=Leaf["lon",">"], ybottom=Leaf["lat",">"], xright=Leaf["lon","<="], ytop=Leaf["lat","<="])
     Leafs[[as.character(i)]]= Leaf
  }
  #draw rectangles
  for (i in nodeids(ct, terminal = TRUE)){
    Leaf=Leafs[[as.character(i)]]
    rect(xleft=Leaf["lon",">"], ybottom=Leaf["lat",">"], xright=Leaf["lon","<="], ytop=Leaf["lat","<="])
    text(mean(Leaf["lon",]), mean(Leaf["lat",]), i, col = "purple")
  }
}
