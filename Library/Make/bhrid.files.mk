### bhrid.files.mk -- Service de copie de fichiers pour le projet

# Author: Michael Grünewald
# Date: Tue Feb 21 22:34:46 GMT 2006

# Copyright (C) 2006-2014 Michael Grünewald
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


.include "bhrid.init.mk"

### Groupes de fichiers

# CLASS: classes de documents
# MACRO: macros
# STYLE: styles
# FONTS: intégration de fontes.
# FORMAT: formats

_BHRID_INSTALLDIR = ${TEXMFDIR}/tex${APPLICATIONDIR}

CLASSDIR =	${_BHRID_INSTALLDIR}/class
MACRODIR =	${_BHRID_INSTALLDIR}/macro
.if defined(PACKAGE)
STYLEDIR =	${_BHRID_INSTALLDIR}/style/${PACKAGE}
LOCALEDIR =	${TEXMFDIR}/tex${APPLICATIONDIR}/locale/${PACKAGE}
.else
STYLEDIR =	${_BHRID_INSTALLDIR}/style
LOCALEDIR =	${TEXMFDIR}/tex${APPLICATIONDIR}/locale
.endif
FONTSDIR =	${_BHRID_INSTALLDIR}/fonts
FORMATDIR =	${TEXMFDIR}/web2c
DOCDIR =	${TEXMFDIR}/doc${APPLICATIONDIR}
BSDMKDIR =      ${PREFIX}/share/mk

FILESGROUPS =	CLASS MACRO STYLE FONTS FORMAT BSDMK LOCALE


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

### End of file `bhrid.files.mk'
