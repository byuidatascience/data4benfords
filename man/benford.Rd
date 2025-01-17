% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{benford}
\alias{benford}
\title{The counts and percentage of first digits for all data objects}
\format{
A data frame with columns:
\describe{
 \item{data}{The variable is character. The data object used to calculate digit counts}
 \item{country}{The variable is character. The location or group within each data object}
 \item{first}{The variable is character. The first digit number}
 \item{n}{The variable is integer. The count of numbers that started with that digit}
 \item{percent}{The variable is numeric. The percent of the total for each data and country group}
 \item{benford_percent}{The variable is numeric. The expected propoprtion under Benford's law}
}
}
\source{
\url{https://github.com/midnightradio/cse140-data-programming, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/, and https://simplemaps.com/data/us-cities}
}
\usage{
benford
}
\description{
This data has to counts by first digit for the election, waitlist, and cities data
}
\examples{
\dontrun{
benford
}
}
\keyword{datasets}
