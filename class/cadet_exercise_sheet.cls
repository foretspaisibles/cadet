%%% cadet_exercise_sheet.cls -- Planches d'exos

% Copyright © 2001–2015 Michael Grünewald
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


%% A. Marques pour les exercices

\def\hints{%
  %\def\P{}
  %\def\${}%
  \def\*{*}%
}

%% B. Exercices

\newcount\exno

\sdef\exercice#1[#2]#3{%
  \par
  \bigbreak
  \begingroup
  \global\advance\exno by 1
  \noindent
  \ifstrempty{#1}\else\llap{\hints#1\enspace}\fi
  {\tenpoint\bf\the\exno.\ }%
  \ifstrempty{#3}\else{\tenpoint\it\ignorespaces #3} \fi
  \endgroup
}

%% C. Domaine du texte

\def\stars{%
  \bigskip
  \nobreak
  \centerline{*\raise0.3333em\hbox{*}*}
  \bigbreak
}

%% D. Domaine de la strucure

\def\fonttitle{\rm\fontsize{20pt}\fontselect}

\sdef\title#1[#2]#3{%
  \def\thetitle{#3}%
  \vskip 16 true mm
  \vbox{%
    \def\\{ \penalty-50 }%
    \parindent=0pt
    \baselineskip=19pt
    \leftskip=0pt plus 1fill
    \rightskip=0pt plus 1fill
    \fonttitle #3%
    \par
  }%
  \vskip 16 true mm
  \relax
}

%% E. Fichier d'en-tête

% Exemple de fichier header
%
% \line{\bf UNIVERSITÉ MONTPELLIER II\hfil Année 2005-2006}
% \line{\bf UFR MATHÉMATIQUES\quad ULMA 302\hfil}
% \def\thelefttag{\rm UMII ULMA302}
% \def\therighttag{\rm Année 2005--2006}

\def\thetitle{}
\def\thelefttag{}
\def\therighttag{}
\headline={\hfil\global\headline={\theheadline}}%
\def\theheadline{%
  \rlap{\sc\expandafter\lowercase\expandafter{\thelefttag}}%
  \hfil{\def\\{ }\sc\expandafter\lowercase\expandafter{\thetitle}}\hfil%
  \llap{\sc\expandafter\lowercase\expandafter{\therighttag}}%
}%

\def\noheadline{\global\headline={\hfil}}
\def\inhibitheadline{\global\headline={\hfil\global\headline={\theheadline}}}%

\ifexists{eheader}\input eheader\fi

%%% End of file `cadet_exercise_sheet.cls'
