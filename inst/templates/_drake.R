library(drake)
library(fs)
library(here)

rmd2pdf <- function(f){
  outdir <- here::here('docs','slides','lectures')
  fname <- fs::path_file(f)
  pdfname <- stringr::str_replace(fname, 'Rmd','pdf')
  pagedown::chrome_print(f, output = fs::path(outdir, pdfname))
}

rmdfiles <- dir_ls(here::here('slides','lectures'), glob = '*.Rmd')
outdir <- here::here('docs','slides','lectures')
outrmd <- fs::path('docs',rmdfiles)

slides_plan <- drake_plan(
  create_slides = target(
    rmarkdown::render(knitr_in(rmdf),
                      output_dir = here::here('docs','slides','lectures')),
    transform = map(rmdf = !!rmdfiles) ),
  create_pdfs = target(
    rmd2pdf(file_in(rmdf)),
    transform = map(rmdf = !!rmdfiles)),
  make_index = target(
    rmarkdown::render_site(input = knitr_in(here::here('slides','index.Rmd'))),
    trigger = trigger(depend = all(file_exists(!!outrmd)))
  )
)

hw_rmdfiles <- dir_ls('assignments/HW', glob = '*.Rmd')
hw_outdir <- here::here('docs','assignments','HW')
hw_outrmd <- fs::path('docs',hw_rmdfiles)

hw_plan <- drake_plan(
  create_hw = target(
    rmarkdown::render(knitr_in(rmdf), output_dir = hw_outdir),
    transform = map(rmdf = !!hw_rmdfiles)
  ),
  make_index = target(
    rmarkdown::render_site(input = knitr_in(here::here('assignments'))),
    trigger = trigger(depend = all(file_exists(!!hw_outrmd)))
  )
)
config_slides <- drake_config(slides_plan, verbose = 2)
config_hw <- drake_config(hw_plan, verbose = 2)
