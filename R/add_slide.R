#' Adding a `xaringan` RMarkdown file into the `slides` folder
#'
#' @details
#' If a custom template is provided, it should be in the `whisker` format, with
#' entries taken from the following list:
#' \itemize{
#' \item course_shortname (course number)
#' \item course_name (course name)
#' \item instructor (instructor)
#' \item description (description of course)
#' \item dates (Dates/semester for course)
#' \item short_repo (short form of github repo, user/repo)
#' \item course_shortname1 (course number without spaces)
#' \item github (full github URL)
#' \item course_url (URL for course homepage)
#' \item slack (Slack channel for course)
#' \item twitter (Twitter handle of instructor)
#' }
#'
#' @param nm Name of the file
#' @param template (default = "default") file path to template file in `whisker` format
#' @param open (T/F) should file be opened after creation
#'
#' @return A new `xaringan`-flavored RMarkdown file
#' @export
#'
#' @examples
#' # add_slide('ggplot.Rmd')
add_slide <- function(nm = 'Untitled.Rmd', template='default', open=TRUE){
  require(usethis)
  require(yaml)
  course_data <- read_yaml('_course.yml')

  if(template=='default'){
  use_template('slide_template.Rmd',
               save_as = paste0('slides/',nm),
               package = 'coursedown',
               data = course_data)
  } else {
    contents <- strsplit(whisker::whisker.render(
      readLines(template, encoding = 'UTF-8'), course_data),'\n')[[1]]
    writeLines(contents, con = file(file.path('slides', nm)))
    if(open) usethis::edit_file(file.path('slides',nm))
  }
}
