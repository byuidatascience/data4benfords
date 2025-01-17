% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{cities}
\alias{cities}
\title{The population of US cities and cities from fictional sources}
\format{
A data frame with columns:
\describe{
 \item{country}{The variable is character. Either US or fiction}
 \item{city}{The variable is character. The city within the country}
 \item{location}{The variable is character. The region within which the city is located}
 \item{number}{The variable is numeric. The population of that city}
 \item{first}{The variable is character. The first digit of number}
 \item{last}{The variable is character. The last digit of number}
}
}
\source{
\url{https://github.com/midnightradio/cse140-data-programming and https://simplemaps.com/data/us-cities}
}
\usage{
cities
}
\description{
The data is built to have the count in the number column with the first and last digit separated
}
\examples{
\dontrun{
cities
}
}
\keyword{datasets}
