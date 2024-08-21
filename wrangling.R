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













