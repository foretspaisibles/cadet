### test.sh -- Test suite for unicode encoding

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

test_result='success'

test-write()
{
    printf 'Test write '
    if grep -q 'àáâãäåæçèéêëìíîïðñòóôöøùúûüÿþœß×÷' write.log; then
	printf 'success\n'
    else
	printf 'failure\n'
	test_sucess='failure'
    fi
}

test-write

### End of file `test.sh'
