process_notes <- function(pdf=FALSE){
  require(rmarkdown)
  require(fs)
  render_site('notes', output_format = "bookdown::gitbook")
  if(pdf) render_site('notes', output_format = "bookdown::pdf_book")
}
