# data wrangling with R

# prefer dplyr functions below
library(conflicted)
library(tidyverse)

conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")

install.packages("nycflights13")

??flights

my_data <- nycflights13::flights

head(my_data)

# First we will just look at the data on oct 14
filter(my_data, month == 10, day == 14)

# If we want to subset this into a new variable
oct_14_flights <- filter(my_data, month == 10, day == 14)

# What if you want to print and save variable
(oct_14_flights_2 <- filter(my_data, month == 10, day == 14))

# if you want to filter based on different operators

# Equals ==
# Not equal to != 
# Greater than >
# Less than <
# Greater than or equal to >=
# Less than or equal to <=

(flights_through_september <- filter(my_data, month < 10))

# If we don't use the == we get this error:
# oct_14_flights = filter(my_data, month = 10, day = 14)

# You can also use logical operators to be more selective

# and &
# or |
# not !

# Lets use the "or" function to pick flights in march and april
(march_april_flights <- filter(my_data, month == 3 | month == 4))

# tinkering
N706Jb_flights <- filter(my_data, tailnum == "N706JB" & origin == "JFK" & dest == "FLL")
count(N706Jb_flights)

# Arrange allows us to arrange the dataset based on the variables we desire (sort by)

arrange(my_data, year, day, month)

# we can also do this in desc fashion
descending_data <- arrange(my_data, desc(year), desc(day), desc(month))

# Missing values are always placed at the end of the data frame regardless of ascending or descending

# Select allows you to select specific columns to view
calendar <- select(my_data, year, month, day)

# we can also look at a range of columns
calendar2 <- select(my_data, year:carrier)

# choose which columns not to include
everything_else <- select(my_data, -(year:day))
# or
everything_else2 <- select(my_data, !(year:day))

# There are some helper functions that can help you select the columns or data you are looking for
# starts_with("xyz") -- will select the values that start with "xyz" can also do "ends_with()" and "contains()"
# matches - similar to contains but must match identically]

# example - only runs through column names... not values
# flight_col <- select(my_data, starts_with("flight"))


head(my_data)

my_data2 <- rename(my_data, departure_time = dep_time) # change name of column from dep_time to departure_time

# or save to same variable - permanent change
# my_data <- rename(my_data, departure_time = dep_time)

# filter by tailnum that has N1
N1_tailnums <- filter(my_data, str_detect(tailnum, "N1"))

# Mutate - add new columns to data frame
# Lets create a smaller data frame
my_data_small <- select(my_data, year:day, distance, air_time)
# Lets calculate the speed of the flights
mutate(my_data_small, speed = distance / air_time * 60) # mph
my_data_small <- mutate(my_data_small, speed = distance / air_time * 60)

# what if we wanted to create a new data frame with only your calculations (transmute)
airspeed <- transmute(my_data_small, speed = distance / air_time * 60, speed2 = distance / air_time) # mph and mpm

# summarize and by_group
# we can use summarize to run a function on a data column to get a single return
summarise(my_data, delay = mean(dep_delay, na.rm = TRUE))

# So we can see here that the avg delay is about 12 minutes, we gain additional value in summarize by pairing it with by_group()
by_day <- group_by(my_data, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))
# As you can see, we now have the delay by the days of the year

# What happens if we don't tell R what to do with the missing data?
summarise(by_day, delay = mean(dep_delay))

# We can also filter our data based on NA (which in this data set was cancelled flights)
not_cancelled <- filter(my_data, !is.na(dep_delay), !is.na(arr_delay))
nrow(not_cancelled)
# OR???
not_cancelled2 <- filter(my_data, !is.na(dep_time))
nrow(not_cancelled2)

# Lets run summarize again on this data
summarise(not_cancelled, delay = mean(dep_delay))

# counts - we can also count the number of variables that are NA in our dataset
sum(is.na(my_data$dep_delay))

# We can also count the numbers that are not NA
sum(!is.na(my_data$dep_delay))

# with tibble datasets (later on this tutorial...), we can pipe results to get rid of the need to use the dollar signs to get col data
# we can then summarize the number of flights by minutes delayed

my_data %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_time, na.rm = TRUE))

# Now its time to explore tibbles, they are modified dataframes which tweak some of the older features from data frames. 
library(tibble)
as_tibble(iris)

# As we can see, we have the same data frame, but we have different features

# You can also create a tibble from scratch with tibble()

tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)

# you can also use tribble() for basic data table creation
tribble(
  ~genea,
  ~geneb,
  ~genec,
  
  110,
  112,
  114,
  
  6,
  5,
  4,
  
)

# Tibbles are built to not overwhelm your console when printing data
# Only showing the first few lines
# This is how a data frame prints
print(by_day)
as.data.frame(by_day)
head(by_day)

nycflights13::flights %>%
  print(n=10, width = Inf)

# Subsetting tibbles is easy, similar to data frames
df_tibble <- tibble(nycflights13::flights)
df_tibble

# We can subset by column name using the $
df_tibble$carrier

#  we can also subset by position by using the [[]]
df_tibble[[2]]

df_tibble %>%
  .$carrier

# Some older functions do not like tibbles. Thus you might have to convert them back to dataframe
class(df_tibble)
df_tibble_2 <- as.data.frame(df_tibble)
class(df_tibble_2)

df_tibble
head(df_tibble_2)

# tidyr
library(tidyverse)

# How do we make a tidy dataset? The tidyverse follows three rues
# 1 - each variable must have its own column
# 2 - each observation must have its own row
# 3 - each value has its own cell

# It is impossible to satisfy two of the three rules

# This leads to the following instructions for tidy data:
# 1 - put each dataset into a tibble
# 2 - put each variable into a column
# 3 - profit

# picking on consistant method of data storage for easier understanding of your code and what is happening under the hood

# Let's now look at working with tibbles
bmi <- tibble(women)

bmi %>%
  mutate(bmi = (703 * weight)/(height)^2)

# spreading and gathering
# sometimes you won't find datasets that don't fit will into a tibble
# we'll use the built in data from tidyverse for this part

table4a

# as you can see from this data, we have one variable in column a (country)
# columns b and c are two of the same, thus there are two observations in each row - violates tidy rule
# to fix this we can use the gather function
table4a %>%
  gather("1999", "2000", key = "year", value = "cases")

# Lets look at another example - similar example as table4a
table4b
table4b %>%
  gather("1999", "2000", key = "year", value = "population")

# what if we want to join these two tables? Let's use deplyr
table4a <- table4a %>%
  gather("1999", "2000", key = "year", value = "cases")

table4b <- table4b %>%
  gather("1999", "2000", key = "year", value = "population")

left_join(table4a, table4b)

# Spreading - oppposite of gathering
table2

# You can see that we have redundant info in columns 1 and 2 - NOT tidy
# We can fix that by combining rows 1 and 2, 3 and 4, etc...
spread(table2, key = type, value = count)

# Type is the key of what we are turning into columns, the value is what becomes rows/observations

# In summary spread makes long table shorter and wider
# Gather makes wide tables narrower and longer

# Separating and pull

# Now what happens when we have two observations stuck in one column?

table3

# As you can see the rate is just the population and cases combines
# we can use use separate to fix this
table3 %>%
  separate(rate, into = c("cases", "population"))

# However if you noticed, column type is not correct
table3 %>%
  separate(rate, into = c("cases", "population"), convert = TRUE)

# You can actually specify what you want to seperate based on

table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

# Lets make this more tidy
table3 %>%
  separate(
    year,
    into = c("century", "year"),
    convert = TRUE,
    sep = 2, # or you can use an int as index of char
  )

# deplyr - it is rare that you will be working with a single data table
# this package allows you to join two data tables based on common values

# Mutate joins - add new variables t one data frame from one matching observation in another
# Filtering joins - filters observation from one data frame based on whether or not they are present in another
# set operations - treat observations as they are set elements

# lets pull full carrier names based on letter codes
airlines <- nycflights13::airlines

# lets get info about airports
airports <- nycflights13::airports

# Lets get info about each plane
planes <- nycflights13::planes

# Lets get info on the weather at the airport
weather <- nycflights13::weather

# Lets get info on singular flights
flights <- nycflights13::flights

# Lets look at how these tables connect

# Flights -> planes based on tailnumber
# Flights -> airlines through carrier
# Flights -> airports origin and destination
# Flights -> weather via origin, year/month/day/hour

# keys - unique identifiers per observation
# primary key uniquely identifies an observation in its own table

# one way to identify a primary key is as follows:
planes %>%
  count(tailnum) %>%
  filter(n>1)
# This indicates that the tail number is unique 0x2

planes %>%
  count(model) %>%
  filter(n>1)
# not unique identifier 79x2

# mutate join
flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2

flights2 %>%
  select(-origin, -dest) %>%
  left_join(airlines, by = "carrier")
# We've added the airline name to our data frame fro mthe airline data frame

# Other types of joins 

# Inner joins (inner_join()) matches a pair of observations whey their key is equal
# outer joins (outer_join()) keeps observations that appear in at least one table

# unite - reverse of separate?
table5
table5 %>%
  unite(date, century, year, sep = "")

# missing values - NA (explicit) OR just no entry (implicit)
gene_data <- tibble(
  gene = c("a", "a", "a", "a", "b", "b", "b"),
  nuc = c(20, 22, 24, 25, NA, 42, 67),
  run = c(1, 2, 3, 4, 2, 3, 4)
)

gene_data

# nucleotide count for Gene b run 2 is explicit missing - NA
# nucleotide count for gene b run 1 is implicitly missing - not seen at all

# one way we can make implicit missing values explicit is by putting runs in columns
gene_data %>%
  spread(gene, nuc) # show all implicit missing values

# If we want to remove the missing values we can use spread and gather and na.rm = TRUE
gene_data %>%
  spread(gene, nuc) %>%
  gather(gene, nuc, "a":"b", na.rm = TRUE)

# Another way we can make missing values implicit to explicit is complete()
# sometimes an NA is present to represent a value being carried forward

treatment <- tribble(
  ~person, ~treatment, ~response,
  "Isaac", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "VDB", 1, 8,
  NA, 2, 11,
  NA, 3, 10,
)

# fill NA with previous value
treatment %>%
  fill(person)

# detect matches - str_detect() returns a logical vector the same length of input
 y <- c("apple", "banana", "pear")
y

str_detect(y, "e")

# How many common words start contain the letter "e"
words

sum(str_detect(words, "e"))

# lets get more complex - wgat proportion words end in a vowel
mean(str_detect(words, "[aeiou]$")) # 27%

mean(str_detect(words, "^[aeiou]"))

# lets find all the words that don't contain o or u
no_o <- !str_detect(words, "[ou]")
no_o

# now lets extract those words that dont contain o or u
words[!str_detect(words, "[ou]")]

# you can also use str_count() to see how many matches are in a string
x <- c("ATTAGA", "CGCCCCCGGAT", "TATTA")
str_count(x, "[GC]")

# Lets couple this with mutate
df <- tibble(
  word = words,
  i = seq_along(word),
)

df

# show number of vowels in constanents in words data
df %>%
  mutate(
    vowels = str_count(words, "[aeiou]"),
    constenants = str_count(words, "[^aeiou]")
  )





