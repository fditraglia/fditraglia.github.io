---
layout: post
title: Christmas Website Reboot
published: true
categories:
---

In a grand holiday tradition, dating back at least to my Freshman year of college, I spent the past three days completely re-designing my website.
As of this afternoon ``ditraglia.com`` is now powered by [Jekyll](http://jekyllrb) and served up by [GitHub Pages](https://pages.github.com).
I'm running something very close to the baseline Jekyll install with a few small tweaks here and there.
If you're interestd in seeing how I got everything set up, take a look at the README in the [git repo](https://github.com/fditraglia/fditraglia.github.io) for this site, and feel free to fork if anything looks interesting.

Now that I'm running Jekyll, I never have to edit another html file again: everything is done in markdown.
I have full MathJax support:

$$ \int_{-\infty}^{\infty} \frac{1}{\sqrt{2\pi} e^{-x^2/2} \; dx = 1 $$

And the next step will be to set things up so I can use RMarkdown as well.
[This](https://github.com/atbradley/jekyll-rmarkdown) looks like one promising possibility.
I'm also planning to take a closer look at [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar) which appears to provide support for parsing BibTeX to properly format references online.
Although GitHub pages doesn't support plugins, [this](http://charliepark.org/jekyll-with-plugins/) seems to be a good workaround.

In terms of content, the main addition is the blog you are currently reading.
The idea behind this is simply to keep a record of interesting or useful things I come across and ideas I'm thinking through.
When I'm stuck on a problem, be it mathematical or code-related, a quick search often turns up incredibly useful material on obscure or sometimes even defunct blogs.
By posting here, the idea is both to increase the signal to noise ratio of the internet by amplifying useful information and, if possible, to add some new information that may be useful to others.
I hope you enjoy!
