---
layout: page
title: R Workshop
permalink: /RWorkshop/
---

On November 21-22, 2014, I organized a hands-on R Workshop through the [Warren Center](http://warrencenter.upenn.edu) featuring [Yihui Xie](http://yihui.name) and [Dirk Eddelbuettel](http://dirk.eddelbuettel.com).
This page contains an archive of the material covered in the workshop, along with setup instructions.

## Yihui's Material

- [Intro to R Slides](http://bit.ly/upenn-r-yihui-1)
- [knitr and RMarkdown Slides](http://bit.ly/upenn-r-yihui-2)
- [Code for knitr and RMarkdown](http://bit.ly/upenn-r-yihui-3)

## Dirk's Material

- [R Package Development](http://dirk.eddelbuettel.com/papers/r_package_development_nov2014.pdf)
- [High-Performance Computing with Rcpp](http://dirk.eddelbuettel.com/papers/rcpp_rcpparmadillo_nov2014.pdf)

## Laptop Setup Instructions

### Step 1: Install R and RStudio

You'll first need to download and install R from [CRAN](http://cran.r-project.org/). 
In this workshop we'll interact with R via a front-end called RStudio so that everyone sees the same interface regardless of operating system. 
After installing R, you can download and install RStudio [here](http://www.rstudio.com/products/rstudio/download).
If you run into any problems, detailed video instructions are available for [Mac](https://www.youtube.com/watch?v=cX532N_XLIs) and [Windows](https://www.youtube.com/watch?v=eD07NznguA4) on Youtube.
If you're running Linux, we'll assume you already know what you're doing ;)
 
### Step 2: Familiarize Yourself with R and R Studio

If you've never used R or RStudio before, don't panic! 
The first session will be an overview of R and we're going to do our best to make sure that you can still benefit from the workshop. 
If you've done a little programming in a language like python or matlab, you should be fine. 
If you haven't, that's ok too but it might be worth spending a little time familiarizing yourself with R and RStudio before the workshop. 
I recommend starting with the [Try R](http://tryr.codeschool.com/) interactive tutorial from O'Reilly's Code School. 
It's free and doesn't require that you have R installed on your machine: you can do everything in a browser window. 
You may also want to take a look at my R Tutorials for Econ 103 at Penn. Links to the tutorials and solutions are posted [here](http://ditraglia.com/Econ103Public) (scroll down to "R Tutorials"). 
RStudio is fairly self-explanatory but if you've never done any programming before you may want to take a look at [this video](https://www.youtube.com/watch?v=Px-6a7fetCg) by Peter Rossi.

### Step 3: Install R Packages

During the workshop we'll use a number of *packages* to extend the functionality of R in helpful ways: ``pkgKitten``, ``knitr``, ``rmarkdown``, and ``RcppArmadillo``.
``RcppArmadillo`` is only needed for our final session on high performance computing. 
Since it's a bit harder to set up, I'll discuss it as a separate item below. In this step you will need to install the other three packages: ``pkgKitten``, ``knitr`` and ``rmarkdown``.
This is very easy to do using RStudio. Simply open the program and follow the instructions in this [video](https://www.youtube.com/watch?v=u1r5XTqrCTQ").
Instead of entering ``modest`` into the dialog box, enter ``pkgkitten``.
Then go back and repeat the same process for ``knitr`` and ``rmarkdown``.

### Step 4: Install RcppArmadillo

This step is only necessary if you'll be joining us for the final session on high-performance computing. 
This session will be a bit more technically involved as we'll be learning how to use C++ code from within R to speed up computationally intensive algorithms. 
If you're running Linux, setting up ``RcppArmadillo`` is easy: you already have all the necessary compilers on your machine so you simply need to install the package from within RStudio as in Step 3 above. 
On Windows, things are more complicated. 
Before installing ``RcppArmadillo`` from within RStudio, you'll need to download and install [Rtools](http://cran.r-project.org/bin/windows/Rtools).
If you're running Mac OSX, you'll need to sign up for a free developer account with Apple [here](https://developer.apple.com/register/).
Then you'll need to log in and install the Command Line Tools for Xcode. 
*Add in details of how to install on Mavericks...*
