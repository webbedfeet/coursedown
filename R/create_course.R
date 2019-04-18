#' Create a template file and directory structure for a teaching course
#'
#' This creates folders for slides, course notes and homework,
#' as well as a website for the course with syllabus, instructor bio and
#' other resources
#'
#' @param slides Should a directory for slides be created, and templates populated (default=T)
#' @param notes Should a directory for course notes be created, and templates populated (Default=T)
#' @param hw Should a directory for homeworks be created and templates populated (default = F)
#'
#' @export
#'
create_course <- function(slides = TRUE, notes = TRUE, hw = FALSE){

  # data inputs
  inputs <- list(
    'course_shortname' = 'Course number',
    'course_name' = 'Full course name',
    'instructor' = 'Instructor',
    'description' = 'Description',
    'course_url' = 'Class URL',
    'dates' = 'Dates',
    'slack' = 'Slack Channel',
    'short_repo' = 'Github (user/repo)',
    'twitter' = 'Twitter handle'
  )
  if(fs::file_exists('_course.yml')){
    course_data <- yaml::read_yaml('_course.yml')
  } else {
    course_data <- list()
  }
  `%nin%` <- Negate(`%in%`)
  for(u in names(inputs)){
    if(u %nin% names(course_data)) course_data[[u]] <-
        readline(prompt = paste0(inputs[[u]],': '))
  }

  course_data$course_shortname1 <- gsub(' ','_',course_data$course_shortname)
  course_data$github <- paste0('https://www.github.com/', course_data$short_repo)
  course_data$slack_channel <- paste0('https://',course_data$slack,'.slack.com')
  yaml::write_yaml(course_data, file = '_course.yml')

  course_directories <- c('R', 'docs')
  if(slides) course_directories <- c(course_directories,
                                     'slides/lectures/img', 'docs/slides/lectures')
  if(notes) course_directories <- c(course_directories,
                                    'notes/img','notes/latex', 'docs/notes')
  if(hw) course_directories <- c(course_directories,
                                'assignments', 'docs/assignments')

  fs::dir_create(course_directories, recursive = T)
  # Fill in top website files
  usethis::use_template('index_top.Rmd', save_as = "index.Rmd", package='coursedown',
               data=course_data)
    print('got here')
  usethis::use_template('top_sites.yml', save_as = '_site.yml', package='coursedown',
               data = course_data)
  fs::file_create(c('style.css', 'bio.Rmd','syllabus.Rmd','resources.Rmd'))

  if(slides){
    usethis::use_template('index_slides.Rmd',save_as = 'slides/index.Rmd', package = 'coursedown',
                 data = course_data)
    usethis::use_template('slide_site.yml', save_as = 'slides/_site.yml', package = 'coursedown',
                 data = course_data)
    usethis::use_template('slide_output.yml', save_as = 'slides/lectures/_output.yml', package='coursedown', data = course_data)
    usethis::use_template('drake_slides.R', save_as = 'slides/lectures/drake.R', package='coursedown',
                 data=course_data)
    fs::file_copy(fs::dir_ls(system.file('templates','css', package='coursedown'),
                     regexp='style.\\.css'),
              'slides', overwrite = T)
    fs::file_copy(fs::dir_ls(system.file('templates','css', package='coursedown'),
                     regexp = 'robot'),
              'slides/lectures', overwrite = T)
  }

  if(notes){
    usethis::use_template('index_notes.Rmd', save_as = 'notes/index.Rmd', package = 'coursedown',
                 data = course_data)
    usethis::use_template('index1_notes.Rmd', save_as = 'notes/index1.Rmd', package = 'coursedown',
                 data = course_data)
    usethis::use_template('bookdown.yml', save_as = 'notes/_bookdown.yml', package = 'coursedown',
                 data = course_data)
    usethis::use_template('output.yml', save_as = 'notes/_output.yml', package = 'coursedown',
                 data = course_data)
    fs::file_create(file.path('notes/latex',
                          c('preamble.tex','before_body.tex','after_body.tex')))
    fs::file_copy(system.file('templates','css','bookdown.css', package='coursedown'),
              'notes/style.css', overwrite = T)
    fs::file_copy(system.file('templates','00-Introduction.Rmd', package = 'coursedown'),
              'notes/00-Introduction.Rmd', overwrite = T)
  }

  if(hw){
    usethis::use_template('hw_index.Rmd', save_as = 'assignments/index.Rmd', package='coursedown',
                 data = course_data)
    usethis::use_template('assignment_site.yml', save_as = 'assignments/_site.yml',
                 package = 'coursedown',
                 data = course_data)
    fs::file_copy(system.file('templates','css','bookdown.css', package='coursedown'),
              'assignments/style.css', overwrite = T)

  }

}
