---
layout: post
use_mathjax: true
title: My paper writing pipeline using LaTeX
date: 2021-07-09 09:00:00 +0100
categories: [tutorial]
excerpt: In this post, I show how I approach writing research papers using LaTeX.
---

# Introduction

In this post, I want to share my pipeline that I use for writing research papers and then discussing them with my Ph.D. supervisor. The primary motivation to write this post and was to make communication with my supervisor who does not use [LaTeX](https://www.latex-project.org/) as smooth as possible. He also supervised my bachelor's as well as master's theses that I wrote using [MS Word](https://www.microsoft.com/sk-sk/microsoft-365/word). Thanks to revision system, our discussions about changes were flawless and the whole process was quick. However, since the beginning of my Ph.D. studies, I have relied solely on LaTeX to write my papers (for obvious reasons) and to produce the final PDF file. Thus, we ended up adding suggestions, comments, and highlights of modifications to the PDF file itself, which was rather cumbersome. Moreover, little changes in phrasing or just spelling corrections could hardly be caught. This got me thinking whether there was a revision system for LaTeX that provided at least similar capabilities to MS Word. It turned out, there was such a service as part of paid [Overleaf](https://www.overleaf.com/) license, but I wanted something free. To this end, I created my own process to circumvent the obstacles of having to highlight changes manually in the PDF file. I managed to resolve the problem of producing *diff-like* PDF-file based on LaTeX sources completely free and quickly. With this in mind, the **contribution** of this tutorial is the following:
* I show how to effectively **incorporate *diff* mechanism when using** LaTeX (similar to revision system in MS Word to easily disseminate the modifications with other people, even with the ones who do not use LaTeX by themselves.
* I provide an **example of my personal work pipeline** for inspiration to see how I approach writing and managing research papers.

# Prerequisites

I am going to assume that the reader is knows how to use LaTeX, either remotely or locally. I think that unless the reader has enough experience with LaTeX, then my motivation and subsequent recommendation would not be fully understood. To make things easier and to actually describe my current work pipeline, I am going to demonstrate the process using [Overleaf](https://www.overleaf.com/). Despite the fact that [Overleaf](https://www.overleaf.com/) is a perfect tool for remote work, we still need to exploit local applications to produce diffs.

I recommend the user to install `texlive-full`.

The two tools that we are going to rely on are:

* [latexpand](https://www.ctan.org/pkg/latexpand) - Latexpand is a Perl script that simply replaces `\input` and `\include` commands with the content of the input or included file.
* [latexdiff](https://www.ctan.org/pkg/latexdiff) - Latexdiff is a Perl script for visual mark up and revision of significant differences between two LaTeX files. Various options are available for visual markup using standard LaTeX packages such as color. Changes not directly affecting visible text, for example in formatting commands, are still marked in the LaTeX source. A rudimentary revision facilility is provided by another Perl script, latexrevise, which accepts or rejects all changes. Manual editing of the difference file can be used to override this default behaviour and accept or reject selected changes only. 

# Work Pipeline Demonstration

## Project structure

I prefer to separate the contents of the paper into multiple source files. I am a programmer, and I use LaTeX due to its programming-like approach (among other things). I guess a separation of concerns and reduction of coupling are well-established manners that programmers should adhere to all the time. Concerning this, I always (give or take) create the following structure:

```
main.tex
references.bib
\sections\introduction.tex
\sections\related_work.tex
\sections\methodology.tex
\sections\experiments.tex
\sections\conclusion.tex
```

Obviously, the structure would change a little from paper the paper, but you get the gist.

The `main.tex` file thus contains all these sections included like this:

```latex
\documentclass[10pt,twocolumn]{article}

\usepackage[a4paper,portrait,width=170mm,top=20mm,bottom=20mm]{geometry}

\usepackage{graphicx}

\usepackage[numbers]{natbib}

% Provides \text{} command in the math mode.
\usepackage{amsmath}

\renewcommand{\figurename}{Fig.}

% To enable \mathbb{} macro and many others.
\usepackage{amssymb}

\usepackage{times} 

% To enable \mathbbm{} macro.
\usepackage{bbm}

% Nice fractions formatted as a/b.
\usepackage{nicefrac}

% Automatic line breaking of displayed equations.
\usepackage{breqn}

% Multi-column tables.
\usepackage{multicol}
\usepackage{multirow}

\usepackage[font={small,it},labelfont=bf]{caption}

% Top, middle and bottom rules in tables.
\usepackage{booktabs}

\usepackage[colorlinks=true,
            linkcolor=red,
            urlcolor=green,
            citecolor=blue]{hyperref}

\begin{document}

\title{Paper title}
\author{Author information}
\date{}

\maketitle

\input{sections/introduction}
\input{sections/related_work}
\input{sections/methodology}
\input{sections/experiments}
\input{sections/conclusion}

\section*{Acknowledgment}

\bibliographystyle{unsrt}
\bibliography{references}

\end{document}
```

Individual files have the following content. For example, `introduction.tex`:

```latex
\section{Introduction}
\label{sec:introduction}
```

then `related_work.tex`:

```latex
\section{Related Work}
\label{sec:related_work}
```

then `methodology.tex`:

```latex
\section{Methodology}
\label{sec:methodology}
```

then `experiments.tex`:

```latex
\section{Experiments}
\label{sec:experiments}
```

and the last file `conclusion.tex`:
```latex
\section{Conclusion}
\label{sec:conclusion}
```

The reason why I am showing this hierarchy is that in order to produce the *diff* file, the `latexdiff` command requires old and new file. However, we now have multiple files, so we will have to merge them prior to finding differences. Just for the record, having to produce a single may also be required for certain publications, so that may one more reason for me to show you a way to do it.

## Merging files

## Creating diff LaTeX file

## Display diff PDF files

## Putting it all together

# Conclusion

I hope that the process described above was easy to comprehend and that you learned something. To my mind, having mastered LaTeX is a must on a personal level if someone wants to quickly write technical research papers. But still, not everyone shares this view. Each to their own. In order to find some common ground between the MS Word and LaTeX world, I think that working on the level of PDF file carrying annotations depicting differences makes the communication between co-authors or article reviewers much faster. I tried it personally. I suggest you try it for yourself, too.

# References
