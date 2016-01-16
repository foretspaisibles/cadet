dnl Copyright © 2001–2016 Michael Grünewald
dnl All rights reserved.
dnl
dnl This file is part of Cadet TeX.
dnl
dnl Cadet TeX is free software: you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation, either version 3 of the License, or
dnl (at your option) any later version.
dnl
dnl Cadet TeX is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with Cadet TeX.  If not, see <http://www.gnu.org/licenses/>.

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
