# Some R Notes

This R document contains some notes I've made while working through material from Hadley Wickham's excellent book [Advanced R](http://adv-r.had.co.nz/). 
The notes are written in R Markdown using the [knitr](http://yihui.name/knitr) package. 

----

## R Functions I'm ashamed I didn't know...

----

### `str`  -- *"Compactly display the structure of an arbitrary R object"*
It does what it says: give it any R object as an argument and `str` will tell you what's inside. 
Let's look at some simple examples.
#### `str` Examples: Atomic Vectors

```r
x <- 1:3
x
```

```
## [1] 1 2 3
```

```r
str(x)
```

```
##  int [1:3] 1 2 3
```

```r
y <- c(1, 2, 3)
y
```

```
## [1] 1 2 3
```

```r
str(y)
```

```
##  num [1:3] 1 2 3
```

```r
z <- rnorm(3)
z
```

```
## [1] -0.08882 -0.98754  0.27008
```

```r
str(z)
```

```
##  num [1:3] -0.0888 -0.9875 0.2701
```

```r
people <- c("Alice", "Bob", "Charlie")
people
```

```
## [1] "Alice"   "Bob"     "Charlie"
```

```r
str(people)
```

```
##  chr [1:3] "Alice" "Bob" "Charlie"
```

#### `str` Examples: Matrices

```r
M <- matrix(1:4, 2, 2)
M
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
```

```r
str(M)
```

```
##  int [1:2, 1:2] 1 2 3 4
```

```r
N <- matrix(rnorm(4), 2, 2)
str(N)
```

```
##  num [1:2, 1:2] -1.331 0.739 -1.529 0.805
```

```r
P <- matrix(paste("Person", 1:4, sep = ""), 2, 2)
P
```

```
##      [,1]      [,2]     
## [1,] "Person1" "Person3"
## [2,] "Person2" "Person4"
```

```r
str(P)
```

```
##  chr [1:2, 1:2] "Person1" "Person2" "Person3" "Person4"
```

#### `str` Examples: Dataframes

```r
str(cars)
```

```
## 'data.frame':	50 obs. of  2 variables:
##  $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
##  $ dist : num  2 10 4 22 16 10 18 26 34 17 ...
```

```r
str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```


#### `str` Examples: Arbitrary Lists

```r
M <- matrix(rnorm(4), 2, 2)
friends <- c("Alice", "Bob", "Charlie")
mylist <- list(M, friends)
mylist
```

```
## [[1]]
##         [,1]    [,2]
## [1,]  0.8332 -0.2208
## [2,] -1.8612 -0.8967
## 
## [[2]]
## [1] "Alice"   "Bob"     "Charlie"
```

```r
str(mylist)
```

```
## List of 2
##  $ : num [1:2, 1:2] 0.833 -1.861 -0.221 -0.897
##  $ : chr [1:3] "Alice" "Bob" "Charlie"
```

#### `str` Examples: Functions

```r
str(mean)
```

```
## function (x, ...)
```

```r
add2 <- function(x, y) {
    x + y
}
str(add2)
```

```
## function (x, y)  
##  - attr(*, "srcref")=Class 'srcref'  atomic [1:8] 2 9 4 1 9 1 2 4
##   .. ..- attr(*, "srcfile")=Classes 'srcfilecopy', 'srcfile' <environment: 0x104a8d4d0>
```

----

### `drop`  -- *"Drop redundant extent information"*

This is both a standalone function and an option that can be used with the various subsetting commands such as `[` and `subset`. 

#### `drop` Examples: Standalone Function
The matrix `M` has only one column, so we could have stored the same information as a vector if we had wanted to. 
The `drop` function makes this simplification. 
In other words it deletes "the dimensions of an array which have only one level"

```r
M <- matrix(1:5, 5, 1)
M
```

```
##      [,1]
## [1,]    1
## [2,]    2
## [3,]    3
## [4,]    4
## [5,]    5
```

```r
drop(M)
```

```
## [1] 1 2 3 4 5
```


#### `drop` Examples: Argument to Subsetting Functions
Both `[` and `subset` take `drop` as a logical argument.
While `[` defaults to `drop = TRUE`

```r
M <- matrix(1:4, 2, 2)
M[1, ]
```

```
## [1] 1 3
```

```r
M[1, , drop = FALSE]
```

```
##      [,1] [,2]
## [1,]    1    3
```

`subset` defaults to `drop = FALSE`

```r
data <- data.frame(age = c(20, 35, 16))
subset(data, age != 35)
```

```
##   age
## 1  20
## 3  16
```

```r
subset(data, age != 35, drop = TRUE)
```

```
## [1] 20 16
```

Setting `drop = FALSE` with `[` can be crucial for getting the results you expect in matrix operations. 
The following code, for example, does not do what we'd expect: it gives the *inner* product rather than the *outer* product:

```r
M <- matrix(1:4, 2, 2)
x <- M[, 1]
y <- M[2, ]
x %*% y
```

```
##      [,1]
## [1,]   10
```

Incidentally, this presents another opportunity to demonstrate `drop` as a standalone function:

```r
drop(x %*% y)
```

```
## [1] 10
```

To get the *outer* product, we use `drop` as an argument to `[` as follows

```r
x <- M[, 1, drop = FALSE]
y <- M[2, , drop = FALSE]
x %*% y
```

```
##      [,1] [,2]
## [1,]    2    4
## [2,]    4    8
```


### `match`  -- *"Value matching"*
This function has a binary operator counterpart `%in%`. 
Whereas `match` returns a vector of *positions*, possibly including `NA`s, `%in%` returns a logical vector *without* `NA`s. 
Both `match` and `%in%` try to match the elements of their *first* argument with elements of their *second* argument.
This means that each returns a result of the same dimension of the *first* argument.

#### `match` Examples: Atomic Vectors

```r
friends <- c("Alice", "Bob", "Charlie")
coworkers <- c("Bob", "Charlie", "Diana", "Elise")
match(friends, coworkers)
```

```
## [1] NA  1  2
```

```r
friends %in% coworkers
```

```
## [1] FALSE  TRUE  TRUE
```

Because Alice is not an element of `coworkers`, `match` cannot return a position, so it returns `NA` instead.
Now try reversing the order of the arguments:

```r
match(coworkers, friends)
```

```
## [1]  2  3 NA NA
```

```r
coworkers %in% friends
```

```
## [1]  TRUE  TRUE FALSE FALSE
```

What about multiple matches?

```r
x <- 1:5
y <- c(2, 3, 4, 4)
```

The function `match` handles multiple matches by returning the position of the *first* match

```r
match(x, y)
```

```
## [1] NA  1  2  3 NA
```

In contrast, `%in%` simply returns TRUE, indicating that there is at least one match

```r
x %in% y
```

```
## [1] FALSE  TRUE  TRUE  TRUE FALSE
```

Both `match` and `%in%` take *vector* arguments. So what happens, for example, if we try to pass them a matrix?

```r
m <- c(11, 13, 19)
M <- matrix(11:19, 3, 3)
m
```

```
## [1] 11 13 19
```

```r
M
```

```
##      [,1] [,2] [,3]
## [1,]   11   14   17
## [2,]   12   15   18
## [3,]   13   16   19
```

To understand the following, remember that we *can* access R matrices with a single index, where the convention is to treat the whole matrix as a vector in which the *columns* are pasted together 

```r
M[1]
```

```
## [1] 11
```

```r
M[1:4]
```

```
## [1] 11 12 13 14
```

Thus,

```r
match(m, M)
```

```
## [1] 1 3 9
```

```r
m %in% M
```

```
## [1] TRUE TRUE TRUE
```

```r
match(M, m)
```

```
## [1]  1 NA  2 NA NA NA NA NA  3
```

```r
M %in% m
```

```
## [1]  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE
```

```r
M %in% M
```

```
## [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```


