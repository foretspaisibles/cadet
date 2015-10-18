%%% cadetpaper.cls -- CADET TeX Documentation Paper

% Author: Michael Grünewald
% Date: Wed Sep 27 00:00:01 CEST 2006

% Cette bibliothèque de macros permet de préparer les `papiers' pour
% la documentation de Cadet TeX.

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


%%% 1. Domaine de la structure

% formalpar
%
% Un `formalpar' est précédé d'un saut important et porte un titre
% optionnel composé en italiques.

\def\formalpar{\readline\to\rtA\then
  \bigskip
  {\emphasis\the\rtA}\enspace
  \ignorespaces
  \done
}

% description
%
% L'environnement description permet de saisir les
% descriptions. Celles-cis sont formées d'un titre d'article composé
% avec `itemfont' et d'un paragraphe composé avec une
% indentation.
%
% L'environnement description supporte plusieurs `tags' qui modifient
% `itemfont'. Ces tags sont:
%
%   `\environment' pour les variables d'environnement, comme elles
%   sont formatées comme avec `ev'.
%
%   `\variables' pour les variables ou les abréviations, formatées
%   comme avec `dv'.
%
% En l'absence de précision, la fonte `symbolicfont' est utilisée pour
% préparer les étiquettes.
%
% Chaque item définit la macro `currentitem' pour qu'elle produise le
% même texte que l'étiquette.

\def\begindescription{%
  \begingroup
  \beginnext
  \getopttagreset
  \def\getopttagunit{%
    \\{\environment}%
    \\{\variables}%
    \\{\definedvariables}%
    \\{\functions}%
    \\{\files}%
  }%
  \let\definedvariables\description@C
  \let\environment\description@A
  \let\variables\description@B
  \let\functions\description@B
  \let\files\description@C
  \getopttag\description@M
}

\def\enddescription{%
  \endlist
  \endgroup
}

\def\description@A{\rtA{\labelmake@symbolic}}
\def\description@B{\rtA{\labelmake@emphasis}}
\def\description@C{\rtA{\labelmake@symbolic}}

\def\description@M#1{%
  \rtA{\labelmake@symbolic}%
  #1%
  \edef\next{\noexpand\beginlist\let\noexpand\labelmake\the\rtA}%
  \endnext
  \let\listbeginskip\medskip
  \let\listinterskip\medbreak
  \let\listendskip\smallskip
  \listleftindent2\itemindent
  \listrightindent\z@
  \let\readlabel\readline
  \labelspace 1.5ex
  \labelindent-\itemindent
  \labelwidth\itemindent
  \advance\labelwidth-\labelspace
  \let\labelprepare\labelprepare@tag
  \beginlist
}

%%% 2. Format du document

\setpaperformat{A4}
\setmargin{25mm}{25mm}
\selectlayout

\def\title{\readline\to\rtA\then
  \topskip 22pt%
  \centerline{\titlefont\the\rtA}%
  \vglue22pt
  \relax
  \done
}

%%% 3. Format Verbatim

\macro verbatim
\enableverbatimtext


%%% 4. État civil

\def\libraryname{cadetpaper}
\def\libraryversion{0.0}

%%% End of file `cadetpaper.cls'
