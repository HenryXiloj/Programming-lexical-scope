## Creates a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix() ) {
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
  
   ## Get the matrix from our object
  data <- x$get()

  s <- solve(data, ...)
  
   ## Set the inverse to the object  
  x$setInverseSolve(s)
  
  ## Return the matrix
  s
}
