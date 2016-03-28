\name{drugCrimes}
\alias{drugCrimes}
\docType{data}
\title{
crime data from San Francisco classified as drug crimes
}
\description{
data downloaded from url
}
\usage{data(drugCrimes)}
\format{
  A data frame with 97248 observations on the following 17 variables.
  \describe{
   \item{Category}{crime category} 
    \item{Date}{date} 
    \item{DayOfWeek}{day of week}
    \item{Descript}{description of crime} 
    \item{HourOfWeek}{hour of week, ranging from 0 to 168}
     \item{HrOfDay}{hour of day}
    \item{IncidntNum}{Incident Number} 
   \item{Location}{address} 
   \item{MATCH}{logical flag indicating drug keyword match} 
    \item{PdDistrict}{police district} 
   \item{PhaseOfWeek}{phase of week} 
   \item{Resolution}{Outcome} 
  \item{Time}{time}
  \item{TimeOfDay}{time of day} 
    \item{X}{latitude} 
    \item{Y}{longitude} 
    \item{violent}{logical indicating violent crime} 
 
  }
}
\details{
crime data from San Francisco filtered by drug category. 
The keywords searched for in the Descript field are:
drugPhrases=c("opium","methadone","marijuana","hallucinogenic","heroin",
                "opiates","cocaine","amphetamine","drugs", "narcotics","controlled substance")

table(drugCrimes$MATCH)

years: 2007:2013
35K additional rows randomly sampled.

The call is:
#source('H:/DropboxHWR/myPapers/JSS2015/FinalSubmission/RcodeForFigures/InterestingClusters.R')

drugCrimes = FilterCrimes(2007:2013, KeyWords=drugPhrases,                                                        file = "data/drugCrimes.rda")

}
\source{
	\url{http://www.datasf.org/story.php?title=crime-incident-data}
}

\examples{
 data(drugCrimes)
 plot(Y~X,data=drugCrimes,col=MATCH+1,pch=20,cex=0.6)
 
}
\keyword{datasets}
