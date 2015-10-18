### cadet.project.mk -- Utiliser CADET pour préparer des documents

# Copyright © 2001–2015 Michael Grünewald
# All rights reserved.
#
# This file is part of Cadet TeX.
#
# Cadet TeX is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Cadet TeX is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Cadet TeX.  If not, see <http://www.gnu.org/licenses/>.

.if !defined(CADETBASEDIR)&&defined(SRCDIR)
CADETBASEDIR=		${SRCDIR}
.endif

.if !defined(CADETBASEDIR)
.error You must define CADETBASEDIR so that TeX and friends can find the CADET files.
.endif

TEXDEVICE?= dvi
TEXFORMATS = ${WRKDIR}/src

INPUTS.amsfonts!= dirname `kpsewhich amssym.tex`
INPUTS.null!= dirname `kpsewhich null.tex`

TEXINPUTS = .
TEXINPUTS+= ${CADETBASEDIR}
TEXINPUTS+= ${CADETBASEDIR}/class
TEXINPUTS+= ${CADETBASEDIR}/macro
TEXINPUTS+= ${WRKDIR}/macro
TEXINPUTS+= ${CADETBASEDIR}/style
TEXINPUTS+= ${CADETBASEDIR}/contrib
TEXINPUTS+= ${INPUTS.amsfonts}
TEXINPUTS+= ${INPUTS.null}

.if defined(CADETFORMAT)&&!empty(CADETFORMAT)&&!defined(FORMAT.cadet)
FORMAT.cadet = ${CADETFORMAT}
.endif

FORMAT.cadet?= original
FORMAT.ps?= ${FORMAT.cadet}_dvips
FORMAT.pdf?= ${FORMAT.cadet}_pdf
FORMAT.dvi?= ${FORMAT.cadet}_xdvi

FORMAT.tex?= ${FORMAT.cadet}_xdvi


TEX= pdftex
PDFTEX?= ${TEX}
TEX.tex=pdftex
TEX.dvi = ${TEX}
TEX.pdf = ${PDFTEX}

APPLICATION?= cadet${.CURDIR:C/${CADETBASEDIR}//}
DOCUMENTDIR?= ${TEXMFDIR}/doc${APPLICATIONDIR}

_TEX_VARS+= FORMAT.cadet

.include "tex.doc.mk"

### End of file `cadet.project.mk'
