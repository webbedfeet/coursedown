#' Process homework documents to create a mini-website
#'
#' @export
#'
process_hw <- function(){
  final_output_dir <- fs::path(here::here('docs/assignments'))
  if(!fs::dir_exists(final_output_dir)) fs::dir_create(final_output_dir, recursive = TRUE)
  yml <- yaml::read_yaml(fs::path(here::here('assignments'),'_site.yml'))
  if(yml$output_dir != fs::path_abs(fs::path(here::here('assignments'), yml$output_dir))){
    output_dir <- fs::path_abs(fs::path(here::here('assignments'), yml$output_dir))
  } else {
    output_dir <- yml$output_dir
  }
  yml$output_dir <- fs::path_rel(output_dir, start = here::here('assignments'))
  yaml::write_yaml(yml, fs::path(here::here('assignments'), '_site.yml'))
  if(!fs::dir_exists(output_dir)) fs::dir_create(output_dir, recursive = TRUE)
  rmarkdown::render_site('assignments')
  source('assignments/HW/drake.R')
  make(plan)
  if (output_dir != final_output_dir){
    fs::file_copy(dir_ls(output_dir), final_output_dir, overwrite = TRUE)
  }
}
