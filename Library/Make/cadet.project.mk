### cadet.project.mk -- Utiliser CADET pour préparer des documents

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

TEXFORMATS=		${WRKDIR}/format

TEXINPUTS=		.
TEXINPUTS+=		${CADETBASEDIR}
TEXINPUTS+=		${CADETBASEDIR}/class
TEXINPUTS+=		${CADETBASEDIR}/macro
TEXINPUTS+=		${WRKDIR}/macro
TEXINPUTS+=		${CADETBASEDIR}/style
TEXINPUTS+=		${CADETBASEDIR}/contrib
TEXINPUTS+=		${INPUTS.amsfonts}
TEXINPUTS+=		${INPUTS.null}

.if defined(CADETFORMAT)&&!empty(CADETFORMAT)&&!defined(FORMAT.cadet)
FORMAT.cadet = ${CADETFORMAT}
.endif

FORMAT.cadet?=		stanford
FORMAT.ps?=		${FORMAT.cadet}_dvips
FORMAT.pdf?=		${FORMAT.cadet}_pdf
FORMAT.dvi?=		${FORMAT.cadet}_xdvi
FORMAT.tex?=		${FORMAT.cadet}_xdvi


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
