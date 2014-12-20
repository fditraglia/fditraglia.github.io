This is the git repository for my academic website and blog, built using [Jekyll](http://www.jekyllrb.com) and hosted on [GitHub Pages](https://pages.github.com/) with a custom domain name registered through [DreamHost](http://www.dreamhost.com).
Although I've used git and GitHub before, I don't know any ruby and this is my first time working with Jekyll.
This readme serves as a record of everything I did to get the site up and running.

I initially tried to get things set up on my Mac at work, but this was a real pain.
At home I'm running [Ubuntu](http://www.ubuntu.com) version 14.04 which is much easier to handle, so all of the instructions below refer to Linux.

Basic Jekyll Setup
------------------
The first thing I did was to install Ruby, RubyGems, and NodeJS via ``apt-get.`` after that, the [quick-start instructions](http://www.jekyllrb.com/docs/quickstart) worked like a charm and I was able to start playing around with a bare-bones Jekyll site:
```
gem install jekyll
jekyll new myblog
cd myblog
```
The site is then available on your local machine at ``http://localhost:4000``.
By browsing through the directories created by Jekyll and Googling for various bits and pieces that I didn't understand, I was able to get a good basic idea of how things work.

Getting Set Up for GitHub Pages
--------------------------------
Although I already had a minimal working example of Jekyll to play around with on my machine, I wanted to eventually host my website on GitHub pages, so I neede to install a few more pre-requisites. 
For details, and a description of the build process, see [GitHub Help: Using Jekyll with Pages](https://help.github.com/articles/using-jekyll-with-pages/).

Using a Custom Domain with GitHub Pages
----------------------------------------
Make sure to explain about the CNAME file, the *correct* IP address to set up with your DNS provider and the fact that it can take a *long time* for things to update!
Eventually provide step-by-step instructions.

- [GitHub Help: Setting up a custom domain](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages/)
- [GitHub Help: Configuring a custom apex domain](https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider/)
- [Haikus in C: Foolproof Guide to Github Pages with a Custom Domain](http://haikus-in-c.com/posts/github-pages-custom-domain/)


LaTeX Math in Jekyll
--------------------
See this post on [stackoverflow](http://stackoverflow.com/questions/10987992/using-mathjax-with-jekyll)
