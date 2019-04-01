slides2notes <- function(infile, outdir, outfile = infile){
  knitr::purl(infile, output = file.path(outdir, outfile),
              documentation = 1)
  knitr::spin(file.path(outdir,outfile), knit = F, format='Rmd')
}
