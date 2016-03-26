\name{crimes}
\alias{crimes}
\docType{data}
\title{
crime data from San Francisco classified as drug crimes
}
\description{
data downloaded from url
}
\usage{data(crimes)}
\format{
  A data frame with 97248 observations on the following 17 variables.
  \describe{
%    \item{IncidntNum}{incident number} 
 %  \item{Category}{crime category} 
    \item{Descript}{description of crime} 
    \item{DayOfWeek}{day of week} 
    \item{Date}{date} 
    \item{Time}{time} 
    \item{PdDistrict}{police district} 
 %  \item{Resolution}{Outcome} 
  %  \item{Location}{address} 
    \item{X}{latitude} 
    \item{Y}{longitude} 
    \item{violent}{logical indicating violent crime} 
%    \item{HrOfDay}{hour of day} 
%    \item{TimeOfDay}{time of day} 
%    \item{HourOfWeek}{hour of week, ranging from 0 to 168} 
%    \item{PhaseOfWeek}{phase of week} 
%    \item{MATCH}{not sure}
  }
}
\details{
crime data from San Francisco filtered by drug category. 25K rows randomly sampled.
}
\source{
	\url{http://www.datasf.org/story.php?title=crime-incident-data}
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(crimes)
 str(crimes)
}
\keyword{datasets}
