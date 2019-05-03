#' Create the coursenotes using bookdonw
#'
#' @param infile The index file for the course notes
#' @param output_format The bookdown output format
#'
#' @return The outcome is a bookdown-based book
#' @export
#'
make_book <- function(infile, output_format){
  setwd(here::here(dirname(infile)))
  infile <- basename(infile)
  # print(getwd())
  # print(infile)
  # if(fs::file_exists(infile)) print('file present')
  bookdown::render_book(infile, output_format)
  setwd(here::here())
}
