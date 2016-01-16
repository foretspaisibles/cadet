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
