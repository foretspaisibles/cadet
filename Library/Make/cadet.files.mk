### cadet.files.mk -- Service de copie de fichiers pour le projet

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

### End of file `cadet.files.mk'
