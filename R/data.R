#'
#' @title The population of US cities and cities from fictional sources
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{country}{The variable is character. Either US or fiction}
#'  \item{city}{The variable is character. The city within the country}
#'  \item{location}{The variable is character. The region within which the city is located}
#'  \item{number}{The variable is numeric. The population of that city}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming and https://simplemaps.com/data/us-cities}
#' @examples
#' \dontrun{
#' cities
#'}
'cities'



#'
#' @title The population of US cities
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{city}{The variable is character. The city within the country}
#'  \item{location}{The variable is character. The region within which the city is located}
#'  \item{number}{The variable is numeric. The population of that city}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://simplemaps.com/data/us-cities}
#' @examples
#' \dontrun{
#' cities_us
#'}
'cities_us'



#'
#' @title The population of cities from fictional sources
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{city}{The variable is character. The city within the country}
#'  \item{location}{The variable is character. The region within which the city is located}
#'  \item{number}{The variable is numeric. The population of that city}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming}
#' @examples
#' \dontrun{
#' cities_fiction
#'}
'cities_fiction'



#'
#' @title The count of citizens on waitlists for medical procedures
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{country}{The variable is character. The source country of the data}
#'  \item{type}{The variable is character. The type of medical procedure}
#'  \item{details}{The variable is character. Further details about the medical procedure}
#'  \item{month}{The variable is character. The month of the year}
#'  \item{year}{The variable is numeric. Year}
#'  \item{number}{The variable is numeric. The number of people on the waitlist}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/}
#' @examples
#' \dontrun{
#' waitlist
#'}
'waitlist'






#'
#' @title The count of Finish citizens on waitlists for medical procedures
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{country}{The variable is character. The source country of the data}
#'  \item{type}{The variable is character. The type of medical procedure}
#'  \item{details}{The variable is character. Further details about the medical procedure}
#'  \item{month}{The variable is character. The month of the year}
#'  \item{year}{The variable is numeric. Year}
#'  \item{number}{The variable is numeric. The number of people on the waitlist}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/}
#' @examples
#' \dontrun{
#' waitlist_finland
#'}
'waitlist_finland'



#'
#' @title The count of Spanish citizens on waitlists for medical procedures
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{country}{The variable is character. The source country of the data}
#'  \item{type}{The variable is character. The type of medical procedure}
#'  \item{details}{The variable is character. Further details about the medical procedure}
#'  \item{month}{The variable is character. The month of the year}
#'  \item{year}{The variable is numeric. Year}
#'  \item{number}{The variable is numeric. The number of people on the waitlist}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/}
#' @examples
#' \dontrun{
#' waitlist_spain
#'}
'waitlist_spain'



#'
#' @title The election results for Iran and US presidential elections
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{country}{The variable is character. The source country of the data}
#'  \item{region}{The variable is character. The region within which the election votes were tallied}
#'  \item{candidate}{The variable is character. The name of the electoral candidate}
#'  \item{number}{The variable is numeric. The number of votes cast for the candidate}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming}
#' @examples
#' \dontrun{
#' election
#'}
'election'



#'
#' @title The election results for the 2009 presidential elections in Iran
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{region}{The variable is character. The region within which the election votes were tallied}
#'  \item{candidate}{The variable is character. The name of the electoral candidate}
#'  \item{number}{The variable is numeric. The number of votes cast for the candidate}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming}
#' @examples
#' \dontrun{
#' election_iran
#'}
'election_iran'



#'
#' @title The election results for the Obama McCain presidential elections in the US
#' @description The data is built to have the count in the number column with the first and last digit separated
#' @format A data frame with columns:
#' \describe{
#'  \item{region}{The variable is character. The region within which the election votes were tallied}
#'  \item{candidate}{The variable is character. The name of the electoral candidate}
#'  \item{number}{The variable is numeric. The number of votes cast for the candidate}
#'  \item{first}{The variable is character. The first digit of number}
#'  \item{last}{The variable is character. The last digit of number}
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming}
#' @examples
#' \dontrun{
#' election_us
#'}
'election_us'






#'
#' @title The counts and percentage of first digits for all data objects
#' @description This data has to counts by first digit for the election, waitlist, and cities data
#' @format A data frame with columns:
#' \describe{
#'  \item{data}{The variable is character. The data object used to calculate digit counts}
#'  \item{country}{The variable is character. The location or group within each data object}
#'  \item{first}{The variable is character. The first digit number}
#'  \item{n}{The variable is integer. The count of numbers that started with that digit}
#'  \item{percent}{The variable is numeric. The percent of the total for each data and country group}
#'  \item{benford_percent}{The variable is numeric. The expected propoprtion under Benford's law}
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/, and https://simplemaps.com/data/us-cities}
#' @examples
#' \dontrun{
#' benford
#'}
'benford'



#'
#' @title The counts and percentage of last digits for all data objects
#' @description This data has to counts by last digit for the election, waitlist, and cities data
#' @format A data frame with columns:
#' \describe{
#'  \item{data}{The variable is character. The data object used to calculate digit counts}
#'  \item{country}{The variable is character. The location or group within each data object}
#'  \item{last}{The variable is character. }
#'  \item{n}{The variable is integer. The count of numbers that started with that digit}
#'  \item{percent}{The variable is numeric. The percent of the total for each data and country group}
#'  \item{last_percent}{The variable is numeric. }
#' }
#' @source \url{https://github.com/midnightradio/cse140-data-programming, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/, and https://simplemaps.com/data/us-cities}
#' @examples
#' \dontrun{
#' last_digit
#'}
'last_digit'



#'
#' @title The counts and percentage of last digits for college students asked to pick random numbers
#' @description This data has to counts by last digit for the random guesses
#' @format A data frame with columns:
#' \describe{
#'  \item{digit}{The variable is character. The number of interest between 0-9}
#'  \item{n_09}{The variable is integer. The count of people that picked that digit. Note 10s were changed to 0}
#'  \item{percent_09}{The variable is numeric. The percentage of each digit of the total for the 0-9 digit counts}
#'  \item{n_last}{The variable is integer. The count of the last digit of numbers picked between 0 and 1 million.}
#'  \item{percent_last}{The variable is numeric. The percentage of each digt of the total for the last digit counts.}
#' }
#' @source \url{https://docs.google.com/spreadsheets/d/1TasFdyWr9xN7uWiWw0PkaFDwHYgQiC3y41YKR9CFRlA/edit#gid=0 and https://www.reddit.com/r/dataisbeautiful/comments/acow6y/asking_over_8500_students_to_pick_a_random_number/}
#' @examples
#' \dontrun{
#' pick_random
#'}
'pick_random'



