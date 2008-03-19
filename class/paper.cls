%%% paper.cls -- Papiers divers

% Author: Michael Grünewald
% Date: Wed Aug 16 00:30:25 CEST 2006
% Copyright: (C) 2006, 2013 Michael Grünewald

% Copyright (C) 2006, 2013 Michael Grünewald
% All rights reserved.
%
% This file is part of Bhrìd TeX.
%
% Bhrìd TeX is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Bhrìd TeX is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Bhrìd TeX.  If not, see <http://www.gnu.org/licenses/>.


%%% DESCRIPTION

% Un `papier' présente un texte structuré en section, paragraphes
% formels et petits paragraphes. Les sections et les paragraphes
% formels sont numérotés hiérarchiquement. Un `papier' peut présenter
% un texte mathématique et les équation sont alors numérotées dans
% chaque paragraphe formel. Un papier peut également être un manuel
% d'informatique et des commandes spéciales permettent de présenter
% des fragments de fichiers ou de boucles d'intéraction.


\macro zapfd
\macro verbatim

\enableauxfile

%%% A. Fontes

\def\romanfont{\rmfamily\fontseries{m}\fontshape{n}}
\def\propositionfont{\mainfont\fontshape{o}}
\def\titlefont{\romanfont\fontsize{17pt}}
\def\sectionfont{\romanfont\fontsize{10pt}\fontseries{b}}
\def\formalparfont{\romanfont\fontsize{10pt}\fontshape{N}}
\def\headerfont{\romanfont\fontsize{9pt}}
\def\footerfont{\romanfont\fontsize{9pt}}

%%% B. Enregistrement du document

\def\ifismark#1{\iffalse}

\let\theauthor=\empty
\let\theshortauthor=\empty
\let\thetitle=\empty
\let\theshorttitle=\empty

\sdef\author#1#2#3{%
  \ifstrempty{#2}\def\theshortauthor{#3}\else\def\theshortauthor{#2}\fi
  \def\theauthor{#3}%
}

\sdef\title#1#2#3{%
  \ifstrempty{#2}\def\theshorttitle{#3}\else\def\theshorttitle{#2}\fi
  \def\thetitle{#3}%
}


%%% C. PRÉPARATION DES PAGES

\def\emptypage{\eject\hbox{}\vfill\eject}
\def\nextevenpage{\vfill\supereject\ifodd\the\pageno\emptypage\fi}
\def\nextoddpage{\vfill\supereject\ifodd\the\pageno\else\emptypage\fi}

\def\maketitle{%
  \centerline{\titlefont\fontselect\thetitle}
  \bigskip
  \centerline{\romanfont\fontselect\theauthor}
  \vskip 4em plus 1em minus 1em
  \relax
}

\def\makeheader{}

\def\insertitleoutput{%
  %
  % On insére le titre dans la main vertical list (MVL)
  %  puis on reporte le contenu présenté à la routine de sortie
  %  (box255) dans cette MVL.
  %
  \vbox{\makeheader\maketitle}%
  \unvbox\@cclv\penalty\outputpenalty
  \global\output={\firstpageoutput}%
}

\def\firstpageoutput{%
  \headline={\hfil}%
  \plainoutput
  \global\output={\plainoutput}%
}

\headline={\headerfont\fontselect\sc\hfil\makeheadlinecontent\hfil}
\def\makeheadlinecontent{%
  \begingroup
  \disablemarkup
  \ifodd\pageno
    \rtA=\expandafter{\theshortauthor}%
  \else
    \rtA=\expandafter{\theshorttitle}%
  \fi
  \expandafter\lowercase\expandafter{\the\rtA}%
  \endgroup
}

\footline={%
  \footerfont\fontselect
  \hfil
  \rm\folio
  \hfil
}

\output={\insertitleoutput}


%%% D. STRUCTURE DU PAPELARD

\newtoks\structuretags
\newtoks\structureref
\newtoks\structuretitle

%
% Section
%

\newcount\sectionno
\newhook\sectionhook

\def\sectionbreak{%
  \vskip 0pt plus .3\vsize
  \penalty-250
  \vskip 0pt plus-.3\vsize
  \vskip 2em plus .3em minus .3em
  \relax
}

\sdef\section#1#2#3{%
  \structuretags={#1}%
  \structureref={#2}%
  \structuretitle={#3}%
  \advance\sectionno by 1
  \formalparno=0
  \setxref\makesectionxref{\the\sectionno}%
  \ifstrempty{#2}\else\label[#2]\fi
  \begingroup\makesection{#1}{#2}{#3}\endgroup
}

\def\makesection#1#2#3{%
  \sectionbreak
  \runhook\sectionhook
  \leftline{\sectionfont\fontselect
    \S\espacefine\the\sectionno. \ignorespaces#3}
  \bigskip
  \noindent
  \aftergroup\ignorewhitespace
}

\def\makesectionxref#1{\S\espacefine#1\relax}

%
% Formalpar
%

\newcount\formalparno
\newhook\formalparhook

\addhook
  \global\formalparno=0
\to\sectionhook

\sdef\formalpar#1#2#3{%
  \ifnum\sectionno=0
    \warning{Formal paragraphs must occur in a section}%
  \fi
  \structuretags={#1}%
  \structureref={#2}%
  \ifstrempty{#3}\structuretitle={sans titre}\else\structuretitle={#3}\fi
  \advance\formalparno by 1
  \setxref\makeformalparxref{{\the\sectionno}{\the\formalparno}}%
  \ifstrempty{#2}\else\label[#2]\fi
  \begingroup\makeformalpar{#1}{#2}{#3}\endgroup
}

\def\makeformalpar#1#2#3{%
  \bigbreak
  \runhook\formalparhook
  \noindent
  \hskip\marginleft
  \begingroup
    \formalparfont\mainsize
    \llap{\the\sectionno.\the\formalparno\relax.\enspace}%
    \ifstrempty{#3}\else\ignorespaces #3\space\medskip\nobreak\noindent\fi
  \endgroup
  \aftergroup\ignorewhitespace
}

\def\makeformalparxref#1{\makeformalparxref@A#1}
\def\makeformalparxref@A#1#2{{\formalparfont\fontselect(#1.#2)}}

\sdef\remark#1#2#3{%
  \ifstrempty{#3}%
    \sdef@@formalpar{#1}{#2}{Remarque}%
  \else
    \sdef@@formalpar{#1}{#2}{#3}%
  \fi
}

\sdef\example#1#2#3{%
  \ifstrempty{#3}%
    \sdef@@formalpar{#1}{#2}{Exemple}%
  \else
    \sdef@@formalpar{#1}{#2}{#3}%
  \fi
}


%%% E. ÉLÉMENTS MATHÉMATIQUES


%
% Proposition
%

\newhook\propositionhook

\sdef\proposition#1#2#3#4\par{%
  \sdef@@formalpar{#1}{#2}{#3}%
  \begingroup\propositionfont\fontselect#4\par\endgroup
  \medskip
}

%
% Preuves
%

\def\proof#1\par{\beginproof#1\endproof}

\long\def\beginproof#1\endproof{%
  {\it Preuve}. #1\hfill\endproofsign\par
  \smallskip
}

\zdchardef\endproofsign="76

%
% Équations
%

\newcount\equationno

\everydisplay={\prepareequationlabel}

\def\prepareequationlabel{%
  \let\equation@L=\label
  \let\label=\eqlabel
}

\def\eqlabel[#1]{%
  \global\advance\equationno by 1
  \setxref\makeequationxref{%
    {\the\sectionno}%
    {\the\formalparno}%
    {\the\equationno}%
  }%
  \equation@L[#1]%
  \relax\leqno\hbox{(\the\sectionno.\the\formalparno.\the\equationno)}%
}

\addhook
  \global\equationno=0
\to\formalparhook

\def\makeequationxref#1{\makeequationxref@A#1}
\def\makeequationxref@A#1#2#3{(#1.#2.#3)}


%%% F. ÉLÉMENTS INFORMATIQUES

\def\li#1{{\tt #1}}		% Literal

\leftappenditem\li\to\markup@L

%
% Code Source
%

\def\begincode{%
  \begingroup
  \def\verbatim@begin{\displayopenskip}%
  \def\verbatim@leave{%
    \displaycloseskip
    \endgroup\endgroup
    \noindent\ignorewhitespace
  }%
  \edef\verbatim@stop{\verbatim@esc endcode}%
  \verbatim@enter
}

%
% Écrans d'intéractions
%

% Les caractèrs spéciaux de TeX sont moins courants dans les écrans
% d'intéraction, comme par exemple avec le shell, aussi le caractère \
% permet d'utiliser de CS, et les accolades déterminent des groupes.

\def\beginscreen{%
  \begingroup
  \def\${\slshape\char"24\space}%
  \def\#{\slshape\char"23\space}%
  \def\%{\char"25 }%
  \def\\{\char"5C }%
  \def\{{\char"7B }%
  \def\}{\char"7D }%
  \def\user##1{\slshape ##1}%
  \def\verbatim@begin{%
    \medskip\nobreak
    \catcode`\%=0		% On ne peut pas utiliser \\ sinon
    \catcode`\{=1		%  \endscreen ne fonctionne pas
    \catcode`\}=2
  }%
  \def\verbatim@end{\medskip\endgroup\noindent}%
  \edef\verbatim@stop{\verbatim@esc endscreen}%
  \verbatim@enter
}

%%% G. PDF GOODIES

\def\enablepdfgoodies{%
\addhook
  \begingroup
  \edef\rmA{\noexpand\outline0{\the\structuretitle}}%
  \expandafter\endgroup\rmA
\to\sectionhook
\addhook
  \begingroup
  \iftoksempty\structuretitle\def\rmA{}\else
    \edef\rmA{\noexpand\outline1{\the\structuretitle}}%
  \fi
  \expandafter\endgroup\rmA
\to\formalparhook
}

\ifpdfoutput\enablepdfgoodies\fi
\let\enablepdfgoodies\undefined

%%% H. MACROS DE L'UTILISATEUR

\ifexists{paperrc}\input paperrc \fi

%%% End of file `paper.cls'
