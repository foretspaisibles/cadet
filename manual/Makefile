### Makefile -- Cadet TeX Makefile

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

DOCUMENT=		cadetman

NOWEB=			cadetmanbegin.nw
NOWEB+=			kernel.nw
NOWEB+=			calendar.nw
NOWEB+=			basedef.nw
NOWEB+=			mdoclist.nw
NOWEB+=			paper.nw
NOWEB+=			output.nw
NOWEB+=			image.nw
NOWEB+=			pfss.nw
NOWEB+=			pfssadj.nw
NOWEB+=			pfssmath.nw
NOWEB+=			convent.nw
NOWEB+=			convtext.nw
NOWEB+=			convcomp.nw
NOWEB+=			convpunc.nw
NOWEB+=			convmath.nw
NOWEB+=			latin9.nw
NOWEB+=			utf8.nw
NOWEB+=			setup.nw

NOWEB+=			cadetcore.nw

NOWEB+=			fontaps.nw
NOWEB+=			fontcmm.nw
NOWEB+=			fontcmmt.nw
NOWEB+=			fonttx.nw
NOWEB+=			fontpx.nw
NOWEB+=			fontlm.nw
NOWEB+=			fonteufm.nw

NOWEB+=			drvxdvi.nw
NOWEB+=			drvdvips.nw
NOWEB+=			drvpdf.nw

NOWEB+=			cadetmanend.nw

NOWEAVE=		${DOCUMENT}

SRCS=			cadetman.tex
SRCS+=			cadetman.sty
SRCS+=			orientation.tex

TEXINPUTS+=		${SRCDIR}/src

USES+=			noweb
NOWEAVE_LATEX_WRAPPER=	delay
NOWEAVE_LATEX_DEFS=	l2h.in

.PATH:			${SRCDIR}/src

.include "latex.doc.mk"

### End of file `Makefile'
