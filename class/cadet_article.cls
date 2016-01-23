%%% cadet_article.cls -- Bibliothèque pour la préparation d'articles

% Copyright © 2001–2016 Michael Grünewald
% All rights reserved.
%
% This file is part of Cadet TeX.
%
% Cadet TeX is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Cadet TeX is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Cadet TeX.  If not, see <http://www.gnu.org/licenses/>.


\macro structure

%
% Section
%

\let\section\undefined

\def\setsectionfont{%
  \setnormalfont
  \setfontshape{R}%
  \setlargesize
}

\def\sectionbeforeskip{%
  \removelastskip
  \vskip\z@ plus.2\vsize
  \penalty-250
  \vskip\z@ plus-.2\vsize
  \bigskip
  \vskip\parskip
  \vskip\baselineskip
}

\def\sectionafterskip{%
  \medskip
  \noindent
}

\def\sectionendparagraph{%
  \par
}

\def\sectiontext{%
  \sectionfont
  \sectionnumber\enspace
  \ignorespaces\the\sectiontitle
}

\def\sectiontext{%
  \centerline{%
    \sectionfont\S\sectionnumber\enspace
    \ignorespaces\the\sectiontitle
  }%
}


\def\sectionempty{%
  \sectiontitle{No title provided}%
  \sectiontext
}

\def\toksloadsectionnumber\to#1{%
  \toksloaddecimal\sectionno\to#1%
}

\newstructure\section

%
% Paragraphe
%

\def\setparagraphfont{\setnormalfont\setfontshape{i}}

\def\paragraphfont{\setparagraphfont\fontswitch}

\def\paragraphbeforeskip{\medbreak}


\def\paragraphempty{%
  \normalfont
  \global\advance\paragraphno\@ne
  \paragraphnumber\enspace
}

\def\paragraphtext{%
  \normalfont
  \paragraphnumber\enspace
  \paragraphfont
  \ignorespaces\the\paragraphtitle.\enspace---\quad
}

\let\paragraphnostep\structurenostepwhentitle

\def\toksloadparagraphnumber\to#1{%
  \beginnext
  \toksloadsectionnumber\to\rtA%
  \toksloaddecimal\paragraphno\to\rtB
  \rtC={#1}%
  \edef\next{\the\rtC={\the\rtA.\the\rtB}}%
  \endnext
}

\def\paragraphsuper{section}
\newstructure\paragraph
\selectequationsuper{paragraph}

%
% Propositions et théorèmes
%

\def\setmathparagraphfont{%
  \setnormalfont
  \setfontshape{R}%
}

\def\mathparagraphfont{%
  \setmathparagraphfont
  \fontswitch
}

\let\mathparagraphbeforeskip\paragraphbeforeskip
\let\mathparagraphno\paragraphno
\let\mathparagraphtitle\paragraphtitle

\def\mathparagraphempty{%
  \toksloadcsexpansion\mathparagraphname\to\mathparagraphtitle
  \mathparagraphtext
}

\def\mathparagraphtext{%
  \normalfont
  \mathparagraphnumber\enspace
  \mathparagraphfont
  \ignorespaces\the\paragraphtitle.\enspace---\quad
}

\let\paragraphnostep\structurenostepwhentitle

\let\toksloadmathparagraphnumber\toksloadparagraphnumber

\def\mathparagraphsuper{section}

\def\mathparagraph@A#1{%
  \def\mathparagraphname{#1}%
  \mathparagraph
}

\def\mathparagraphnextparagraph#1\par{%
  \begingroup\sl#1\par\endgroup\medbreak
}

\newstructure\mathparagraph

% XXX Créer des paramètres régionaux
\def\proposition{\mathparagraph@A{Proposition}}%
\def\theorem{\mathparagraph@A{Théorème}}%
\def\lemma{\mathparagraph@A{Lemme}}%

\def\proof{\par\indent{\sc Preuve.\enspace---\quad}}

%
% Affichages
%

% Cf. TeXbook p.189.

\abovedisplayskip=\bigskipamount
\belowdisplayskip=\bigskipamount

\abovedisplayshortskip=\medskipamount
\belowdisplayshortskip=\bigskipamount


%
% Titre
%

% La page de titre est une page spéciale, elle est préparée par une
% OUTPUT ROUTINE spéciale.

\def\settitlefont{%
  \setnormalfont
  \setlargesize
}%

\def\title{%
  \readline\to\rtA\then
    \beginnext
    \edef\next{\noexpand\titlemake{\the\rtA}}%
    \endnext
  \done
}

\def\titlemake#1{%
  \topglue 14mm
  \centerline{\titlefont\uppercase{#1}}%
  \vskip 14mm
  \relax
}

%
% Auteur
%

\def\setauthorfont{%
  \setnormalfont
}%

\def\authorfont{%
  \setauthorfont
  \fontswitch
}

\def\author{%
  \readline\to\rtA\then
    \beginnext
    \edef\next{\noexpand\authormake{\the\rtA}}%
    \endnext
  \done
}

\def\authormake#1{%
  \rdA=\lastskip
  \ifdim\lastskip>\bigskipamount
    \removelastskip
  \fi
  \bigskip
  \centerline{\authorfont\uppercase{#1}}%
  \vskip\rdA
  \relax
}

\auxinput

%%% End of file `cadet_article.cls'
