#' Create the coursenotes using bookdonw
#'
#' @param infile The index file for the course notes
#' @param output_format The bookdown output format
#'
#' @return The outcome is a bookdown-based book
#' @export
#'
make_book <- function(infile, output_format){
  requireNamespace('bookdown')
  requireNamespace('here')
  setwd(here::here(fs::path_dir(infile)))
  infile1 <- as.character(fs::path_file(infile))
  # print(getwd())
  # print(infile)
  # if(fs::file_exists(infile)) print('file present')
  bookdown::render_book(infile1, output_format)
  setwd(here::here())
}
