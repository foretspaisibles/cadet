### cadet.doc.mk -- Préparation de documents avec Cadet TeX

# Copyright © 2001–2016 Michael Grünewald
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


# Confer `tex.doc.mk'.

TEX?=			pdftex
PDFTEX?=		pdftex
TEX.dvi?=		${TEX}
TEX.ps?=		${TEX}
TEX.pdf?=		${PDFTEX}

_TEX_SUFFIXES=		.tex .cls .sty .mac


# The PROGNAME variable influences the value of the TEXINPUTS variable.
PROGNAME?=		cadet

.if defined(CADETFORMAT)&&!empty(CADETFORMAT)&&!defined(FORMAT.cadet)
FORMAT.cadet=		${CADETFORMAT}
.endif

FORMAT.cadet?=		darmstadt
FORMAT.dvi?=		${FORMAT.cadet}_xdvi
FORMAT.ps?=		${FORMAT.cadet}_dvips
FORMAT.pdf?=		${FORMAT.cadet}_pdf

.include "tex.doc.mk"

### End of file `cadet.doc.mk'
