### bhrid.doc.mk -- Préparation de documents avec Bhrìd TeX

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 20:33:08 CEST

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


# Confer `tex.doc.mk'.

TEX = pdftex
PDFTEX = ${TEX}
TEX.dvi = ${TEX}
TEX.pdf = ${PDFTEX}

# The PROGNAME variable influences the value of the TEXINPUTS variable.
PROGNAME?= bhrid

.if defined(BHRIDFORMAT)&&!empty(BHRIDFORMAT)&&!defined(FORMAT.bhrid)
FORMAT.bhrid = ${BHRIDFORMAT}
.endif

FORMAT.bhrid?= original
FORMAT.dvi?= ${FORMAT.bhrid}_xdvi
FORMAT.ps?= ${FORMAT.bhrid}_dvips
FORMAT.pdf?= ${FORMAT.bhrid}_pdf

.include "tex.doc.mk"

### End of file `bhrid.doc.mk'
