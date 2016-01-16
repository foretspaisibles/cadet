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

SRCS+=			kernel.nw
SRCS+=			calendar.nw
SRCS+=			basedef.nw
SRCS+=			mdoclist.nw
SRCS+=			paper.nw
SRCS+=			output.nw
SRCS+=			image.nw
SRCS+=			pfss.nw
SRCS+=			pfssadj.nw
SRCS+=			pfssmath.nw
SRCS+=			convent.nw
SRCS+=			convtext.nw
SRCS+=			convcomp.nw
SRCS+=			convpunc.nw
SRCS+=			convmath.nw
SRCS+=			latin9.nw
SRCS+=			utf8.nw
SRCS+=			setup.nw

SRCS+=			cadetcore.nw

SRCS+=			fontaps.nw
SRCS+=			fontcmm.nw
SRCS+=			fontcmmt.nw
SRCS+=			fonttx.nw
SRCS+=			fontpx.nw
SRCS+=			fontlm.nw
SRCS+=			fonteufm.nw

SRCS+=			drvxdvi.nw
SRCS+=			drvdvips.nw
SRCS+=			drvpdf.nw

MANUAL+=		cadetman.tex
MANUAL+=		cadetman.sty
MANUAL+=		orientation.tex

TEXINPUTS.epsf!=	kpsewhich epsf.tex

TEXINPUTS=		.
TEXINPUTS+=		${TEXINPUTS.epsf:/epsf.tex=}
TEXINPUTS+=		${SRCDIR}
TEXINPUTS+=		${SRCDIR}/src
TEXINPUTS+=		${SRCDIR}/contrib
TEXINPUTS+=		:

TEXENV=			/usr/bin/env TEXINPUTS=${TEXINPUTS:Q:S/\\ /:/g}
INITEX=			${TEXENV} pdftex -halt-on-error -ini -8bit
LATEX=			${TEXENV} latex -halt-on-error
PDFLATEX=		${TEXENV} pdflatex -halt-on-error

### 1. Cibles principales

all: build doc

build: buildfiles

doc: do-doc


### 2. Petits calculs


WEBFILES = ${SRCS}
TEXFILES = ${SRCS:.nw=.tex}
LTXFILES = ${WEBFILES:.nw=.latex}

REALCLEANFILES+= ${TEXFILES}
REALCLEANFILES+= ${LTXFILES}

CLEANFILES = ${FORMAT:.fmt=.tex} ${FORMAT}

.SUFFIXES: .fmt .tex .latex .nw


### 3. Préparation des formats

_AUTO_FORMAT!= (cd ${.CURDIR} && perl format.pl -l format.spec)
_AUTO_DRIVER+= ${SRCS:Mdrv*:S/.nw//:S/drv//}

.for format in ${_AUTO_FORMAT}
.for driver in ${_AUTO_DRIVER}
FORMAT+= ${format}_${driver}.fmt
${format}_${driver}.fmt: ${format}_${driver}.tex drv${driver}.tex
${format}_${driver}.tex: format.spec format.pl
	perl ${.ALLSRC:M*.pl} -m ${.ALLSRC:M*.spec} -f ${format} -d ${driver} > ${.TARGET}
REALCLEANFILES+= ${format}_${driver}.tex
.endfor
.endfor

buildfiles: do-build-fmt
# C'est pour "make.files.mk".

do-build-fmt: ${FORMAT}

${FORMAT}: ${TEXFILES}

.for format in ${FORMAT}

.if exists(${format:.fmt=.nw})
${format:.fmt=.tex}: ${format:.fmt=.nw}
.endif

${format}: ${format:.fmt=.tex}

.if defined(SRCS.${format}) && !empty(SRCS.${format})
${format}: ${SRCS.${format}}
.endif

${format}:
	${INITEX} ${.TARGET:.fmt=.tex}
.endfor

.for file in ${FORMAT} ${FORMAT:.fmt=.log} ${FORMAT:.fmt=.dvi} ${FORMAT:.fmt=.pdf} missfont.log
.if exists(${file})
CLEANFILES+= ${file}
.endif
.endfor

### 4. Préparation de la documentation

.nw.latex:
	noweave -n -latex -autodefs tex -x ${.ALLSRC} > ${.TARGET}

.nw.tex:
	notangle ${.ALLSRC} > ${.TARGET}

.if defined(DRAFT)
cadetman.dvi: ${MANUAL} ${LTXFILES}
	${LATEX} cadetman
.else
cadetman.dvi: ${MANUAL} ${LTXFILES}
	${LATEX} cadetman
	${LATEX} cadetman
	${LATEX} cadetman
cadetman.pdf: ${MANUAL} ${LTXFILES}
	${PDFLATEX} cadetman
	${PDFLATEX} cadetman
	${PDFLATEX} cadetman
.endif

do-doc: cadetman.dvi
.if !defined(DRAFT)
do-doc: cadetman.pdf
.endif

.for file in cadetman.dvi cadetman.pdf cadetman.log cadetman.aux cadetman.toc
.if exists(${file})
CLEANFILES+= ${file}
.endif
.endfor

### Installation des formats


### Installation du manuel

#FILESGROUPS+= DOC
# DOCDIR est positionné par "make.own.mk" à la valeur
# /share/doc${APPLICATIONDIR}.
#
# "make.own.mk" est inclus par "make.init.mk".

DOC+= cadetman.dvi
.if !defined(DRAFT)
DOC+= cadetman.pdf
.endif

### Mktexlsr positinstallatoire

post-install:
	${INFO} "Rebuilding TeX ls-R databases"
	mktexlsr


### Nettoyage

clean:
.if!empty(CLEANFILES)
	rm -f ${CLEANFILES}
.endif

.include "cadet.files.mk"
.include "bps.init.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

#install: doc

### End of file `Makefile'
