% devel.cls -- A Class for TeX experimentations

%
% Layout
%

% We switch to a small paper size A5, which is suited to screen
% display.
\setpaperformat{A5}
\setmargin{10mm}{10mm}
\selectlayout
\nopagenumbers
\parindent\z@

%
% Structure
%

\def\maketitle#1{%
  \centerline{\largesize\bf#1}%
  \medskip
}

\def\title{%
  \beginnext
  \readline\to\rtA\then
    \edef\next{\noexpand\maketitle{\the\rtA}}%
    \endnext
  \done
}


%
% Tracing
%
\newbox\tracebox
\newdimen\tracewidth
\tracewidth=\hsize
\def\tracestyle{%
  \verysmallsize\tt
}

\def\traceannounce#1{%
  \par
  \leftline{\verysmallsize #1\dotfill}%
  \smallskip
}

\long\def\begintrace{%
  \traceannounce{\llap{\P\quad}Beginning to trace}%
  \global\setbox\tracebox=\vbox to0pt{}%
}

\def\endtrace{%
  \traceannounce{Dumping trace results}%
  \box\tracebox
  \traceannounce{End of trace results}%
}

\long\def\trace#1{%
  \global\setbox\tracebox=\vbox{%
    \unvbox\tracebox
    \smallskip
    \hsize=\tracewidth
    \tracestyle
    #1\relax
  }%
}

\long\def\tracevalue#1#2{%
  \trace{\quad#1\quad\string#2 = \meaning#2}%
}

%
% Tracing tokens
%

% \tracetokens #1\done
%
%  Trace this list of tokens.  The trace generated is a list of
%  leftlines containing the meaning of each of the tokens encountered.

\begingroup
\setcatcodeactive`\*
\global\def\tracetokens@d{*tracetokens@d*}%
\endgroup

\def\tracetokens{%
  \par
  \begingroup
  \let\done\tracetokens@d
  \tracetokens@L
}

\def\tracetokens@L{%
  \futurelet\tracetokens@t\tracetokens@M
}

\def\tracetokens@M{%
  \ifx\tracetokens@t\tracetokens@d
     \let\tracetokens@N\tracetokens@E
  \else
     \leftline{\meaning\tracetokens@t}%
     \ifx\tracetokens@t\spacetoken
        \let\tracetokens@N\tracetokens@S
     \else
        \let\tracetokens@N\tracetokens@I
     \fi
  \fi
  \tracetokens@N
}

% @E End of the procedure
\def\tracetokens@E#1{%
  \endgroup
}

% @I Ignore the next token (non-space case)
\def\tracetokens@I{%
  \afterassignment\tracetokens@L
  \let\rmA
}

% @S Ignore the next token (space case)
\def\tracetokens@S{%
  \afterassignment\tracetokens@L
  \rcA0%
}



%
% Private names
%
% This not very nice kludge allows us to stay in the private name
% space after we left the class file.
\let\bhrid@disableprivatenames=\disableprivatenames
\def\disableprivatenames{%
  \let\disableprivatenames\bhrid@disableprivatenames
}
