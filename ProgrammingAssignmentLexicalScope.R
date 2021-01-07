
makeCacheMatrix <- function(x = matrix(sample(1:100,9),3,3)) {
  s <- NULL
  set <- function(y) {
    x <<- y
    s <<- NULL
  }
  get <- function() x
  setInverseSolve <- function(inverseSolve) s <<- inverseSolve
  getInverseSolve <- function() s
  list(set = set, get = get,
       setInverseSolve = setInverseSolve,
       getInverseSolve = getInverseSolve)
}

cacheSolve <- function(x, ...) {
  s <- x$getInverseSolve()
  if(!is.null(s)) {
    message("getting inversed matrix")
    return(s)
  }
  data <- x$get()
  s <- solve(data, ...)
  x$setInverseSolve(s)
  s
}