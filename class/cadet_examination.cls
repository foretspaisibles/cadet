%%% cadet_examination.cls -- Feuillets d'examens

% Cadet TeX (https://github.com/foretspaisibles/cadet)
% This file is part of Cadet TeX.
%
% Copyright © 2001–2021 Michaël Le Barbier
% All rights reserved.

% This software is governed by the CeCILL-B license under French law and
% abiding by the rules of distribution of free software.  You can  use,
% modify and/ or redistribute the software under the terms of the CeCILL-B
% license as circulated by CEA, CNRS and INRIA at the following URL
% "https://cecill.info/licences/Licence_CeCILL-B_V1-en.txt"


\macro structure

\def\setnormalsize{\fontsize=12 }%
\def\setsmallsize{\fontsize=11 }%
\def\setverysmallsize{\fontsize=9 }%
\def\setlargesize{\fontsize=14 }%
\def\setverylargesize{\fontsize=21 }%
\normalfont

%%% A. Enregistrement du document

\let\theauthor=\empty
\let\thetitle=\empty

\def\author{%
  \readline\to\rtA\then
    \edef\theauthor{\the\rtA}%
  \done
}

\def\title{%
  \readline\to\rtA\then
    \edef\thetitle{\the\rtA}%
  \done
}

%%% B. Fontes

\def\settitlefont{%
  \setnormalfont
  \setlargesize
  \setfontfamily{lmd}%
}%


%%% C. Préparation des pages

\def\emptypage{\eject\hbox{}\vfill\eject}
\def\nextevenpage{\vfill\supereject\ifodd\the\pageno\emptypage\fi}
\def\nextoddpage{\vfill\supereject\ifodd\the\pageno\else\emptypage\fi}

\let\headerleft\empty
\let\headerright\empty

\def\makeheader{%
  \line{%
    \tbox.3\hsize{\headerleft}\hfill\tbox.3\hsize{\headerright}%
  }%
}

\def\maketitle{%
  \beginnext
  \let\centerline\z@
  \let\titlefont\z@
  \let\uppercase\z@
  \toksloadcsexpansion\thetitle\to\rtA
  \edef\next{\centerline{\titlefont\uppercase{\the\rtA}}}%
  \endnext
  \vskip 3em plus 1em minus 1em
  \relax
}

\def\insertitleoutput{%
  %
  % On insére le titre dans la main vertical list (MVL)
  %  puis on reporte le contenu présenté à la routine de sortie
  %  (box255) dans cette MVL.
  %
  \vbox{\makeheader\vskip1cm\maketitle}%
  \unvbox\@cclv\penalty\outputpenalty
  \global\output={\firstpageoutput}%
}

\def\firstpageoutput{%
  \headline={\hfil}%
  \plainoutput
  \global\output={\plainoutput}%
}

\output={\insertitleoutput}

%%% D. Structure de l'examen

%
% Exercices
%

% On peut dire `exercisenumberedfalse' pour avoir des exercices sans
% numéros.

\newif\ifexercisenumbered
\exercisenumberedtrue

\def\exercisefont{\setexercisefont\selectfont}

\def\setexercisefont{%
  \setnormalfont
  \setfontweight{b}%
}

\def\exercisebeforeskip{%
  \removelastskip
  \vskip\z@ plus.2\vsize
  \penalty-250
  \vskip\z@ plus-.2\vsize
  \bigskip
  \vskip\parskip
  \vskip\baselineskip
}

\def\exerciseafterskip{%
  \medskip
  \noindent
}

\def\exerciseendparagraph{%
  \par
}

\def\exercisetext{%
  \exercisefont
  \ifexercisenumbered
    \exercisenumber\space
  \fi
  \ignorespaces\the\exercisetitle
}

\def\exerciseempty{%
  \exercisetitle{No title provided}%
  \exercisetext
}

\def\toksloadexercisenumber\to#1{%
  \toksloaddecimal\exerciseno\to#1%
}

\newstructure\exercise


%
% Question
%

\def\questionsuper{exercise}

\def\questionfont{\setquestionfont\selectfont}

\def\setquestionfont{%
  \setnormalfont
  \setfontshape{i}%
}

\def\questionbeforeskip{%
  \smallskip
}

\def\questionafterskip{%
  \noindent
}

\def\questionendparagraph{%
  \testtoksempty\questiontitle
  \iftoksempty\else
    \par
  \fi
  \ignorespaces
}

\def\questiontext{%
  \questionfont
  \questionnumber\space
  \ignorespaces\the\questiontitle
}

\def\questionempty{%
  \questionfont
  \questionnumber\space
}

\def\toksloadquestionnumber\to#1{%
  \toksloaddecimal\questionno\to#1%
}

\newstructure\question

%
% Instructions
%

\def\begindirectives{\begingroup\it}
\def\enddirectives{\par\endgroup\medskip}

%%% End of file `cadet_examination.cls'
