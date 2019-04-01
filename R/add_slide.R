add_slide <- function(nm = 'Untitled.Rmd'){
  require(usethis)
  require(yaml)
  course_data <- read_yaml('_course.yml')

  use_template('slide_template.Rmd',
               save_as = paste0('slides/',nm),
               package = 'coursedown',
               data = course_data)
}
