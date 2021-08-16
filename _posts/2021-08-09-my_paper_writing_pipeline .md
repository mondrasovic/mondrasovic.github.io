---
layout: post
use_mathjax: true
title: My paper writing pipeline using LaTeX
date: 2021-08-09 09:00:00 +0100
categories: [tutorial]
excerpt: In this post, I show how I approach writing research papers using LaTeX.
---

# Introduction

In this post, I want to share the pipeline that I use for writing research papers and then discussing them with my Ph.D. supervisor. The primary motivation to write this post and was to make communication with my supervisor who does not use [LaTeX](https://www.latex-project.org/) as smooth as possible. He also supervised my bachelor's as well as master's theses that I wrote using [MS Word](https://www.microsoft.com/sk-sk/microsoft-365/word). Thanks to the revision system, our discussions about changes were flawless and the whole process was quick. However, since the beginning of my Ph.D. studies in the applied computer science program, I have relied solely on LaTeX to write my papers (for obvious reasons) and to produce the final PDF file. Thus, we ended up adding suggestions, comments, and highlights of modifications to the PDF file itself, which was rather cumbersome. Moreover, little changes in phrasing or just spelling corrections could hardly be caught. This got me thinking about whether there was a revision system for LaTeX that provided at least similar capabilities to MS Word. It turned out, there was such a service as part of paid [Overleaf](https://www.overleaf.com/) license, but I wanted something free. To this end, I created my process to circumvent the obstacles of having to highlight changes manually in the PDF file. I managed to resolve the problem of producing *diff-like* PDF files based on LaTeX sources completely free and quickly. With this in mind, the main **contribution** of this tutorial is as follows:
* I show how to effectively **incorporate *diff* mechanism when using** LaTeX (similar to revision system in MS Word to easily disseminate the modifications with other people, even with the ones who do not use LaTeX by themselves.
* I provide an **example of my work pipeline** for inspiration to see how I approach writing and managing research papers.

# Prerequisites

I am going to assume that the reader knows how to use LaTeX, either remotely or locally. I think that unless the reader has enough experience with LaTeX, then my motivation and subsequent recommendation would not be fully understood. To make things easier and to describe my current work pipeline, I am going to demonstrate the process using [Overleaf](https://www.overleaf.com/). Even though [Overleaf](https://www.overleaf.com/) is a perfect tool for remote work with LaTeX documents, we still need to exploit local applications to produce *diff*s.

I recommend the user to install `texlive-full`.

The two tools that we are going to rely on are:

* [latexpand](https://www.ctan.org/pkg/latexpand) - *Latexpand* is a Perl script that simply replaces `\input` and `\include` commands with the content of the input or included file.
* [latexdiff](https://www.ctan.org/pkg/latexdiff) - *Latexdiff* is a Perl script for visual mark up and revision of significant differences between two LaTeX files. Various options are available for visual markup using standard LaTeX packages such as color. Changes not directly affecting visible text, for example in formatting commands, are still marked in the LaTeX source. A rudimentary revision facility is provided by another Perl script, latexrevise, which accepts or rejects all changes. Manual editing of the difference file can be used to override this default behavior and accept or reject selected changes only. 

# Work Pipeline Demonstration

## Project structure

I prefer to separate the contents of the paper into multiple source files. I am a programmer, and I use LaTeX due to its programming-like approach (among other things). I guess separation of concerns and reduction of coupling are well-established manners that programmers should adhere to all the time. Concerning this, I always (give or take) create the following structure:

```
main.tex
references.bib
\sections\introduction.tex
\sections\related_work.tex
\sections\methodology.tex
\sections\experiments.tex
\sections\conclusion.tex
```

The structure would change a little from paper the paper, but you get the gist.

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

% Top, middle, and bottom rules in tables.
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

The reason why I am showing this hierarchy is that to produce the *diff* file, the `latexdiff` command requires the old and the new file. However, we now have multiple files, so we will have to merge them before finding differences. Just for the record, having to produce a single may also be required for certain publications, so that may be one more reason for me to show you a way to do it.

## Merging files

To produce a single LaTeX file from multiple sub-files, we need to use the `latexpand` command. The usage is simple. Just provide the name of the root file and every other referred sub-file will be *expanded* by the pre-processor. In our case, we may use:

```bash
latexpand main.tex > main_flat.tex
```

## Creating *diff* LaTeX file

To generate the *diff*-like LaTeX source file reflecting changes between the two versions of the same document, we will employ `latexdiff` utilize as follows:

```bash
latexdiff main_orig_flat.tex main_new_flat.tex > main_diff.tex
```

It takes two files, the *old* and the *new* version of the document, and produces the *diff*-like output. As you can see, we may only provide two source files. That's why we have to merge sub-files (see the previous step for details).

At some point, I had trouble with generating the *diff* file when I made certain changes in tables and figures. To remedy this, try:

```
latexdiff --config="PICTUREENV=(?:picture|DIFnomarkup|align|tabular)[\w\d*@]*" main_orig_flat.tex main_new_flat.tex > main_diff.tex
```


## Putting it all together

Here is the script (I named it `diff_paper_latex.tex`) that can produce the *diff*-like LaTeX source file between two versions of the same LaTeX document.

```bash
#!/usr/bin/bash

mkdir -p $3

cd $1
latexpand main.tex > ../$3/main_orig_flat.tex
cd ..

cd $2
latexpand main.tex > ../$3/main_new_flat.tex
cd ..

cd $3
latexdiff --config="PICTUREENV=(?:picture|DIFnomarkup|align|tabular)[\w\d*@]*" main_orig_flat.tex main_new_flat.tex > main_diff.tex
```

The script requires the names of three directories. The first is the directory of the old document version that contains the main.tex file. The second directory is the corresponding new version of the same document. The third document is the output directory into which the `main_diff.tex` file will be saved (besides the two auxiliary files). The script may be executed as follows:

```
./diff_paper_latex.sh paper_version_old paper_version_new paper_version_diff
```

After this step, all that remains is to grab the `main_diff.tex` file and either compile it locally or put it into some remote server (e.g., Overleaf) to show it there. It is a regular LaTeX file as any other, thus one may incorporate it into the existing compilation pipeline easily.

# Example

For simplicity's sake, assume that we have two versions of the same LaTeX document contained only in a single source file. The content of the `main_orig.tex` file is:

```latex
\documentclass{article}
\usepackage[utf8]{inputenc}

\pagenumbering{gobble}

\title{Sample Document}
\date{August 2021}

\begin{document}

\maketitle

\section{Introduction}

Here is a short sentence in the introduction. This sentence will be removed in the new version. And another sentence will be appended after this one. Stay tuned!

\end{document}
```

whereas the content of `main_new.tex` conveys the changes shown below:

```latex
\documentclass{article}
\usepackage[utf8]{inputenc}

\pagenumbering{gobble}

\title{Sample Document}
\date{August 2021}

\begin{document}

\maketitle

\section{Introduction}

Here is a short sentence in the introduction. And another sentence will be appended after this one. New content has been inserted into the document. Stay tuned!

\

\noindent Thanks for reading!

\end{document}
```

The corresponding produced *diff*-like LaTeX source file looks like this (the default definitions were stripped for clarity - but you get the idea):

```latex
\documentclass{article}
%DIF LATEXDIFF DIFFERENCE FILE
%DIF DEL main_orig.tex   Mon Aug 16 09:52:34 2021
%DIF ADD main_new.tex    Mon Aug 16 09:52:34 2021
\usepackage[utf8]{inputenc}

\pagenumbering{gobble}

\title{Sample Document}
\date{August 2021}

% !!! HERE WOULD BE A LIST OF AUTOMATICALLY GENERATED DEFINITIONS BY THE LATEXDIFF TOOL.

\begin{document}

\maketitle

\section{Introduction}

Here is a short sentence in the introduction.\DIFdelbegin \DIFdel{This sentence will be removed in the new version. }\DIFdelend And another sentence will be appended after this one. \DIFdelbegin \DIFdel{Stay tuned}\DIFdelend \DIFaddbegin \DIFadd{A new content has been inserted into the document. Stay tuned!
}

\DIFadd{\
}

\noindent \DIFadd{Thanks for reading}\DIFaddend !

\end{document}
```

When compiled and rendered, we have a nice looking PDF. To demonstrate, here we have the three files in the same order rendered:

| ![original-LaTeX-document]({{ site.baseurl }}images/document_render_orig.jpg){:class="img-responsive"} |
|:--:|
| *Original LaTeX document.* |

| ![new-LaTeX-document]({{ site.baseurl }}images/document_render_new.jpg){:class="img-responsive"} |
|:--:|
| *New (modified) LaTeX document.* |

| ![diff-LaTeX-document]({{ site.baseurl }}images/document_render_diff.jpg){:class="img-responsive"} |
|:--:|
| *Diff-like LaTeX document for revision.* |

# Conclusion

I hope that the process described above was easy to comprehend and that you learned something. To my mind, having mastered LaTeX is a must on a personal level if someone wants to quickly write technical research papers. But still, not everyone shares this view. Each to their own. To find some common ground between the MS Word and LaTeX world, I think that working on the level of PDF file carrying annotations depicting differences makes the communication between co-authors or article reviewers much faster. I tried it personally. I suggest you try it for yourself, too.
