slide2note <- function(infile, outdir = 'notes', outfile = basename(infile)){
  require(stringr)
  require(purrr)
  require(magrittr)
  require(rmarkdown)
  require(yaml)
  outfile <- file.path(outdir, outfile)
  file_contents <- readLines(infile)
  ind <- which(map_lgl(file_contents, str_detect,'---'))
  title <- rmarkdown:::parse_yaml_front_matter(file_contents)$title
  title <- paste('#',title)
  bl <- file_contents[-(1:ind[2])] # remove frontmatter
  bl <- bl %>%
    `[`(!str_detect(., 'class')) %>%
    `[`(!str_detect(., '---')) %>%
    `[`(!str_detect(.,'layout')) %>%
    `[`(!str_detect(., 'span')) %>%
    str_replace('^#','##') %>%
    c(c(title,''),.)
  writeLines(bl, con=file(outfile))
  yml <- read_yaml(file.path(outdir,'_bookdown.yml'))
  yml$rmd_files$html <- unique(c(yml$rmd_files$html, basename(outfile)))
  yml$rmd_files$latex <- unique(c(yml$rmd_files$latex, basename(outfile)))
  write_yaml(yml, file.path(outdir,'_bookdown.yml'))
}
