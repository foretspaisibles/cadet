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


# AC_NEED_PROG([INFORMAL PROGRAM NAME], [PROGRAM NAME])
# -----------------------------------------------------
AC_DEFUN([AC_NEED_PROG],
[AC_CHECK_PROG([has_$2], [$2], [yes], [no])
if test "x$has_$2" = 'xno'; then
  AC_MSG_ERROR([*** $1 not found.])
fi;])


# CADET_EPSFPATH
# --------------
# Check for an epsf.tex file that can be read by TeX and
# store its path in cadet_epsfpath.

AC_DEFUN([CADET_EPSFPATH],
[AC_CACHE_CHECK([for EPS macros], cadet_cv_epsfpath,
[dnl
  cadet_cv_epsfpath=$(kpsewhich epsf.tex || echo no)
  if test "x${cadet_cv_epsfpath}" = 'xno'; then
    AC_MSG_ERROR([*** file epsf.tex not found]);
  else
    cadet_cv_epsfpath="${cadet_cv_epsfpath%/epsf.tex}"
  fi;])
  cadet_epsfpath="${cadet_cv_epsfpath}"
  AC_SUBST([cadet_epsfpath])])


# CADET_TEXMFCNF
# --------------
# Check for the path to texmf configuration directory.

AC_DEFUN([CADET_TEXMFCNF],
[AC_CACHE_CHECK([texmf configuration path], cadet_cv_texmfcnf,
[dnl
  cadet_cv_texmfcnf=$(kpsewhich --expand-var='${TEXMFCNF}' || echo no)
  if test "x${cadet_cv_texmfcnf}" = 'xno'; then
    AC_MSG_ERROR([*** texmf configuration path not found]);
  fi;])
  cadet_texmfcnf="${cadet_cv_texmfcnf}"
  AC_SUBST([cadet_texmfcnf])])


# CADET_TEXLIVEUPDATECNF
# ----------------------
# Check for the path to the texlive-update-cnf tool.

AC_DEFUN([CADET_TEXLIVEUPDATECNF],
[AC_CACHE_CHECK([texlive-update-cnf tool], cadet_cv_texliveupdatecnf,
[dnl
  cadet_cv_texliveupdatecnf=$(kpsewhich --expand-var='${TEXMFCNF}' || echo /nonexistant)
  cadet_cv_texliveupdatecnf="${cadet_cv_texliveupdatecnf%/etc*}/libexec/texlive-update-cnf"
  if ! test -x "${cadet_cv_texliveupdatecnf}"; then
    cadet_cv_texliveupdatecnf="no";
    AC_MSG_ERROR([*** texmf configuration path not found]);
  fi;])
  cadet_texliveupdatecnf="${cadet_cv_texliveupdatecnf}"
  AC_SUBST([cadet_texliveupdatecnf])])
