#' Title
#'
#' @return
#' @export
#'
#' @examples
process_hw <- function(){
  require(rmarkdown)
  require(fs)
  final_output_dir <- fs::path(here::here('docs/assignments'))
  if(!dir_exists(final_output_dir)) dir_create(final_output_dir, recursive = TRUE)
  yml <- yaml::read_yaml(fs::path(here::here('assignments'),'_site.yml'))
  output_dir <- fs::path_abs(fs::path(here::here('assignmnets'), yml$output_dir))
  yml$output_dir <- output_dir
  yaml::write_yaml(yml, fs::path(here::here('assignments'),'_site.yml'))
  if(!dir_exists(output_dir)) dir_create(output_dir, recursive = TRUE)
  render_site('assignments')
  if (output_dir != final_output_dir){
    fs::file_copy(dir_ls(output_dir), final_output_dir, overwrite = TRUE)
  }
}
