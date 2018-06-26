# tbraun 11/5/2006
# added most/all beamer commands
# be sure to use an up to date kile svn version, only that will work properly with the strange syntax here
# 11/24/2006 added missing commands, thanks to  Marco Bertolini
\begin{frame}
\begin{frame}[options]
\begin{frame}[options]{title}
\begin{frame}[options]{title}{subtitle}
\begin{frame}[options]{title}{subtitle}
\begin{frame}{title}
\begin{frame}{subtitle}
\end{frame}
\begin{thebibliography}{longest label text}
\end{thebibliography}
\begin{itemize}\item
\end{itemize}
\begin{enumerate}[mini template]\item
\begin{enumerate}\item
\end{enumerate}
\begin{description}[long text]\item
\begin{description}\item
\end{description}
\begin{structureenv}
\end{structureenv}
\begin{alertenv}
\end{alertenv}

\begin{block}{block title}
\end{block}

\begin{alertblock}{block title}
\end{alertblock}
\begin{exampleblock}{block title}
\end{exampleblock}


\begin{theorem}
\end{theorem}


\begin{definition}
\end{definition}


\begin{example}
\end{example}


\begin{proof}
\end{proof}
\begin{beamercolorbox}[options]{beamer color}
\begin{beamercolorbox}{beamer color}
\end{beamercolorbox}
\begin{beamerboxesrounded}[options]{head}
\begin{beamerboxesrounded}{head}
\end{beamerboxesrounded}
\begin{columns}[options]
\begin{columns}
\end{columns}
\begin{column}[placement]{column width}
\begin{column}{column width}
\end{column}
\begin{semiverbatim}
\end{semiverbatim}

\end{abstract}

\end{verse}

\end{quotation}

\end{quote}

\begin{onlyenv}
\end{onlyenv}


\end{altenv}
\begin{overlayarea}{area width}{area height}
\end{overlayarea}
\begin{overprint}[area width]
\begin{overprint}
\end{overprint}

\end{actionenv}
\movie[options]{poster text}{movie filename}
\movie{poster text}{movie filename}
\hyperlinkmovie[options]{movie label}{text}
\hyperlinkmovie{movie label}{text}
\animate

\animatevalue<start slide - end slide>{name}{start value}{end value}
\animatevalue{name}{start value}{end value}

\multiinclude[options]{base file name}
\multiinclude{base file name}
\sound[options]{sound poster text}{sound filename}
\sound{sound poster text}{sound filename}
\hyperlinksound[options]{sound label}{text}
\hyperlinksound{sound label}{text}
\hyperlinkmute{text}


\transblindshorizontal[options]
\transblindshorizontal


\transblindsvertical[options]
\transblindsvertical


\transboxin[options]
\transboxin


\transboxout[options]
\transboxout


\transdissolve[options]
\transdissolve


\transglitter[options]
\transglitter


\transsplitverticalin[options]
\transsplitverticalin


\transsplitverticalout[options]
\transsplitverticalout


\transsplithorizontalin[options]
\transsplithorizontalin


\transsplithorizontalout[options]
\transsplithorizontalout


\transwipe[options]
\transwipe

\transduration{number of seconds}
\usebeamercolor*[fg or bg]{beamer-color name}
\usebeamercolor*{beamer-color name}
\usebeamercolor[fg or bg]{beamer-color name}
\usebeamercolor{beamer-color name}
\ifbeamercolorempty[fg or bg]{beamer-color name}{if undefined}{if defined}
\ifbeamercolorempty{beamer-color name}{if undefined}{if defined}
\setbeamercolor*{beamer-color name}{options}
\setbeamercolor{beamer-color name}{options}
\setbeamercovered{options}
\opaqueness{percentage of opaqueness}

\opaqueness{percentage of opaqueness}
\usebeamertemplate{element name}
\usebeamertemplate*{element name}
\usebeamertemplate**{element name}
\usebeamertemplate***{element name}
\ifbeamertemplateempty{beamer template name}{executed if empty}{executed otherwise}
\expandbeamertemplate{beamer template name}
\setbeamertemplate{element name}[predefined option]{args}
\setbeamertemplate{element name}{args}
\addtobeamertemplate{element name}{pre-text}{post-text}






\defbeamertemplate{element name}{predefined option}[argument number][default optional argument]{predefined text}[action]{action command}
\defbeamertemplate{element name}{predefined option}[default optional argument]{predefined text}[action]{action command}
\defbeamertemplate{element name}{predefined option}{predefined text}[action]{action command}
\defbeamertemplate{element name}{predefined option}[argument number][default optional argument]{predefined text}
\defbeamertemplate{element name}{predefined option}[argument number]{predefined text}
\defbeamertemplate{element name}{predefined option}{predefined text}
\defbeamertemplatealias{element name}{new predefined option name}{existing predefined option name}
\defbeamertemplateparent{parent template name}[predefined option name]{child template list} [argument number][default optional argument]{arguments for children}
\defbeamertemplateparent{parent template name}{child template list} [argument number][default optional argument]{arguments for children}
\defbeamertemplateparent{parent template name}{child template list} [default optional argument]{arguments for children}
\defbeamertemplateparent{parent template name}{child template list} {arguments for children}
\usebeamerfont*{beamer-font name}
\usebeamerfont{beamer-font name}
\setbeamerfont*{beamer-font name}{attributes}
\setbeamerfont{beamer-font name}{attributes}
\insertnavigation
\insertpagenumber
\insertsection
\insertsectionnavigation
\insertsectionnavigationhorizontal
\insertshortauthor
\insertshortdate
\insertshortinstitute
\insertshortpart
\insertshorttitle
\insertshortsubtitle
\insertsubsection
\insertsubsectionnavigation
\insertsubsectionnavigationhorizontal
\insertverticalnavigation
\insertframenumber
\inserttotalframenumber
\insertframestartpage
\insertframeendpage
\insertsubsectionstartpage
\insertsubsectionendpage
\insertsectionstartpage
\insertsectionendpage
\insertpartstartpage
\insertpartendpage
\insertpresentationstartpage
\insertpresentationendpage
\insertappendixstartpage
\insertappendixendpage
\insertdocumentstartpage
\insertdocumentendpage
\setbeamersize{}
\insertsectionhead
\insertsectionheadnumber
\insertpartheadnumber
\insertsubsectionhead
\insertsubsectionheadnumber
\insertslidenavigationsymbol
\insertframenavigationsymbol
\insertsubsectionnavigationsymbol
\insertsectionnavigationsymbol
\insertdocnavigationsymbol
\insertbackfindforwardnavigationsymbol
\insertenumlabel
\insertenumlabel
\insertsubsubenumlabel
\insertdescriptionitem
\inserttheoremheadfont
\inserttheoremname
\inserttheoremnumber
\inserttheoremaddition
\inserttheorempunctuation
\insertcaption
\insertcaptionname
\insertcaptionnumber
\insertfootnotetext
\insertfootnotemark
\insertnote
\insertslideintonotes
\logo{logo text}
\insertlogo


\frametitle[short frame title]{frame title text}
\frametitle{frame title text}

\framesubtitle{frame subtitle text}
\setbeamersize{options}
\titlepage
\maketitle
\title[short title]{title}
\title{title}
\subtitle[short subtitle]{subtitle}
\subtitle{subtitle}
\author[short author names]{author names}
\author{author names}
\institute[short institute]{institute}
\institute{institute}
\date[short date]{date}
\date{date}
\titlegraphic{text}
\subject{text}
\keywords{text}
\AtBeginSection[special star text]{text}
\AtBeginSection{text}
\AtBeginSubsection[special star text]{text}
\AtBeginSubsection{text}
\AtBeginSubsubsection[special star text]{text}
\AtBeginSubsubsection{text}


\part[short part name]{part name}
\part{part name}
\partpage
\AtBeginPart{text}
\lecture[short lecture name]{lecture name}{lecture label}
\lecture{lecture name}{lecture label}
\includeonlylecture{lecture label}
\AtBeginLecture{text}
\tableofcontents[comma-separated option list]
\tableofcontents


\bibitem[citation text]{label name}
\bibitem{label name}

\appendix

\hypertarget{target name}{text}
\beamerbutton{button text}
\beamergotobutton{button text}
\beamerskipbutton{button text}
\beamerreturnbutton{button text}


\hyperlink{target name}{link text}

\hyperlinkslideprev{link text}

\hyperlinkslidenext{link text}

\hyperlinkframestart{link text}

\hyperlinkframeend{link text}

\hyperlinkframestartnext{link text}

\hyperlinkframeendprev{link text}

\hyperlinkpresentationstart{link text}

\hyperlinkpresentationend{link text}

\hyperlinkappendixstart{link text}

\hyperlinkappendixend{link text}

\hyperlinkdocumentstart{link text}

\hyperlinkdocumentend{link text}




\againframe[options]{name}
\againframe{name}



\structure{text}

\alert{highlighted text}
\newtheorem*{environment name}[numbered same as]{head text}[number within]
\newtheorem*{environment name}{head text}[number within]
\newtheorem*{environment name}{head text}
\newtheorem{environment name}[numbered same as]{head text}[number within]
\newtheorem{environment name}{head text}[number within]
\newtheorem{environment name}{head text}


\footnote[options]{text}
\footnote{text}
\setjobnamebeamerversion{filename without extension}
\includeslide[options]{label name}
\includeslide{label name}

\mode{text}

\mode*
\mode


\note[options]{note text}
\note{note text}
\AtBeginNote{text}
\AtEndNote{text}
\pause[number]
\pause




\onslide


\only{text}

\uncover{text}

\visible{text}

\invisible{text}


\alt{default text}{alternative text}
\temporal{before slide text}{default text}{after slide text}

\temporal{before slide text}{default text}{after slide text}



\item[item label]
\item

\label{label name}
\resetcounteronoverlays{counter name}
\resetcountonoverlays{count register name}

\action{text}

\usetheme[options]{name list}
\usetheme{name list}
\usecolortheme[options]{name list}
\usecolortheme{name list}
\usefonttheme[options]{name}
\usefonttheme{name}
\useinnertheme[options]{name}
\useinnertheme{name}
\useoutertheme[options]{name}
\useoutertheme{name}
\addheadbox{beamer color}{box template}
\addfootbox{beamer color}{box template}
\includeonlyframes{frame label list}

