#' Process the notes to create a bookdown document and potentially a PDF version
#'
#' @param pdf (T/F) Whether the PDF version of the notes should be compiled
#'
#' @export
#'
process_notes <- function(drake_source = here::here('_drake.R'), pdf=FALSE){
  requireNamespace("tidyverse")
  requireNamespace('here')
  requireNamespace('fs')
  requireNamespace('drake')

  source(drake_source)
  if(!pdf){
    make(notes_plan %>% filter(!str_detect(target, 'pdf')))
  } else {
    make(notes_plan)
  }
}

#   final_output_dir <- here::here('docs/notes')
#   yml <- yaml::read_yaml(fs::path(here::here('notes'),'_bookdown.yml'))
#   output_dir <- fs::path_abs(fs::path(here::here('notes'), yml$output_dir))
#   yml$output_dir <- fs::path_rel(output_dir, start = here::here('notes'))
#   yaml::write_yaml(yml, fs::path(here::here('notes'), '_bookdown.yml'))
#   if(!fs::dir_exists(final_output_dir)) fs::dir_create(final_output_dir, recursive = T)
#   if(!fs::dir_exists(output_dir)) fs::dir_create(output_dir, recursive = T)
#   rmarkdown::render_site('notes', output_format = "bookdown::gitbook")
#   if(pdf) rmarkdown::render_site('notes', output_format = "bookdown::pdf_book")
#   if(final_output_dir != output_dir){
#     fs::file_copy(fs::dir_ls(output_dir), final_output_dir, overwrite = T)
#   }
# }
