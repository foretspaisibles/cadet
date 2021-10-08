### cadet.doc.mk -- Préparation de documents avec Cadet TeX

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



# Confer `tex.doc.mk'.

TEXMFDIR?=		${datarootdir}/texmf-local

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
