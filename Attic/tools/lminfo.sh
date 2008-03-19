cd /usr/local/texlive/Latest/texmf-dist/fonts/type1/public/lm

name=`mktemp /tmp/lminfo.XXXX`
attr=`mktemp /tmp/lminfo.XXXX`

ls *.pfb > $name
sed -n \
    -e 's%^/FullName(\(.*\)).*%\1%p' \
    -e 's%^/Weight(\(.*\)).*%\1%p' \
    *.pfb > $attr

awk -v name=$name -v attr=$attr '
BEGIN {
  i = 0;
  while((getline < name) == 1) {
    file = $0
    getline < attr;
    font = $0
    getline < attr
    weight = $0
    printf("%-14s %-42s %s\n", file, font, weight)
  }
  exit
}'

rm $name $attr
