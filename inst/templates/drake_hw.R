library(drake)
library(fs)

files <- dir_ls(path=here::here('assignments/HW'), glob='*.Rmd', type='file')
out_html <- files %>% map_chr(~str_replace(., 'assignments','docs/assignments')) %>%
  map_chr(~str_replace(., 'Rmd','html'))


plan <- drake_plan(
  render = target(
    rmarkdown::render(
      knitr_in(infile), output_dir=here::here('docs/assignments/HW')),
    transform = map(infile = !!files))
)
# config <- drake_config(plan)
# vis_drake_graph(config)
plan_pdf <- drake_plan(
  render_pdf = target(
    pagedown::chrome_print(infile),
    transform = map(infile = !!out_html)
  )
)

