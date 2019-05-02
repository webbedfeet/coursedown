#' Build the website, knit the notes, slides and homeworks to create the full website
#'
#' @param notes_pdf Should PDF version of the notes be created
#' @param slides (T/F) should slides and pages be build
#' @param notes (T/F) should course notes be compiled
#' @param hw  (T/F) should homework be compiled
#'
#' @export
#'
process <- function(drake_source = here::here('_drake.R'),
                    slides = T, notes = F, hw = T,
                    slides_pdf = TRUE, notes_pdf = FALSE,
                    lock_environment = TRUE){
  requireNamespace('drake')
  if(slides) process_slides(drake_source, pdf = slides_pdf, lock_environment = lock_environment)
  if(hw) process_hw(drake_source)
  if(notes) process_notes(drake_source, pdf = notes_pdf)
  make(top_plan)
  #
  # if(!fs::dir_exists(here::here('docs'))) fs::dir_create(here::here('docs'))
  # rmarkdown::render_site(here::here())
  # if(fs::dir_exists('slides') & slides) process_slides()
  # if(fs::dir_exists('notes') & notes) process_notes(pdf = notes_pdf)
  # if(fs::dir_exists('assignments') & hw) process_hw()
}
