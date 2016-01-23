%%% cadet_letter.cls -- Bibliothèque pour la préparation de lettres

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


% La bibliothèque pour la préparation des lettres tient avec trois
% bouts de ficelle. Elle permet un résultat correct pour le courrier
% français et positionne l'adresse du récipiendaire à la position de
% la fenêtre. La première ligne du message (soit l'objet soit la
% formule de politesse) a comme `baseline' le tiers de la feuille et
% peut donc servir de repère de pli.


%%% Choses à faire

% Tenir compte des paramètres régionaux (en cours)
% Créer une véritable `output routine'.

% Commentaires:
%
% La présentation des lettres relève toute entière des paramètres
% régionaux, cependant la bibliothèque `lettre' devrait pouvoir
% comprendre:
%  -- différentes façons d'écrire la date;
%  -- des variantes pour les `objet', `pièces jointes' etc., par
%     exemple les suisses francophones préfèrent écrire `concerne' à
%     la place de `objet'.


%%% Code

%
% Dimensions
%

% Le choix du format du papier est obligatoirement A4 et les
% dimensions des marges ne *peuvent pas* être modifiées.

\setpaperformat{A4}
\def\\#1{#1=25mm \unmagnify#1}%
\\\layoutmarginleft
\\\layoutmarginright
\\\layoutmargintop
\\\layoutmarginbottom
\let\\\undefined

\newdimen\lettermarginleft
\newdimen\lettermarginright
\lettermarginleft=25 true mm
\lettermarginright=0 true mm

\newdimen\letteraddresseewidth
\newdimen\letteraddresseeheight
\letteraddresseewidth=85 true mm
\letteraddresseeheight=35 true mm

\newdimen\letteraddresswidth
% The height of the address box is a priori unimportant

% The gap between addressee and address
\newdimen\letterheadersep
\letterheadersep=20 true mm

% The indentation before the signature
\newdimen\lettersignatureindent

\def\selectlayoutletter{%
  \letteraddresswidth=\paperwidth
  \advance\letteraddresswidth -\layoutmarginleft
  \advance\letteraddresswidth -\layoutmarginright
  \advance\letteraddresswidth -\letteraddresseewidth
  \advance\letteraddresswidth -\letterheadersep
  \lettersignatureindent=\letteraddresswidth
  \advance\lettersignatureindent\letterheadersep
}

\addhook\selectlayoutletter\to\selectlayouthook

\selectlayout

\def\setsectionfont{%
  \setnormalfont\setfontshape{i}\setnormalsize
}

\outer\def\section#1\par{%
  \removelastskip
  \vskip\z@ plus.1\vsize
  \penalty-250
  \vskip\z@ plus-.1\vsize
  \bigskip
  \vskip\parskip
  \vskip\baselineskip
  \leftline{\hskip\layoutmarginleft\sectionfont#1}\nobreak
  \medskip
  \noindent
  \ignoreblanks
}

%
% Identification
%

\def\identdef#1{%
  \outer\csdef{#1}{%
    \readline\to\rtA\then
      \toksloadcsname{the@#1}\to\rtB
      \edef\next{\noexpand\global\noexpand\def\the\rtB{\the\rtA}}%
      \next
    \done
  }%
}

\identdef{name}
\identdef{phone}
\identdef{mobile}
\identdef{email}
\identdef{date}
\identdef{place}
\identdef{nref}
\identdef{vref}
\identdef{subject}
\identdef{sceal}

\def\the@date{\today}

%
% Paramètres régionaux
%

\def\letteradjustment#1#2{%
  \csbindlocalecsname{Subject}{#1}{#2}\to{Subjectname}%
  \csbindlocalecsname{Phone}{#1}{#2}\to{Phonename}%
  \csbindlocalecsname{Mobile}{#1}{#2}\to{Mobilename}%
  \csbindlocalecsname{Fax}{#1}{#2}\to{Faxname}%
  \csbindlocalecsname{EMail}{#1}{#2}\to{EMailname}%
  \csbindlocalecsname{CarbonCopy}{#1}{#2}\to{CarbonCopyname}%
  \csbindlocalecsname{Enclosings}{#1}{#2}\to{Enclosingsname}%
}

\addlocaleadjustment\letteradjustment
\addlocalefacility{letter}

%
% Ramasser les adresses
%

\def\collectlines\to#1\then#2\done{%
  \beginnext
  \rtA={}%
  \rtB={}%
  \rtC={}%
  \def\rmA{\rtB={#1}\rtC={#2}}%
  \collectlines@C%
}

\def\collectlines@C{%
  \readline\to\rtA\then
    \testtoksempty\rtA
    \iftoksempty\else\rtC={\endline}\fi
    \collectlines@A
  \done
}

\def\collectlines@A{%
  \readline\to\rtB\then
    \testtoksempty\rtB
    \iftoksempty
      \def\next{\collectlines@B}%
    \else
      \edef\next{%
        \noexpand\rtA={\the\rtA\the\rtC\the\rtB}%
        \noexpand\rtC={\noexpand\endline}%
        \noexpand\collectlines@A
      }%
    \fi
    \next
  \done
}

\def\collectlines@B{%
  \rmA
  \edef\next{\the\rtB={\the\rtA}\the\rtC}%
  \endnext
}

\def\address{%
  \collectlines\to\rtA\then
    \edef\the@address{\the\rtA}%
    \relaxmode
  \done
}

\def\addressee{%
  \collectlines\to\rtA\then
    \edef\the@addressee{\the\rtA}%
    \relaxmode
  \done
}

%
% Préparation de l'en-tête
%

% Les éléments makeaddress, makephone, makefax, makeemail servent à
% préparer les éléments d'adresse.
%
% Les `makeaddress' et `makeaddressee' produisent du matériel vertical
% (ils peuvent utilsier la commande `par') tandis que les autres
% produisent du matériel horizontal.

\def\makeaddress{%
  \begingroup
  \parindent\z@
  \ifx\the@address\undefined
      \makename\par
  \else
    \let\endline\par
    \the@address\endline
  \fi
  \par
  \endgroup
}

\let\make@B\relax
\let\make@E\relax

\def\makeany#1#2{%
  \beginnext
  \ifx#1\undefined
    \let\next\empty
  \else
    \def\next{\noindent\make@B#2\make@E}%
  \fi
  \endnext
}
\def\makename{\makeany\the@name\the@name}
\def\makephone{\makeany\the@phone{\Phonename: \the@phone}}
\def\makemobile{\makeany\the@mobile{\Mobilename: \the@mobile}}
\def\makefax{\makeany\the@fax{\Faxname: \the@fax}}
\def\makeemail{\makeany\the@email{\EMailname: {\tt\the@email}}}

\def\makedate{%
  \noindent
  \ifx\the@place\undefined\else\the@place,\enspace\fi
  \the@date
}

\def\makesubject{%
  \ifx\the@subject\undefined
  \else
    \noindent
    \begingroup
    \noindent
    \hangindent=\itemindent
    \hangafter=1
    \raggedright
    {\bf
      \ifx\Subjectname\empty\else
      \Subjectname:\space
      \fi
      \the@subject
    }%
    \par
    \endgroup
    \vskip2\baselineskip
    \smallskip
  \fi
}

\def\makeaddressee{%
  \begingroup
  \elfpoint
  \hyphenpenalty=10000
  \let\endline\par
  \ifx\the@addressee\undefined
    (No addressee)%
  \else
    \parindent\z@
    \the@addressee
  \fi
  \par
  \endgroup
}

\def\makeheader@l{\\{phone}\\{mobile}\\{fax}\\{email}}
\def\makeheader@P#1{%
  \beginnext
  \toksloadcsname{the@#1}\to\rtA
  \expandafter\ifx\the\rtA\undefined
    \def\next{}%
  \else
    \def\next{\makeheadertrue}%
  \fi
  \endnext
}

\newif\ifmakeheader

\def\testmakeheader{%
  \beginnext
  \makeheaderfalse
  \let\\\makeheader@P
  \makeheader@l
  \ifmakeheader
    \def\next{\makeheadertrue}%
  \else
    \def\next{\makeheaderfalse}%
  \fi
  \endnext
}

\def\makeheaderaddress{%
    \vtop{%
      \hsize=\letteraddresswidth
      \parindent\z@
      \makeaddress
      \testmakeheader
      \ifmakeheader
        \medskip
        \makephone\par
        \makemobile\par
        \makefax\par
        %\makeemail
        % Il faut mettre l'adresse E-Mail ailleurs car elle prend
        % généralement une place trop importante
      \fi
      \vfill
    }%
}

\def\makeheaderaddressee{%
    \vtop{%
      \hsize=\letteraddresseewidth
      \makedate
      \vskip -\baselineskip
      \vskip 30 true mm % 55 - layoutmargintop = 30
      \vtop to 35 mm {\makeaddressee\vfill}%
    }%
}

\def\makeheader{%
  \line{%
    \makeheaderaddress
    \hskip\letterheadersep
    \hss                % Compense les erreurs d'arrondi
    \makeheaderaddressee
  }%
}

%
% Parties modales
%

\def\relaxmode{%
  \let\endmode\relax
}

\def\normalmode{%
  \let\endmode\par
  \parskip=\smallskipamount
}

\def\linesmode{%
  \begingroup
  \parindent\z@
  \parskip\z@
  \obeylines
  \def\endmode{\par\endgroup}%
}

\def\opening{%
  \endmode
  \rdA=\paperheight
  \divide\rdA by 3
  \advance\rdA by - \layoutmargintop
  \vbox to\rdA{\makeheader\vss}%
  \readline\to\rtA\then
    \advance\leftskip\lettermarginleft
    \advance\rightskip\lettermarginright
    \makesubject
    \noindent\the\rtA
    \smallskip
    \normalmode
    \noindent
    \ignoreblanks
  \done
}

\def\closing{%
  \endmode
  \bigskip
  \relaxmode
}

\def\signature{%
  \endmode
  \ifx\the@sceal\undefined
    \vskip 35 true mm     % Espace pour la signature
  \else
    \vbox to 35 true mm{%
      \leftskip\lettersignatureindent
      \parskip\z@
      \rightskip\z@
      \vfill
      \noindent\image{\the@sceal}\hss
      \vfill
    }%
    \nointerlineskip
  \fi
  \def\endmode{%
    \par
    \vskip\bigskipamount
    \egroup
    \relaxmode
  }%
  \vtop\bgroup
    \leftskip\lettersignatureindent
    \parindent\z@
    \parskip\z@
    \obeylines\ignorespaces
}

% Annotations

\def\annotations@L#1{%
  \noindent\llap{#1\qquad}%
}

\def\annotations@A#1#2{%
  \endmode
  \bigskip
  #1\annotations@L{#2}%
}

\def\annotations@B#1#2{%
  \readline\to\rtA\then
    \annotations@A{#1}{#2}%
  \done
}

\def\annotations@C#1{%
  \readline\to\rtA\then
    \rtB={#1}%
    \beginnext
    \edef\next{\noexpand\annotations@A{\the\rtB}{\the\rtA}}%
    \endnext
  \done
}

\def\annotations{%
  \annotations@C\linesmode
}

\def\enclosings{\annotations@B\linesmode{\Enclosingsname}}

\def\carboncopy{\annotations@B\linesmode{\CarbonCopyname}}

\def\postscriptum{%
  \annotations@B\normalmode{P.S.}%
}

\addhook\endmode\to\endhook

%
% Output Routine
%

\def\makefootline{%
  \baselineskip24\p@
  \lineskiplimit\z@
  \vskip 1 true cm
  \hrule
  \vskip 1 true mm
  \line{\normalfont\the\footline}%
}

\footline={%
  \eightpoint
  \def\make@B{}%
  \def\make@E{\def\make@B{\enspace---\enspace}\let\make@E\empty}%
  \noindent\hfil\makename
  \ifx\the@mobile\undefined\makephone\else\makemobile\fi
  \makefax\makeemail\hfil
}%

%
% Styles
%

\def\style@center{%
  \lettermarginleft=12.5 true mm
  \lettermarginright=12.5 true mm
  \relax
}


%
% Trampoline
%

\selectlocalemainlocale
\relaxmode

%%% End of file `cadet_letter.cls'
