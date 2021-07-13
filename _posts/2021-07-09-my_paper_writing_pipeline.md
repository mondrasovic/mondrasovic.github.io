---
layout: post
use_mathjax: true
title: My paper writing pipeline using LaTeX
date: 2021-07-09 09:00:00 +0100
categories: [tutorial]
excerpt: In this post, I show how I approach writing research papers using LaTeX.
---

# Introduction

In this post, I want to share my pipeline that I use for writing research papers and then discussing them with my Ph.D. supervisor. The primary motivation to write this post and to actually implement the described steps in the first place was to make communication with my supervisor who does not use [LaTeX](https://www.latex-project.org/) as smooth as possible. He also supervised my bachelor's as well as master's theses that I wrote using [MS Word](https://www.microsoft.com/sk-sk/microsoft-365/word). Thanks to revision system, our discussions about changes were flawless and the whole process was quick. However, since the beginning of my Ph.D. studies, I have relied solely on LaTeX to write my papers (for obvious reasons) and to produce the final PDF file. Thus, we ended up adding suggestions, comments, and highlights of modifications to the PDF file itself, which was cumbersome. Moreover, little changes in phrasing or just spelling corrections could hardly be caught. This got me thinking whether there was a revision system for [LaTeX](https://www.latex-project.org/) that provided at least similar capabilities to [MS Word](https://www.microsoft.com/sk-sk/microsoft-365/word). It turned out, there was such a service as part of paid [Overleaf](https://www.overleaf.com/) license, but I wanted something free. To this end, I created my own process to circumvent the obstacles of having to highlight changes manually in the PDF file. I managed to resolve the problem of producing *diff-like* PDF-file based on LaTeX sources completely free and quickly. With this in mind, the **contribution** of this tutorial is the following:
* I show how to effectively **incorporate *diff* mechanism when using** [LaTeX](https://www.latex-project.org/) (similar to revision system in [MS Word](https://www.microsoft.com/sk-sk/microsoft-365/word)) to easily disseminate the modifications with other people, even with the ones who do not use [LaTeX](https://www.latex-project.org/) by themselves.
* I provide an **example of my personal work pipeline** for inspiration to see how I approach writing research papers.

# Prerequisites

I am going to assume that the reader is knows how to use LaTeX, either remotely or locally. I think that unless the reader has enough experience with LaTeX, then my motivation and subsequent recommendation would not be fully understood. To make things easier and to actually describe my current work pipeline, I am going to demonstrate the process using [Overleaf](https://www.overleaf.com/). Despite the fact that [Overleaf](https://www.overleaf.com/) is a perfect tool for remote work, we still need to exploit local applications to produce diffs.

I recommend the user to install `texlive-full`.

The two tools that we are going to rely on are:

* [latexpand](https://www.ctan.org/pkg/latexpand) - Latexpand is a Perl script that simply replaces `\input` and `\include` commands with the content of the input or included file.
* [latexdiff](https://www.ctan.org/pkg/latexdiff) - Latexdiff is a Perl script for visual mark up and revision of significant differences between two LaTeX files. Various options are available for visual markup using standard LaTeX packages such as color. Changes not directly affecting visible text, for example in formatting commands, are still marked in the LaTeX source. A rudimentary revision facilility is provided by another Perl script, latexrevise, which accepts or rejects all changes. Manual editing of the difference file can be used to override this default behaviour and accept or reject selected changes only. 

# Work Pipeline Demonstration

I prefer to separate the contents of the paper into multiple source files. I am a programmer, and I use LaTeX due to its programming-like approach (among other things). I guess a separation of concerns and reduction of coupling are well-established manners that programmers should adhere to all the time. Concerning this, I always (give or take) create the following structure:

```
main.tex
\sections\introduction.tex
\sections\related_work.tex
\sections\methodology.tex
\sections\experiments.tex
\sections\conclusion.tex
```

Obviously, the structure would change a little from paper the paper, but you get the gist.

The main file thus contains all these sections included like this:

```latex
\begin{document}

# Other statements...

\input{sections/introduction}
\input{sections/related_work}
\input{sections/methodology}
\input{sections/experiments}
\input{sections/conclusion}

\end{document}
```

The reason why I am showing this hierarchy is that in order to produce the *diff* file, the `latexdiff` command requires old and new file. However, we now have multiple files, so we will have to merge them prior to finding differences. Just for the record, having to produce a single may also be required for certain publications, so that may one more reason for me to show you a way to do it.

# Conclusion

# References
