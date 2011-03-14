### bhrid.project.mk -- Utiliser BHRID pour préparer des documents

# Author: Michael Grünewald
# Date: Mon Sep 11 18:01:50 CEST 2006
# Copyright: (C) 2006, 2013 Michael Grünewald

# Copyright (C) 2006, 2013 Michael Grünewald
# All rights reserved.
#
# This file is part of Bhrìd TeX.
#
# Bhrìd TeX is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Bhrìd TeX is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Bhrìd TeX.  If not, see <http://www.gnu.org/licenses/>.


.if !defined(BHRIDBASEDIR)
.error You must define BHRIDBASEDIR so that TeX and friends can find the BHRID files.
.endif

TEXDEVICE?= dvi
TEXFORMATS = ${BHRIDBASEDIR}/src

INPUTS.amsfonts!= dirname `kpsewhich amssym.tex`
INPUTS.null!= dirname `kpsewhich null.tex`

TEXINPUTS = .
TEXINPUTS+= ${BHRIDBASEDIR}
TEXINPUTS+= ${BHRIDBASEDIR}/class
TEXINPUTS+= ${BHRIDBASEDIR}/macro
TEXINPUTS+= ${BHRIDBASEDIR}/style
TEXINPUTS+= ${INPUTS.amsfonts}
TEXINPUTS+= ${INPUTS.null}

.if defined(BHRIDFORMAT)&&!empty(BHRIDFORMAT)&&!defined(FORMAT.bhrid)
FORMAT.bhrid = ${BHRIDFORMAT}
.endif

FORMAT.bhrid?= original
FORMAT.ps?= ${FORMAT.bhrid}_dvips
FORMAT.pdf?= ${FORMAT.bhrid}_pdf
FORMAT.dvi?= ${FORMAT.bhrid}_xdvi

TEX?= pdftex
PDFTEX?= ${TEX}
TEX.dvi = ${TEX}
TEX.pdf = ${PDFTEX}

APPLICATION?= bhrid${.CURDIR:C/${BHRIDBASEDIR}//}
DOCUMENTDIR?= ${TEXMFDIR}/doc${APPLICATIONDIR}

_TEX_VARS+= FORMAT.bhrid

.include "tex.doc.mk"

### End of file `bhrid.project.mk'
