library(drake)
library(fs)
library(here)
suppressPackageStartupMessages(library(tidyverse))
library(bookdown)

make_book <- function(infile, output_format){
  requireNamespace('bookdown')
  requireNamespace('here')
  setwd(here::here(fs::path_dir(infile)))
  infile1 <- as.character(fs::path_file(infile))
  # print(getwd())
  # print(infile)
  # if(fs::file_exists(infile)) print('file present')
  bookdown::render_book(infile1, output_format)
  setwd(here::here())
}


slides_rmdfiles <- dir_ls('slides/lectures/', glob = '*.Rmd')
slides_outdir <- here::here('docs','slides','lectures')
slides_outrmd <- fs::path('docs',slides_rmdfiles)
slides_outpdf <- str_replace(slides_outrmd, 'Rmd','pdf')

hw_rmdfiles <- dir_ls('assignments/HW', glob = '*.Rmd')
hw_outdir <- here::here('docs','assignments','HW')
hw_outrmd <- fs::path('docs',hw_rmdfiles)

top_rmdfiles <- dir_ls('.', glob = '*.Rmd')

full_plan <- drake_plan(
  create_slides_html = target(
    rmarkdown::render(knitr_in(rmdf), output_dir=slides_outdir),
    transform = map(rmdf=!!slides_rmdfiles)
  ),
  create_slides_pdf = target(
    coursedown::slide2pdf(knitr_in(rmdf)),
    transform = map(rmdf = !!slides_rmdfiles)
  ),
  make_slide_index = target(
    rmarkdown::render_site(input = knitr_in('slides/index.Rmd')),
    trigger = trigger(depend = all(file_exists(!!slides_outrmd)))
  ),
  create_hw_html = target(
    rmarkdown::render(knitr_in(rmdf), output_dir = hw_outdir),
    transform = map(rmdf = !!hw_rmdfiles)
  ),
  make_hw_index = target(
    rmarkdown::render_site(input = knitr_in(here::here('assignments'))),
    trigger = trigger(depend = all(file_exists(!!hw_outrmd)))
  ),
  create_notes_html = make_book(knitr_in('notes/index.Rmd'),"bookdown::gitbook"),
  create_notes_pdf = make_book(knitr_in('notes/index1.Rmd'),'bookdown::pdf_book'),
  create_top = target(
    rmarkdown::render_site(input = knitr_in(rmdf)),
    transform = map(rmdf = !!top_rmdfiles)
  )
)

drake_config(full_plan)
