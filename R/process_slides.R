#' Title
#'
#' @return
#' @export
#'
#' @examples
process_slides <- function(pdf = FALSE){
  require(rmarkdown)
  require(fs)
  final_output_dir <- fs::path(here::here('docs/slides'))
  if(!dir_exists(final_output_dir)) dir_create(final_output_dir, recursive = TRUE)
  yml <- yaml::read_yaml(fs::path(here::here('slides'),'_site.yml'))
  if(yml$output_dir != fs::path_abs(fs::path(here::here('slides'), yml$output_dir))){
    output_dir <- fs::path_abs(fs::path(here::here('slides'), yml$output_dir))
  } else {
    output_dir <- yml$output_dir
  }
  yml$output_dir <- fs::path_rel(output_dir, start = here::here('slides'))
  if(!dir_exists(output_dir)) dir_create(output_dir, recursive = TRUE)
  if(pdf){
    slnames <- dir_ls('slides', glob='*.Rmd') %>%
      `[`(!str_detect('index'))
    slnames <- path('slides', slnames)
    map(slnames, ~try(slide2pdf(.)))
    if(length(dir_ls('slides', glob = "*.pdf")) > 0){
      file_copy(dir_ls('slides', glob='*.pdf'), output_dir)
    }
  } else {
    render_site('slides')
  }
  if (output_dir != final_output_dir){
    fs::file_copy(dir_ls(output_dir), final_output_dir, overwrite = TRUE)
  }
}
