#' Title
#'
#' @param notes_pdf
#'
#' @return
#' @export
#'
#' @examples
process <- function(notes_pdf = FALSE){
  require(fs)
  if(dir_exists('slides')) process_slides()
  if(dir_exists('notes')) process_notes(pdf = notes_pdf)
  if(dir_exists('assignments')) process_hw()
  rmarkdown::render_site(here::here())
}
