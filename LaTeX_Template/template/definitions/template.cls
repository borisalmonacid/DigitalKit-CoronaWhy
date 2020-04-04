% ============================================
% Corona Why class for LaTeX files	 04-04-2020
% For information about this class, please send an e-mail at boris.almonacid@globalchange.science

% change log.
% 04-04-2020    Boris Almonacid - boris.almonacid@globalchange.science
%               Initial Version, v1.0.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{definitions/template}[04/04/2020 CoronaWhy paper class]

 
% ----- Load class
\LoadClass[10.5pt,a4paper]{article}

% ------ Pre-load packages

% format packages.
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{indentfirst}    % for fix indent.
\RequirePackage{float}      % For float objects.
\RequirePackage{setspace}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{ifthen}
\RequirePackage{lineno}   % For line numberts
\RequirePackage{booktabs} % For \toprule etc. in tables
\RequirePackage[largestsep]{titlesec}
\RequirePackage{etoolbox} % For \AtBeginDocument etc.
\RequirePackage{tabto} % To use tab for alignment on first page
\RequirePackage[table]{xcolor} % To provide color for soul (for english editing) and provide coloring for tables (author request)
\RequirePackage{soul} % To highlight text
\newcommand{\highlight}[1]{\colorbox{yellow}{#1}}
\RequirePackage{multirow}
\RequirePackage{microtype} % For command \textls[]{}
\RequirePackage{blindtext} % For create a blind text (sample text)
\RequirePackage{totcount} % To enable extracting the value of the counter "page" 

% graphic packages.
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{tikz} % For \foreach used for Orcid icon

% math packages.
\RequirePackage{amsmath}
\RequirePackage{mathpazo}
\RequirePackage{calc}

% algorithm packages.
% from https://shantoroy.com/latex/how-to-write-algorithm-in-latex/
\RequirePackage{xcolor}
% https://www.ctan.org/pkg/algorithm2e
\RequirePackage[linesnumbered, ruled, vlined]{algorithm2e}
%%% Coloring the comment as blue
\newcommand\mycommfont[1]{\footnotesize\ttfamily\textcolor{bluecite}{#1}}
\SetCommentSty{mycommfont}
\SetKwInput{KwInput}{Input}                % Set the Input
\SetKwInput{KwOutput}{Output}              % set the Output

% chemical package.
\RequirePackage{chemfig}
\RequirePackage{chemnum}

% Process options
\ProcessOptions\relax

% Hyphenation
\RequirePackage[none]{hyphenat}
\sloppy

% ----- Hyperlinks
% Define color for citations
\definecolor{bluecite}{HTML}{0875b7}

\RequirePackage[unicode=true,
    bookmarksopen={true},
    pdffitwindow=true, 
    colorlinks=true, 
    linkcolor=bluecite, 
    citecolor=bluecite, 
    urlcolor=bluecite, 
    hyperfootnotes=false, 
    pdfstartview={FitH},
    pdfpagemode= UseNone]{hyperref}

% To have the possibility to change the urlcolor
\newcommand{\changeurlcolor}[1]{\hypersetup{urlcolor=#1}} 

% URL
\RequirePackage{url}
\urlstyle{same}
\g@addto@macro{\UrlBreaks}{\UrlOrds} 

% Widows & orphans
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

%% Metadata
\newcommand{\org@maketitle}{}% LATEX-Check
\let\org@maketitle\maketitle
\def\maketitle{%
	\hypersetup{
		pdftitle={\@Title},
		pdfauthor={www.coronawhy.org},
		pdfsubject={\@abstract},
		pdfkeywords={\@keyword}
		}%
	\org@maketitle
}

% front matter
\newcommand{\firstargument}{}
\newcommand{\Title}[1]{\gdef\@Title{#1}}%
\newcommand{\Author}[1]{\gdef\@Author{#1}}%
\newcommand{\doinum}[1]{\gdef\@doinum{#1}}

% Doi number and orcid is from mdpi-template.
% DOI number 
\newcommand\twodigits[1]{%
\ifnum#1<10
0\number#1
   \else
\number#1
\fi
}

\newcommand\fourdigits[1]{%
\ifnum#1<10 000\number#1 
  \else
     \ifnum#1<100 00\number#1
        \else
           \ifnum#1<1000 0\number#1
              \else
                  \ifnum#1<10000 \number#1
                   \else                   
                     error
               \fi
            \fi
         \fi
  \fi
}


%% ORCID
% Make Orcid icon
\newcommand{\orcidicon}{\includegraphics[width=0.32cm]{definitions/logo-orcid.eps}}

% Define link and button for each author
\foreach \x in {A, ..., Z}{%
    \foreach \y in {A, ..., Z}{%
        \expandafter\xdef\csname orcid\x\y\endcsname{\noexpand\href{https://orcid.org/\csname orcidauthor\x\y\endcsname}{\noexpand\orcidicon}}
    }
}


% ===============
% --- definitions

% affiliations
\usepackage{fontawesome}
\newenvironment{packed_enum}{
\begin{enumerate}
  \setlength{\itemsep}{1pt}
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{0pt}
}{\end{enumerate}}
\newcommand{\address}[2][]{\renewcommand{\firstargument}{#1}\gdef\@address{#2}}

% Abstract
\def\@abstract{}
\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}

% Abstract
\def\@graphicalabstract{}
\newcommand{\graphicalabstract}[1]{\gdef\@graphicalabstract{#1}}

% Keyword
\def\@keyword{}
\newcommand{\keyword}[1]{\gdef\@keyword{#1}}

% dataset
\def\@dataset{}
\newcommand{\dataset}[1]{\gdef\@dataset{#1}}
\def\@datasetlicense{}
\newcommand{\datasetlicense}[1]{\gdef\@datasetlicense{#1}}

% key contribuition
\def\@keycontribution{}
\newcommand{\keycontribution}[1]{\gdef\@keycontribution{#1}}



%---- Abstract, keywords, dataset, etc
\newcommand{\abstractkeywords}{
\vspace{-8pt}

% Abstract
{
\begingroup
\leftskip0.2cm 
\ifthenelse{\equal{\@abstract}{\@empty}}{}{
\noindent\textbf{Abstract:\space}\@abstract
\vspace{12pt}
\par
}
\endgroup
}% End abstract.

% For keywords.
{
\begingroup
\leftskip0.2cm
\ifthenelse{\equal{\@keyword}{\@empty}}{}{
\noindent\textbf{Keywords:\space}\@keyword
\vspace{12pt}
\par
}
\endgroup
}% End for keywords.

%For contributions
{
\begingroup
\leftskip0.2cm
\ifthenelse{\equal{\@keycontribution}{\@empty}}{}{
\noindent\textbf{Key Contribution:\space}\@keycontribution
\vspace{12pt}
\par
}
\endgroup
}% End for contributions.

% For dataset source.
{
\ifthenelse{\equal{\@dataset}{\@empty}}{}{
\begingroup
\leftskip0.2cm
\noindent\textbf{Dataset:\space}\@dataset
\vspace{12pt}
\par
\endgroup}
}% End for dataset source.

% For Dataset license.
{
\ifthenelse{\equal{\@datasetlicense}{\@empty}}{}{
\begingroup
\leftskip0.2cm
\noindent\textbf{Dataset License:\space}\@datasetlicense
\vspace{12pt}
\par
\endgroup}
}% End for dataset licence.

% Graphical Abstract
{
\begingroup
\leftskip0.2cm 
\ifthenelse{\equal{\@graphicalabstract}{\@empty}}{}{
\centering
\noindent\textbf{Graphical Abstract}
\par
\@graphicalabstract
\includegraphics{figures/graphical_abstract.png}
\par
}
\endgroup
}% En for graphics abstract.


}


% Define acknowledgments command.
\newcommand{\acknowledgments}[1]{
\vspace{8pt}
\noindent{\fontsize{10}{10}\selectfont\textbf{Acknowledgments:} {#1}\par}
}

% Define author contributions command.
\newcommand{\authorcontributions}[1]{
\vspace{8pt}
\noindent{\fontsize{10}{10}\selectfont\textbf{Author Contributions:} {#1}\par}
}

% Define funding command.
\newcommand{\funding}[1]{
\vspace{8pt}
\noindent{\fontsize{10}{10}\selectfont\textbf{Funding:} {#1} \par}
}

% Define conflicts of interest.
\newcommand{\conflictsofinterest}[1]{
\vspace{8pt}
\noindent{\fontsize{10}{10}\selectfont\textbf{Conflicts of Interest:} {#1} \par}
}

% Define dedication.
\newcommand{\dedication}[1]{
\vspace{8pt}
\noindent{\fontsize{10}{10}\selectfont\textbf{Dedication:} {#1} \par}
}


% Print maketitle and abstractkeywords
\AfterEndPreamble{
	\maketitle
	\abstractkeywords
}% En print maketitle and abstractkeywords.


% Modified the maketitle command
\renewcommand{\@maketitle}{
% add coronawhy logo
{   
    \hspace{252pt}
    \href{https://www.coronawhy.org/}
    {
        \includegraphics[height=1cm]{definitions/CoronaWhy_Imagotype.eps}
    }
    \vspace{0.5cm}
} % end logo

\begin{flushleft}
\leftskip 0.2cm % for move the title and authors.
\par % <- this is a jumpline
% Title.
{
    %\vspace{-1pt}
    \fontsize{18}{18}\selectfont
    \boldmath\bfseries{\@Title}
    \par
    \vspace{15pt}
} % End title.
\par
% Add Authors
{
    \boldmath\bfseries{\@Author}
}% End authors.
\par
% Add address
{
    \@address
}
\end{flushleft}

\par\null
}


% ===============
% LAYOUT
\RequirePackage[left=3.0cm,
			    right=2.8cm,
			    top=1.8cm,
			    bottom=1.7cm,
			    includehead,
			    includefoot]{geometry}

\linespread{1.14} 
\setlength{\parindent}{0.75cm}



\endinput