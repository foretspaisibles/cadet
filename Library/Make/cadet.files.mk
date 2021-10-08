### cadet.files.mk -- Service de copie de fichiers pour le projet

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



.include "cadet.init.mk"

### Groupes de fichiers

# CLASS: classes de documents
# MACRO: macros
# STYLE: styles
# FONTS: intégration de fontes.
# FORMAT: formats

_CADET_INSTALLDIR = ${TEXMFDIR}/tex${APPLICATIONDIR}

CLASSDIR =	${_CADET_INSTALLDIR}/class
MACRODIR =	${_CADET_INSTALLDIR}/macro
.if defined(PACKAGE)
STYLEDIR =	${_CADET_INSTALLDIR}/style/${PACKAGE}
LOCALEDIR =	${TEXMFDIR}/tex${APPLICATIONDIR}/locale/${PACKAGE}
.else
STYLEDIR =	${_CADET_INSTALLDIR}/style
LOCALEDIR =	${TEXMFDIR}/tex${APPLICATIONDIR}/locale
.endif
FONTSDIR =	${_CADET_INSTALLDIR}/fonts
FORMATDIR =	${TEXMFDIR}/web2c
DOCDIR =	${TEXMFDIR}/doc${APPLICATIONDIR}
BSDMKDIR =      ${PREFIX}/share/mk
CNFDIR=		${TEXMFCNF}/texmf.cnf.d

FILESGROUPS =	CLASS MACRO STYLE FONTS FORMAT BSDMK LOCALE CNF


NOTANGLE?=	notangle

.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
.for file in ${${group}}
.if exists(${file:C/\..*$/.nw/})
REALCLEANFILES+= ${file}
${file}: ${file:C/\..*$/.nw/}
	${NOTANGLE} ${.ALLSRC} > ${.TARGET}
.endif
.endfor
.endif
.endfor

.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `cadet.files.mk'
