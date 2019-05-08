#' Processing all the raw files to create a deployable website
#'
#' The default location for the deployed files is in `here::here('docs')`, i.e the docs folder. The
#' assumption is that the website is deployed on GitHub Pages, where the pages are in the docs folder
#' rather than in the gh-pages branch. This can be set in the settings of the GitHub repository
#'
#' @param drake_source The location of the file containing the drake plan that creates all the deployable web files. Default value is `_drake.R` in the top folder of the project, i.e. `here::here('_drake.R')`.
#' @param plan Name of the drake plan. Defaults to `full_plan` as in the default `_drake.R` template
#' @param lock_environment A logical designating whether we should lock the environment when using `make(plan)`. See the Self-invalidation section of the `drake::make` documentation.
#'
#' @return Several files are created that comprise the deployable website, with xaringan presentations in HTML, PDF and raw Rmd, course notes as a gitbook-formatted bookdown web document and PDF, homeworks as HTML pages and R Markdown, and a top-level website with information about the course.
#' @export
#'
#' @examples
#' # Not run:
#' # process() # Uses default values
process <- function(drake_source = here::here('_drake.R'), plan = full_plan, lock_environment = TRUE){
  curdir <- getwd()
  setwd(here::here())
  if(!fs::file_exists(drake_source)){
    usethis::use_template('_drake.R', package='coursedown', save_as = drake_source)
  }
  tmp <- new.env()
  source(drake_source, local = tmp) # capturing names of the created objects
  source(drake_source)
  tst <- tryCatch(drake::make(plan, lock_envir = lock_environment))
  if(is.null(tst)) {
    rm(list = ls(tmp), envir = as.environment('.GlobalEnv'))
    rm(tmp)
  }
  setwd(curdir)
}
