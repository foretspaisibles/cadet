### Makefile -- BHRID, un format pour TeX

# Author: Michael Grünewald
# Date: Tue Feb 21 22:34:46 GMT 2006
# Copyright: (C) 2006, 2013 Michael Grünewald

# Copyright (C) 2006, 2013 Michael Grünewald
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

PROJECT = bhrid
VERSION = 0.1
AUTHOR = Michael Grünewald

SUBDIR+= src
SUBDIR+= macro
SUBDIR+= class
SUBDIR+= make
SUBDIR+= paper
SUBDIR+= example
SUBDIR+= locale

#SUBDIR+= style
#SUBDIR+= ancillary
#SUBDIR+= fonts

.MAKEFLAGS: -I ${.CURDIR}/Library/Make
.MAKEFLAGS: BHRIDBASEDIR=${.CURDIR}
.MAKEFLAGS: USE_SWITCH_CREDENTIALS=no

.include "bps.subdir.mk"
.include "bps.project.mk"

afterinstall:	.USE
	mktexlsr

install:	afterinstall


### End of file `Makefile'
