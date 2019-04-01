
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coursedown

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
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

process_notes(pdf=FALSE)
process_slides()

# or, all together
process(notes_pdf = FALSE)
```
