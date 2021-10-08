### Makefile -- Cadet, un format pour TeX

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


PROJECT=		cadet
VERSION=		1.0.0
OFFICER=		michipili@gmail.com

SUBDIR=			manual
SUBDIR+=		format
SUBDIR+=		macro
SUBDIR+=		class
SUBDIR+=		style
SUBDIR+=		make
SUBDIR+=		paper
SUBDIR+=		example
SUBDIR+=		locale
SUBDIR+=		config

post-install:

.include "generic.project.mk"

post-install: do-update-cnf
post-install: do-mktexlsr

### End of file `Makefile'
