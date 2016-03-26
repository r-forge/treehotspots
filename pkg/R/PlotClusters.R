if (0) {
#   drugPhrases=c("opium","methadone","marijuana","hallucinogenic","heroin",
#                 "opiates","cocaine","amphetamine","drugs", "narcotics","controlled substance")
#   robbery = c("robbery")
#   burglary = c("burglary")
#   bicycles="bicycles"
#   PeopleMissing = c("missing")
#   drugCrimes = FilterCrimes(2007:2013, KeyWords=drugPhrases, file = "data/drugCrimes.rda")
#   robberyCrimes = FilterCrimes(2007:2013, KeyWords=robbery, file = "data/robberyCrimes.rda")
#   burglaryCrimes = FilterCrimes(2007:2013, KeyWords=burglary, file = "data/burglaryCrimes.rda")
#   missingCrimes = FilterCrimes(2007:2013, KeyWords=PeopleMissing, file = "data/missingCrimes.rda")
#   
#   drugPolys = PlotCrimeClusters("data/drugCrimes.rda", TRUE)
#   #PlotCrimeClusters("data/drugCrimes.rda", TRUE, polys = drugPolys)
#   drugPolysRel = PlotCrimeClusters("data/drugCrimes.rda", FALSE)
#   #PlotCrimeClusters("data/drugCrimes.rda", TRUE, polys = drugPolysRel)
#   robberyPolys = PlotCrimeClusters("data/robberyCrimes.rda", TRUE)
#   #PlotCrimeClusters("data/robberyCrimes.rda", TRUE, polys = robberyPolys)
#   burglaryPolys = PlotCrimeClusters("data/burglaryCrimes.rda", TRUE)
#   burglaryPolysRel = PlotCrimeClusters("data/burglaryCrimes.rda", FALSE)
#   
#   
#     TimeOfWeekModelGAM = bam(violent ~ s(HourOfWeek, k=60,  bs = "cc") , data=crimes, family=binomial(link="logit"))
#     Figure.RateHrOfWeek(main="burglaries")
#      
#   load("data/drugCrimes.rda")
#   PlotCrimes(SFzoom12, incidents=crimes, polys=NULL, cex = 0.45, alpha = 0.4)
#   PlotCrimes(SFMap, incidents = subset(crimes, violent == TRUE), polys = NULL, cex = 0.45, alpha =0.4)
#   
#              
#   polys = FindClusters(crimes,DENS=FALSE, OR2=0,OR1=1.2,minArea=10,maxArea=1000)
#   polys = FindClusters(subset(crimes, violent == TRUE),DENS=TRUE, OR2=0,OR1=1.2,minArea=10,maxArea=1000)
#   
#   polys2 = polys[1:50,];#top ten clusters #subset(polys, yval>5)
#   yval=round(polys2[polys2[,"POS"]==1,"yval"],1)
#   ColorMap(yval, SFzoom13, polys2, add = FALSE, alpha = 0.35, log = FALSE,
#            include.legend = list(FALSE), textInPolys=yval)
}
    
PlotClusters = structure(function#plot clusters on a map
###plot clusters on a static Google map
(crimeFile="data/drugCrimes.rda", ##<< rda file containing point data
 DENS=FALSE, ##<< logical indicating density based clusters
 polys, ##<< clusters/polygons to draw
 map, ##<< map object 
 topClus=10 ##<< how many clusters to draw (ranked)
){
  
  #PlotCrimes(SFzoom12, incidents=crimes, polys=NULL, cex = 0.45, alpha = 0.4)
  #PlotCrimes(SFMap, incidents = subset(crimes, violent == TRUE), polys = NULL, cex = 0.45, alpha =0.4)
  
  if (missing(polys)) {
    load(crimeFile)#data(drugCrimes)
    crimes$violent = as.logical(crimes$violent)
    if (DENS) crimes = subset(crimes, violent == TRUE)
    polys = FindClusters(crimes,DENS=DENS, OR2=0,OR1=1.2,minArea=10,maxArea=1000)
  }
  #polys = FindClusters(subset(crimes, violent == TRUE),DENS=TRUE, OR2=0,OR1=1.2,minArea=10,maxArea=1000)
  
  topClus = min(c(topClus, nrow(polys)/5))
  polys2 = polys[1:(5*topClus),];#top ten clusters #subset(polys, yval>5)
  yval=round(polys2[polys2[,"POS"]==1,"yval"],1)
  #browser()
  ColorMap(yval, map, polys2, add = FALSE, alpha = 0.35, log = FALSE,
           include.legend = list(FALSE), textInPolys=yval)
  
  invisible(polys)
### clusters found/passed
}, ex = function(){
  #data(drugCrimes)
  #PlotClusters()
  #examples to come
  print(1)
})


