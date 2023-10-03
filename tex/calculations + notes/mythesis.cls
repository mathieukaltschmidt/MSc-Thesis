\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2020/04/09 Style for my Master thesis]

% Options to easily switch output format
\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption{digital}{\@printfalse}

\ExecuteOptions{digital}
\ProcessOptions\relax

% General
\LoadClassWithOptions{scrreprt}

% Geometry
\RequirePackage[onehalfspacing]{setspace}
\RequirePackage[a4paper,width=150mm,top=30mm,bottom=30mm]{geometry}

% Links and Colors
\RequirePackage{color,xcolor}
\definecolor{MScRed}{RGB}{157,0,0}
\definecolor{MScBlue}{RGB}{1,1,141}
\definecolor{MScGreen}{RGB}{0, 119, 85}
\definecolor{MScGray}{RGB}{102, 102, 142}

\RequirePackage{hyperref}
\if@print % switch link coloring off for printing
	\hypersetup{colorlinks=false}
	
\else
	\hypersetup{colorlinks=true, 
	            linkcolor=MScBlue, 
	            citecolor = MScGreen, 
	            urlcolor= MScBlue}
\fi
\AtBeginDocument{
	\hypersetup{ % set pdf metadata
	    pdfauthor={\@author},
		pdftitle={\@title}
	}
}

% Math and physics utility to load before font selection
\RequirePackage{amsmath,amssymb,nccmath}
\RequirePackage{commath}
\RequirePackage{mathtools}
\RequirePackage{physics, slashed} %QFT notation
\RequirePackage{xfrac, relsize, bbm, chngcntr} %more options for formulas
\RequirePackage[export]{adjustbox}

% Fonts
\RequirePackage{fontspec,xunicode, lmodern}
\RequirePackage[utf8]{inputenc}
\setmainfont{Palatino}
\setsansfont{Optima}
\setmonofont[Scale=MatchLowercase]{Menlo}

% Language support
\RequirePackage{polyglossia}
\setmainlanguage{english}
\setotherlanguages{german}

% Titles
\RequirePackage{titlesec}
\titleformat{\chapter}[display]
{\LARGE\bfseries}{\chaptertitlename\ \thechapter}{0pt}{\huge}

%Headings
\addtokomafont{disposition}{\rmfamily} % serif font for headings
%\setkomafont{section}{\bfseries\Large}
%\setkomafont{subsection}{\bfseries\large}
%\setkomafont{subsubsection}{\bfseries\normalsize}

% Units
\RequirePackage[separate-uncertainty]{siunitx}

% Tables
\RequirePackage{array} % for math mode in tables
\RequirePackage{booktabs} % for hline rules

% Figures and appearance
\RequirePackage{graphicx, float, subcaption}
\RequirePackage[labelfont=bf]{caption}
\captionsetup[figure]{labelsep=space}
\captionsetup[table]{labelsep=space}

% Page Layout
\RequirePackage{fancyhdr}
\fancyhfoffset{0pt}
\pagestyle{fancy}
\fancyhf{}
\if@twoside
	\fancyhead[LE]{
	    \footnotesize{\nouppercase{\leftmark}}
	}
	\fancyhead[RO]{
		\footnotesize{\nouppercase{\rightmark}}
	}
	\fancyfoot[C]{
		\thepage
	}
\else
	\fancyhead[L]{
	    \footnotesize{\nouppercase{\leftmark}}
	}
	\fancyfoot[C]{
		\thepage
	}
\fi
\renewcommand{\headrulewidth}{0.2pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{
	\fancyhead{}
	\renewcommand{\headrulewidth}{0pt}
}

% Type optimization
\RequirePackage{microtype}

% Modify footnotes
\RequirePackage{scrextend}
\deffootnote[10pt]{10pt}{10pt}{\makebox[15pt][l]{\thefootnotemark.\hspace{10pt}}}
\counterwithout{footnote}{chapter} %not resetting the footnote counter after new chapter begins

% Bibliography
\RequirePackage[
	style=numeric-comp,
	backend=biber,
	isbn=false,
	date=year,
	url=false,
	doi=false,
	sorting = none, %refs sorted as cited in the main document
	hyperref = auto, ,backref, backrefstyle=none
]{biblatex}

\DeclareFieldFormat*{title}{``#1"}
\DeclareFieldFormat*{date}{(#1)}
\renewbibmacro{in:}{\iffieldundef{journaltitle}{\addspace}{\adddot\addspace In: }}
\renewbibmacro*{issue+date}{\iffieldundef{issue}
    {\usebibmacro{date}}
    {\printfield{issue}%
     \setunit*{\addspace}%
     \usebibmacro{date}}%
     \newunit}
\renewbibmacro*{publisher+location+date}{%
  \printlist{publisher}%
  \iflistundef{location}{}{\setunit*{\space}}%
  \printlist{location}%
  \setunit*{\addspace}%
  \usebibmacro{date}%
  \newunit}
\usepackage{xpatch}
\xpatchbibdriver{thesis}
  {\printfield{type}%
   \newunit
   \usebibmacro{institution+location+date}}
  {\printfield{type}%
   \setunit*{\addspace}%
   \usebibmacro{date}}
  {}{}
\AtEveryBibitem{%
    \clearfield{pages}%
}

%Blindtext
\RequirePackage{blindtext}

% Appendix
\RequirePackage[toc,page]{appendix}

% Reinstate the correct level for list of tables and figures
\appto\listoffigures{\addtocontents{lof}{\protect\setcounter{tocdepth}{1}}}
\appto\listoftables{\addtocontents{lot}{\protect\setcounter{tocdepth}{1}}}

%Layout of citations
\renewcommand*{\figref}[2][]{%
		\hyperref[{#2}]{%
			Figure~\ref{#2}%
			\ifx\\#1\\%
			\else#1%
			\fi
		}}

	\newcommand*{\tabref}[1]{%
		\hyperref[{#1}]{%
			Table~\ref{#1}
		}}
	
	\renewcommand*{\secref}[2][]{%
		\hyperref[{#2}]{%
			\ifx\\#1\\%
			Section~\ref{#2}%
			\else
			\text{#1}.~\ref{#2}%
			\fi
	}}
	
	\newcommand*{\chapref}[2][]{%
		\hyperref[{#2}]{%
			\ifx\\#1\\%
			Chapter~\ref{#2}%
			\else
			\text{#1}.~\ref{#2}%
			\fi
	}}

	\renewcommand*{\eqref}[2][]{%
		\hyperref[{#2}]{%
			Equation~\ref{#2}%
			\ifx\\#1\\%
			\else#1%
			\fi
	}}
\endinput