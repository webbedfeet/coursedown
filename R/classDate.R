#' Fill in a sequence of dates for class
#'
#' @param wk The week number (integer >= 1)
#'
#' @return New dates
#' @export
#'
#' @examples
classDate <- function(wk, startDate){
  today <- startDate + 7*(wk-1)
  format(today, "%B %d, %Y")
}
