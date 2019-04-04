#' Title
#'
#' @param slname
#'
#' @return
#' @export
#'
#' @examples
slide2pdf <- function(slname){
  require(pagedown)
  pagedown::chrome_print(slname)
}
