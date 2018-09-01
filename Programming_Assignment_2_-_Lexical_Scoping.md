### 1. Introduction

This report was prepared to test functions created as part of
*Programming Assignment 2* for **R Programming** course (Coursera, Data
Science Specialization, Johns Hopkins Bloomberg School of Public
Health).

Credit for test scenarios goes to [Alan E.
Berger](https://www.coursera.org/learn/r-programming/discussions/weeks/3/threads/ePlO1eMdEeahzg7_4P4Vvg),
who generously explained basic algebra which stands behind operations
with matrices.

### 2. Definition of inverse matrix

    #Lets define m1 as simple 2*2 matrix
    m1 <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2)
    m1

    ##       [,1]  [,2]
    ## [1,]  0.50 -1.00
    ## [2,] -0.25  0.75

    # Lets define n1 also as simple 2*2 matrix
    n1 <- matrix(c(6,2,8,4), nrow = 2, ncol = 2)
    n1

    ##      [,1] [,2]
    ## [1,]    6    8
    ## [2,]    2    4

    # Matrix m1 is said to be inverse of matrix n1 (and vice versa) 
    # if their multiplication produces identity matrix i1
    i1 <- matrix(c(1,0,0,1), nrow = 2, ncol = 2)
    i1

    ##      [,1] [,2]
    ## [1,]    1    0
    ## [2,]    0    1

    # Lets check whether n1 is in fact inverse of m1 (and vice versa)
    i2<-m1 %*% n1
    i2

    ##      [,1] [,2]
    ## [1,]    1    0
    ## [2,]    0    1

    i2==i1

    ##      [,1] [,2]
    ## [1,] TRUE TRUE
    ## [2,] TRUE TRUE

    i3<-n1 %*% m1
    i3

    ##      [,1] [,2]
    ## [1,]    1    0
    ## [2,]    0    1

    i3==i1

    ##      [,1] [,2]
    ## [1,] TRUE TRUE
    ## [2,] TRUE TRUE

### 3. Calculation of inverse matrix

    # Lets now calculate inverse matrix for m1 via solve() 
    # to make sure that result is the same as n1
    # We will do the same thing for n1

    n2 <- solve(m1)
    n2

    ##      [,1] [,2]
    ## [1,]    6    8
    ## [2,]    2    4

    n2==n1

    ##      [,1] [,2]
    ## [1,] TRUE TRUE
    ## [2,] TRUE TRUE

    m2<-solve(n1)
    m2

    ##       [,1]  [,2]
    ## [1,]  0.50 -1.00
    ## [2,] -0.25  0.75

    m2==m1

    ##       [,1]  [,2]
    ## [1,]  TRUE FALSE
    ## [2,] FALSE FALSE

Hmmm, in the last example it seems that R does not agree that matrices
`m1` and `m2` are equal. Lets find out why. Full answer to this question
is presented here
[stackoverflow](https://stackoverflow.com/questions/9508518/why-are-these-numbers-not-equal),
but in short here is how `m2` matrix really looks like. Not quite what
we expected, yeah?

    sprintf("%.54f",m2)

    ## [1] "0.500000000000000000000000000000000000000000000000000000" 
    ## [2] "-0.249999999999999972244424384371086489409208297729492187"
    ## [3] "-0.999999999999999888977697537484345957636833190917968750"
    ## [4] "0.749999999999999888977697537484345957636833190917968750"

We can use `all.equal()` function to make our test again and receive
proper answer.

    isTRUE(all.equal(m1, m2))

    ## [1] TRUE

### 4. Testing makeCacheMatrix() and cacheSolve()

    # To run the tests you must have both functions loaded
    # in your environment

    setwd("D:/Coursera/Data Science Specialization/2. R Programming/Programming Assignment 2/ProgrammingAssignment2")

    source("cachematrix.r")

    # myInvMatrix must be equal to n1
    myMatrix <- makeCacheMatrix(m1)
    myInvMatrix_m <- cacheSolve(myMatrix)
    myInvMatrix_m

    ##      [,1] [,2]
    ## [1,]    6    8
    ## [2,]    2    4

    myInvMatrix_m == n1

    ##      [,1] [,2]
    ## [1,] TRUE TRUE
    ## [2,] TRUE TRUE

    # Calling cacheSolve() second time should retrieve cached matrix
    # and not recalculate it

    cacheSolve(myMatrix)

    ## getting cached data

    ##      [,1] [,2]
    ## [1,]    6    8
    ## [2,]    2    4

    # We can put inside our fuction new matrix
    # by using set function and get inverse of it

    myMatrix$set(n1)
    myInvMatrix_n <- cacheSolve(myMatrix)
    myInvMatrix_n

    ##       [,1]  [,2]
    ## [1,]  0.50 -1.00
    ## [2,] -0.25  0.75

    myInvMatrix_n == m1

    ##       [,1]  [,2]
    ## [1,]  TRUE FALSE
    ## [2,] FALSE FALSE

    # Okay, and what about this? Seems better.
    isTRUE(all.equal(m1, myInvMatrix_n))

    ## [1] TRUE

    # Later we can retrieve our cached matrix
    # in the same way we did previously

    cacheSolve(myMatrix)

    ## getting cached data

    ##       [,1]  [,2]
    ## [1,]  0.50 -1.00
    ## [2,] -0.25  0.75
