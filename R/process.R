#' Title
#'
#' @param notes_pdf
#'
#' @return
#' @export
#'
#' @examples
process <- function(slides = T, notes = T, hw = F, notes_pdf = FALSE){
  require(fs)
  if(!dir_exists(here::here('docs'))) dir_create(here::here('docs'))
  rmarkdown::render_site(here::here())
  if(dir_exists('slides') & slides) process_slides()
  if(dir_exists('notes') & notes) process_notes(pdf = notes_pdf)
  if(dir_exists('assignments') & hw) process_hw()
}
