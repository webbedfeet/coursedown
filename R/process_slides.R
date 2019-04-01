process_slides <- function(){
  require(rmarkdown)
  require(fs)
  render_site('slides')
  if(dir_exists('docs/slides')) dir_delete('docs/slides')
  dir_copy('slides/slides', 'docs')
  dir_delete('slides/slides')
}
