# Some R Notes

This R document contains some notes I've made while working through material from Hadley Wickham's excellent book [Advanced R](http://adv-r.had.co.nz/). 
The notes are written in R Markdown using the [knitr](http://yihui.name/knitr) package. 

----

## R Functions I'm ashamed I didn't know...

----

### `str`  -- *"Compactly display the structure of an arbitrary R object"*
It does what it says: give it any R object as an argument and `str` will tell you what's inside. Let's look at some simple examples.
#### `str` Examples: Atomic Vectors

```r
str(1:3)
```

```
##  int [1:3] 1 2 3
```

```r
str(c(1, 2, 3))
```

```
##  num [1:3] 1 2 3
```

```r
str(rnorm(3))
```

```
##  num [1:3] 1.158 -0.325 -0.131
```

```r
str(c("Alice", "Bob", "Charlie"))
```

```
##  chr [1:3] "Alice" "Bob" "Charlie"
```

#### `str` Examples: Matrices

```r
str(matrix(1:4, 2, 2))
```

```
##  int [1:2, 1:2] 1 2 3 4
```

```r
str(matrix(rnorm(4), 2, 2))
```

```
##  num [1:2, 1:2] 0.17 -0.736 -1.11 0.547
```

```r
str(matrix(paste("Person", 1:4, sep = ""), 2, 2))
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
str(list(M, friends))
```

```
## List of 2
##  $ : num [1:2, 1:2] 0.769 -1.062 -0.704 -2.277
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
##   .. ..- attr(*, "srcfile")=Classes 'srcfilecopy', 'srcfile' <environment: 0x104d9b600>
```

----

### `drop`  -- *"Drop redundant extent information"*

This is both a standalone function and an option that can be used with the various subsetting commands such as `[` and `subset`. 

#### `drop` Examples: Standalone Function
The matrix `M` has only one column, so we could have stored the same information as a vector if we had wanted to. The `drop` function makes this simplification. In other words it deletes "the dimensions of an array which have only one level"

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
Both `[` and `subset` take `drop` as a logical argument. While `[` defaults to `drop = TRUE`

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

Setting `drop = FALSE` with `[` can be crucial for getting the results you expect in matrix operations. The following code, for example, does not do what we'd expect: it gives the *inner* product rather than the *outer* product:

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

