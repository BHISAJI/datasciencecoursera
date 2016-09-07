makeCacheMatrix <- function(m = matrix()) {
  
  inv = NULL
  set = function(n) {
     
    m <<- n
    inv <<- NULL
  }
  get = function() m
  setinv = function(inverse) inv <<- inverse 
  getinv = function() inv
  list(set=set, get=get, setinv=setinv, getinv=getinv)
}
