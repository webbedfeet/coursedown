#' Title
#'
#' @param pdf
#'
#' @return
#' @export
#'
#' @examples
process_notes <- function(pdf=FALSE){
  require(rmarkdown)
  require(fs)
  final_output_dir <- here::here('docs/notes')
  yml <- yaml::read_yaml(fs::path(here::here('notes'),'_bookdown.yml'))
  output_dir <- fs::path_abs(fs::path(here::here('notes'), yml$output_dir))
  yml$output_dir <- output_dir
  yaml::write_yaml(yml, fs::path(here::here('notes'), '_bookdown.yml'))
  if(!dir_exists(final_output_dir)) dir_create(final_output_dir, recursive = T)
  if(!dir_exists(output_dir)) dir_create(output_dir, recursive = T)
  render_site('notes', output_format = "bookdown::gitbook")
  if(pdf) render_site('notes', output_format = "bookdown::pdf_book")
  if(final_output_dir != output_dir){
    fs::file_copy(fs::dir_ls(output_dir), final_output_dir, overwrite = T)
  }
}
