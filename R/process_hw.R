process_hw <- function(){
  require(rmarkdown)
  require(fs)
  render_site('assignments')
}
