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
NOWEB+=			cadetcore.nw


NOWEB+=			latin9.nw
NOWEB+=			utf8.nw

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

NOTANGLE=		cadetcore.tex
NOTANGLE+=		image.tex
NOTANGLE+=		convent.tex

NOTANGLE+=		latin9.tex
NOTANGLE+=		utf8.tex
NOTANGLE+=		fontaps.tex
NOTANGLE+=		fontcmm.tex
NOTANGLE+=		fontcmmt.tex
NOTANGLE+=		fonttx.tex
NOTANGLE+=		fontpx.tex
NOTANGLE+=		fontlm.tex
NOTANGLE+=		fonteufm.tex
NOTANGLE+=		drvxdvi.tex
NOTANGLE+=		drvdvips.tex
NOTANGLE+=		drvpdf.tex

TEXINPUTS+=		${TEXMFEPSFPATH}
TEXINPUTS+=		${SRCDIR}
TEXINPUTS+=		${SRCDIR}/src
TEXINPUTS+=		${SRCDIR}/contrib
TEXINPUTS+=		${.OBJDIR}

USES+=			noweb

.PATH:			${SRCDIR}/src

TEXENV?=		/usr/bin/env TEXINPUTS=${TEXINPUTS:Q:S/\\ /:/g}
INITEX?=		${TEXENV} pdftex -halt-on-error -ini -8bit
FILESDIR?=		${TEXMFDIR}/web2c


CADET_FORMAT!=		(cd ${SRCDIR}/src && perl format.pl -l format.spec)
CADET_DRIVER=		${NOWEB:Mdrv*:S/.nw//:S/drv//}

.for format in ${CADET_FORMAT}
.for driver in ${CADET_DRIVER}
FILES+=		${format}_${driver}.fmt
${format}_${driver}.fmt: ${format}_${driver}.tex drv${driver}.tex ${NOTANGLE:Ndrv*}
	${INITEX} ${format}_${driver}.tex
${format}_${driver}.tex: format.spec format.pl
	perl ${.ALLSRC:M*.pl} -m ${.ALLSRC:M*.spec} -f ${format} -d ${driver} > ${.TARGET}
REALCLEANFILES+= ${format}_${driver}.tex
.endfor
.endfor

.include "bps.init.mk"
.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `Makefile'
