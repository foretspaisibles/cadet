### Makefile -- Cadet TeX Makefile

# Cadet TeX (https://github.com/foretspaisibles/cadet)
# This file is part of Cadet TeX.
#
# Copyright © 2001–2021 Michaël Le Barbier
# All rights reserved.

# This software is governed by the CeCILL-B license under French law and
# abiding by the rules of distribution of free software.  You can  use,
# modify and/ or redistribute the software under the terms of the CeCILL-B
# license as circulated by CEA, CNRS and INRIA at the following URL
# "https://cecill.info/licences/Licence_CeCILL-B_V1-en.txt"


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
