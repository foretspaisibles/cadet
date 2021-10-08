### test.sh -- Test suite for unicode encoding

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
