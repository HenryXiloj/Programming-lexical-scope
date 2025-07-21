# Programming Assignment: Lexical Scoping in R

## 📋 Overview

This programming assignment demonstrates the power of **lexical scoping** in R by implementing functions that cache potentially time-consuming computations. By leveraging R's scoping rules, we can preserve state inside R objects and avoid redundant calculations.

## 🎯 Objective

Write R functions that cache the inverse of a matrix to avoid repeated expensive computations. This showcases how lexical scoping can be used to create efficient, stateful objects in R.

## 📖 Background: Caching Computations

When working with large datasets or complex calculations, repeated computations can become a performance bottleneck. Caching allows us to:
- Store results of expensive operations
- Retrieve cached results instead of recalculating
- Improve overall program performance

### Example Use Case
Taking the mean of a numeric vector is typically fast, but for very long vectors computed repeatedly (e.g., in loops), caching the result can provide significant performance benefits.

## 🔍 Understanding the `<<-` Operator

The `<<-` operator assigns values to objects in a different environment than the current one, enabling us to:
- Modify variables in parent environments
- Preserve state across function calls
- Create closures that maintain internal data

## 📝 Example: Caching the Mean of a Vector

### Function 1: `makeVector`
Creates a special "vector" object that stores a numeric vector and caches its mean:

```r
makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}
```

**What it does:**
- `set`: Updates the vector value and resets the cached mean
- `get`: Retrieves the current vector
- `setmean`: Caches the calculated mean
- `getmean`: Retrieves the cached mean

### Function 2: `cachemean`
Calculates the mean with intelligent caching:

```r
cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}
```

**How it works:**
1. Check if mean is already cached
2. If cached, return the stored value
3. If not cached, calculate the mean and store it
4. Return the calculated mean

## 🎯 Assignment: Caching Matrix Inverse

Matrix inversion is computationally expensive. Your task is to implement two functions that cache matrix inverses:

### Required Functions

#### 1. `makeCacheMatrix`
- **Purpose**: Creates a special "matrix" object that can cache its inverse
- **Returns**: A list of functions to manipulate the matrix and its cached inverse

#### 2. `cacheSolve`
- **Purpose**: Computes the inverse of the special "matrix" from `makeCacheMatrix`
- **Behavior**: 
  - If inverse is cached and matrix unchanged → return cached inverse
  - If not cached → compute inverse, cache it, and return result

### Key Points
- Use `solve(X)` to compute the inverse of matrix `X`
- Assume all matrices are square and invertible
- Follow the same pattern as the vector mean example

## 🚀 Getting Started

### Prerequisites
- R programming environment
- Basic understanding of functions and closures
- Familiarity with matrix operations

### Setup Instructions

1. **Fork the Repository**
   ```bash
   # Fork https://github.com/rdpeng/ProgrammingAssignment2
   ```

2. **Clone Your Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/ProgrammingAssignment2
   cd ProgrammingAssignment2
   ```

3. **Implement Your Solution**
   - Edit the R file in the repository
   - Do NOT rename the file
   - Follow the existing structure

4. **Submit Your Work**
   ```bash
   git add .
   git commit -m "Complete matrix caching assignment"
   git push origin main
   ```

## 📊 Testing Your Implementation

### Example Usage
```r
# Create a matrix
mat <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)

# Create cached matrix object
cached_matrix <- makeCacheMatrix(mat)

# First call - computes and caches inverse
inverse1 <- cacheSolve(cached_matrix)

# Second call - retrieves from cache
inverse2 <- cacheSolve(cached_matrix)  # Should show "getting cached data"
```

### Verification
```r
# Verify the inverse is correct
original_matrix %*% inverse_matrix  # Should give identity matrix
```

## 🏆 Grading Criteria

This assignment will be **peer-assessed** based on:
- ✅ Correct implementation of `makeCacheMatrix`
- ✅ Correct implementation of `cacheSolve`
- ✅ Proper use of lexical scoping and `<<-` operator
- ✅ Code follows the required structure and naming
- ✅ Functions work correctly with caching mechanism

## 📚 Learning Outcomes

After completing this assignment, you will understand:
- How lexical scoping works in R
- The difference between `<-` and `<<-` operators
- How to create stateful objects using closures
- Performance optimization through caching
- Practical application of functional programming concepts

## 🔗 Resources

- [R Documentation on Scoping](https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Scope)
- [Matrix Operations in R](https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Arrays-and-matrices)
- [Original Assignment Repository](https://github.com/rdpeng/ProgrammingAssignment2)

---

**Note**: Remember to submit the URL to your GitHub repository containing your completed R code to Coursera for peer review.
