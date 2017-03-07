
echo -e 'Book\tFirst\tSecond\tRatio'
for input_file in "$@"
do
    filename=$(basename "$input_file")
    book="${filename%.*}"
    head -n 2 $input_file \
        | awk -v ORS=' ' '{print $2}' \
        | awk -v book=$book '{printf "%s\t%i\t%i\t%.2f\n",  book, $1, $2, $1/$2}'
done
