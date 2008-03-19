### pfbinfo.sh -- Extraire deux trois informations des fichiers PFB

get_entry()
{
    sed -n -e "s@/$2(\\(.*\\)).*@\\1@p" $1
}

print_table()
{
    fullname=`get_entry $1 FullName`
    weight=`get_entry $1 Weight`

    printf '%-15s %-35s %-10s\n' \
	`basename $1` $fullname $weight
}

process_directories()
{
    find "$@" -name '*.pfb' | while read f; do
	print_table $f
    done
}

if [ $# -gt 0 ]; then
    process_directories "$@"
else
    echo "Usage: PFBINFO directory1 ..."
fi
