cacheSolve <- function(m, ...) {
   
  
  inv = m$getinv()
  
  # if the inverse has already been calculated
  if (!is.null(inv)){
    # get it from the cache and skips the computation. 
    message("Yes! cached data found and collecting same")
    return(inv)
  }
  
  # otherwise, calculates the inverse 
  m1.data = m$get()
  inv = solve(m1.data, ...)
  
  # sets the value of the inverse in the cache via the setinv function.
  m$setinv(inv)
  
  return(inv)
}
