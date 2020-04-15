# benfords data package

pacman::p_load(pdftools, tidyverse, stringr, purrr, googlesheets4)

random_guess <- read_sheet("https://docs.google.com/spreadsheets/d/1TasFdyWr9xN7uWiWw0PkaFDwHYgQiC3y41YKR9CFRlA/edit#gid=0") 
rgall <- random_guess
random_guess <- rgall

random_guess <- random_guess %>%
  select(rand_09 = `Pick a random number from 1-10.
[Asked by: Rutgers]`,
rand_01m = `Pick a random number from 1-1,000,000.
[Asked by: Rutgers]`) %>%
  mutate(rand_09 = ifelse(rand_09 == 10, 0, rand_09) %>% as.integer()) %>%
  separate(rand_01m, into = c("junk", "last"), sep = -1) %>%
  select(-junk) %>%
  filter(!is.na(rand_09), !is.na(last)) 

pick_random <- left_join(
random_guess %>%
  count(rand_09, name = "n_09") %>%
  mutate(percent_09 = n_09/sum(n_09)) %>%
  rename(digit = rand_09) %>%
  mutate(digit = as.character(digit)),

random_guess %>%
  count(last, name = "n_last") %>%
  mutate(percent_last = n_last/sum(n_last)) %>%
  rename(digit = last)
)

  
waitlist_text <- pdf_text("data/bmjopen-2018-022079supp001.pdf")

waitlist_list <- map(waitlist_text, ~read_table(.x, col_names = FALSE))

other_pages <- bind_rows(waitlist_list[-1])

first_page <- waitlist_list[[1]][-1, -5]
colnames(first_page) <- colnames(other_pages)

waitlist <- bind_rows(first_page, other_pages)
colnames(waitlist) <- c("country", "type", "number", "month", "year", "details")

waitlist <- waitlist %>%
  mutate(month = str_remove_all(month, "number.patien")) %>%
  select(country, type, details, month, year, number) %>%
  separate(number, into = c("junk", "last"), sep = -1, remove = FALSE) %>%
  separate(number, into = "first", sep = 1, remove = FALSE) %>%
  select(-junk)

waitlist_spain <- filter(waitlist, country == "Spain")
waitlist_finland <- filter(waitlist, country == "Finland")

election_iran <- read_csv("https://github.com/midnightradio/cse140-data-programming/raw/master/homework6/election-iran-2009.csv") %>% 
  select(-contains("%")) %>%
  pivot_longer(Ahmadinejad:`Eligible voters`, names_to = "candidate", values_to = "number") %>%
  filter(!is.na(number)) %>%
  separate(number, into = c("junk", "last"), sep = -1, remove = FALSE) %>%
  separate(number, into = "first", sep = 1, remove = FALSE) %>%
  select(-junk) %>%
  rename_all(str_to_lower)


us_election_names <- read_lines("https://github.com/midnightradio/cse140-data-programming/raw/master/homework6/election-us-2008.csv", n_max = 1)  %>% 
  str_split(",") %>% 
  unlist() %>% .[-c(17,18)]

election_us <- read_csv("https://github.com/midnightradio/cse140-data-programming/raw/master/homework6/election-us-2008.csv", skip = 1, col_names = FALSE)  %>%
  select(-17, -18) %>%
  select(-str_which(us_election_names, "%"))

colnames(election_us) <- us_election_names[-str_which(us_election_names, "%")]

election_us <- election_us %>%
  pivot_longer(Obama:`Others votes`, names_to = "candidate", values_to = "number") %>%
  filter(!is.na(number)) %>%
  separate(number, into = c("junk", "last"), sep = -1, remove = FALSE) %>%
  separate(number, into = "first", sep = 1, remove = FALSE) %>%
  select(-junk, -Electors) %>%
  rename(region = State) %>%
  rename_all(str_to_lower)

election <- bind_rows(tibble(election_us, country = "US"),
                      tibble(election_iran, country = "Iran")) %>%
  select(country, everything())


cities_fiction <- read_tsv("https://github.com/midnightradio/cse140-data-programming/raw/master/homework6/literature-population.txt", col_names = FALSE) %>%
  rename(city_book = X1, number = X2) %>%
  separate(city_book, into = c("city", "location"), sep = "\\(") %>%
  mutate(city = str_trim(city), location = str_remove_all(location, "\\)")) %>%
  separate(number, into = c("junk", "last"), sep = -1, remove = FALSE) %>%
  separate(number, into = "first", sep = 1, remove = FALSE) %>%
  select(-junk) 

cities_us <- read_csv("data/uscities.csv") %>%
  mutate(location = str_c(state_name,", ", county_name)) %>%
  select(city, location, number = population) %>%
  separate(number, into = c("junk", "last"), sep = -1, remove = FALSE) %>%
  separate(number, into = "first", sep = 1, remove = FALSE) %>%
  select(-junk) 

cities <- bind_rows(tibble(cities_us, country = "US"),
                      tibble(cities_fiction, country = "Fiction")) %>%
  select(country, everything())

benford <- bind_rows(
cities %>%
  count(country, first) %>%
  filter(first !=0) %>%
  group_by(country) %>%
  mutate(percent = n/sum(n)) %>%
  mutate(data = "cities") %>%
  ungroup(),

election %>%
  count(country, first) %>%
  filter(first !=0) %>%
  group_by(country) %>%
  mutate(percent = n/sum(n)) %>%
  mutate(data = "elections") %>%
  ungroup(),

waitlist %>%
  count(country, first) %>%
  filter(first !=0) %>%
  group_by(country) %>%
  mutate(percent = n/sum(n)) %>%
  mutate(data = "waitlist") %>%
  ungroup()
) %>%
  select(data, everything()) %>%
  mutate(benford_percent = log(1 + 1/as.numeric(first))/log(10))


last_digit <- bind_rows(
  cities %>%
    count(country, last) %>%
    group_by(country) %>%
    mutate(percent = n/sum(n)) %>%
    mutate(data = "cities") %>%
    ungroup(),
  
  election %>%
    count(country, last) %>%
    group_by(country) %>%
    mutate(percent = n/sum(n)) %>%
    mutate(data = "elections") %>%
    ungroup(),
  
  waitlist %>%
    count(country, last) %>%
    group_by(country) %>%
    mutate(percent = n/sum(n)) %>%
    mutate(data = "waitlist") %>%
    ungroup()
) %>%
  select(data, everything()) %>%
  mutate(last_percent = 1/10)


cities_description <- list(city = "The city within the country",
                           location = "The region within which the city is located",
                           number = "The population of that city",
                           first = "The first digit of number",
                           last = "The last digit of number")
waitlist_description <- list(type = "The type of medical procedure",
                             details = "Further details about the medical procedure",
                             month = "The month of the year",
                             year = "Year",
                             number = "The number of people on the waitlist",
                             first = "The first digit of number",
                             last = "The last digit of number"
                             )
election_description <- list(region = "The region within which the election votes were tallied",
                             candidate = "The name of the electoral candidate",
                             number = "The number of votes cast for the candidate",
                             first = "The first digit of number",
                             last = "The last digit of number")

benford_description <- list(data = "The data object used to calculate digit counts",
                            country = "The location or group within each data object",
                            first = "The first digit number",
                            n = "The count of numbers that started with that digit",
                            percent = "The percent of the total for each data and country group",
                            benford_percent = "The expected propoprtion under Benford's law")

last_digit_description <- list(data = "The data object used to calculate digit counts",
                            country = "The location or group within each data object",
                            last = "The last digit number",
                            n = "The count of numbers that ended with that digit",
                            percent = "The percent of the total for each data and country group",
                            last_percent = "The expected propoprtion under complete randomness")



pick_random_description <- list(digit = "The number of interest between 0-9",
                                n_09 = "The count of people that picked that digit. Note 10s were changed to 0",
                                percent_09 = "The percentage of each digit of the total for the 0-9 digit counts",
                                n_last = "The count of the last digit of numbers picked between 0 and 1 million.",
                                percent_last = "The percentage of each digt of the total for the last digit counts.")

## Build package

package_name_text <- "data4benfords"
base_folder <- "../../byuidatascience/"
user <- "byuidatascience"
package_path <- str_c(base_folder, package_name_text)


####  Run to create repo locally and on GitHub.  ######

# github_info <- dpr_create_github(user, package_name_text)
#   
# package_path <- dpr_create_package(list_data = NULL,
#                                      package_name = package_name_text,
#                                      export_folder = base_folder,
#                                       git_remote = github_info$clone_url)

##### dpr_delete_github(user, package_name_text) ####

####### End create section
github_info <- dpr_info_github(user, package_name_text)
usethis::proj_set(package_path)

usethis::use_data(waitlist, waitlist_finland, waitlist_spain,
                  election, election_iran, election_us,
                  cities, cities_fiction, cities_us,
                  pick_random, benford, last_digit)

usethis::use_data(benford, last_digit)

dpr_export(pick_random, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(benford, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(last_digit, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))

## Waitlist data

dpr_export(waitlist, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(waitlist_finland, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(waitlist_spain, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))


dpr_export(election, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(election_us, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(election_iran, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))


dpr_export(cities, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(cities_fiction, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))
dpr_export(cities_us, export_folder = path(package_path, "data-raw"), 
           export_format = c(".csv", ".json", ".xlsx", ".sav", ".dta"))


##### Cities data

dpr_document(cities, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "cities", title = "The population of US cities and cities from fictional sources",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://github.com/midnightradio/cse140-data-programming and https://simplemaps.com/data/us-cities",
             var_details = c(country = "Either US or fiction",cities_description))


dpr_document(cities_us, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "cities_us", title = "The population of US cities",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://simplemaps.com/data/us-cities",
             var_details = cities_description)

dpr_document(cities_fiction, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "cities_fiction", title = "The population of cities from fictional sources",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://github.com/midnightradio/cse140-data-programming",
             var_details = cities_description)

## Waitlist data

dpr_document(waitlist, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "waitlist", 
             title = "The count of citizens on waitlists for medical procedures",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/",
             var_details = c(country = "The source country of the data", waitlist_description))

dpr_document(waitlist_finland, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "waitlist_finland", 
             title = "The count of Finish citizens on waitlists for medical procedures",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/",
             var_details = c(country = "The source country of the data", waitlist_description))
                          
dpr_document(waitlist_spain, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "waitlist_spain", 
             title = "The count of Spanish citizens on waitlists for medical procedures",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/",
             var_details =c(country = "The source country of the data", waitlist_description))

#### Election data


dpr_document(election, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "election", 
             title = "The election results for Iran and US presidential elections",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://github.com/midnightradio/cse140-data-programming",
             var_details = c(country = "The source country of the data", election_description))

dpr_document(election_iran, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "election_iran", 
             title = "The election results for the 2009 presidential elections in Iran",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://github.com/midnightradio/cse140-data-programming",
             var_details = election_description)

dpr_document(election_us, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "election_us", 
             title = "The election results for the Obama McCain presidential elections in the US",
             description = "The data is built to have the count in the number column with the first and last digit separated",
             source = "https://github.com/midnightradio/cse140-data-programming",
             var_details = election_description)

## tabulated data 

dpr_document(benford, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "benford", 
             title = "The counts and percentage of first digits for all data objects",
             description = "This data has to counts by first digit for the election, waitlist, and cities data",
             source = "https://github.com/midnightradio/cse140-data-programming, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/, and https://simplemaps.com/data/us-cities",
             var_details = benford_description)

dpr_document(last_digit, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "last_digit", 
             title = "The counts and percentage of last digits for all data objects",
             description = "This data has to counts by last digit for the election, waitlist, and cities data",
             source = "https://github.com/midnightradio/cse140-data-programming, https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942457/, and https://simplemaps.com/data/us-cities",
             var_details = benford_description)

dpr_document(pick_random, extension = ".md.R", export_folder = usethis::proj_get(),
             object_name = "pick_random", 
             title = "The counts and percentage of last digits for college students asked to pick random numbers",
             description = "This data has to counts by last digit for the random guesses",
             source = "https://docs.google.com/spreadsheets/d/1TasFdyWr9xN7uWiWw0PkaFDwHYgQiC3y41YKR9CFRlA/edit#gid=0 and https://www.reddit.com/r/dataisbeautiful/comments/acow6y/asking_over_8500_students_to_pick_a_random_number/",
             var_details = pick_random_description)

### Finalize package stuff ###
### 

dpr_write_script(folder_dir = usethis::proj_get(), r_read = "scripts/benford_package.R", 
                 r_folder_write = "data-raw", r_write = str_c(package_name_text, ".R"))

dpr_readme(usethis::proj_get(), package_name_text, user)

dpr_push(folder_dir = usethis::proj_get(), message = "'Second Push'", repo_url = NULL)




# https://www.isaca.org/resources/isaca-journal/past-issues/2010/using-spreadsheets-and-benfords-law-to-test-accounting-data
# http://shiny.stat.calpoly.edu/BenfordData/
# https://courses.cs.washington.edu/courses/cse140/13wi/homework/hw6/assignment.html
# https://github.com/midnightradio/cse140-data-programming/blob/master/homework6/election-iran-2009.csv
# https://github.com/midnightradio/cse140-data-programming/blob/master/homework6/election-us-2008.csv
# https://github.com/midnightradio/cse140-data-programming/blob/master/homework6/literature-population.txt
# find data for city populations use marathon data set or R city data set.
# https://www.youtube.com/watch?v=XXjlR2OK1kM
# https://www.youtube.com/watch?v=tP-Ipsat90c&feature=youtu.be
# 
