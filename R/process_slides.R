#' Title
#'
#' @return
#' @export
#'
#' @examples
process_slides <- function(pdf = FALSE){
  require(rmarkdown)
  require(fs)
  if(pdf){
    slnames <- dir_ls('slides', glob='*.Rmd') %>%
      `[`(!str_detect('index'))
    slnames <- path('slides', slnames)
    map(slnames, ~try(slide2pdf(.)))
    if(length(dir_ls('slides', glob = "*.pdf")) > 0){
      file_copy(dir_ls('slides', glob='*.pdf'), 'docs/slides')
    }
  } else {
    render_site('slides')
  }
}
