# simple operations

## This is how R does addition
12 + 6

## This is how R does subtraction
12 - 6

## This is how we store data as variables. We are going to store the days of the week for this current example:
days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

# Lets find the fifth entry in our stored collection - days
days[5]

# Lets pull out a range of entries
days[1:3]

# Lets pull out the end of the week
days[5:7]

# Lets pull out every other day
days[c(1, 3, 5, 7)]

# Lets subset our days variable and create weekdays
weekdays <- days[1:5]

weekdays

# Functions
# f(argument1, argument2, ...)
# where f is the name of the function, and argument1, argument2, ... are the different conditions that we are asking the function to evaluate

exampleFunction <- function(x, y)
  {c(x+1, y+10)}

exampleFunction(2, 4)

# Example built in functions
exp(2)

# tangents
tan(2)

# logs
log(12)

log(x=12, base=4)

log(12, 4)

# Data structures

# Lets start with the array function
months <- array(c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), dim = (c(3, 4)))

months

# and compare it to the simple list function
months1 <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")


months[2, 3]


# Lets now look at a matrix

months2 <- matrix(data = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"), nrow = 3, ncol = 4)

months2

# Making a 3d array 
array3d <- array(c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36), dim = c(3, 3, 2))

array3d

array3d[1, 3, 2]

# If you want to pull an entire row or column
array3d[2,  , 1]

# List and Data Frames
HSPA1A <- list(genes="HSPA1A", amino.acids = 641, nucleotides=2400)

print(HSPA1A)

HSPA1A$amino.acids

HSPA1A$nucleotides

gene <- c("HSPA4", "HSPA5", "HSPA8", "HSPA9", "HSPA1A", "HSPA1B")
nucleotides <- c(54537, 6491, 4648, 21646, 2400, 2517)
aminoAcids <- c(840, 654, 493, 679, 641, 641)

HSPs <- data.frame(gene, nucleotides, aminoAcids)

HSPs

HSPs$gene

# Lets search for a specific gene
HSPs$aminoAcids[HSPs$gene == "HSPA5"]

# Object classes
class(HSPs$gene)
class(HSPs$nucleotides)
class(HSPs$aminoAcids)

x <- 15 + 38

z <- as.character(c(1, 2, 3, 4, 5, 6))
class(z)

y <- as.character(c(9, 8, 7, 6, 5, 4))

z + y

z2 <- c(1, 2, 3, 4, 5, 6)
y2 <- c(9, 8, 7, 6, 5, 4)

z2 + y2

class(z2)

class(HSPs)

class(y)

y <- as.numeric(y)

class(y)

# Models and formulas

# y ~ x1 + x2


dataset <- iris

head(dataset)

tail(dataset)

# number or rows and cols of dataset
nrow(dataset)
ncol(dataset)

# Lets start with a simple linear model
petals.lm <- lm(formula = Petal.Length ~ Petal.Width, data = dataset)

petals.lm

summary(petals.lm)

#annotate charts and graphs
names(iris)

hist(iris$Sepal.Length)

# increase the number of bins in our histogram
hist(iris$Sepal.Length, breaks = 25)

# Lets add some labels
hist(iris$Sepal.Length, breaks = 25, xlab = "Sepal Width", ylab = "count", main = "Sepal Length Frequency")


# Lets make a plot
plot(iris$Sepal.Length ~ iris$Sepal.Width, xlab = "Sepal Length", ylab = "Sepal Width")

# install and add to library
install.packages("lattice")
library(lattice)

# Lets use the lattice dotplot
dotplot(iris$Sepal.Width ~ iris$Sepal.Length|Species, data = iris)

# Lets use the lattice dotplot to look at petal width length x width
dotplot(iris$Petal.Width ~ iris$Petal.Length|Species, data = iris)






