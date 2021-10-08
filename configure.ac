dnl Cadet TeX (https://github.com/foretspaisibles/cadet)
dnl This file is part of Cadet TeX.
dnl
dnl Copyright © 2001–2021 Michaël Le Barbier
dnl All rights reserved.

dnl This software is governed by the CeCILL-B license under French law and
dnl abiding by the rules of distribution of free software.  You can  use,
dnl modify and/ or redistribute the software under the terms of the CeCILL-B
dnl license as circulated by CEA, CNRS and INRIA at the following URL
dnl "https://cecill.info/licences/Licence_CeCILL-B_V1-en.txt"


AC_INIT([src/cadetmanbegin.nw])
AC_NEED_PROG([pdftex], [pdftex])
AC_NEED_PROG([kpsewhich], [kpsewhich])
AC_NEED_PROG([noweb], [notangle])
AC_SUBST([version], [$(sed -n -e '/^VERSION/s/VERSION=[[:space:]]*//p' Makefile)])
AC_SUBST([texmfroot], [$(kpsewhich -expand-var='${TEXMFROOT}')])
AC_SUBST([texmflocal], [$(kpsewhich -expand-var='${TEXMFLOCAL}')])
CADET_EPSFPATH
CADET_TEXMFCNF
CADET_TEXLIVEUPDATECNF

AC_CONFIG_FILES([Makefile.config src/format.spec])
AC_OUTPUT
