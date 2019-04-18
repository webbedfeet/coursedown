#' Converting slides to PDF format using chrome_print
#'
#' @param slname Either the name of the HTML slides (preferred) or the name of the Rmd file
#'
#' @export
#'
slide2pdf <- function(slname){
  pagedown::chrome_print(slname)
}
