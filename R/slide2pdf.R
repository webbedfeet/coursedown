#' Converting xaringan slides to PDF
#'
#' @param f The relative path to the R Markdown file for the xaringan presentation
#'
#' @return The function produces a PDF in the folder where the HTML version of the file resides for web deployment
#' @export
#'
#' @examples
#' # slide2pdf('slides/lectures/00-Introduction.Rmd')
slide2pdf <- function(f){
  requireNamespace('stringr')
  outdir <- here::here('docs','slides','lectures')
  fname <- fs::path_file(f)
  pdfname <- stringr::str_replace(fname, 'Rmd','pdf')
  pagedown::chrome_print(f, output = fs::path(outdir, pdfname))
}
