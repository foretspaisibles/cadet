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
% Private names
%
% This not very nice kludge allows us to stay in the private name
% space after we left the class file.
\let\bhrid@disableprivatenames=\disableprivatenames
\def\disableprivatenames{%
  \let\disableprivatenames\bhrid@disableprivatenames
}
