#' Title
#'
#' @return
#' @export
#'
#' @examples
process_slides <- function(){
  require(rmarkdown)
  require(fs)
  render_site('slides')
}
