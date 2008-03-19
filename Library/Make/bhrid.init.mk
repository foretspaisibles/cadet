### bhrid.init.mk

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


.if !target(__<bhrid.init.mk>)
__<project.init.mk>:

APPLICATION?=		bhrid
APPLICATIONDIR?=	/bhrid
TEXMFDIR?=		${PREFIX}/share/texmf

.include "make.init.mk"
.include "make.own.mk"

.endif

### End of file `bhrid.init.mk'
