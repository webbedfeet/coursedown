#' Build the website, knit the notes, slides and homeworks to create the full website
#'
#' @param notes_pdf Should PDF version of the notes be created
#' @param slides (T/F) should slides and pages be build
#' @param notes (T/F) should course notes be compiled
#' @param hw  (T/F) should homework be compiled
#'
#' @export
#'
process <- function(slides = T, notes = T, hw = T, notes_pdf = FALSE){
  if(!dir_exists(here::here('docs'))) fs::dir_create(here::here('docs'))
  rmarkdown::render_site(here::here())
  if(dir_exists('slides') & slides) process_slides()
  if(dir_exists('notes') & notes) process_notes(pdf = notes_pdf)
  if(dir_exists('assignments') & hw) process_hw()
}
