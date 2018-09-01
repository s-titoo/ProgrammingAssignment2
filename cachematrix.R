# The first function, makeCacheMatrix creates a special matrix and contains a function to
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of the inverse matrix
# 4. get the value of the inverse matrix

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y) {
		x <<- y
		i <<- NULL
    }
    get <- function() x
    setInverse <- function(inv) i <<- inv
    getInverse <- function() i
    list(set = set, get = get,
		 setInverse = setInverse,
		 getInverse = getInverse)
}

# The second function computes inverse from the matrix created above. 
# But first it checks whether this inverse has already been calculated.
# If yes just returns calculated result from cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        i <- x$getInverse()
        if(!is.null(i)) {
			message("getting cached data")
			return(i)
        }
        data <- x$get()
        i <- solve(data, ...)
        x$setInverse(i)
        i
}