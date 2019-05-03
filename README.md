
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coursedown

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/webbedfeet/coursedown.svg?branch=master)](https://travis-ci.org/webbedfeet/coursedown)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/webbedfeet/coursedown?branch=master&svg=true)](https://ci.appveyor.com/project/webbedfeet/coursedown)
<!-- badges: end -->

The goal of coursedown is to create a template for course materials.

One folder (`slides`) comprises of lecture slides written using
`xaringan` and is processed using RMarkdown into a mini-website, where
the `index.Rmd` would be a listing of lectures as well as any meta-data
related to lectures.

One folder (`notes`) comprises course notes (which may be derivative of
the slides) built using `bookdown` into a gitbook-formatted online book

One folder (`assignments`) can hold homework assignments written in
RMarkdown

The top folder creates the class website using RMarkdown, which can link
to a [Slack](http://www.slack.com) space for class collaboration, the
[GitHub](http://www.github.com) repository for the course materials and
various other pages (standard ones are provided for syllabus, instructor
bio and other resources)

Building the web pages, presentations and course notes from R Markdown
is monitored and controlled by
[drake](https://cran.r-project.org/web/packages/drake/).

## Installation

The development version can be installed from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("webbedfeet/coursedown")
```

## Example

This is a basic example which shows you how to create a structured set
of folders based on `coursedown`:

``` r
library(coursedown)
create_course(slides = T, notes = T, hw = F)

add_slide('00-Introduction.Rmd')
slide2note('slides/00-Introduction.Rmd', outdir = 'notes')
# This creates basic notes from the corresponding slides. These can now be
# edited before processing

process()
```

This will create the website in the `docs` folder. Opening
`docs/index.html` will give you access to the full website. You can also
deploy this website using GitHub Pages

An example (in fact the first example) of this process can be seen for
my BIOF 439 class being taught Spring 2019 at FAES Graduate School @
NIH. [Follow the link](http://www.araastat.com/BIOF439)
