#' Compute the dates for the class, based on weekly classes
#'
#' @param wk The week number
#' @param startDate The first date for class, formatted as YYYY-MM-DD
#' @param out_format The format in which the dates will be printed. Follows the conventions in \code{strptime}
#'
#' @return A formatted date
#' @export
#'
#' @examples
#' classDate(3, '2019-01-28')
classDate <- function(wk, startDate, out_format = "%B %d, %Y"){
  if(!stringr::str_detect(as.character(startDate), '\\d{4}-\\d{2}-\\d{2}')){
    stop('The start date must be formated as YYYY-MM-DD')
  }
  startDate <- as.Date(startDate)
  today <- startDate + 7*(wk-1)
  format(today, "%B %d, %Y")
}
