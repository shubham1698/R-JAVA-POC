# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

printStatement <- function(statement) {
  jhw <- .jnew("Hello", statement)
  .jcall(jhw, "V", "printStatement")
}

# Helper function to convert R vector to Java ArrayList<Integer>
createJavaArrayList <- function(vec) {
  vec <- as.integer(unlist(vec))
  javaArrayList <- .jnew("java/util/ArrayList")
  for (val in vec) {
    intObj <- .jnew("java/lang/Integer", val)
    .jcall(javaArrayList, "Z", "add", .jcast(intObj, "java/lang/Object"))
  }
  return(javaArrayList)
}

# 🔹 Function 1: Just print sorted list using Java's printSorted()
sortArrayAndPrint <- function(unSortedList) {
  javaArrayList <- createJavaArrayList(unSortedList)
  sorter <- .jnew("Sorting", javaArrayList)
  .jcall(sorter, "V", "printSorted")
}

sortArrayAndReturn <- function(unSortedList) {
  javaArrayList <- createJavaArrayList(unSortedList)
  sorter <- .jnew("Sorting", javaArrayList)
  sortedJavaList <- .jcall(sorter, "Ljava/util/List;", "getSorted")

  sortedSize <- .jcall(sortedJavaList, "I", "size")
  sortedResult <- vapply(0:(sortedSize - 1), function(i) {
    intObj <- .jcall(sortedJavaList, "Ljava/lang/Object;", "get", as.integer(i))
    .jcall(intObj, "I", "intValue")
  }, integer(1))

  return(sortedResult)
}





