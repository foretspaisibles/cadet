### Makefile -- Bhrìd TeX Makefile

# Author: Michael Grünewald <michael.lebarbier@laposte.net>
# Date: Dim 17 déc 2006 18:16:26 CET

# Copyright (C) 2006, 2014 Michael Grünewald
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


SRCS+= kernel.nw
SRCS+= calendar.nw
SRCS+= basedef.nw
SRCS+= mdoclist.nw
SRCS+= paper.nw
SRCS+= output.nw
SRCS+= image.nw
SRCS+= pfss.nw
SRCS+= pfssadj.nw
SRCS+= pfssmath.nw
SRCS+= convent.nw
SRCS+= convtext.nw
SRCS+= convcomp.nw
SRCS+= convpunc.nw
SRCS+= convmath.nw
SRCS+= latin9.nw
SRCS+= setup.nw

SRCS+= bhridcore.nw

SRCS+= fontaps.nw
SRCS+= fontcmm.nw
SRCS+= fontcmmt.nw
SRCS+= fonttx.nw
SRCS+= fontpx.nw
SRCS+= fontlm.nw
SRCS+= fonteufm.nw

SRCS+= drvxdvi.nw
SRCS+= drvdvips.nw
SRCS+= drvpdf.nw

MANUAL+= bhridman.tex
MANUAL+= bhridman.sty
MANUAL+= orientation.tex

TEXMFDIST = /usr/local/share/texmf-dist

TEXINPUTS.epsf!= kpsewhich epsf.tex

TEXINPUTS = .
TEXINPUTS+= ${TEXINPUTS.epsf:/epsf.tex=}
TEXINPUTS+= ${PROJECTBASE}/contrib
TEXINPUTS+= :

TEX = /usr/bin/env TEXINPUTS=${TEXINPUTS:Q:S/\\ /:/g} pdftex -halt-on-error
#INITEX = ${TEX} -ini -translate-file=natural.tcx
INITEX = ${TEX} -ini -translate-file=cp227.tcx

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

_AUTO_FORMAT!= perl format.pl -l format.spec
_AUTO_DRIVER+= ${SRCS:Mdrv*:S/.nw//:S/drv//}

.for format in ${_AUTO_FORMAT}
.for driver in ${_AUTO_DRIVER}
FORMAT+= ${format}_${driver}.fmt
${format}_${driver}.fmt: ${format}_${driver}.tex drv${driver}.tex
${format}_${driver}.tex: format.spec
	perl format.pl -m format.spec -f ${format} -d ${driver} > ${.TARGET}
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
bhridman.dvi: ${MANUAL} ${LTXFILES}
	latex -halt-on-error bhridman
.else
bhridman.dvi: ${MANUAL} ${LTXFILES}
	latex -halt-on-error bhridman
	latex -halt-on-error bhridman
	latex -halt-on-error bhridman
bhridman.pdf: ${MANUAL} ${LTXFILES}
	pdflatex -halt-on-error bhridman
	pdflatex -halt-on-error bhridman
	pdflatex -halt-on-error bhridman
.endif

do-doc: bhridman.dvi
.if !defined(DRAFT)
do-doc: bhridman.pdf
.endif

.for file in bhridman.dvi bhridman.pdf bhridman.log bhridman.aux bhridman.toc
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

DOC+= bhridman.dvi
.if !defined(DRAFT)
DOC+= bhridman.pdf
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

.include "bhrid.files.mk"
.include "bps.init.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

install: doc

### End of file `Makefile'
